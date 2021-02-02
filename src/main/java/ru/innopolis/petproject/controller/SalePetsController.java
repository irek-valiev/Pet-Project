package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.SalePets;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.PetService;
import ru.innopolis.petproject.service.SalePetsService;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Controller
public class SalePetsController {

    private SalePetsService salePetsService;
    private PetService petService;

    @Autowired
    public SalePetsController(SalePetsService salePetsService, PetService petService) {
        this.salePetsService = salePetsService;
        this.petService = petService;
    }


    //root/user/put_pet_sale?idpet=<id питомца, которого будем продавать>
    @GetMapping("/user/put_pet_sale")
    public String setMeeting(@RequestParam("idpet") Long idPet,
                             @AuthenticationPrincipal User user,
                             Model model) {

        Pet petToSell = petService.findById(idPet);
        if(petToSell != null) {
            model.addAttribute("user", user);
            model.addAttribute("pet", petToSell);
            model.addAttribute("putPetOnSaleForm", new SalePets());
            return "put_pet_sale";
        } else {
            return "redirect:/user/profile";
        }
    }

    @PostMapping("/user/put_pet_sale")
    public String postMeeting(@ModelAttribute("putPetOnSaleForm") SalePets salePets) {

        salePetsService.save(salePets);
        return "redirect:/user/profile";
    }

    @GetMapping("/user/sale_pets")
    public String getSalePets(@AuthenticationPrincipal User user, Model model) {
        List<SalePets> petsForSale = salePetsService.findActiveSales();

        model.addAttribute("user", user);
        model.addAttribute("petsForSale", petsForSale);
        return "sale_pets";
    }

    @Transactional
    @PostMapping("/user/sale_pets")
    public String buyPet(@RequestParam("sale_id") Long saleId,
                         @AuthenticationPrincipal User user) {

        if (user == salePetsService.findById(saleId).getOldOwner()) {
            return "sale_pets";
        }

        Pet updatedPet = salePetsService.findById(saleId).getPet();
        updatedPet.setUser(user);
        petService.savePet(updatedPet);

        SalePets salePets = salePetsService.findById(saleId);
        salePets.setDateSale(new Date());
        salePetsService.save(salePets);
        return "redirect:/user/profile";
    }

    //Страница должна иметь адрес: root/user/story_pet?id=<id питомца>
    @GetMapping("/user/story_pet")
    public String getPetSaleStory(@RequestParam("id") Long id,
                                    Model model) {
        Pet pet = petService.findById(id);
        List<SalePets> listOfSales = salePetsService.findPetSaleStory(pet);
        model.addAttribute("pet", pet);
        model.addAttribute("listOfSales", listOfSales);
        return "pet_sale_story";
    }
}
