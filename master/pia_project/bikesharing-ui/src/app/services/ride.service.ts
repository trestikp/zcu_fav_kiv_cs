import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Observable} from "rxjs";
import {RideDTO} from "../model/ride-dto";
import {RideState} from "./path-follower.service";
import {SimplifiedRideDTO} from "../model/simplified-ride-dto";

/**
 * Service to handle ride-related requests.
 */
@Injectable({
  providedIn: 'root'
})
export class RideService {
  ride: RideDTO | undefined;
  startStandId: string = "";
  endStandId: string = "";

  private apiUrl = environment.backendUrl;

  constructor(private http: HttpClient) { }

  /**
   * Returns all rides of the current user.
   */
  getAllRides() {
    return this.http.get<RideDTO[]>(`${this.apiUrl}/ride`, { });
  }

  /**
   * Sets local data about ride.
   * @param ride
   * @param startStandId
   * @param endStandId
   */
  setRide(ride: RideDTO, startStandId: string, endStandId: string) {
    this.ride = ride;
    this.startStandId = startStandId;
    this.endStandId = endStandId;
  }

  /**
   * Sends a request to finish a ride.
   */
  finishRide() {
    const rideDto: SimplifiedRideDTO = {
      startStandId: this.startStandId,
      endStandId: this.endStandId,
      bikeId: this.ride?.bike?.id ?? ""
    };

    return this.http.post(`${this.apiUrl}/ride/${this.ride?.id}/complete`, rideDto);
  }

  /**
   * Posts a new ride.
   * @param fromStandId
   * @param toStandId
   * @param bikeId
   */
  postNewRide(fromStandId: string, toStandId: string, bikeId: string): Observable<RideDTO> {
    const rideDto: SimplifiedRideDTO = {
      startStandId: fromStandId,
      endStandId: toStandId,
      bikeId: bikeId
    };

    return this.http.post<RideDTO>(`${this.apiUrl}/ride/start`, rideDto);
  }
}
