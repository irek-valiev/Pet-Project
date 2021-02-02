package ru.innopolis.petproject.service;

import org.springframework.security.core.userdetails.UserDetailsService;
import ru.innopolis.petproject.entities.User;

import java.util.List;

/**
 * Методы для класса {@link User}
 */
public interface UserService extends UserDetailsService {

    List<User> findAll();

    User findByLogin(String login);

    User findById(Long id);

    User save(User user);

    void delete(Long id);

    void update(User currentUser, User newUser);

}
