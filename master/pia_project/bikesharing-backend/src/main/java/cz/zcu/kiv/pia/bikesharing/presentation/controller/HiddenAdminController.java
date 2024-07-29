package cz.zcu.kiv.pia.bikesharing.presentation.controller;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.InsufficientPermissionException;
import cz.zcu.kiv.pia.bikesharing.business.exception.InvalidTokenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;
import cz.zcu.kiv.pia.bikesharing.business.service.IAuthService;
import cz.zcu.kiv.pia.bikesharing.business.service.RideService;
import cz.zcu.kiv.pia.bikesharing.model.RideDTO;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * This serves for special "admin" operations, that are hidden from the public API but are useful for testing
 * and simulating real behaviour.
 */
@RestController
public class HiddenAdminController {
    private static final Logger logger = getLogger(HiddenAdminController.class);
    private final RideService rideService;
    private final IAuthService authService;

    @Autowired
    public HiddenAdminController(RideService rideService, IAuthService authService) {
        this.rideService = rideService;
        this.authService = authService;
    }

    /**
     * Calling this endpoint will set all unfinished rides to finished. This is for convenience while testing and
     * simulating user-provider interaction.
     * @param authorization Authorization header of the request. Only SERVICEMAN are allowed to use this
     * @return Response based on success
     */
    @GetMapping("/hidden/admin/completeAllRides")
    public ResponseEntity<List<RideDTO>> setAllRidesAsCompleted(@RequestHeader(value = "Authorization", required = true) String authorization) {
        logger.info("Resetting all rides");

        try {
            authService.authenticateUser(authorization, User.Role.SERVICEMAN);

            rideService.completeAllRides();

            return ResponseEntity.ok().build();
        } catch (UnauthorizedException | UsernameNotFoundException | InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InsufficientPermissionException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        } catch (Exception ex) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
