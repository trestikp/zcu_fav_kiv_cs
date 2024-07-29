package cz.zcu.kiv.pia.bikesharing.business.exception;

/**
 * Thrown when username is already taken during registration.
 */
public class UsernameAlreadyTakenException extends IllegalArgumentException {
    public final String username;

    public UsernameAlreadyTakenException(String username) {
        super("Username %s is already taken.".formatted(username));
        this.username = username;
    }
}
