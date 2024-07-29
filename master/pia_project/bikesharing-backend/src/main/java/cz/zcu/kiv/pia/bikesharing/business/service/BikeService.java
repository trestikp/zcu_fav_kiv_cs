package cz.zcu.kiv.pia.bikesharing.business.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Location;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeAlreadyOnRideException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotFoundException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotServiceableException;
import cz.zcu.kiv.pia.bikesharing.data.repository.IBikeRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

import java.time.Period;
import java.util.Collection;
import java.util.Map;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Service for manipulating bikes. For method documentation see {@link IBikeService}
 */
@Service
public class BikeService implements IBikeService {
    private static final Logger logger = getLogger(BikeService.class);

    private final IBikeRepository bikeRepository;
    private final JmsTemplate jmsTemplate;
    private final Period serviceInterval;
    private final ObjectMapper objectMapper;

    @Autowired
    public BikeService(IBikeRepository bikeRepository, @Qualifier("jmsTopicTemplate") JmsTemplate jmsTemplate, Period serviceInterval) {
        this.bikeRepository = bikeRepository;
        this.jmsTemplate = jmsTemplate;
        this.serviceInterval = serviceInterval;
        this.objectMapper = new ObjectMapper();
    }

    @Override
    public Collection<Bike> getBikesDueForService() {
        logger.debug("Getting bikes due for service");
        return bikeRepository.getBikesDueForService();
    }

    @Override
    public void markServiced(UUID bikeId) {
        logger.debug("Marking bike {} as serviced", bikeId);
        var existingBike = bikeRepository.getById(bikeId);

        if (!existingBike.isDueForService(serviceInterval)) {
            logger.info("Bike {} is not due for service", existingBike);
            throw new BikeNotServiceableException(existingBike);
        }

        existingBike.markServiced();
        bikeRepository.save(existingBike);
    }

    @Override
    public Bike getById(UUID bikeId) {
        logger.debug("Getting bike with id {}", bikeId);
        return bikeRepository.getById(bikeId);
    }

    @Override
    public void startBikeRide(UUID bikeId, Location initialLocation) {
        logger.debug("Starting bike {} on ride with initial location {}", bikeId, initialLocation);
        var bike = bikeRepository.getById(bikeId);
        bike.startBikeRide(initialLocation);
        bikeRepository.save(bike);
    }

    @Override
    public void moveBike(UUID bikeId, Location location) throws BikeNotFoundException, BikeAlreadyOnRideException {
        logger.trace("Moving bike {} to location {}", bikeId, location);
        var bike = bikeRepository.getById(bikeId);

        if (bike == null) {
            logger.info("Bike {} not found", bikeId);
            throw new BikeNotFoundException();
        }
        if (!isBikeOnRide(bike)) {
            logger.warn("Bike {} is not on ride", bikeId);
            throw new BikeAlreadyOnRideException();
        }

        bike.setLocation(location);
        bikeRepository.save(bike);

        try {
            logger.trace("Broadcasting bike {} location update", bikeId);

            var destination = "kiv.pia.bikesharing.bikes.location";
            var body = objectMapper.writeValueAsString(new BikeLocationDTO(bikeId, location));

            jmsTemplate.convertAndSend(destination, body);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

    private boolean isBikeOnRide(Bike bike) {
        logger.trace("Checking if bike {} is on ride", bike.getId());
        return bikeRepository.isBikeOnRide(bike);
    }

    @Override
    public void removeBikeFromClient(UUID bikeId) {
        try {
            logger.info("Broadcasting bike {} removal", bikeId);

            var destination = "kiv.pia.bikesharing.bikes.removal";
            var body = objectMapper.writeValueAsString(Map.of("bikeId", bikeId));

            jmsTemplate.convertAndSend(destination, body);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }


    /**
     * Bike location update transmitted through MQ.
     *
     * @param bikeId UUID of the bike
     * @param longitude Longitude in defined coordinates system.
     * @param latitude Latitude in defined coordinates system.
     */
    private record BikeLocationDTO(
            UUID bikeId,
            Double longitude,
            Double latitude
    ) {
        public BikeLocationDTO(UUID bikeId, Location location) {
            this(bikeId, location.getLongitude(), location.getLatitude());
        }
    }
}
