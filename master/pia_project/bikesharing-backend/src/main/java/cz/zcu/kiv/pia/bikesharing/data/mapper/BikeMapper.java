package cz.zcu.kiv.pia.bikesharing.data.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.data.dto.BikeDB;

import java.util.function.Function;

/**
 * Provides mapping between data and business layers for Bikes.
 */
public class BikeMapper {
    /**
     * Maps data layer BikeDB to business layer Bike.
     * WARNING! - circular reference with stand, where stand has bikes in a set and mapping the stand maps the bikes and again
     */
    public static final Function<BikeDB, Bike> DB_TO_BUSINESS = bikeDB -> {
        var id = bikeDB.getId();
        var stand = StandMapper.DB_TO_BUSINESS.apply(bikeDB.getStand()); // WARNING: circular reference!!
        var location = LocationMapper.DB_TO_BUSINESS.apply(bikeDB.getLocation());
        var lastServiced = bikeDB.getLastServiceTimestamp();
        return new Bike(id, location, lastServiced, stand);
    };

    /**
     * Maps data layer BikeDB to business layer Bike, however leaves stand empty. Stand should be filled later on.
     * This should avoid circular reference.
     */
    public static final Function<BikeDB, Bike> DB_TO_BUSINESS_FLAT = bikeDB -> {
        var id = bikeDB.getId();
        var location = LocationMapper.DB_TO_BUSINESS.apply(bikeDB.getLocation());
        var lastServiced = bikeDB.getLastServiceTimestamp();
        return new Bike(id, location, lastServiced);
    };

    /**
     * Maps business layer Bike to data layer BikeDB.
     */
    public static final Function<Bike, BikeDB> BUSINESS_TO_DB = bike -> {
        BikeDB bikeDB = new BikeDB();
        bikeDB.setId(bike.getId());
        bikeDB.setStand(StandMapper.BUSINESS_TO_DB_FLAT.apply(bike.getStand())); // WARN: using FLAT to avoid circular reference
        bikeDB.setLocation(LocationMapper.BUSINESS_TO_DB.apply(bike.getLocation()));
        bikeDB.setLastServiceTimestamp(bike.getLastServiceTimestamp());
        return bikeDB;
    };
}
