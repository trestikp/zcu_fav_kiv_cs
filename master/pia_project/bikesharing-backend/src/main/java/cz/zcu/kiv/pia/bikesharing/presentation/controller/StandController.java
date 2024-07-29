package cz.zcu.kiv.pia.bikesharing.presentation.controller;

import cz.zcu.kiv.pia.bikesharing.business.exception.*;
import cz.zcu.kiv.pia.bikesharing.business.service.IAuthService;
import cz.zcu.kiv.pia.bikesharing.business.service.IStandService;
import cz.zcu.kiv.pia.bikesharing.controller.StandApi;
import cz.zcu.kiv.pia.bikesharing.model.BikeDTO;
import cz.zcu.kiv.pia.bikesharing.model.StandDTO;
import cz.zcu.kiv.pia.bikesharing.presentation.mapper.BikeDTOMapper;
import cz.zcu.kiv.pia.bikesharing.presentation.mapper.StandDTOMapper;
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
 * Implementation of {@link StandApi}, which is generated from OpenAPI specification.
 */
@RestController
public class StandController implements StandApi {
    private static final Logger logger = getLogger(StandController.class);
    private final IStandService standService;
    private final IAuthService authService;

    @Autowired
    public StandController(IStandService standService, IAuthService authService) {
        this.standService = standService;
        this.authService = authService;
    }

    /**
     * Retrieves all stands.
     * @return List of StandDTOs
     */
    @Override
    public ResponseEntity<List<StandDTO>> retrieveStands() {
        logger.debug("Retrieving all stands");

        try {
            var stands = standService.getAll();

            if (stands == null || stands.isEmpty()) {
                return ResponseEntity.noContent().build();
            }

            // count rideable bikes at each stand
            stands.forEach(standService::prepareRideableBikeCountFromStand);

            var convertedStands = stands.stream().map(StandDTOMapper.BUSINESS_TO_DTO).toList();

            return ResponseEntity.ok(convertedStands);
        } catch (Exception e) {
            logger.error("Error retrieving stands", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * Gets a bike from the stand, that can be used for a ride.
     * @param authorization Bearer token (JWT) for authentication (required)
     * @param standId Unique stand identifier. (required)
     * @return Bike that is ready for ride (status code 200), or error code
     */
    @Override
    public ResponseEntity<BikeDTO> getBikeFromStand(String authorization, UUID standId) {
        logger.debug("Requesting bike from stand {}", standId);

        try {
            authService.authenticateUser(authorization);

            var bike = standService.getAvailableBikeFromStand(standId);

            return ResponseEntity.ok(BikeDTOMapper.BUSINESS_TO_DTO.apply(bike));
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (InvalidTokenException ex) {
            return ResponseEntity.status(HttpStatus.I_AM_A_TEAPOT).build();
        } catch (NonExistentEntityException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        } catch (StandIsEmptyException | NoRideableBikeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).build();
        } catch (Exception e) {
            logger.error("Unexpected error retrieving bike from stand", e);
            return ResponseEntity.internalServerError().build();
        }
    }
}
