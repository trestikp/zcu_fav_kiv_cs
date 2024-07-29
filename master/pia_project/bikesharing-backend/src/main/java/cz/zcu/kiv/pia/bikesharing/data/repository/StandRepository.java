package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.data.mapper.StandMapper;
import cz.zcu.kiv.pia.bikesharing.data.repository.jpa.IJpaStandRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link IStandRepository}.
 */
@Primary
@Repository
public class StandRepository implements IStandRepository {
    private static final Logger logger = getLogger(StandRepository.class);
    private final IJpaStandRepository repository;

    @Autowired
    public StandRepository(IJpaStandRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Stand> getAll() {
        logger.trace("Getting all stands");
        return repository.findAll().stream().map(StandMapper.DB_TO_BUSINESS).toList();
    }

    @Override
    public Stand getById(UUID uuid) {
        logger.trace("Getting stand with id {}", uuid);
        return repository.findById(uuid).map(StandMapper.DB_TO_BUSINESS).orElse(null);
    }

    @Override
    public Stand save(Stand entity) {
        logger.trace("Saving stand {}", entity);
        var toBeSaved = StandMapper.BUSINESS_TO_DB_FLAT.apply(entity);
        var savedEntity = repository.save(toBeSaved);
        return StandMapper.DB_TO_BUSINESS.apply(savedEntity);
    }

    @Override
    public void deleteById(UUID uuid) {
        logger.trace("Deleting stand with id {}", uuid);
        repository.deleteById(uuid);
    }
}
