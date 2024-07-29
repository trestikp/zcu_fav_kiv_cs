package cz.zcu.kiv.pia.bikesharing.data.dto;

import jakarta.persistence.*;

import java.time.Instant;
import java.util.UUID;


/**
 * Database representation of {@link cz.zcu.kiv.pia.bikesharing.business.domain.Ride}. User by JPA for ORM.
 */
@Entity(name = "Ride")
@Table(name = "ride")
public class RideDB {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "uuid4")
    @Column(columnDefinition = "BINARY(16)")
    private UUID id;
    @OneToOne
    private UserDB user;
    @OneToOne
    private BikeDB bike;
    @Enumerated(EnumType.STRING)
    @Column(length = 2)
    private StateDB state;
    @Column
    private Instant startTimestamp;
    @OneToOne
    private StandDB startStand;
    @Column
    private Instant endTimestamp;
    @OneToOne
    private StandDB endStand;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public UserDB getUser() {
        return user;
    }

    public void setUser(UserDB user) {
        this.user = user;
    }

    public BikeDB getBike() {
        return bike;
    }

    public void setBike(BikeDB bike) {
        this.bike = bike;
    }

    public StateDB getState() {
        return state;
    }

    public void setState(StateDB state) {
        this.state = state;
    }

    public Instant getStartTimestamp() {
        return startTimestamp;
    }

    public void setStartTimestamp(Instant startTimestamp) {
        this.startTimestamp = startTimestamp;
    }

    public StandDB getStartStand() {
        return startStand;
    }

    public void setStartStand(StandDB startStand) {
        this.startStand = startStand;
    }

    public Instant getEndTimestamp() {
        return endTimestamp;
    }

    public void setEndTimestamp(Instant endTimestamp) {
        this.endTimestamp = endTimestamp;
    }

    public StandDB getEndStand() {
        return endStand;
    }

    public void setEndStand(StandDB endStand) {
        this.endStand = endStand;
    }

    public enum StateDB {
        /**
         * STARTED
         */
        S,
        /**
         * COMPLETED
         */
        C,
    }
}
