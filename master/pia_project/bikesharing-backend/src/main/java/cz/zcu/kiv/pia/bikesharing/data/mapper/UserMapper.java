package cz.zcu.kiv.pia.bikesharing.data.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.data.dto.UserDB;

import java.util.function.Function;

/**
 * Provides mapping between data and business layers for User.
 */
public class UserMapper {
    /**
     * Maps data layer UserDB to business layer User.
     */
    public static final Function<UserDB, User> DB_TO_BUSINESS = userDB -> {
        var id = userDB.getId();
        var name = userDB.getName();
        var email = userDB.getEmailAddress();
        var username = userDB.getUsername();
        var password = userDB.getPassword();
        var role = userDB.getRole() == UserDB.RoleDB.R ? User.Role.REGULAR : User.Role.SERVICEMAN;
        var github = userDB.getGithub();
        return new User(id, name, email, role, username, password, github);
    };

    /**
     * Maps business layer User to data layer UserDB.
     */
    public static final Function<User, UserDB> BUSINESS_TO_DB = user -> {
        UserDB userDB = new UserDB();
        userDB.setId(user.getId());
        userDB.setName(user.getName());
        userDB.setUsername(user.getUsername());
        userDB.setEmailAddress(user.getEmailAddress());
        userDB.setRole(user.getRole() == User.Role.REGULAR ? UserDB.RoleDB.R : UserDB.RoleDB.S);
        userDB.setPassword(user.getPassword());
        userDB.setGithub(user.getGithub());
        return userDB;
    };
}
