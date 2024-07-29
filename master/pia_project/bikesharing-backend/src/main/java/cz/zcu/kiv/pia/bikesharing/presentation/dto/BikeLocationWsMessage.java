package cz.zcu.kiv.pia.bikesharing.presentation.dto;

import cz.zcu.kiv.pia.bikesharing.business.domain.Location;

import java.util.UUID;

/**
 * DTO for websocket bike update location. Additionally contains users token, so it can authorize user for the move.
 * @param jwtToken
 * @param bikeId
 * @param longitude
 * @param latitude
 */
public record BikeLocationWsMessage (
        String jwtToken,
        UUID bikeId,
        Double longitude,
        Double latitude
) {
    public BikeLocationWsMessage(String jwtToken, UUID bikeId, Location location) {
        this(jwtToken, bikeId, location.getLongitude(), location.getLatitude());
    }
}
