package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.InsufficientPermissionException;
import cz.zcu.kiv.pia.bikesharing.business.exception.InvalidTokenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * Service for "manual" user authentication. This service is to be used in each endpoint that requires authentication.
 * It kind of replaces the Spring Security filter chain.
 */
public interface IAuthService {
    /**
     * Authenticates user from authorization header. Expects format "Bearer <token>".
     * @param authorization Authorization header value.
     * @return Authenticated user.
     * @throws UnauthorizedException Thrown when user is not authorized.
     */
    User authenticateUser(String authorization) throws UnauthorizedException, InvalidTokenException, UsernameNotFoundException;

    /**
     * Authenticates user from authorization header. Expects format "Bearer <token>". Also verifies that user has role
     * Permission verification is easy in this project. Only matters if <code>role</code> is <code>SERVICEMAN</code>.
     * with sufficient permissions.
     * @param authorization Authorization header value.
     * @param role Required role.
     * @return Authenticated user.
     * @throws UnauthorizedException Thrown when user is not authorized.
     * @throws UsernameNotFoundException Thrown when user is not found.
     * @throws InsufficientPermissionException Thrown when user does not have sufficient permissions.
     */
    User authenticateUser(String authorization, User.Role role) throws UnauthorizedException, UsernameNotFoundException, InsufficientPermissionException, InvalidTokenException;
}
