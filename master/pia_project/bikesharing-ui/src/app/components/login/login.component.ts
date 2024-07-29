import {Component} from '@angular/core';
import {CommonModule} from '@angular/common';
import {FormsModule} from "@angular/forms";
import {AuthService} from "../../services/auth.service";
import {Router} from "@angular/router";
import {SessionStorageService} from "../../services/session-storage.service";
import {environment} from "../../../environments/environment";
import {AuthResponse} from "../../model/auth-response";

/**
 * Component for handling user login.
 */
@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  form: any = {
    username: null,
    password: null
  };
  isLoggedIn = false;
  isLoginFailed = false;
  errorMessage = '';

  constructor(private authService: AuthService,
              private storage: SessionStorageService,
              private router: Router) { }

  ngOnInit(): void {
    if (this.storage.getToken()) {
      this.isLoggedIn = true;
    }
  }

  /**
   * Login form submit function.
   */
  onSubmit(): void {
    this.authService.login(this.form.username, this.form.password).subscribe({
      next: (data: AuthResponse) => {
        if (this.authService.handleLoginSuccess(data)) {
          this.isLoggedIn = true;
          this.isLoginFailed = false;
        } else {
          this.isLoginFailed = true;
          this.isLoggedIn = false;
          this.errorMessage = 'Server returned success, but no token was provided.';
        }
      },
      error: (err) => {
        this.isLoginFailed = true;
        this.isLoggedIn = false; // just to be sure
        this.errorMessage = err.error.message;
      }
    });
  }

  /**
   * Login with GitHub, redirects to GitHub OAuth2 login page.
   */
  loginWithGitHub(): void {
    const clientId = environment.clientId
    const redirectUri = environment.redirectUri;
    const authorizationUri = environment.authorizationUri;

    window.location.href = `${authorizationUri}?client_id=${clientId}&redirect_uri=${redirectUri}`;
  }
}
