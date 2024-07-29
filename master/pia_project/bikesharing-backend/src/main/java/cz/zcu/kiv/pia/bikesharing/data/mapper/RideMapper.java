package cz.zcu.kiv.pia.bikesharing.data.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
import cz.zcu.kiv.pia.bikesharing.data.dto.RideDB;

import java.util.function.Function;

/**
 * Provides mapping between data and business layers for Ride.
 */
public class RideMapper {
    /**
     * Maps data layer RideDB to business layer Ride.
     */
    public static final Function<RideDB, Ride> DB_TO_BUSINESS = rideDB -> {
        // safe attributes
        var id = rideDB.getId();
        var user = UserMapper.DB_TO_BUSINESS.apply(rideDB.getUser()); // user has no circular references
        var startTimestamp = rideDB.getStartTimestamp();
        var endTimestamp = rideDB.getEndTimestamp();
        var state = rideDB.getState() == RideDB.StateDB.C ? Ride.State.COMPLETED : Ride.State.STARTED;

        // potentially problematic attributes (circular references)
        var startStand = StandMapper.DB_TO_BUSINESS.apply(rideDB.getStartStand());
        var endStand = StandMapper.DB_TO_BUSINESS.apply(rideDB.getEndStand());
        var bike = BikeMapper.DB_TO_BUSINESS.apply(rideDB.getBike());

        return new Ride(id, user, bike, state, startTimestamp, startStand, endTimestamp, endStand);
    };

    /**
     * Maps business layer Ride to data layer RideDB.
     */
    public static final Function<Ride, RideDB> BUSINESS_TO_DB = ride -> {
        RideDB rideDB = new RideDB();
        rideDB.setId(ride.getId());
        rideDB.setBike(BikeMapper.BUSINESS_TO_DB.apply(ride.getBike()));
        rideDB.setUser(UserMapper.BUSINESS_TO_DB.apply(ride.getUser()));
        rideDB.setState(ride.getState() == Ride.State.COMPLETED ? RideDB.StateDB.C : RideDB.StateDB.S);
        rideDB.setStartTimestamp(ride.getStartTimestamp());
        rideDB.setEndTimestamp(ride.getEndTimestamp());
        rideDB.setStartStand(StandMapper.BUSINESS_TO_DB_FLAT.apply(ride.getStartStand()));
        rideDB.setEndStand(StandMapper.BUSINESS_TO_DB_FLAT.apply(ride.getEndStand()));
        return rideDB;
    };
}
