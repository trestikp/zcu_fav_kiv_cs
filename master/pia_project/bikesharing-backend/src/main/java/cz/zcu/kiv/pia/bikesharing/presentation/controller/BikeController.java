package cz.zcu.kiv.pia.bikesharing.presentation.controller;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.*;
import cz.zcu.kiv.pia.bikesharing.business.service.IAuthService;
import cz.zcu.kiv.pia.bikesharing.business.service.IBikeService;
import cz.zcu.kiv.pia.bikesharing.controller.BikeApi;
import cz.zcu.kiv.pia.bikesharing.model.BikeDTO;
import cz.zcu.kiv.pia.bikesharing.model.LocationDTO;
import cz.zcu.kiv.pia.bikesharing.presentation.mapper.BikeDTOMapper;
import cz.zcu.kiv.pia.bikesharing.presentation.mapper.LocationDTOMapper;
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
 * Implementation of {@link BikeApi}, which is generated from OpenAPI specification.
 */
@RestController
public class BikeController implements BikeApi {
    private static final Logger logger = getLogger(BikeController.class);
    private final IBikeService bikeService;
    private final IAuthService authService;

    @Autowired
    public BikeController(IBikeService bikeService, IAuthService authService) {
        this.bikeService = bikeService;
        this.authService = authService;
    }

    /**
     * Moves bike to specified location. Only logged in user can do this.
     * @param authorization Bearer token (JWT) for authentication (required)
     * @param bikeId Unique bike identifier. (required)
     * @param locationDTO  (required)
     * @return Empty reponse with status code
     */
    @Override
    public ResponseEntity<Void> moveBike(String authorization, UUID bikeId, LocationDTO locationDTO) {
        logger.trace("Moving bike {} to location {}", bikeId, locationDTO); // only trace, because this can be called a lot

        try {
            authService.authenticateUser(authorization);
            bikeService.moveBike(bikeId, LocationDTOMapper.DTO_TO_BUSINESS.apply(locationDTO));

            return ResponseEntity.ok().build();
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (BikeNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        } catch (BikeAlreadyOnRideException ex) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        } catch (Exception e) {
            logger.error("Error while moving bike due to unexpected exception", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * Retrieves all bikes that are due for service. Only logged in user with role SERVICEMAN can do this.
     * @param authorization Bearer token (JWT) for authentication (required)
     * @return List of bikes that are due for service or error
     */
    @Override
    public ResponseEntity<List<BikeDTO>> retrieveServiceableBikes(String authorization) {
        logger.debug("Retrieving bikes due for service");

        try {
            authService.authenticateUser(authorization, User.Role.SERVICEMAN);

            var bikes = bikeService.getBikesDueForService();
            var bikeDTOs = bikes.stream().map(BikeDTOMapper.BUSINESS_TO_DTO).toList();

            return ResponseEntity.ok(bikeDTOs);
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (InsufficientPermissionException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        } catch (Exception e) {
            logger.error("Error while retrieving bikes due for service due to unexpected exception", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * Marks bike as serviced. Only logged in user with role SERVICEMAN can do this.
     * @param authorization Bearer token (JWT) for authentication (required)
     * @param bikeId Unique bike identifier. (required)
     * @return Empty reponse with status code
     */
    @Override
    public ResponseEntity<Void> markBikeAsServiced(String authorization, UUID bikeId) {
        logger.debug("Marking bike {} as serviced", bikeId);

        try {
            authService.authenticateUser(authorization, User.Role.SERVICEMAN);

            bikeService.markServiced(bikeId);

            return ResponseEntity.ok().build();
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (InsufficientPermissionException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        } catch (BikeNotServiceableException ex) {
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).build();
        } catch (Exception e) {
            logger.error("Error while marking bike as serviced due to unexpected exception", e);
            return ResponseEntity.internalServerError().build();
        }
    }
}
