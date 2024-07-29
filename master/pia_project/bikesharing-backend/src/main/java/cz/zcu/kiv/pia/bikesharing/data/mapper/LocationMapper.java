package cz.zcu.kiv.pia.bikesharing.data.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.Location;
import cz.zcu.kiv.pia.bikesharing.data.dto.LocationDB;

import java.util.function.Function;

/**
 * Provides mapping between data and business layers for Location.
 */
public class LocationMapper {

    /**
     * Maps data layer LocationDB to business layer Location.
     */
    public static final Function<LocationDB, Location> DB_TO_BUSINESS = locationDB -> {
        return new Location(locationDB.getLongitude(), locationDB.getLatitude());
    };

    /**
     * Maps business layer Location to data layer LocationDB.
     */
    public static final Function<Location, LocationDB> BUSINESS_TO_DB = location -> {
        LocationDB locationDB = new LocationDB();
        locationDB.setLatitude(location.getLatitude().toString());
        locationDB.setLongitude(location.getLongitude().toString());
        return locationDB;
    };
}
