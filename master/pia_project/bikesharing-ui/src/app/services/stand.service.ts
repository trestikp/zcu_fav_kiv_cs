import {Injectable} from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {StandDTO} from "../model/stand-dto";
import {BikeDTO} from "../model/bike-dto";

/**
 * Service to handle stand-related requests.
 */
@Injectable({
  providedIn: 'root'
})
export class StandService {
  private apiUrl = environment.backendUrl;

  constructor(private http: HttpClient) { }

  /**
   * Returns all stands.
   */
  getAllStands(): Observable<StandDTO[]> {
    return this.http.get<StandDTO[]>(`${this.apiUrl}/stand`);
  }

  /**
   * Requests an available bike from a stand.
   * @param standId
   */
  getBikeFromStand(standId: string): Observable<BikeDTO> {
    return this.http.get<BikeDTO>(`${this.apiUrl}/stand/${standId}/bike`);
  }
}
