package cz.zcu.kiv.pia.bikesharing.data.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
import cz.zcu.kiv.pia.bikesharing.data.dto.StandDB;

import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Provides mapping between data and business layers for Stand.
 */
public class StandMapper {

    /**
     * Maps data layer StandDB to business layer Stand.
     * Potentially can cause circular reference problem with bikes.
     */
    public static final Function<StandDB, Stand> DB_TO_BUSINESS = standDB -> {
        if (standDB == null) {
            return null;
        }

        var id = standDB.getId();
        var name = standDB.getName();
        var location = LocationMapper.DB_TO_BUSINESS.apply(standDB.getLocation());
        // WARNING: using DB_TO_BIKE_FLAT just for this to avoid circular reference
        var availableBikes = standDB.getAvailableBikes() == null ? null :
                standDB.getAvailableBikes().stream().map(BikeMapper.DB_TO_BUSINESS_FLAT).collect(Collectors.toSet());

        // create stand object and fill references to mapped bikes. Bikes were mapped without stand to avoid circular reference
        Stand stand = new Stand(id, name, location, availableBikes);
        stand.getBikes().forEach(bike -> bike.setStand(stand));

        return stand;
    };

    /**
     * Maps business layer Stand to data layer StandDB.
     * Unsure but possibly can also cause circular reference problem.
     */
    public static final Function<Stand, StandDB> BUSINESS_TO_DB = stand -> {
        StandDB standDB = new StandDB();
        standDB.setId(stand.getId());
        standDB.setName(stand.getName());
        var locationDB = LocationMapper.BUSINESS_TO_DB.apply(stand.getLocation());
        standDB.setLocation(locationDB);
        standDB.setAvailableBikes(stand.getBikes().stream().map(BikeMapper.BUSINESS_TO_DB).collect(Collectors.toSet()));
        return standDB;
    };

    /**
     * Maps business layer Stand to data layer StandDB but should be circular reference safe. This is by
     * excluding bikes from mapping.
     */
    public static final Function<Stand, StandDB> BUSINESS_TO_DB_FLAT = stand -> {
        if (stand == null) {
            return null;
        }

        StandDB standDB = new StandDB();
        standDB.setId(stand.getId());
        standDB.setName(stand.getName());
        var locationDB = LocationMapper.BUSINESS_TO_DB.apply(stand.getLocation()); // this should be safe from circular ref.
        standDB.setLocation(locationDB);
        standDB.setAvailableBikes(null); // WARN!: this causes circular ref problem. However bikes probably arent needed for saving stand
        return standDB;
    };
}
