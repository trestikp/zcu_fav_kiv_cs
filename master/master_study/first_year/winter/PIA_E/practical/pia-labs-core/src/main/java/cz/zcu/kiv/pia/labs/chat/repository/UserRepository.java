package cz.zcu.kiv.pia.labs.chat.repository;

import cz.zcu.kiv.pia.labs.chat.domain.User;
import reactor.core.publisher.Mono;

public interface UserRepository {
    /**
     * Registers user
     *
     * @param user User to be registered
     * @return Registered user
     */
    Mono<User> registerUser(User user);
}
