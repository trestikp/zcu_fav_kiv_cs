package cz.zcu.kiv.pia.bikesharing.data.repository.jpa;

import cz.zcu.kiv.pia.bikesharing.data.dto.UserDB;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

/**
 * JPA repository for User.
 */
public interface IJpaUserRepository extends JpaRepository<UserDB, UUID> {
    default UserDB findByUsername(String username) {
        return findByUsernameAndGithub(username, false);
    }
    UserDB findByUsernameAndGithub(String username, Boolean github);
}
