package ru.innopolis.petproject.service.impl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.RoleDAO;
import ru.innopolis.petproject.DAO.UserDAO;
import ru.innopolis.petproject.entities.Role;
import ru.innopolis.petproject.service.RoleService;

import java.util.List;

@Service
@Log4j2
public class RoleServiceImpl implements RoleService {

    private RoleDAO roleDAO;
    private UserDAO userDAO;
    private String defaultRolePrefix = "ROLE_";

    @Autowired
    public RoleServiceImpl(RoleDAO roleDAO, UserDAO userDAO) {
        this.roleDAO = roleDAO;
        this.userDAO = userDAO;
    }

    @Override
    public List<Role> findAll() {
        try {
            List<Role> result = roleDAO.findAll();
            log.info("Получен список ролей count="+result.size());
            return  result;
        }
        catch (Exception e){
            log.error("При получении списка ролей возникло исключение" + e.getStackTrace());
            return null;
        }
    }

    @Override
    public void save(Role role) {
        try {
            String roleValue = defaultRolePrefix + role.getName().toUpperCase();
            Role rl = roleDAO.findByName(roleValue);
            if (rl == null) {
                role.setName(roleValue);
                roleDAO.save(role);
                log.info("Создана новая роль: " + role.getName());
            }
        } catch (Exception e) {
            log.error("При попытке создании роли возникло исключение " + e.getStackTrace());
        }

    }

    @Override
    public void delete(Long id) {
        try {
            Role role = roleDAO.findById(id).orElse(null);
            if (role != null && userDAO.countUserByRole(role) == 0) {
                roleDAO.deleteById(id);
                log.info("Роль удалена: " + role.getName());
            }
        } catch (Exception e) {
            log.error("При попытке удалить роль возникло исключение " + e.getStackTrace());
        }

    }

}
