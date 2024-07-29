import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders, HttpParams} from "@angular/common/http";
import {environment} from '../../environments/environment';
import {Observable} from "rxjs";
import {Router} from "@angular/router";
import {SessionStorageService} from "./session-storage.service";
import {AuthResponse} from "../model/auth-response";
import {RegistrationForm} from "../model/registration-form";
import {LoginForm} from "../model/login-form";

const headers = new HttpHeaders({
  'Content-Type': 'application/x-www-form-urlencoded'
});

/**
 * Service to handle authentication.
 */
@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = environment.backendUrl;

  constructor(private http: HttpClient,
              private router: Router,
              private storage: SessionStorageService) { }

  /**
   * Logs the user in via form.
   * @param username
   * @param password
   */
  login(username: string, password: string): Observable<AuthResponse> {
    const loginForm: LoginForm = {
      username: username,
      password: password
    }

    return this.http.post<AuthResponse>(`${this.apiUrl}/auth/login`, loginForm);
  }

  /**
   * Logs the user in via GitHub OAuth.
   * @param code
   */
  githubLogin(code: string): Observable<AuthResponse> {
    const params = new HttpParams().set('code', code);

    return this.http.get<AuthResponse>(`${this.apiUrl}/auth/github`, {
      params
    });
  }

  /**
   * Registers new user via form.
   * @param name
   * @param username
   * @param password
   * @param email
   */
  register(name: string, username: string, password: string, email: string): Observable<any> {
    const regDto: RegistrationForm = {
      name: name,
      username: username,
      password: password,
      email: email
    }

    return this.http.post(`${this.apiUrl}/auth/register`, regDto);
  }

  /**
   * Action after successful login.
   * @param data
   */
  handleLoginSuccess(data: AuthResponse): boolean {
    // check if we actually got a token
    if (data?.token == null || data?.token?.trim() === '') {
      return false;
    }

    this.storage.saveToken(data?.token);
    this.storage.saveUser(data?.user);

    this.router.navigate(['/']);
    return true;
  }
}
