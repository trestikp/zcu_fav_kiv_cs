package cz.zcu.kiv.pia.bikesharing.data.dto;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Database representation of {@link cz.zcu.kiv.pia.bikesharing.business.domain.Bike}. User by JPA for ORM.
 */
@Entity(name = "Bike")
@Table(name = "bike")
public class BikeDB {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "uuid4")
    @Column(columnDefinition = "BINARY(16)")
    private UUID id;
    @Embedded
    private LocationDB location;
    @Column
    private LocalDateTime lastServiceTimestamp;
    @ManyToOne
    @JoinColumn(name = "stand_id")
    private StandDB stand;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public LocationDB getLocation() {
        return location;
    }

    public void setLocation(LocationDB location) {
        this.location = location;
    }

    public LocalDateTime getLastServiceTimestamp() {
        return lastServiceTimestamp;
    }

    public void setLastServiceTimestamp(LocalDateTime lastServiceTimestamp) {
        this.lastServiceTimestamp = lastServiceTimestamp;
    }

    public StandDB getStand() {
        return stand;
    }

    public void setStand(StandDB stand) {
        this.stand = stand;
    }
}
