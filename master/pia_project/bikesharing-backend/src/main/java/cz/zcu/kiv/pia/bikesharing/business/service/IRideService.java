package cz.zcu.kiv.pia.bikesharing.business.service;


import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotCloseToStandException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotFoundException;
import cz.zcu.kiv.pia.bikesharing.business.exception.RideNotFoundException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;

import java.util.Collection;

/**
 * Service supporting all use cases with bike {@link Ride}.
 */
public interface IRideService {
    /**
     * Starts a new {@link Ride} of given <code>user</code> and <code>bike</code> starting at given <code>startStand</code>.
     *
     * @param user User riding bike
     * @param bike Bike to be ridden by user
     * @return Started ride
     */
    Ride startRide(User user, Bike bike, Stand startStand) throws UnauthorizedException, IllegalStateException;

    /**
     * Completes given <code>ride</code> at given <code>endState</code>, i.e. returns {@link Bike} to the {@link Stand}.
     *
     * @param ride Started ride to be completed
     * @param endStand End stand where the ride is completed
     * @throws RideNotFoundException when ride is not found
     * @throws IllegalStateException when ride is not started and therefore cannot be completed
     */
    void completeRide(Ride ride, Bike bike, Stand endStand) throws BikeNotFoundException, RideNotFoundException, BikeNotCloseToStandException, IllegalStateException;

    /**
     * Retrieves all {@link Ride}s that given <code>user</code> has completed in the past, including
     * any {@link Ride} which might be ongoing at the moment.
     *
     * @param user User doing bike rides
     * @return All rides of given user
     */
    Collection<Ride> getRides(User user);
}
