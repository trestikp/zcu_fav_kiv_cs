package cz.zcu.kiv.pia.bikesharing.presentation.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Location;
import cz.zcu.kiv.pia.bikesharing.model.LocationDTO;

import java.util.function.Function;

/**
 * Mapper for converting presentation layer and business layer Location.
 */
public class LocationDTOMapper {
    /**
     * Mapper for converting business layer Location to presentation layer LocationDTO.
     */
    public static final Function<Location, LocationDTO> BUSINESS_TO_DTO = location -> {
        if (location == null) {
            return null;
        }
        return new LocationDTO(location.getLongitude(), location.getLatitude());
    };

    /**
     * Mapper for converting presentation layer LocationDTO to business layer Location.
     */
    public static final Function<LocationDTO, Location> DTO_TO_BUSINESS = locationDTO -> {
        if (locationDTO == null) {
            return null;
        }
        return new Location(locationDTO.getLongitude(), locationDTO.getLatitude());
    };
}
