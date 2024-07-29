package cz.zcu.kiv.pia.bikesharing.presentation.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import cz.zcu.kiv.pia.bikesharing.business.domain.Location;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeAlreadyOnRideException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotFoundException;
import cz.zcu.kiv.pia.bikesharing.business.exception.InvalidTokenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;
import cz.zcu.kiv.pia.bikesharing.business.service.IAuthService;
import cz.zcu.kiv.pia.bikesharing.business.service.IBikeService;
import cz.zcu.kiv.pia.bikesharing.presentation.dto.BikeLocationWsMessage;
import org.slf4j.Logger;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;

import static org.slf4j.LoggerFactory.getLogger;

@Controller
public class MoveBikeWebSocketController {
    private static final Logger logger = getLogger(MoveBikeWebSocketController.class);
    private final ObjectMapper objectMapper;
    private final IAuthService authService;
    private final IBikeService bikeService;

    public MoveBikeWebSocketController(IAuthService authService, IBikeService bikeService) {
        this.authService = authService;
        this.bikeService = bikeService;
        this.objectMapper = new ObjectMapper();
    }

    @MessageMapping("/moveBike")
    public void moveBike(String message) {
        logger.trace("Updating bike location via websocket");

        try {
            var bikeLocationWsMessage = objectMapper.readValue(message, BikeLocationWsMessage.class);

            var tokenWithBearer = "Bearer " + bikeLocationWsMessage.jwtToken();
            authService.authenticateUser(tokenWithBearer);
            bikeService.moveBike(bikeLocationWsMessage.bikeId(), new Location(bikeLocationWsMessage.longitude(), bikeLocationWsMessage.latitude()));

        } catch (JsonProcessingException e) {
            logger.error("Cannot update bike location because the message was invalid and failed to parse");
        } catch (UnauthorizedException | UsernameNotFoundException ex) {
            logger.error("Unauthorized user tried to move bike");
        } catch (InvalidTokenException ex) {
            logger.error("Invalid token was used trying to move bike");
        } catch (BikeNotFoundException ex) {
            logger.error("Bike not found while trying to move bike");
        } catch (BikeAlreadyOnRideException ex) {
            logger.error("Bike is already on ride while trying to move bike");
        } catch (Exception e) {
            logger.error("Error while moving bike due to unexpected exception", e);
        }
    }

}
