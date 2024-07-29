package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.EmailAlreadyTakenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UsernameAlreadyTakenException;
import cz.zcu.kiv.pia.bikesharing.data.repository.IUserRepository;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link IUserService}.
 */
@Service
public class UserService implements IUserService, UserDetailsService {
    private static final Logger logger = getLogger(StandService.class);
    public static final String FAKE_GITHUB_PASSWORD = "FAKE_PASSWORD";
    private final IUserRepository userRepository;

    @Autowired
    public UserService(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * This is from UserDetailsService, which is required by spring security. It actually uses ID instead of username,
     * because username is not unique (due to github users).
     * @param username the username identifying the user whose data is required.
     * @return User object loaded from database.
     * @throws UsernameNotFoundException if the user could not be found
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // due to github, username is NOT unique -> even though its not intuitive, ID can be used instead
        // ID will always get correct user regardless of username and githubflag
        try {
            var user = userRepository.getById(UUID.fromString(username));
            if (user == null) {
                logger.warn("User with ID {} not found.", username);
                throw new UsernameNotFoundException("Username not found.");
            }

            return user;
        } catch (IllegalArgumentException | NullPointerException ex) {
            logger.error("ID {} cannot be parsed into UUID", username);
            throw new UsernameNotFoundException("Username not found.");
        }
    }

    @Override
    public User registerNewUser(String name, String username, String password, String email) throws
            DataIntegrityViolationException, UsernameAlreadyTakenException, EmailAlreadyTakenException {
        logger.debug("Registering new user {} with email {}", username, email);

        // cannot use the one from SecurityConfiguration because of circular dependency
        PasswordEncoder bcryptEncode = new BCryptPasswordEncoder();

        User newUser = new User(null, name, email, User.Role.REGULAR, username, bcryptEncode.encode(password));

        try {
            return userRepository.save(newUser);
        } catch (DataIntegrityViolationException ex) {
            // UC_username = UniqueConstraint_username (database constraint), similar for email
            if (ex.getMessage().contains("UC_username")) {
                throw new UsernameAlreadyTakenException(username);
            }
            if (ex.getMessage().contains("UC_email")) {
                throw new EmailAlreadyTakenException(email);
            }

            logger.error("Unexpected data integrity was violated during user registration", ex);
            throw new DataIntegrityViolationException("Unrecognized constraint violation. User information is not unique.");
        }
    }

    @Override
    public User registerNewGithubUser(String username) {
        logger.debug("Registering new Github user {}", username);

        // cannot use the one from SecurityConfiguration because of circular dependency
        PasswordEncoder bcryptEncode = new BCryptPasswordEncoder();

        // user technically doesn't use password, but its MUSTN'T be null in DB and it serves for spring security auth
        User newUser = new User(username, bcryptEncode.encode(FAKE_GITHUB_PASSWORD));
        newUser.setGithub(true);

        try {
            return userRepository.save(newUser);
        } catch (Exception ex) { // if this occur its probably database going bad
            logger.error("Unexpected error while saving new Github user", ex);
            return null;
        }
    }

    @Override
    public User findByUsernameAndGithub(String username, Boolean github) {
        return userRepository.findByUsernameAngGithub(username, github);
    }
}
