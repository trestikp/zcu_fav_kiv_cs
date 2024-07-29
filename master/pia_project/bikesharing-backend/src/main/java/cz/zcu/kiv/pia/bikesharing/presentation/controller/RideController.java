package cz.zcu.kiv.pia.bikesharing.presentation.controller;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotCloseToStandException;
import cz.zcu.kiv.pia.bikesharing.business.exception.InvalidTokenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;
import cz.zcu.kiv.pia.bikesharing.business.service.IAuthService;
import cz.zcu.kiv.pia.bikesharing.business.service.IBikeService;
import cz.zcu.kiv.pia.bikesharing.business.service.IRideService;
import cz.zcu.kiv.pia.bikesharing.business.service.IStandService;
import cz.zcu.kiv.pia.bikesharing.controller.RideApi;
import cz.zcu.kiv.pia.bikesharing.model.RideDTO;
import cz.zcu.kiv.pia.bikesharing.model.SimplifiedRideDTO;
import cz.zcu.kiv.pia.bikesharing.presentation.mapper.RideDTOMapper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link RideApi}, which is generated from OpenAPI specification.
 */
@RestController
public class RideController implements RideApi {
    private static final Logger logger = getLogger(RideController.class);
    private final IRideService rideService;
    private final IBikeService bikeService;
    private final IStandService standService;
    private final IAuthService authService;

    @Autowired
    public RideController(IRideService rideService, IBikeService bikeService, IStandService standService, IAuthService authService) {
        this.rideService = rideService;
        this.bikeService = bikeService;
        this.standService = standService;
        this.authService = authService;
    }

    /**
     * Starts a ride for user.
     * @param authorization Bearer token (JWT) for authentication (required). Servers to find the user.
     * @param newRideDTO SimplifiedRideDTO with bikeId, startStandId, endStandId (which can theoretically be change)
     * @return RideDTO with created ride
     */
    @Override
    public ResponseEntity<RideDTO> startRide(String authorization, SimplifiedRideDTO newRideDTO) {
        logger.debug("Starting new ride");

        try {
            var user = authService.authenticateUser(authorization);
            var bike = bikeService.getById(newRideDTO.getBikeId());
            var startStand = standService.getStandById(newRideDTO.getStartStandId());

            var ride = rideService.startRide(user, bike, startStand);
            if (ride != null) {
                return ResponseEntity.ok(RideDTOMapper.BUSINESS_TO_DTO.apply(ride));
            }
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (IllegalStateException ex) {
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).build();
        } catch (Exception ex) {
            logger.error("Error while starting ride due to unexpected exception", ex);
            return ResponseEntity.internalServerError().build();
        }

        logger.error("Error while starting ride due to unknown reason (bike was not saved successfully but no exception was thrown?)");
        return ResponseEntity.internalServerError().build();
    }

    /**
     * Retrieves all past rides for user.
     * @param authorization Bearer token (JWT) for authentication (required)
     * @return List of past rides or error
     */
    @Override
    public ResponseEntity<List<RideDTO>> retrieveRides(String authorization) {
        logger.debug("Retrieving rides");

        try {
            // no need to null check, because if user was not found an exception would be thrown
            var user = authService.authenticateUser(authorization, User.Role.REGULAR);

            var rides = rideService.getRides(user);
            if (rides.isEmpty()) {
                return ResponseEntity.noContent().build();
            }

            var rideDTOs = rides.stream().map(RideDTOMapper.BUSINESS_TO_DTO).toList();

            return ResponseEntity.ok(rideDTOs);
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (Exception e) {
            logger.error("Error while retrieving rides due to unexpected exception", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * Completes a ride for user.
     * @param authorization Bearer token (JWT) for authentication (required). Used to get the user.
     * @param rideId UUID of the ride (required)
     * @param simplifiedRideDTO SimplifiedRideDTO with bikeId, startStandId, endStandId (which is now required)
     * @return Empty response with status code
     */
    @Override
    public ResponseEntity<Void> completeRide(String authorization, UUID rideId, SimplifiedRideDTO simplifiedRideDTO) {
        logger.debug("Completing ride {} for user", rideId);

        try {
            authService.authenticateUser(authorization); // rv ignored, no need for User here

            Stand stand = standService.getStandById(simplifiedRideDTO.getEndStandId());
            Bike bike = bikeService.getById(simplifiedRideDTO.getBikeId());

            rideService.completeRide(new Ride(rideId), bike, stand);

            // send message to ActiveMQ, so clients can stop tracking the bike
            bikeService.removeBikeFromClient(bike.getId());

            return ResponseEntity.ok().build();
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (BikeNotCloseToStandException ex) {
            return ResponseEntity.status(HttpStatus.PRECONDITION_FAILED).build();
        } catch (IllegalStateException ex) {
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).build();
        } catch (Exception ex) {
            logger.error("Error while completing ride due to unexpected exception", ex);
            return ResponseEntity.internalServerError().build();
        }
    }
}
