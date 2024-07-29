import { Injectable } from '@angular/core';
import {SessionStorageService} from "./session-storage.service";

/**
 * Service to handle user-related requests.
 */
@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private sessionStorage: SessionStorageService) { }

  /**
   *  Returns whether the user is logged in or not.
   */
  isUserLoggedIn(): boolean {
    return this.sessionStorage.getToken() !== null && this.sessionStorage.getToken()?.trim() !== '';
  }
}
