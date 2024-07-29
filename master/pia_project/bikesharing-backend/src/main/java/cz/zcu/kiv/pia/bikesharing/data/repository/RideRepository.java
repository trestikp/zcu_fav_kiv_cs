package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.data.dto.RideDB;
import cz.zcu.kiv.pia.bikesharing.data.mapper.RideMapper;
import cz.zcu.kiv.pia.bikesharing.data.mapper.UserMapper;
import cz.zcu.kiv.pia.bikesharing.data.repository.jpa.IJpaRideRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link IRideRepository}.
 */
@Primary
@Repository
public class RideRepository implements IRideRepository {
    private static final Logger logger = getLogger(RideRepository.class);
    private final IJpaRideRepository repository;

    @Autowired
    public RideRepository(IJpaRideRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Ride> getAll() {
        logger.trace("Getting all rides");
        return repository.findAll().stream().map(RideMapper.DB_TO_BUSINESS).toList();
    }

    @Override
    public Ride getById(UUID id) {
        logger.trace("Getting ride with id {}", id);
        return repository.findById(id).map(RideMapper.DB_TO_BUSINESS).orElse(null);
    }

    @Override
    public Ride save(Ride entity) {
        logger.trace("Saving ride {}", entity);
        var toBeSaved = RideMapper.BUSINESS_TO_DB.apply(entity);
        var savedEntity = repository.save(toBeSaved);
        return RideMapper.DB_TO_BUSINESS.apply(savedEntity);
    }

    @Override
    public void deleteById(UUID id) {
        logger.trace("Deleting ride with id {}", id);
        repository.deleteById(id);
    }

    @Override
    public Collection<Ride> getByUser(User user) {
        logger.trace("Getting rides for user {}", user.getUsername());
        var userDB = UserMapper.BUSINESS_TO_DB.apply(user);
        return repository.findAllByUserOrderByStartTimestampDesc(userDB).stream().map(RideMapper.DB_TO_BUSINESS).toList();
    }

    @Override
    public boolean hasUserRideInProgress(User user) {
        logger.trace("Checking if user {} has ride in progress", user.getUsername());
        return repository.hasUserRideInProgress(UserMapper.BUSINESS_TO_DB.apply(user));
    }

    @Override
    public void completeAllRides() {
        logger.warn("Someone is completing all rides!");

        var allStartedRides = repository.findAllByStateEquals(RideDB.StateDB.S);
        allStartedRides.forEach(ride -> {
            ride.setState(RideDB.StateDB.C);
            repository.save(ride);
        });
    }
}
