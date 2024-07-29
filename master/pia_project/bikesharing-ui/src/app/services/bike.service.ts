import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {BikeDTO} from "../model/bike-dto";
import {LocationDTO} from "../model/location-dto";
import {MoveBikeWebSocketService} from "./move-bike-web-socket.service";
import {BikeLocationWsMessage} from "../model/bike-location-ws-message";
import {SessionStorageService} from "./session-storage.service";

/**
 * Service to handle bike-related requests.
 */
@Injectable({
  providedIn: 'root'
})
export class BikeService {
  private apiUrl = environment.backendUrl;

  constructor(private http: HttpClient,
              private moveBikeWebSocket: MoveBikeWebSocketService,
              private sessionStorage: SessionStorageService) { }

  /**
   * Returns all bikes due for service.
   */
  getBikesDueForService() {
    return this.http.get<BikeDTO[]>(`${this.apiUrl}/bike/serviceable`, { });
  }

  /**
   * Marks a bike as serviced.
   * @param bikeId
   */
  postBikeServiced(bikeId: string) {
    return this.http.post(`${this.apiUrl}/bike/${bikeId}/service`, { });
  }

  /**
   * Posts a new bike location. Originally it used to be post through REST api, but now it works through websocket.
   * @param bikeId
   * @param latitude
   * @param longitude
   */
  postBikeMoveLocation(bikeId: string, latitude: number, longitude: number) {
    // const locationDto: LocationDTO = {
    //   latitude: latitude,
    //   longitude: longitude
    // }
    // return this.http.post(`${this.apiUrl}/bike/${bikeId}/location`, locationDto);

    // location updates via websocket
    const webSocketMessage: BikeLocationWsMessage = {
      jwtToken: this.sessionStorage.getToken() ?? "",
      bikeId: bikeId,
      latitude: latitude,
      longitude: longitude
    }

    this.moveBikeWebSocket.sendMoveBikeMessage(JSON.stringify(webSocketMessage));
  }
}
