package cz.zcu.kiv.pia.bikesharing.business.exception;

/**
 * Thrown when email is already taken during registration.
 */
public class EmailAlreadyTakenException extends IllegalArgumentException {
    public final String email;

    public EmailAlreadyTakenException(String email) {
        super("Email %s is already taken.".formatted(email));
        this.email = email;
    }
}
