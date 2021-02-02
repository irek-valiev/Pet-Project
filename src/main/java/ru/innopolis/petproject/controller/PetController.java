package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.PetService;
import ru.innopolis.petproject.service.TypePetService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;

@Controller
public class PetController {

    private PetService petService;
    private TypePetService typePetService;

    @Autowired
    public PetController(PetService petService, TypePetService typePetService) {
        this.petService = petService;
        this.typePetService = typePetService;

    }

    @GetMapping("/user/pet_profile")
    public String petProfile(@RequestParam("id") Long id,
                             @AuthenticationPrincipal User user,
                             Model model) throws IOException {
        Pet pet = petService.findById(id);
        if (pet != null) {
            model.addAttribute("user", user);
            model.addAttribute("pet", pet);
            return "pet_profile";
        } else {
            return "redirect:/user/profile";
        }
    }

    @GetMapping("/user/pet_profile/{id}")
    public String deletePet(@AuthenticationPrincipal User user, @PathVariable("id") Long id) {
        if (user.getId() != null && petService.findById(id).getUser().getId().equals(user.getId())) {
            petService.delete(id);
        }
        return "redirect:/user/profile";
    }

    @GetMapping("/user/add_pet")
    public String addNewPet(@AuthenticationPrincipal User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("petForm", new Pet());
        model.addAttribute("toDay", LocalDate.now());
        model.addAttribute("allTypePet", typePetService.findAll());
        return "add_pet";
    }

    @PostMapping("/user/add_pet")
    public String submitNewPet(@RequestParam(name = "name", required = false, defaultValue = "") String name,
                               @RequestParam(name = "typePet", required = false, defaultValue = "") String typePet,
                               @RequestParam(name = "sex", required = false, defaultValue = "") String sex,
                               @RequestParam(name = "birthday", required = false, defaultValue = "") String birthday,
                               @RequestParam(name = "checkBox", required = false, defaultValue = "") String checkBox,
                               @AuthenticationPrincipal User user) {
        if (checkBox.equals("on")) {
            petService.addPet(name, user, typePet, sex, birthday);
            return "redirect:/user/profile";
        }
        petService.addPet(name, user, typePet, sex, birthday);
        return "redirect:/user/add_pet/indicate_parents/" + petService.findByName(name).getId();
    }

    @GetMapping("/user/add_pet/indicate_parents/{id}")
    public String addNewPet(Model model, @PathVariable("id") Long id) {
        model.addAttribute("allPetsBoysName",
                petService.findAllPetsNameBySexAndTypePetId("MALE", id));
        model.addAttribute("allPetsGirlsName",
                petService.findAllPetsNameBySexAndTypePetId("FEMALE", id));
        return "indicate_parents";
    }

    @PostMapping("/user/add_pet/indicate_parents/{id}")
    public String submitNewPet(@PathVariable("id") Long id,
                               @RequestParam(name = "father", required = false, defaultValue = "") String father,
                               @RequestParam(name = "mother", required = false, defaultValue = "") String mother) {
        petService.setParents(id, father, mother);
        return "redirect:/user/profile";
    }

    @GetMapping("/pet_profile/edit_pet_profile/{id}")
    public String editPetProfile(@PathVariable("id") Long id, @AuthenticationPrincipal User user, Model model) {
        model.addAttribute("edit_pet", petService.findById(id));
        model.addAttribute("user", user);
        model.addAttribute("toDay", LocalDate.now());
        model.addAttribute("allTypePet", typePetService.findAll());
        return "edit_pet_profile";
    }

    @PostMapping("/pet_profile/edit_pet_profile/{id}")
    public String submitEditPetProfile(@PathVariable("id") Long id,
                                       @RequestParam(name = "name", required = false, defaultValue = "") String name,
                                       @RequestParam(name = "typePet", required = false, defaultValue = "") String typePet,
                                       @RequestParam(name = "sex", required = false, defaultValue = "") String sex,
                                       @RequestParam(name = "birthday", required = false, defaultValue = "") String birthday,
                                       @RequestParam(name = "alive", required = false, defaultValue = "") Boolean alive,
                                       @RequestParam(name = "image", required = false) Optional<MultipartFile> file) throws IOException {

        if(file.isPresent()){
            byte[] image = file.get().getBytes();
            petService.update(id,image);
        }
        else
            petService.update(id, name, typePet, sex, birthday, alive.booleanValue());
        return "redirect:/user/profile";
    }
}
