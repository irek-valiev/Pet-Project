package ru.innopolis.petproject.service.impl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.SalePetsDAO;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.SalePets;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.SalePetsService;

import java.util.List;

@Service
@Log4j2
public class SalePetsServiceImpl implements SalePetsService {
    private final SalePetsDAO salePetsDAO;

    @Autowired
    public SalePetsServiceImpl(SalePetsDAO salePetsDAO) {
        this.salePetsDAO = salePetsDAO;
    }

    @Override
    public void save(SalePets salePets) {
        try {
            salePetsDAO.saveAndFlush(salePets);
            log.info("Отправлена заявка на продажу питомца");
        } catch (Exception e) {
            log.error("При попытке отправить заявку на продажу возникло исключение " + e.getStackTrace());
        }

    }

    @Override
    public List<SalePets> findByOldOwner(User user) {
        try {
            List<SalePets> result = salePetsDAO.findByOldOwner(user);
            log.info("Получены заявки на продажу выставленные пользователем " + user.toString() +
                    " count =" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При получении заявок на продажу выставленные пользователем " + user.toString() +
                    "возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<SalePets> findByPet(Pet pet) {
        try {
            List<SalePets> result = salePetsDAO.findByPet(pet);
            log.info("Получены заявки на продажу питомца " + pet.toString() + " count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При получении заявок на продажу питомца " + pet.toString() +
                    " возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public SalePets findById(Long id) {
        try {
            SalePets result = salePetsDAO.findSalePetsById(id);
            log.info("Получена заявка на продажу id=" + id);
            return result;
        } catch (Exception e) {
            log.error("При получении заявки на продажу id=" + id +
                    "возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<SalePets> findActiveSales() {
        try {
            List<SalePets> activeSales = salePetsDAO.findAllByDateSaleIsNullOrderByIdDesc();
            log.info("Получен список объявлений о продаже животных: " + activeSales.size());
            return activeSales;
        } catch (Exception e) {
            log.error("При получении списка объявлений о продаже животных возникло исключение "
                    + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<SalePets> findPetSaleStory(Pet pet) {
        return salePetsDAO.findByPetAndDateSaleIsNotNullOrderByIdAsc(pet);
    }
}
