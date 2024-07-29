package cz.zcu.kiv.pia.bikesharing.business.service;


import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.InsufficientPermissionException;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface IUserService extends UserDetailsService {
    /**
     * Registers a new user.
     * @param name User's name. This is optional
     * @param username User's username. Required.
     * @param password User's password. Required.
     * @param email User's email. Required.
     * @return Newly registered user if successful.
     */
    User registerNewUser(String name, String username, String password, String email);

    /**
     * Registers a new user via Github authentication.
     * @param username User's username. Required.
     * @return Newly registered user if successful.
     */
    User registerNewGithubUser(String username);

    /**
     * Finds a user by using username and github flag, to allow to specify which user to find.
     * @param username User's username.
     * @param github Flag if user is or is not github user.
     * @return User object.
     */
    User findByUsernameAndGithub(String username, Boolean github);
}
