package cz.zcu.kiv.pia.bikesharing.data.repository.jpa;

import cz.zcu.kiv.pia.bikesharing.data.dto.BikeDB;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.time.Period;
import java.util.List;
import java.util.UUID;

/**
 * JPA repository for Bike.
 */
public interface IJpaBikeRepository extends JpaRepository<BikeDB, UUID> {
    @Query("SELECT b FROM Bike b WHERE b.lastServiceTimestamp < :thresholdTimestamp ORDER BY b.lastServiceTimestamp ASC")
    List<BikeDB> findAllDueForService(LocalDateTime thresholdTimestamp);

    /**
     * Finds all bikes that are due for service. Method requires default body to convert period to LocalDateTime, which
     * can be used for the query.
     * @param serviceInterval period after which the bike is due for service
     * @return list of bikes due for service
     */
    default List<BikeDB> findAllDueForService(Period serviceInterval) {
        LocalDateTime thresholdTimestamp = LocalDateTime.now().minus(serviceInterval);
        return findAllDueForService(thresholdTimestamp);
    }

    @Query("SELECT true FROM Bike b JOIN Ride r ON b.id = r.bike.id WHERE b.id = :id AND r.state = 'S'")
    Boolean isBikeOnRide(UUID id);
}
