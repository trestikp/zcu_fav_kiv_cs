package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.business.exception.NoRideableBikeException;
import cz.zcu.kiv.pia.bikesharing.business.exception.NonExistentEntityException;
import cz.zcu.kiv.pia.bikesharing.business.exception.StandIsEmptyException;
import cz.zcu.kiv.pia.bikesharing.data.repository.IStandRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Period;
import java.util.Collection;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link IStandService}.
 */
@Service
public class StandService implements IStandService {
    private static final Logger logger = getLogger(StandService.class);
    private final IStandRepository standRepository;
    private final Period serviceInterval;


    @Autowired
    public StandService(IStandRepository standRepository, Period serviceInterval) {
        this.standRepository = standRepository;
        this.serviceInterval = serviceInterval;
    }

    @Override
    public Collection<Stand> getAll() {
        logger.debug("Getting all stands");
        return standRepository.getAll();
    }

    @Override
    public Stand getStandById(UUID id) {
        logger.debug("Getting stand with id {}", id);
        return standRepository.getById(id);
    }

    @Override
    public Bike getAvailableBikeFromStand(UUID standId) throws StandIsEmptyException, NonExistentEntityException, NoRideableBikeException {
        Stand stand = standRepository.getById(standId);
        if (stand == null) {
            logger.error("Stand with id {} does not exist", standId);
            throw new NonExistentEntityException();
        }

        logger.debug("Getting available bike from stand {}", standId);

        var bikes = stand.getBikes();
        if (bikes.isEmpty()) {
            logger.warn("Stand {} is empty", standId);
            throw new StandIsEmptyException();
        }

        var bikeOptional = bikes.stream().filter(bike -> !bike.isDueForService(serviceInterval)).findFirst();
        if (bikeOptional.isPresent()) {
            return bikeOptional.get();
        } else {
            logger.warn("Stand {} has bikes, but non is rideable", standId);
            throw new NoRideableBikeException();
        }
    }

    @Override
    public void prepareRideableBikeCountFromStand(Stand stand) {
        logger.debug("Preparing rideable bike count for stand {}", stand.getId());
        if (stand.getBikes() != null && !stand.getBikes().isEmpty()) {
            var bikeCount = (int) stand.getBikes().stream().filter(bike -> !bike.isDueForService(serviceInterval)).count();
            stand.setRideableBikeCount(bikeCount);
        }
    }
}
