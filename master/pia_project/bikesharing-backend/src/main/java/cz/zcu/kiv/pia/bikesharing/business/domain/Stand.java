package cz.zcu.kiv.pia.bikesharing.business.domain;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;

/**
 * Represent a stand where bikes are placed when not ridden.
 */
public class Stand {
    /**
     * Unique identifier
     */
    private UUID id;
    /**
     * Human understandable name of the stand
     */
    private String name;
    /**
     * Location of the stand, constant
     */
    private Location location;
    /**
     * Bikes currently parked at this stand
     */
    private final Set<Bike> bikes;
    private int rideableBikeCount = 0;

    public Stand(UUID id) {
        this.id = id;
        this.bikes = new HashSet<>();
    }

    public Stand(UUID id, String name, Location location, Set<Bike> bikes) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.bikes = bikes == null ? new HashSet<>() : bikes;
    }

    public Stand(UUID id, String name, Location location) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.bikes = new HashSet<>();
    }

    public Stand(String name, Location location) {
        this.name = name;
        this.location = location;
        this.bikes = new HashSet<>();
    }

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Location getLocation() {
        return location;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public int getRideableBikeCount() {
        return rideableBikeCount;
    }

    public void setRideableBikeCount(int rideableBikeCount) {
        this.rideableBikeCount = rideableBikeCount;
    }

    /**
     * Adds given bike to this stand.
     *
     * @param bike Bike to be added
     */
    public void addBike(Bike bike) {
        this.bikes.add(bike);
    }

    /**
     * Removes given bike from this stand.
     *
     * @param bike Bike to be removed
     */
    public void removeBike(Bike bike) {
        this.bikes.remove(bike);
    }

    public Set<Bike> getBikes() {
        return bikes;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Stand stand)) return false;
        return Objects.equals(id, stand.id) && Objects.equals(name, stand.name) && Objects.equals(location, stand.location);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, location);
    }

    @Override
    public String toString() {
        return "Stand{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", location=" + location +
                '}';
    }
}
