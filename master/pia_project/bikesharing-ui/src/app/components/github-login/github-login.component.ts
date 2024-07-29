import {Component} from '@angular/core';
import {CommonModule} from '@angular/common';
import {ActivatedRoute, Router} from "@angular/router";
import {AuthService} from "../../services/auth.service";
import {ToastrService} from "ngx-toastr";
import {AuthResponse} from "../../model/auth-response";

export const SUCCESS_REDIRECT_TIMEOUT_MS = 2000;

/**
 * Component for handling GitHub login. GitHub OAuth2 authenticates the user and redirects the user here.
 */
@Component({
  selector: 'app-github-login',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './github-login.component.html',
  styleUrl: './github-login.component.css'
})
export class GithubLoginComponent {
  loginSuccess: boolean = false;
  errorCode: string = 'Unknown error';
  errorMessage: string = 'An error occurred but no details were provided.';

  constructor(private route: ActivatedRoute,
              private router: Router,
              private authService: AuthService,
              private toastr: ToastrService) { }

  ngOnInit(): void {
    const code = this.route.snapshot.queryParamMap.get('code');
    const error = this.route.snapshot.queryParamMap.get('error');
    const errorDesc = this.route.snapshot.queryParamMap.get('error_description');

    if (code != null && code.trim() !== '') {
      this.loginSuccess = true;

      if (this.loginWithGitHub(code)) {
        // only redirect if login was successful
        this.redirectAfterTimeout(SUCCESS_REDIRECT_TIMEOUT_MS);
      }
    } else if (error != null) {
      this.loginSuccess = false;
      this.errorCode = error;

      if (errorDesc != null) {
        this.errorMessage = errorDesc;
      }
    }
  }

  /**
   * After small timeout redirects to home page. The only reason for the delay is to let the user know, that the
   * login was successful.
   * @param delayInMs
   * @private
   */
  private redirectAfterTimeout(delayInMs: number = 2000) {
    setTimeout(() => {
      this.router.navigate(['/']);
    }, delayInMs);
  }

  /**
   * After GitHub redirects there, this function sends the github code to the backend for verification.
   * @param code GitHub code
   * @return true on success, false otherwise
   */
  private loginWithGitHub(code: string): boolean {
    this.authService.githubLogin(code).subscribe({
      next: (data: AuthResponse) => {
        if (this.authService.handleLoginSuccess(data)) {
          this.loginSuccess = true;
        } else {
          this.toastr.error('Server returned success, but no token was provided.', 'Login error');
        }

        return true;
      },
      error: (err) => {
        this.loginSuccess = false;

        // not sure what data type is err, so no specific properties are used
        this.errorCode = 'Server error';
        this.errorMessage = err.toString();
      }
    });

    return false;
  }
}
