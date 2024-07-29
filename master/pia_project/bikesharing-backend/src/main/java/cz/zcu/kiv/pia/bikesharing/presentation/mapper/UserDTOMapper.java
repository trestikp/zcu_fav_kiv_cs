package cz.zcu.kiv.pia.bikesharing.presentation.mapper;

import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.model.UserDTO;

import java.util.function.Function;

/**
 * Mapper for converting presentation layer and business layer User.
 */
public class UserDTOMapper {
    /**
     * Mapper for converting business layer User to presentation layer UserDTO.
     */
    public static final Function<User, UserDTO> BUSINESS_TO_DTO = user -> {
        if (user == null) {
            return null;
        }

        var id = user.getId();
        var username = user.getUsername();
        var email = user.getEmailAddress();
        return new UserDTO(id, username, email);
    };
}
