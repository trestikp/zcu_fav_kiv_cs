package cz.zcu.kiv.pia.bikesharing.data.repository.jpa;

import cz.zcu.kiv.pia.bikesharing.data.dto.RideDB;
import cz.zcu.kiv.pia.bikesharing.data.dto.UserDB;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.UUID;

/**
 * JPA repository for Ride.
 */
public interface IJpaRideRepository extends JpaRepository<RideDB, UUID> {

    List<RideDB> findAllByUserOrderByStartTimestampDesc(UserDB user);

    @Query("SELECT COUNT(r) > 0 FROM Ride r WHERE r.user = :user AND r.state = 'S'")
    boolean hasUserRideInProgress(UserDB user);

    List<RideDB> findAllByStateEquals(RideDB.StateDB state);
}
