package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.data.mapper.UserMapper;
import cz.zcu.kiv.pia.bikesharing.data.repository.jpa.IJpaUserRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link IUserRepository}.
 */
@Primary
@Repository
public class UserRepository implements IUserRepository {
    private static final Logger logger = getLogger(UserRepository.class);
    private final IJpaUserRepository repository;

    @Autowired
    public UserRepository(IJpaUserRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<User> getAll() {
        logger.trace("Getting all users");
        return repository.findAll().stream().map(UserMapper.DB_TO_BUSINESS).toList();
    }

    @Override
    public User getById(UUID id) {
        logger.trace("Getting user with id {}", id);
        return repository.findById(id).map(UserMapper.DB_TO_BUSINESS).orElse(null);
    }

    @Override
    public User save(User entity) {
        logger.trace("Saving user {}", entity);
        var toBeSaved = UserMapper.BUSINESS_TO_DB.apply(entity);
        var savedEntity = repository.save(toBeSaved);
        return UserMapper.DB_TO_BUSINESS.apply(savedEntity);
    }

    @Override
    public void deleteById(UUID id) {
        logger.trace("Deleting user with id {}", id);
        repository.deleteById(id);
    }

    @Override
    public User findByUsernameAngGithub(String username, Boolean github) {
        logger.trace("Getting user with username {} and github flag {}", username, github);
        var user = repository.findByUsernameAndGithub(username, github);
        return user != null ? UserMapper.DB_TO_BUSINESS.apply(user) : null;
    }
}
