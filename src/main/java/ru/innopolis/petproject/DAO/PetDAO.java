package ru.innopolis.petproject.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.TypePet;
import ru.innopolis.petproject.entities.User;

import java.util.List;

@Repository
public interface PetDAO extends JpaRepository<Pet, Long> {

    Pet saveAndFlush(Pet pet);

    int countPetsByUser(User user);

    int countPetsByTypePet(TypePet type);

    Pet findByName(String name);

    List<Pet> findByUser(User user);

    Pet save(Pet pet);
}
