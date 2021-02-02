package ru.innopolis.petproject.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.innopolis.petproject.entities.Role;
import ru.innopolis.petproject.entities.User;

@Repository
public interface UserDAO extends JpaRepository<User, Long> {
    User findByLogin(String login);

    int countUserByRole(Role role);
}
