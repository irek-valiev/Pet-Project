package ru.innopolis.petproject.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.SalePets;
import ru.innopolis.petproject.entities.User;

import java.util.List;

@Repository
public interface SalePetsDAO extends JpaRepository<SalePets, Long> {

    List<SalePets> findByPet(Pet pet);

    List<SalePets> findByOldOwner(User owner);

    SalePets findSalePetsById(Long id);

    SalePets saveAndFlush(SalePets salePets);

    List<SalePets> findAllByDateSaleIsNullOrderByIdDesc();

    List<SalePets> findByPetAndDateSaleIsNotNullOrderByIdAsc(Pet pet);
}
