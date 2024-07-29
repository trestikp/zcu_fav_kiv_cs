package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.configuration.security.JwtUtils;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.InsufficientPermissionException;
import cz.zcu.kiv.pia.bikesharing.business.exception.InvalidTokenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Class providing implementation for IAuthService. For method doc see interface.
 */
@Service
public class AuthService implements IAuthService {
    private static final Logger logger = getLogger(BikeService.class);
    /** Bean providing utils to process JWT */
    private final JwtUtils jwtUtils;
    private final UserService userService;

    @Autowired
    public AuthService(JwtUtils jwtUtils, UserService userService) {
        this.jwtUtils = jwtUtils;
        this.userService = userService;
    }

    @Override
    public User authenticateUser(String authorization) throws UnauthorizedException, UsernameNotFoundException, InvalidTokenException {
        if (authorization == null || authorization.length() < 9) {
            logger.warn("Authorization header is missing or too short.");
            throw new UnauthorizedException();
        }

        if (authorization.startsWith("Bearer ")) {
            authorization = authorization.substring(7);
        }

        if (!jwtUtils.validateJwtToken(authorization)) {
            logger.warn("Received invalid token."); // possible attack?
            throw new InvalidTokenException("Failed to validate users token.");
        }

        var username = jwtUtils.getUserNameFromJwtToken(authorization);
        return (User) userService.loadUserByUsername(username);
    }

    @Override
    public User authenticateUser(String authorization, User.Role role) throws UnauthorizedException, UsernameNotFoundException, InsufficientPermissionException, InvalidTokenException {
        var user = authenticateUser(authorization);
        // this only works because only 2 roles are defined and used (only SERVICEMAN needs elevated permissions)
        if (role == User.Role.SERVICEMAN && role != user.getRole()) {
            throw new InsufficientPermissionException(user);
        }

        return user;
    }
}
