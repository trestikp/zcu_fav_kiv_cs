package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;

import java.util.Collection;
import java.util.UUID;

/**
 * Repository storing all information about bike rides.
 */
public interface IRideRepository extends ICommonRepository<Ride, UUID> {
    /**
     * Retrieves all rides that given user has completed in the past, including any ride which
     * might be ongoing at the moment.
     *
     * @param user User doing bike rides
     * @return All rides of given user
     */
    Collection<Ride> getByUser(User user);

    /**
     * Checks if user has any ride in progress or not.
     * @param user User for which to check
     * @return True if user has any ride in progress, false otherwise
     */
    boolean hasUserRideInProgress(User user);

    /**
     * This should preferably NOT be a part of the interface. It bypasses all logic and just sets all unfinished
     * rides as completed.
     */
    void completeAllRides();
}
