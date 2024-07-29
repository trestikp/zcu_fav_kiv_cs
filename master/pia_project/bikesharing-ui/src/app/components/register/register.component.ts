import {Component} from '@angular/core';
import {CommonModule} from '@angular/common';
import {FormsModule} from "@angular/forms";
import {AuthService} from "../../services/auth.service";
import {Router} from "@angular/router";
import {PasswordConfirmationDirective} from "./password-confirmation.directive";
import {ToastrService} from "ngx-toastr";

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, FormsModule, PasswordConfirmationDirective],
  templateUrl: './register.component.html',
  styleUrl: './register.component.css'
})
export class RegisterComponent {
  form: any = {
    name: null,
    username: null,
    email: null,
    password: null,
    passwordVerification: null
  };
  isSuccessful = false;
  isSignUpFailed = false;
  errorMessage = '';

  constructor(private authService: AuthService,
              private toastr: ToastrService,
              private router: Router) { }

  /**
   * Submits the registration form to the backend.
   */
  onSubmit() {
    this.authService.register(this.form.name, this.form.username, this.form.password, this.form.email).subscribe({
      next: (data) => {
        this.isSuccessful = true;
        this.isSignUpFailed = false;
        this.toastr.success('You have successfully registered! You can now log in.', 'Success');
        this.router.navigate(['/login']);
      },
      error: (err) => {
        // this is currently the best way to resolve this, getting errors to highlight in the form proved too difficult
        this.errorMessage = `Server responded with: ${err.error?.messages[0]?.message}`;
        this.isSignUpFailed = true;
      }
    });
  }
}
