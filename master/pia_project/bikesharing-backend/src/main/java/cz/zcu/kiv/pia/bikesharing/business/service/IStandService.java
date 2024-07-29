package cz.zcu.kiv.pia.bikesharing.business.service;


import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.business.exception.NoRideableBikeException;
import cz.zcu.kiv.pia.bikesharing.business.exception.NonExistentEntityException;
import cz.zcu.kiv.pia.bikesharing.business.exception.StandIsEmptyException;

import java.util.Collection;
import java.util.UUID;

/**
 * Service for {@link Stand} management.
 */
public interface IStandService {
    /**
     * Retrieves all {@link Stand}s currently in the system.
     *
     * @return All stands
     */
    Collection<Stand> getAll();

    /**
     * Retrieves {@link Stand} with given <code>id</code>.
     * @param id Unique stand identifier
     * @return Stand with given <code>id</code>
     */
    Stand getStandById(UUID id);

    /**
     * Retrieves {@link Bike} from given <code>standId</code> which is available for ride.
     *
     * @param standId Unique stand identifier
     * @return Available bike from given stand
     * @throws StandIsEmptyException when stand is empty
     */
    Bike getAvailableBikeFromStand(UUID standId) throws StandIsEmptyException, NonExistentEntityException, NoRideableBikeException;

    /**
     * Prepares rideable bike count from given <code>stand</code> and sets it to <code>stand##rideableBikeCount</code>.
     * @param stand     Stand to get bike count from
     */
    void prepareRideableBikeCountFromStand(Stand stand);
}
