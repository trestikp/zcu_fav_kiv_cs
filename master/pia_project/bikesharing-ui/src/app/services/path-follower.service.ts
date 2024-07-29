import { Injectable } from '@angular/core';
import {interval, takeWhile} from "rxjs";
import {environment} from "../../environments/environment";
import * as geolib from 'geolib';
import {RideService} from "./ride.service";
import {BikeService} from "./bike.service";

export enum RideState {
  NO_RIDE = 0,                          // no ride in progress -> display ride start selection
  TRACKING_UNFINISHED = 1,              // ride in progress -> display ride status, but no button to finish
  TRACKING_UNFINISHED_IN_PROXIMITY = 2, // ride in progress, but user is in proximity of the end stand -> display button to finish
  FINISHED_NO_TRACKING = 3,             // ride finished = finished tracking -> display finish button, requires user action
  FINISHED = 4                          // doesn't have much use: FINISHED -> NO_RIDE
}

/**
 * Service to handle path following for a ride.
 */
@Injectable({
  providedIn: 'root'
})
export class PathFollowerService {
  rideState: RideState = RideState.NO_RIDE;
  // not sure if typing below properties is ok, leaving any
  marker: any; // L.AnimatedMarker (child of L.Marker)
  path: any; // L.Polyline

  constructor(private rideService: RideService,
              private bikeService: BikeService) { }

  /**
   * Starts following a ride. Sets initial state, path, marker and start interval to update location (on the backend).
   * @param path
   * @param marker
   */
  startFollowingRide(path: any, marker: any) {
    this.rideState = RideState.TRACKING_UNFINISHED;
    this.path = path;
    this.marker = marker;

    const rideInterval = environment.rideIntervalInMs ?? 5000;

    interval(rideInterval).pipe(
      // keep updating location as long as ride is moving (being tracked)
      takeWhile(() => (this.rideState === RideState.TRACKING_UNFINISHED ||
                                this.rideState === RideState.TRACKING_UNFINISHED_IN_PROXIMITY))
    ).subscribe(() => {
      const bike = this.rideService.ride?.bike;
      if (!bike) {
        console.log("No bike found in ride, cannot update location. This shouldn't occur, so user is not informed.");
        return;
      }

      // no subscribing thanks to using websocket
      this.bikeService.postBikeMoveLocation(bike.id, this.marker.getLatLng().lat, this.marker.getLatLng().lng);

      // not doing anything based on the request result, user doesn't care about successfully updating backend location or not
      // this.bikeService.postBikeMoveLocation(bike.id, this.marker.getLatLng().lat, this.marker.getLatLng().lng).subscribe({
      //   next: (data) => { },
      //   error: (err) => { }
      // });
    });
  }

  /**
   * Calculates a distance from current location to the chosen end stand.
   * @param endLat
   * @param endLng
   */
  calculateDistanceToEnd(endLat: number, endLng: number) {
    const currentLat = this.marker.getLatLng().lat;
    const currentLng = this.marker.getLatLng().lng;
    const distance = geolib.getDistance(
      {latitude: currentLat, longitude: currentLng},
      {latitude: endLat, longitude: endLng})

    // distance should already be in meters
    return distance;
  }
}
