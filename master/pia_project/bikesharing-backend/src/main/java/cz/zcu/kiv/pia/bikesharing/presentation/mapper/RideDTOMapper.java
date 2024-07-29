package cz.zcu.kiv.pia.bikesharing.presentation.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.model.RideDTO;

import java.time.ZoneOffset;
import java.util.function.Function;

/**
 * Mapper for converting presentation layer and business layer Ride.
 */
public class RideDTOMapper {
    /**
     * Mapper for converting business layer Ride to presentation layer RideDTO.
     */
    public static final Function<Ride, RideDTO> BUSINESS_TO_DTO = ride -> {
        var id = ride.getId();
        var startTime = ride.getStartTimestamp().atOffset(ZoneOffset.UTC);
        var startLocation = LocationDTOMapper.BUSINESS_TO_DTO.apply(ride.getStartStand().getLocation());
        var bike = BikeDTOMapper.BUSINESS_TO_DTO.apply(ride.getBike());
        var user = UserDTOMapper.BUSINESS_TO_DTO.apply(ride.getUser());
        var startLocName = ride.getStartStand().getName();

        RideDTO rideDTO = new RideDTO(id, startTime, startLocName, startLocation, bike, user);

        // these can theoretically be null, but we dont care
        var endTime = ride.getEndTimestamp() != null ? ride.getEndTimestamp().atOffset(ZoneOffset.UTC) : null;
        var endLocation = ride.getEndStand() != null ? LocationDTOMapper.BUSINESS_TO_DTO.apply(ride.getEndStand().getLocation()) : null;
        var endLocName = ride.getEndStand() != null ? ride.getEndStand().getName() : null;
        rideDTO.setEndTime(endTime);
        rideDTO.setEndLocation(endLocation);
        rideDTO.setEndLocationName(endLocName);

        return rideDTO;
    };
}
