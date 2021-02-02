package ru.innopolis.petproject.service;

import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.SalePets;
import ru.innopolis.petproject.entities.User;

import java.util.List;
/**
 * Методы класса {@link SalePets}
 */
public interface SalePetsService {

    void save(SalePets salePets);

    List<SalePets> findByOldOwner(User user);

    List<SalePets> findByPet(Pet pet);

    SalePets findById(Long id);

    List<SalePets> findActiveSales();

    List<SalePets> findPetSaleStory(Pet pet);
}
