package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;

import java.util.Collection;
import java.util.UUID;

/**
 * Repository storing all information related to bikes.
 */
public interface IBikeRepository extends ICommonRepository<Bike, UUID> {

    /**
     * Retrieves all bikes which are due for service, sorted by {@link Bike##lastServiceTimestamp} in ascending order
     *
     * @return All bikes which are due for service
     */
    Collection<Bike> getBikesDueForService();

    /**
     * Checks if bike is in a currently active ride.
     * @param bike Bike to check
     * @return True if bike is in a currently active ride, false otherwise
     */
    boolean isBikeOnRide(Bike bike);
}
