package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.*;
import cz.zcu.kiv.pia.bikesharing.data.repository.IBikeRepository;
import cz.zcu.kiv.pia.bikesharing.data.repository.IRideRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.geotools.referencing.GeodeticCalculator;

import java.util.Collection;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link IRideService}.
 */
@Service
public class RideService implements IRideService {
    private static final Logger logger = getLogger(RideService.class);
    private final IRideRepository rideRepository;
    private final IBikeService bikeService;
    private final IBikeRepository bikeRepository;

    @Autowired
    public RideService(IRideRepository rideRepository, IBikeService bikeService, IBikeRepository bikeRepository) {
        this.rideRepository = rideRepository;
        this.bikeService = bikeService;
        this.bikeRepository = bikeRepository;
    }

    @Override
    public Ride startRide(User user, Bike bike, Stand startStand) {
        if (bike == null) {
            throw new BikeNotFoundException();
        }
        if (startStand == null) {
            throw new StandNotFoundException();
        }

        logger.info("Starting ride for user {} on bike {} from stand {}", user.getUsername(), bike.getId(), startStand.getId());

        if (rideRepository.hasUserRideInProgress(user)) {
            logger.warn("User {} already has a ride in progress", user.getUsername());
            throw new UserAlreadyRidingException();
        }
        if (bike.getStand() == null) {
            logger.warn("Bike {} is not at any stand", bike.getId());
            throw new BikeAlreadyOnRideException();
        }
        if (bike.getStand().getId() != startStand.getId()) { // comparing instances is unreliable, using id
            logger.warn("Bike {} is not at stand {}", bike.getId(), startStand.getId());
            throw new BikeNotAtStandException();
        }

        Ride ride = new Ride(user, bike, startStand);

        try {
            var res = rideRepository.save(ride);

            bikeService.startBikeRide(bike.getId(), startStand.getLocation()); // if this fails, we ignore it (ride already exists)

            if (res != null) {
                return res;
            }
        } catch (Exception ex) {
            logger.error("Failed to save ride.", ex);
        }

        logger.error("Failed to save ride but no exception was thrown.");
        // if res is null or exception was thrown then return null -> consider that server error
        return null;
    }

    @Override
    public void completeRide(Ride ride, Bike bike, Stand endStand) throws BikeNotFoundException, RideNotFoundException, BikeNotCloseToStandException, IllegalStateException {
        var existingRide = rideRepository.getById(ride.getId());

        if (bike == null || endStand == null) {
            logger.error("Bike and stand of ride {} must be provided", ride.getId());
            throw new BikeNotFoundException();
        }
        if (existingRide == null) {
            logger.error("Ride {} not found", ride.getId());
            throw new RideNotFoundException(ride);
        }

        logger.info("Completing ride {} at stand {}", ride.getId(), endStand.getId());

        if (existingRide.isCompleted()) {
            logger.error("Ride {} is already completed", existingRide);

            if (bike.getStand() == null) {
                logger.error("Bike {} is not at any stand, but the ride is already completed", bike.getId());
                // could try to save bike here, but its could be on another ride and this was reached through malicious request
            }

            throw new IllegalStateException("Ride %s is already completed.".formatted(ride.getId()));
        }

        double proximityDist = calculateDistance(bike.getLocation().getLatitude(), bike.getLocation().getLongitude(),
                endStand.getLocation().getLatitude(), endStand.getLocation().getLongitude());

        if (proximityDist == -1) {
            // logging is done by calculateDistance
            throw new IllegalStateException("Failed to calculate distance between bike and stand.");
        }
        if (proximityDist > 50) {
            logger.warn("Bike {} is not close enough to stand {}", bike.getId(), endStand.getId());
            throw new BikeNotCloseToStandException();
        }

        existingRide.complete(endStand);
        rideRepository.save(existingRide);
        bikeRepository.save(existingRide.getBike());
    }

    @Override
    public Collection<Ride> getRides(User user) {
        logger.info("Getting rides of user {}", user);

        return rideRepository.getByUser(user);
    }

    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        GeodeticCalculator calculator = new GeodeticCalculator();

        try {
            calculator.setStartingGeographicPoint(lon1, lat1);
            calculator.setDestinationGeographicPoint(lon2, lat2);
        } catch (Exception e) {
            logger.error("Failed to create coordinates to calculate distance", e);
            return -1;
        }

        return calculator.getOrthodromicDistance(); // Distance in meters
    }

    /**
     * This is intentionally not part of the interface, because it shouldn't normally be used. It sets all rides
     * to state COMPLETED.
     */
    public void completeAllRides() {
        logger.warn("Completing all rides!");
        rideRepository.completeAllRides();
    }
}
