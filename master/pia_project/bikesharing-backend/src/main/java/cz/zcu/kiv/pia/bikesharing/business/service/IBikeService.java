package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Location;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeAlreadyOnRideException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotFoundException;

import java.util.Collection;
import java.util.UUID;
import java.util.function.Consumer;

/**
 * Service supporting all use cases involving bikes.
 */
public interface IBikeService {

    /**
     * Retrieves all {@link Bike}s which are due for service, sorted by {@link Bike##lastServiceTimestamp} in ascending order
     *
     * @return All bikes which are due for service
     */
    Collection<Bike> getBikesDueForService();

    /**
     * Marks bike as serviced.
     * @param bikeId UUID of the bike
     */
    void markServiced(UUID bikeId);

    /**
     * Gets a specific bike.
     * @param bikeId UUID of desired bike
     * @return Retrieved bike.
     */
    Bike getById(UUID bikeId);

    /**
     * Starts a ride with this bike.
     * @param bikeId UUID of the bike
     * @param initialLocation Starting location of the ride. This is set as initial location of the bike. Corresponds
     *                        with stand location
     */
    void startBikeRide(UUID bikeId, Location initialLocation);

    /**
     * Moves {@link Bike} with given <code>bikeId</code> to a new <code>location</code>.
     *
     * @param bikeId Unique bike identifier
     * @param location New bike location
     */
    void moveBike(UUID bikeId, Location location) throws BikeNotFoundException, BikeAlreadyOnRideException;

    /**
     * Sends a message to ActiveMQ to "removal" topic, which tells the clients to stop observing this bike.
     * @param bikeId UUID of the bike.
     */
    void removeBikeFromClient(UUID bikeId);
}
