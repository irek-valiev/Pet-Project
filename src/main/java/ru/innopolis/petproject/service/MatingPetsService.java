package ru.innopolis.petproject.service;

import ru.innopolis.petproject.entities.MatingPets;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.User;

import java.util.List;

/**
 * Методы класса {@link MatingPets}
 */
public interface MatingPetsService {

    void save(MatingPets matingPets);

    List<MatingPets> findByFromPet(Pet fromPet);

    List<MatingPets> findByToPet(Pet toPet);

    MatingPets findById(Long id);

    List<MatingPets> getUpcomingApprovedMatings(User user);
}
