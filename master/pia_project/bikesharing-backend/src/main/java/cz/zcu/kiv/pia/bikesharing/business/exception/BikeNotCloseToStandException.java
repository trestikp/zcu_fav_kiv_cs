package cz.zcu.kiv.pia.bikesharing.business.exception;

/**
 * Thrown when a bike is not close to a stand. This is thrown by proximity check (required 50m)
 */
public class BikeNotCloseToStandException extends IllegalStateException {
}
