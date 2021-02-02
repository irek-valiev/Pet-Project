package ru.innopolis.petproject.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.innopolis.petproject.entities.MatingPets;
import ru.innopolis.petproject.entities.Pet;

import java.util.List;

@Repository
public interface MatingPetsDAO extends JpaRepository<MatingPets, Long> {

    List<MatingPets> findByToPetOrderByDateMatingDesc(Pet pet);

    List<MatingPets> findByFromPetOrderByDateMatingDesc(Pet pet);

    MatingPets findMatingPetsById(Long id);

    MatingPets saveAndFlush(MatingPets matingPets);

    @Query("FROM MatingPets mat \n" +
            "WHERE mat.isDone = true \n" +
            "AND mat.dateMating >= current_date \n" +
            "AND mat.toPet.user.id = :id")
    List<MatingPets> getUpcomingIncomingMatingsByUserId(@Param("id") Long userId);

    @Query("FROM MatingPets mat \n" +
            "WHERE mat.isDone = true \n" +
            "AND mat.dateMating >= current_date \n" +
            "AND mat.fromPet.user.id = :id")
    List<MatingPets> getUpcomingOutcomingMatingsByUserId(@Param("id") Long userId);
}
