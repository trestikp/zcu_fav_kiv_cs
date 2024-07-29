package cz.zcu.kiv.pia.bikesharing.business.domain;

import java.time.LocalDateTime;
import java.time.Period;
import java.util.Objects;
import java.util.UUID;

/**
 * Class representing a single bike.
 */
public class Bike {
    /**
     * Unique identifier
     */
    private UUID id;
    /**
     * Current location of the bike, updated in real-time.
     */
    private Location location;
    /**
     * Date of the last service.
     */
    private LocalDateTime lastServiceTimestamp;
    /**
     * Stand that the bike is currently placed at. Can be null if the bike is ridden atm.
     */
    private Stand stand;

    // constructor used when a reference to Bike is needed in other object but full Bike object is not loaded from storage
    public Bike(UUID id) {
        this.id = id;
    }

    // constructor used when full Bike object is loaded from storage
    public Bike(UUID id, Location location, LocalDateTime lastServiceTimestamp, Stand stand) {
        this.id = id;
        this.location = location;
        this.lastServiceTimestamp = lastServiceTimestamp;
        this.stand = stand;
    }

    // constructor used when Bike is loaded from storage, but ignoring stand to avoid circular reference
    public Bike(UUID id, Location location, LocalDateTime lastServiceTimestamp) {
        this.id = id;
        this.location = location;
        this.lastServiceTimestamp = lastServiceTimestamp;
    }

    public UUID getId() {
        return id;
    }

    public Location getLocation() {
        return location;
    }

    public LocalDateTime getLastServiceTimestamp() {
        return lastServiceTimestamp;
    }

    public Stand getStand() {
        return stand;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public void setStand(Stand stand) {
        this.stand = stand;
    }

    /**
     * Checks whether this bike is due for service.
     *
     * @param serviceInterval Maximum service interval
     * @return True if bike is due for service, false otherwise
     */
    public boolean isDueForService(Period serviceInterval) {
        LocalDateTime nextServiceTimestamp = lastServiceTimestamp.plus(serviceInterval);

        return LocalDateTime.now().isAfter(nextServiceTimestamp);
    }

    /**
     * Marks this bike as serviced now.
     */
    public void markServiced() {
        this.lastServiceTimestamp = LocalDateTime.now();
    }

    /**
     * Adds this bike to given stand.
     *
     * @param stand Stand to add the bike to
     */
    public void addToStand(Stand stand) {
        this.stand = stand;
        this.location = stand.getLocation();
        this.stand.addBike(this);
    }

    /**
     * Removes this bike from its current stand.
     */
    public void removeFromStand() {
        this.stand.removeBike(this);
        this.stand = null;
    }

    /**
     * Starts a bike ride by setting the bike location to stand location and setting stand to null.
     * @param initialLocation location where the bike ride starts (stand location)
     */
    public void startBikeRide(Location initialLocation) {
        this.location = initialLocation;
        this.stand = null; // this means bike is on ride
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Bike bike)) return false;
        return Objects.equals(id, bike.id) && Objects.equals(location, bike.location) && Objects.equals(lastServiceTimestamp, bike.lastServiceTimestamp) && Objects.equals(stand, bike.stand);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, location, lastServiceTimestamp, stand);
    }

    @Override
    public String toString() {
        return "Bike{" +
                "id=" + id +
                ", location=" + location +
                ", lastServiceTimestamp=" + lastServiceTimestamp +
                ", stand=" + stand +
                '}';
    }
}
