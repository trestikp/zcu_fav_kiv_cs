import {Directive, Input} from '@angular/core';
import {AbstractControl, NG_VALIDATORS, ValidationErrors, Validator, ValidatorFn} from "@angular/forms";

/**
 * Creates a directive, that can be used to validate that a password and password confirmation field match.
 */
@Directive({
  selector: '[appPasswordConfirmation]',
  providers: [
    {
      provide: NG_VALIDATORS,
      useExisting: PasswordConfirmationDirective,
      multi: true,
    },
  ],
  standalone: true
})
export class PasswordConfirmationDirective implements Validator {

  /**
   * Retrieves password from HTML and compares it to "control" value (control is passwordVerification).
   * @param control
   */
  validate(control: AbstractControl): ValidationErrors | null {
    const password = control.root?.get('password');

    return password && control && password.value !== control.value
      ? { mismatch: true }
      : null;
  }
}
