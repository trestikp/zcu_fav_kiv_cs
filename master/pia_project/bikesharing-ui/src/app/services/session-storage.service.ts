import { Injectable } from '@angular/core';
import {AuthResponseUser} from "../model/auth-response-user";


const TOKEN_KEY = 'auth-token';
const USER_KEY = 'auth-user';

/**
 * Service to handle session storage.
 */
@Injectable({
  providedIn: 'root'
})
export class SessionStorageService {

  constructor() { }

  /**
   * Signs the user out. Clearing the session storage.
   */
  signOut(): void {
    window.sessionStorage.clear();
  }

  /**
   * Saves the token to the session storage.
   * @param token
   */
  public saveToken(token: string): void {
    window.sessionStorage.removeItem(TOKEN_KEY);
    window.sessionStorage.setItem(TOKEN_KEY, token);
  }

  /**
   * Returns the token from the session storage.
   */
  public getToken(): string | null {
    return window.sessionStorage.getItem(TOKEN_KEY);
  }

  /**
   * Saves the user to the session storage.
   * @param user
   */
  public saveUser(user: AuthResponseUser): void {
    window.sessionStorage.removeItem(USER_KEY);
    window.sessionStorage.setItem(USER_KEY, JSON.stringify(user));
  }

  /**
   * Returns the user from the session storage.
   */
  public getUser(): AuthResponseUser | null {
    const user = window.sessionStorage.getItem(USER_KEY);
    if (user) {
      return JSON.parse(user);
    }

    return null;
  }
}
