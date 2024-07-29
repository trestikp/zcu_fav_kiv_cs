package cz.zcu.kiv.pia.bikesharing.data.dto;

import jakarta.persistence.*;

import java.util.Set;
import java.util.UUID;

/**
 * Database representation of {@link cz.zcu.kiv.pia.bikesharing.business.domain.Stand}. User by JPA for ORM.
 */
@Entity(name = "Stand")
@Table(name = "stand")
public class StandDB {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "uuid4")
    @Column(columnDefinition = "BINARY(16)")
    private UUID id;
    @Column
    private String name;
    @Embedded
    private LocationDB location;
    @OneToMany(mappedBy = "stand")
    private Set<BikeDB> availableBikes;

    public StandDB() {
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocationDB getLocation() {
        return location;
    }

    public void setLocation(LocationDB location) {
        this.location = location;
    }

    public Set<BikeDB> getAvailableBikes() {
        return availableBikes;
    }

    public void setAvailableBikes(Set<BikeDB> availableBikes) {
        this.availableBikes = availableBikes;
    }
}