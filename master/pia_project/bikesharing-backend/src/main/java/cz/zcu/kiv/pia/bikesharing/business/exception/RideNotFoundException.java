package cz.zcu.kiv.pia.bikesharing.business.exception;

import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;

/**
 * Thrown when {@link Ride} is not found.
 */
public class RideNotFoundException extends IllegalStateException {
    public final Ride ride;

    public RideNotFoundException(Ride ride) {
        super("Ride %s was not found.".formatted(ride));
        this.ride = ride;
    }
}
