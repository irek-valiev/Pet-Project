package ru.innopolis.petproject.service.impl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.PetDAO;
import ru.innopolis.petproject.DAO.TypePetDAO;
import ru.innopolis.petproject.entities.TypePet;
import ru.innopolis.petproject.service.TypePetService;

import java.util.List;

@Service
@Log4j2
public class TypePetServiceImpl implements TypePetService {

    private TypePetDAO typePetDAO;
    private PetDAO petDAO;

    @Autowired
    public TypePetServiceImpl(TypePetDAO typePetDAO, PetDAO petDAO) {
        this.typePetDAO = typePetDAO;
        this.petDAO = petDAO;
    }

    @Override
    public List<TypePet> findAll() {
        try {
            List<TypePet> result = typePetDAO.findAll();
            log.info("Получены все виды питомцев count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При получении всех видов питомцев возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public void save(TypePet typePet) {
        try {
            TypePet type = typePetDAO.findByTypeName(typePet.getTypeName());
            if (type == null) {
                typePetDAO.save(typePet);
                log.info("Вид питомца сохранен " + type.toString());
            }
        } catch (Exception e) {
            log.error("При сохранении вида питомца " + typePet.toString() + " возникло исключение " + e.getStackTrace());
        }
    }

    @Override
    public void delete(Long id) {
        try {
            TypePet type = typePetDAO.findById(id).orElse(null);
            if (type != null && petDAO.countPetsByTypePet(type) == 0) {
                typePetDAO.deleteById(id);
                log.info("Вид питомца удален " + type.toString());
            }
        } catch (Exception e) {
            log.error("При удалении вида питомца id=" + id + " возникло исключение " + e.getStackTrace());
        }

    }

    @Override
    public TypePet findTypeByTypePetName(String name){
        try {
            TypePet typePet = typePetDAO.findByTypeName(name);
            log.info("Найден вид питомца " + typePet + " по имени в запросе " + name);
            return typePet;
        } catch (Exception e){
            log.error("При поиске вида питомца с именем " + name + " возникло исключение " + e.getStackTrace());
            return null;
        }
    }
}
