import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Observable} from "rxjs";

/**
 * Service to get real routes from OpenRouteService.
 */
@Injectable({
  providedIn: 'root'
})
export class OpenRouteServiceService {

  constructor(private http: HttpClient) { }

  requestRoute(startLat: number, startLon: number, endLat: number, endLon: number): Observable<any> {
    const ORSToken = environment.ORSToken;

    // start/ end points use "lon,lat" format
    return this.http.get(`https://api.openrouteservice.org/v2/directions/cycling-regular?api_key=${ORSToken}&start=${startLon},${startLat}&end=${endLon},${endLat}`);
  }
}
