package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.data.mapper.BikeMapper;
import cz.zcu.kiv.pia.bikesharing.data.repository.jpa.IJpaBikeRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.time.Period;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

@Primary
@Repository
public class BikeRepository implements IBikeRepository {
    private static final Logger logger = getLogger(BikeRepository.class);
    private final IJpaBikeRepository repository;
    private final Period serviceInterval;

    @Autowired
    public BikeRepository(IJpaBikeRepository repository, Period serviceInterval) {
        this.repository = repository;
        this.serviceInterval = serviceInterval;
    }

    @Override
    public List<Bike> getAll() {
        logger.trace("Getting all bikes");
        return repository.findAll().stream().map(BikeMapper.DB_TO_BUSINESS).toList();
    }

    @Override
    public Bike getById(UUID id) {
        logger.trace("Getting bike with id {}", id);
        // NOTE: this was suspected of circular reference problem, but it hasn't occurred yet, so it's probably fine
        return repository.findById(id).map(BikeMapper.DB_TO_BUSINESS).orElse(null);
    }

    @Override
    public Bike save(Bike entity) {
        logger.trace("Saving bike {}", entity);
        var toBeSaved = BikeMapper.BUSINESS_TO_DB.apply(entity);
        var savedEntity = repository.save(toBeSaved);
        // NOTE: this was suspected of circular reference problem, but it hasn't occurred yet, so it's probably fine
        return BikeMapper.DB_TO_BUSINESS.apply(savedEntity);
    }

    @Override
    public void deleteById(UUID id) {
        logger.trace("Deleting bike with id {}", id);
        repository.deleteById(id);
    }

    @Override
    public Collection<Bike> getBikesDueForService() {
        logger.trace("Getting bikes due for service");
        var dueBikes = repository.findAllDueForService(serviceInterval);
        return dueBikes.stream().map(BikeMapper.DB_TO_BUSINESS).toList();
    }

    @Override
    public boolean isBikeOnRide(Bike bike) {
        logger.trace("Checking if bike {} is on ride", bike);
        var res = repository.isBikeOnRide(bike.getId());
        return res != null && res;
    }
}
