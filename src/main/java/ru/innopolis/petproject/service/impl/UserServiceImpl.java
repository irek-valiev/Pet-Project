package ru.innopolis.petproject.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.PetDAO;
import ru.innopolis.petproject.DAO.RoleDAO;
import ru.innopolis.petproject.DAO.UserDAO;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.UserService;

import java.util.List;
import java.util.Objects;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

    private final UserDAO userDAO;
    private final RoleDAO roleDAO;
    private final PetDAO petDAO;
    private final BCryptPasswordEncoder encoder;

    @Autowired
    public UserServiceImpl(UserDAO userDAO, RoleDAO roleDAO, PetDAO petDAO, BCryptPasswordEncoder encoder) {
        this.userDAO = userDAO;
        this.roleDAO = roleDAO;
        this.petDAO = petDAO;
        this.encoder = encoder;
    }

    @Override
    public List<User> findAll() {
        try {
            List<User> result = userDAO.findAll();
            log.info("Получены все пользователи count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При получении всех пользователей возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public User save(User user) {
        try {
            User newUser = findByLogin(user.getLogin());

            if (newUser != null) {
                return null;
            }

            user.setRole(roleDAO.getOne(1L)); // default role: ROLE_USER
            user.setPassword(encoder.encode(user.getPassword()));
            userDAO.save(user);
            log.info("Добавлен новый пользователь " + user.toString());
            return user;
        } catch (Exception e) {
            log.error("При добавлении нового пользователя возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public void delete(Long id) {
        try {
            User user = userDAO.findById(id).orElse(null);
            if (user != null && petDAO.countPetsByUser(user) == 0) {
                userDAO.deleteById(id);
                log.info("Удален пользователь id=" + id);
            }
        } catch (Exception e) {
            log.error("При удалении пользователя id=" + id + " возникло исключение " + e.getStackTrace());
        }

    }

    @Override
    public void update(User currentUser, User newUser) {
        try {
            currentUser.setFirstName(newUser.getFirstName());
            currentUser.setLastName(newUser.getLastName());
            currentUser.setEmail(newUser.getEmail());

            if (newUser.getRole() != null) {
                currentUser.setRole(newUser.getRole());
            }

            if (!Objects.equals(newUser.getPassword(), "") && newUser.getPassword() != null) {
                currentUser.setPassword(encoder.encode(newUser.getPassword()));
            }

            userDAO.save(currentUser);
            log.info("Редактированеи пользователя прошло успешно " +
                    currentUser.toString() + " -> " + newUser.toString());
        } catch (Exception e) {
            log.error("При редактировании пользователя возникло исключение " + e.getStackTrace());
        }
    }

    @Override
    public User findByLogin(String login) {
        try {
            User result = userDAO.findByLogin(login);
            log.info("Получен пользователь " + result.toString());
            return result;
        } catch (Exception e) {
            log.error("При получении пользователя " + login + " возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public User findById(Long id) {
        try {
            User result = userDAO.findById(id).orElse(null);
            log.info("Получен пользователь " + result.toString());
            return result;
        } catch (Exception e) {
            log.error("При получении пользователя id=" + id + " возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        User user = userDAO.findByLogin(login);

        if (user == null) {
            log.error("ошибка при входе пользователя " + login);
            throw new UsernameNotFoundException("User '" + login + "' not found");
        }
        log.info("Вход пользователя " + user.toString());
        return user;
    }

}
