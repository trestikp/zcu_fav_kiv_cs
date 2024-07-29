package cz.zcu.kiv.pia.bikesharing.business.exception;

/**
 * Thrown when token received token is invalid.
 */
public class InvalidTokenException extends RuntimeException {
    String message;

    public InvalidTokenException(String message) {
        this.message = message;
    }
}
