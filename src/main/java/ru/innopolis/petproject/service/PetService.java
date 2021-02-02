package ru.innopolis.petproject.service;

import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.User;

import java.io.File;
import java.util.List;

/**
 * Методы для класса {@link Pet}
 */
public interface PetService {

    Pet save(Pet pet);

    List<Pet> findAll();

    List<Pet> findAllByFiler(String name, String sex, String type);

    List<Pet> findAllPetsOfUser(Pet pet, User user);

    Pet findById (Long id);

    void delete(Long id);

    List<String> findAllPetsNameBySexAndTypePetId(String sex, Long petID);

    Pet addPet(String name, User user, String typePet, String sex, String birthday);

    Pet findByName(String name);

    void setParents(Long id, String father, String mother);

    void update(Long id, String name, String typePet, String sex, String birthday, boolean alive);

    void update(Long id, byte[] image);

    void savePet(Pet pet);
}
