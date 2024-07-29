package cz.zcu.kiv.pia.bikesharing.data.repository.jpa;

import cz.zcu.kiv.pia.bikesharing.data.dto.StandDB;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

/**
 * JPA repository for Stand.
 */
public interface IJpaStandRepository extends JpaRepository<StandDB, UUID> {
}
