package ru.innopolis.petproject.service.impl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.MatingPetsDAO;
import ru.innopolis.petproject.entities.MatingPets;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.MatingPetsService;

import java.util.List;

@Service
@Log4j2
public class MatingPetsServiceImpl implements MatingPetsService {
    private final MatingPetsDAO matingPetsDAO;

    @Autowired
    public MatingPetsServiceImpl(MatingPetsDAO matingPetsDAO) {
        this.matingPetsDAO = matingPetsDAO;
    }

    @Override
    public void save(MatingPets matingPets) {
        try {
            matingPetsDAO.saveAndFlush(matingPets);
            log.info(matingPets.getFromPet().getUser().getLogin() +
                    " Отправлен запрос на случку с " +
                    matingPets.getToPet().getUser().getLogin() +
                    " [ToPet=" + matingPets.getToPet().getId() + "; " +
                    "FromPet=" + matingPets.getFromPet().getId() + "]");
        } catch (Exception e) {
            log.error("При отправке запроса возникло исключение " + e.getStackTrace());
        }
    }

    @Override
    public List<MatingPets> findByFromPet(Pet fromPet) {
        try {
            List<MatingPets> result = matingPetsDAO.findByFromPetOrderByDateMatingDesc(fromPet);
            log.info("Получены исходящие заявки на случку " +
                    fromPet.getUser().toString() + ". count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При попытке получить исходящие заявки на случку возникло исключение " +
                    e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<MatingPets> findByToPet(Pet toPet) {
        try {
            List<MatingPets> result = matingPetsDAO.findByToPetOrderByDateMatingDesc(toPet);
            log.info("Получены входящие заявки на случку " +
                    toPet.getUser().toString() + ". count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При попытке получить входящие заявки на случку возникло исключение " +
                    e.getStackTrace());
            return null;
        }
    }

    @Override
    public MatingPets findById(Long id) {
        try {
            MatingPets result = matingPetsDAO.findMatingPetsById(id);
            log.info("Получена заявка на случку " + result.toString());
            return result;
        } catch (Exception e) {
            log.error("При попытке получить заявку id=" + id + " возникло исключение" +
                    e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<MatingPets> getUpcomingApprovedMatings(User user) {
        List<MatingPets> matingPetsList = matingPetsDAO.getUpcomingIncomingMatingsByUserId(user.getId());
        List<MatingPets> outcomingMatings = matingPetsDAO.getUpcomingOutcomingMatingsByUserId(user.getId());
        matingPetsList.addAll(outcomingMatings);
        log.info("Запрос списка предстоящих встреч для пользователя: " + user.getId());
        return matingPetsList;
    }
}
