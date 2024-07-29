package cz.zcu.kiv.pia.bikesharing.data.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

/**
 * Database representation of {@link cz.zcu.kiv.pia.bikesharing.business.domain.Location}. User by JPA for ORM.
 */
@Embeddable
public class LocationDB {
    @Column
    private String longitude;
    @Column
    private String latitude;

    public LocationDB() {
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
}
