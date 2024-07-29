package cz.zcu.kiv.pia.bikesharing.presentation.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.model.StandDTO;

import java.util.function.Function;

/**
 * Mapper for converting presentation layer and business layer Stand.
 */
public class StandDTOMapper {
    /**
     * Mapper for converting business layer Stand to presentation layer StandDTO.
     */
    public static final Function<Stand, StandDTO> BUSINESS_TO_DTO = stand -> {
        if (stand == null) {
            return null;
        }

        var id = stand.getId();
        var name = stand.getName();
        var location = LocationDTOMapper.BUSINESS_TO_DTO.apply(stand.getLocation());
        var bikeCount = stand.getRideableBikeCount();
        return new StandDTO(id, name, location, bikeCount);
    };
}
