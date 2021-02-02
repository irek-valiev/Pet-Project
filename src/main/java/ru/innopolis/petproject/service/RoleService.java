package ru.innopolis.petproject.service;

import ru.innopolis.petproject.entities.Role;

import java.util.List;

public interface RoleService {

    List<Role> findAll();

    void save(Role role);

    void delete(Long id);

}
