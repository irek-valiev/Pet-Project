package ru.innopolis.petproject.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.innopolis.petproject.entities.TypePet;

@Repository
public interface TypePetDAO extends JpaRepository<TypePet, Long> {

    TypePet findByTypeName(String type);

}
