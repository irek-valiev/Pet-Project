package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.innopolis.petproject.service.PetService;
import ru.innopolis.petproject.service.TypePetService;

import java.io.IOException;

@Controller
@RequestMapping("/")
public class SearchController {

    private PetService petService;
    private TypePetService typePetService;

    @Autowired
    public SearchController(PetService petService, TypePetService typePetService) {
        this.petService = petService;
        this.typePetService = typePetService;
    }

    @GetMapping
    public String search(
            @RequestParam(name = "name", required = false, defaultValue = "") String name,
            @RequestParam(name = "sex", required = false, defaultValue = "") String sex,
            @RequestParam(name = "type", required = false, defaultValue = "") String type,
            Model model) throws IOException {
        model.addAttribute("listTypes", typePetService.findAll());
        if (!name.equals("") || !sex.equals("") || !type.equals(""))
            model.addAttribute("pets", petService.findAllByFiler(name, sex, type));
        else
            model.addAttribute("pets", petService.findAll());

        return "index";
    }
}
