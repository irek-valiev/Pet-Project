package ru.innopolis.petproject.service.impl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.PetDAO;
import ru.innopolis.petproject.DAO.TypePetDAO;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.PetService;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


@Service
@Log4j2
public class PetServiceImpl implements PetService {

    private final PetDAO petDAO;
    private final TypePetDAO typePetDAO;

    @Autowired
    public PetServiceImpl(PetDAO petDAO, TypePetDAO typePetDAO) {
        this.petDAO = petDAO;
        this.typePetDAO = typePetDAO;
    }


    @Override
    public Pet save(Pet pet) {
        try {
            Pet result = petDAO.saveAndFlush(pet);
            log.info("Сохранение состояния питомца прошло успешно " + pet.toString());
            return result;
        } catch (Exception e) {
            log.error("При попытке сохранить состояние питомца возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<Pet> findAll() {
        try {
            List<Pet> result = petDAO.findAll();
            log.info("Получен список питомцев count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("при получении списка питомцев возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<Pet> findAllPetsOfUser(Pet pet, User user) {
        try {
            List<Pet> result = petDAO.findByUser(user)
                    .stream()
                    .filter(x -> !x.getSex().equals(pet.getSex())
                            && x.getTypePet() == pet.getTypePet())
                    .collect(Collectors.toList());
            log.info("Получен список питомцев " + user.toString() + ", count=" + result.size());
            return result;
        } catch (Exception e) {
            log.error("При получении списка питомцев " + user.toString() +
                    " возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public Pet findById(Long id) {
        try {
            Pet result = petDAO.findById(id).orElse(null);
            log.info("Получен питомец id=" + id);
            return result;
        } catch (Exception e) {
            log.error("При получении питомца id=" + id +
                    "возникло исключение" + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<Pet> findAllByFiler(String name, String sex, String type) {
        try {
            List<Pet> result = petDAO.findAll();

            if (!name.equals("")) {
                result = result.stream()
                        .filter(pet -> pet.getName().equals(name))
                        .collect(Collectors.toList());
            }

            if (!sex.equals("")) {
                result = result.stream()
                        .filter(pet -> pet
                                .getSex().equals(sex))
                        .collect(Collectors.toList());
            }

            if (!type.equals("")) {
                result = result.stream()
                        .filter(pet -> pet
                                .getTypePet()
                                .getTypeName().equals(type))
                        .collect(Collectors.toList());
            }
            log.info(String.format("Получен результат поиска [name = %s, sex=%s, type=%s] count=%s", name, sex, type, result.size()));
            return result;
        } catch (Exception e) {
            log.error(String.format("При поиске возникло исключение [name = %s, sex=%s, type=%s] %s", name, sex, type, e.getStackTrace()));
            return null;
        }
    }

    @Override
    public void delete(Long id) {
        try {
            petDAO.deleteById(id);
            log.info("Удален питомец id=" + id);
        } catch (Exception e) {
            log.error("При удалении питомца id=" + id + " возникло исключение " + e.getStackTrace());
        }
    }

    public List<String> findAllPetsNameBySexAndTypePetId(String sex, Long petID) {
        List<Pet> petsByOneSex = petDAO.findAll().stream()
                .filter(x -> x.getSex().equals(sex))
                .filter(t -> t.getTypePet().getId().equals(petDAO.getOne(petID).getTypePet().getId()))
                .filter(n -> !n.getId().equals(petID))
                .collect(Collectors.toList());
        List<String> allPetsByOneSexNameAndTypePetId = new ArrayList<>();
        for (Pet pet : petsByOneSex) {
            allPetsByOneSexNameAndTypePetId.add(pet.getName());
        }
        return allPetsByOneSexNameAndTypePetId;
    }

    public Pet addPet(String name, User user, String typePetName, String sex, String birthday) {
        try {
            Pet testPet = petDAO.findByName(name);
            Pet savePet = new Pet();
            if (testPet != null) {
                return null;
            }
            savePet.setUser(user);
            savePet.setTypePet(typePetDAO.findByTypeName(typePetName));
            savePet.setName(name);
            savePet.setSex(sex);
            String delimeter = "-";
            String[] subStr = birthday.split(delimeter);
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.MONTH, Integer.parseInt(subStr[1]) - 1);
            calendar.set(Calendar.YEAR, Integer.parseInt(subStr[0]));
            calendar.set(Calendar.DATE, Integer.parseInt(subStr[2]));
            Date rightBirthday = calendar.getTime();
            savePet.setBirthday(rightBirthday);
            savePet.setAlive(true);
            savePet.setImages(null);
            petDAO.save(savePet);
            log.info("Добавлен питомец " + typePetName + " с именем " + name + " пользователю с ID " + user.getId());
            return savePet;
        } catch (Exception e) {
            log.error("При добавлении питомца " + typePetName + " с именем " + name
                    + " пользователю с ID " + user.getId() + " возникло исключение " + e.getStackTrace());
            return null;
        }
    }

    @Override
    public Pet findByName(String name) {
        return petDAO.findByName(name);
    }

    @Override
    public void setParents(Long id, String father, String mother) {
        Pet childPet = petDAO.findById(id).orElse(null);
        try {
            if (father == null) {
                childPet.setFather_id(null);
            } else {
                if (petDAO.findByName(father).getId() != null) {
                    childPet.setFather_id(petDAO.findByName(father).getId());
                } else childPet.setFather_id(null);
            }
            if (mother == null) {
                childPet.setMother_id(null);
            } else {
                if (petDAO.findByName(mother).getId() != null) {
                    childPet.setMother_id(petDAO.findByName(mother).getId());
                } else childPet.setFather_id(null);
            }
            petDAO.flush();
            log.info("Внесены сведения о родителях питомцу с ID " + childPet.getId());
        } catch (Exception e) {
            log.error("При внесении сведений о родителях питомцу с ID " + childPet.getId()
                    + " возникло исключение " + e.getStackTrace());
        }
    }

    public void update(Long id, String name, String typePet, String sex, String birthday, boolean alive) {
        try {
            String delimeter = "-";
            String[] subStr = birthday.split(delimeter);
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.MONTH, Integer.parseInt(subStr[1]) - 1);
            calendar.set(Calendar.YEAR, Integer.parseInt(subStr[0]));
            calendar.set(Calendar.DATE, Integer.parseInt(subStr[2]));
            Date rightBirthday = calendar.getTime();
            Pet editPet = petDAO.findById(id).get();
            editPet.setName(name);
            editPet.setTypePet(typePetDAO.findByTypeName(typePet));
            editPet.setSex(sex);
            editPet.setBirthday(rightBirthday);
            editPet.setAlive(alive);
            petDAO.save(editPet);
            log.info("Обновлены данные по питомцу с id= " + id);
        } catch (Exception e) {
            log.error("При обновлении данных питомца с id=" + id + " возникло исключение " + e.getStackTrace());
        }
    }

    @Override
    public void update(Long id, byte[] image) {
        try {
            if (image.length == 0) {
                log.info("Картинка не была выбрана");
                return;
            }
            Pet pet = petDAO.findById(id).get();
            pet.setImages(image);
            petDAO.saveAndFlush(pet);
            log.info("Обнавлена картинка питомца id=" + id);
        } catch (Exception e) {
            log.error("При обновлении картинки питомца id=" + id + " произошло исключение " + e.getStackTrace());
        }
    }

    @Override
    public void savePet(Pet pet) {
        try {
            petDAO.save(pet);
            log.info("Данные питомца обновлены");
        } catch (Exception e) {
            log.error("При попытке обновить данные питомца возникло исключение " + e.getStackTrace());
        }

    }
}
