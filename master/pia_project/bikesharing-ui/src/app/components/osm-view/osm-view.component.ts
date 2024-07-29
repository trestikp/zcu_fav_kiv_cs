import {Component, OnInit} from '@angular/core';
import {CommonModule} from '@angular/common';
import * as L from 'leaflet';
import 'leaflet-extra-markers'
import {StandService} from "../../services/stand.service";
import {UserService} from "../../services/user.service";
import {FormsModule} from "@angular/forms";
import {ToastrService} from "ngx-toastr";
import {interval, Observable, takeWhile} from "rxjs";
import {OpenRouteServiceService} from "../../services/open-route-service.service";
import 'leaflet.animatedmarker/src/AnimatedMarker';
import {environment} from "../../../environments/environment";
import {PathFollowerService, RideState} from "../../services/path-follower.service";
import {RideService} from "../../services/ride.service";
import {ActiveMQSubscriptionService} from "../../services/active-m-q-subscription.service";
import {StandDTO} from "../../model/stand-dto";
import {BikeDTO} from "../../model/bike-dto";
import {RideDTO} from "../../model/ride-dto";

/**
 * Hearth of the client. This component is responsible for rendering the map, stands and bikes.
 */
@Component({
  selector: 'app-osm-view',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './osm-view.component.html',
  styleUrl: './osm-view.component.css'
})

export class OsmViewComponent implements OnInit {
  private map!: L.Map; // leaflet map
  // centered around "middle" of Pilsen (close to main train station)
  private centroid: L.LatLngExpression = [49.741526, 13.386230]

  private standMarkers = new Map<string, L.Marker>(); // key: stand uuid, value: marker
  private observedBikes = new Map<string, L.Marker>(); // key: bike uuid, value: marker

  // ride data
  stands: StandDTO[] = [];
  stands1: StandDTO[] = [];
  stands2: StandDTO[] = [];
  fromStand: string = ""; // its only UUID of the stand, not the full object!
  toStand: string = ""; // its only UUID of the stand, not the full object!
  toStandName: string = "";
  distanceToEnd: number = 0;

  constructor(private standService: StandService,
              private toastr: ToastrService,
              private userService: UserService,
              private orsService: OpenRouteServiceService,
              private pathFollower: PathFollowerService,
              private rideService: RideService,
              private webSocketService: ActiveMQSubscriptionService) { }

  ngOnInit(): void {
    // render map first, in case backend isn't running/ responding (so it doesn't slow/ break the front page)
    this.initMap();

    this.renderStands();

    this.webSocketService.getBikeLocationUpdates().subscribe((location) => {
      this.handleBikeLocationUpdateMessage(location);
    });

    this.webSocketService.getBikeRemovalUpdates().subscribe((bikeId) => {
      this.handleBikeObservationRemovalMessage(bikeId);
    });
  }

  /**
   * Wrapper for checking if user is logged in.
   */
  isUserLoggedIn(): boolean {
    return this.userService.isUserLoggedIn();
  }

  /**
   * Updates select box values for starting ride.
   */
  updateFromStandOptions() {
    if (this.toStand) {
      this.stands1 = this.filterOutStandsWithNoBikes(this.prepareStandValues(this.toStand));
    }

    this.toStandName = this.stands.filter((stand: StandDTO) => stand.id === this.toStand)[0]?.name;
  }

  /**
   * updates select box values for starting ride.
   */
  updateToStandOptions() {
    if (this.fromStand) {
      this.stands2 = this.prepareStandValues(this.fromStand)
    }
  }

  /**
   * Starts a ride.
   */
  startRide() {
    // this shouldn't occur, because select boxes only exclude value from each other
    if (this.fromStand === this.toStand) {
      this.toastr.error("You can't start ride from and to the same stand.", "Ride error");
      return;
    }

    // not sure if observable can be const
    let bikeObs = this.standService.getBikeFromStand(this.fromStand);
    this.handleStartRideBikeObs(bikeObs);
  }

  /**
   * Gets the state of ENUM RideStatus as number. See PathFollowerService for the enum values.
   */
  getRideStatus(): number {
    return this.pathFollower.rideState;
  }

  /**
   * Finishes a ride.
   */
  finishRide() {
    this.rideService.finishRide().subscribe({
      next: (data: any) => {
        this.pathFollower.rideState = RideState.NO_RIDE; // FINISHED -> NO_RIDE
        this.map.removeLayer(this.pathFollower.marker);
        this.map.removeLayer(this.pathFollower.path);
        this.toastr.success("Ride finished successfully.", "Ride success");
      },
      error: (err) => {
        this.toastr.error("Failed to finish ride.", "Ride error");
      },
      complete: () => {
        this.renderStands();
      }
    });
  }

  /**
   * Initializes the map.
   * @private
   */
  private initMap(): void {
    this.map = L.map('map', {
      center: this.centroid,
      zoom: 13
    });

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 20,
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);
  }

  /**
   * Renders a stand marker on the map.
   * @param stand A stand for which the marker is rendered.
   */
  private renderStandMarker(stand: StandDTO): void {
    const lat = stand?.location?.latitude ?? -1;
    const lng = stand?.location?.longitude ?? -1;
    const bikeCnt = stand?.availableBikes ?? 0;

    // don't draw markers if lat or lng is not set (?)
    if (lat === -1 || lng === -1) {
      console.log(`lat or lng is not set for stand ${stand?.name}`);
      return;
    }

    let standMarker = L.marker([lat, lng], {
      icon: this.prepareStandIcon(bikeCnt),
      draggable: false
    }).addTo(this.map);

    // stand.id should be there, but defense programming
    if (stand?.id) {
      this.standMarkers.set(stand.id, standMarker);
    }
  }

  /**
   * Initializes select boxes for starting and ending a ride.
   * @private
   */
  private initSelectBoxStands() {
    this.stands1 = this.filterOutStandsWithNoBikes(this.prepareStandValues(null));
    if (this.stands1.length > 0) {
      this.fromStand = this.stands1[0]?.id;
    }

    this.stands2 = this.prepareStandValues(this.fromStand);
    if (this.stands2.length > 0) {
      this.toStand = this.stands2[0]?.id;
      this.toStandName = this.stands2[0]?.name;
      this.stands1 = this.stands1.filter((stand: StandDTO) => stand.id !== this.toStand)
    }
  }

  /**
   * Prepares values for select boxes.
   * @param alreadyUsedId exclude this value from the list
   * @return returns the modified stand list
   * @private
   */
  private prepareStandValues(alreadyUsedId: string | null): StandDTO[] {
    let values = this.stands.slice();

    if (values.length > 0 && alreadyUsedId !== null) {
      values = values.filter((stand: StandDTO) => stand.id !== alreadyUsedId);
    }

    return values;
  }

  /**
   * Modifies stand list to exclude stands with no bikes, so the
   * @param stands
   * @return modified stand list
   * @private
   */
  private filterOutStandsWithNoBikes(stands: StandDTO[]): StandDTO[] {
    return stands.filter((stand: StandDTO) => stand.availableBikes > 0);
  }

  /**
   * Handles the bike observable. This is a part of starting a ride.
   * @param bikeObs observable for GET /stand/{standId}/bike
   * @private
   */
  private handleStartRideBikeObs(bikeObs: Observable<BikeDTO>) {
    bikeObs.subscribe({
      next: (bike: BikeDTO) => {
        let rideObs = this.rideService.postNewRide(this.fromStand, this.toStand, bike?.id);
        this.handleStartRideNewRideObs(rideObs);
      },
      error: (err) => {
        this.toastr.error("Failed to retrieve bike.", "Bike error");
      }
    });
  }

  /**
   * Handles the ride observable. This is a part of starting a ride.
   * @param bikeObs observable for POST /ride/start
   * @private
   */
  private handleStartRideNewRideObs(bikeObs: Observable<RideDTO>) {
    bikeObs.subscribe({
      next: (ride: RideDTO) => {
        this.toastr.success("Ride started successfully.", "Ride success");

        this.rideService.setRide(ride, this.fromStand, this.toStand);

        // update marker number, to make app look more responsive
        const fromStandObj = this.stands.filter((stand: StandDTO) => stand.id === this.fromStand)[0];
        if ((fromStandObj.availableBikes - 1) >= 0) {
          fromStandObj.availableBikes--;

          const marker = this.standMarkers.get(this.fromStand);
          if (marker) {
            // update the marker's icon (client side only, backend is already updated, but this avoids fetching stands again)
            marker.setIcon(this.prepareStandIcon(fromStandObj.availableBikes));
          }
        }

        this.startRideOnMap()
      },
      error: (err) => {
        this.toastr.error("Failed to start ride.", "Ride error");
      }
    });
  }

  /**
   * Starts a ride on the map. Requests a route from ORS and draws it. Also starts a marker following this path.
   * Starts observers (intervals) for updating distance, moving the bike and finishing the ride.
   * @private
   */
  private startRideOnMap() {
    // index 0, because filtering by id can only return 1 stand (unless someone tries something funny i guess..)
    const fromStandObj = this.stands.filter((stand: StandDTO) => stand.id === this.fromStand)[0];
    const toStandObj = this.stands.filter((stand: StandDTO) => stand.id === this.toStand)[0];

    this.orsService.requestRoute(fromStandObj?.location?.latitude, fromStandObj?.location?.longitude,
                                 toStandObj?.location?.latitude,   toStandObj?.location?.longitude).subscribe({
      next: (data) => {
        let coordinates = data?.features[0]?.geometry?.coordinates;
        if (coordinates && coordinates.length > 0) {
          coordinates = coordinates.map((coord: any) => [coord[1], coord[0]]); // swap lat and lon

          const pathAndMarker = this.drawRideOnMap(coordinates)
          this.pathFollower.startFollowingRide(pathAndMarker[0], pathAndMarker[1]);
          this.keepUpdatingDistanceToEnd();
        } else {
          this.toastr.error("Route request was successful, but failed to retrieve coordinates.", "Route error");
        }
      },
      error: (err) => {
        this.toastr.error("Failed to retrieve route.", "Route error");
      }
    })
  }

  /**
   * Draws an animated marker which moves along a path. This path is created from coordinates.
   * @param coordinates coordinates of the path
   * @return tuple of [path, animatedMarker]
   * @private
   */
  private drawRideOnMap(coordinates: any): [L.Polyline, L.Marker] {
    // draw polyline representing the path (on roads, the coordinates are fetched from ORS using actual roads)
    let actualPath = L.polyline(coordinates, {color: 'blue'}).addTo(this.map)

    const interval = environment.rideIntervalInMs ?? 2000;
    const distance = environment.rideDistancePerIntervalInM ?? 500;

    // https://github.com/Igor-Vladyka/leaflet.motion/issues/6#issuecomment-681949015 (L as any) thingy
    let animatedMarker = (L as any).animatedMarker(actualPath.getLatLngs(), {
      distance: distance,
      interval: interval,
      icon: L.icon({
        iconUrl: 'assets/marker-bike-green.png',
        iconSize: [25, 39],
        iconAnchor: [0, 39]
      }),
      draggable: false,
      onEnd: () => {
        this.pathFollower.rideState = RideState.FINISHED_NO_TRACKING;
      }
    }).addTo(this.map);

    // the animation should auto-start but this cant hurt
    animatedMarker.start();

    return [actualPath, animatedMarker];
  }

  /**
   * Starts an interval for updating distance to end of the ride, which is displayed to the user.
   * @private
   */
  private keepUpdatingDistanceToEnd() {
    const period = environment.rideIntervalInMs ?? 2000;

    interval(period).pipe(
      takeWhile(() => (this.pathFollower.rideState ===  RideState.TRACKING_UNFINISHED ||
                                this.pathFollower.rideState === RideState.TRACKING_UNFINISHED_IN_PROXIMITY))
    ).subscribe({
      next: () => {
        const toStandObj = this.stands.filter((stand: StandDTO) => stand.id === this.toStand)[0];
        this.distanceToEnd = this.pathFollower.calculateDistanceToEnd(toStandObj?.location?.latitude,
                                                                      toStandObj?.location?.longitude);
      },
      complete: () => {
        this.finishRide();
      }
    });
  }

  /**
   * Creates a marker representing a stand.
   * @param bikeCnt
   * @private
   */
  private prepareStandIcon(bikeCnt: number): L.ExtraMarkers.Icon {
    // draw stands without bikes as orange (bikes can be deposited but rides cant be started from there)
    const markerColor = bikeCnt > 0 ? 'cyan' : 'orange';

    return L.ExtraMarkers.icon({
      icon: 'fa-number',
      number: bikeCnt.toString(),
      markerColor: markerColor,
      shape: 'square',
    });
  }

  /**
   * Handles a bike location update message from ActiveMQ websocket.
   * @param location JSON string as {bikeId: string, latitude: number, longitude: number}
   * @private
   */
  private handleBikeLocationUpdateMessage(location: string) {
    const locationObj = JSON.parse(location);
    const bikeId = locationObj.bikeId;
    const lat = locationObj.latitude;
    const lng = locationObj.longitude;

    // this means there is a ride in progress (filtering out the location of this client)
    if (this.getRideStatus() >= RideState.TRACKING_UNFINISHED &&
        this.getRideStatus() <= RideState.FINISHED_NO_TRACKING) {
      if (this.rideService.ride?.bike?.id === bikeId) {
        // DO NOT update location if its this clients ride
        return;
      }
    }

    if (!this.observedBikes.has(bikeId)) {
      this.observedBikes.set(bikeId, this.getBikeObserverMarker(lat, lng));
    }

    const marker = this.observedBikes.get(bikeId);
    marker?.setLatLng([lat, lng]);
  }

  /**
   * Creates a marker representing an observed bike.
   * @param lat latitude
   * @param lng longitude
   * @return marker
   * @private
   */
  private getBikeObserverMarker(lat: number, lng: number): L.Marker {
    return L.marker([lat, lng], {
      icon: L.icon({
        iconUrl: 'assets/marker-bike-gray-no-border.png',
        iconSize: [25, 39],
        iconAnchor: [0, 39]
      }),
      draggable: false
    }).addTo(this.map);
  }

  /**
   * Handles a bike observation removal message from ActiveMQ websocket.
   * @param bikeIdJson JSON string as {bikeId: string}
   * @private
   */
  private handleBikeObservationRemovalMessage(bikeIdJson: string) {
    const bikeId = JSON.parse(bikeIdJson).bikeId;

    if (this.observedBikes.has(bikeId)) {
      const marker = this.observedBikes.get(bikeId);

      // remove marker from map
      if (marker) {
        this.map.removeLayer(marker);
      }

      this.observedBikes.delete(bikeId);
    }
  }

  /**
   * Renders all stands to the map.
   * @private
   */
  private renderStands() {
    this.standService.getAllStands().subscribe({
      next: (data: StandDTO[]) => {
        this.stands = data;

        this.initSelectBoxStands()

        data.forEach((stand: StandDTO) => {
          this.renderStandMarker(stand);
        });
      },
      error: (err) => {
        this.toastr.error("Failed to retrieve stands.", "Stands error");
      }
    });
  }

  protected readonly RideState = RideState;
}
