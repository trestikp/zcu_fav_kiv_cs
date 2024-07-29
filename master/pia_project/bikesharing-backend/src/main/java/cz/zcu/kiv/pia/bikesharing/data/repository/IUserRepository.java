package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;

import java.util.UUID;

/**
 * Repository storing all information related to users.
 */
public interface IUserRepository extends ICommonRepository<User, UUID> {

    /**
     * Finds user by username and github flag.
     * @param username Username
     * @param github Github flag
     * @return User with given username and github flag
     */
    User findByUsernameAngGithub(String username, Boolean github);
}
