package cz.zcu.kiv.pia.bikesharing.business.exception;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;

/**
 * Thrown when {@link User} has insufficient permission.
 */
public class InsufficientPermissionException extends RuntimeException {
    public final User bike;

    public InsufficientPermissionException(User user) {
        super("User " + user.getUsername() + " has insufficient permission.");
        this.bike = user;
    }
}
