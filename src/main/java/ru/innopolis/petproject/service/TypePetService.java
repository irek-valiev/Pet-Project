package ru.innopolis.petproject.service;

import ru.innopolis.petproject.entities.TypePet;

import java.util.List;

/**
 * Методы для класса {@link TypePet}
 */
public interface TypePetService {

    List<TypePet> findAll();

    void save(TypePet typePet);

    void delete(Long id);

    TypePet findTypeByTypePetName(String name);

}
