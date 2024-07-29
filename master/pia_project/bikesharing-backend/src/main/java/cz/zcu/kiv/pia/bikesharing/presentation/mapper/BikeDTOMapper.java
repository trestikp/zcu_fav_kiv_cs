package cz.zcu.kiv.pia.bikesharing.presentation.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.model.BikeDTO;

import java.time.ZoneOffset;
import java.util.function.Function;

/**
 * Mapper for converting presentation layer and business layer Bike.
 */
public class BikeDTOMapper {
    /**
     * Mapper for converting business layer Bike to presentation layer BikeDTO.
     */
    public static final Function<Bike, BikeDTO> BUSINESS_TO_DTO = bike -> {
        var id = bike.getId();
        var location = LocationDTOMapper.BUSINESS_TO_DTO.apply(bike.getLocation());
        var stand = StandDTOMapper.BUSINESS_TO_DTO.apply(bike.getStand());

        var lastServiceTimestamp = bike.getLastServiceTimestamp();
        var lastServiceDate = lastServiceTimestamp.atOffset(ZoneOffset.UTC);

        return new BikeDTO(id, lastServiceDate, location, stand);
    };
}
