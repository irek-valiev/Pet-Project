package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.service.PetService;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class ImageController {

    @Value("${spring.default.image.pets}")
    private String DEFAULT_AVATAR_PATH;
    private final PetService petService;

    @Autowired
    public ImageController(PetService petService) {
        this.petService = petService;
    }

    @GetMapping("/pet_image")
    @ResponseBody
    public void getPetImage(HttpServletResponse response, @RequestParam(name = "id") Long id) throws IOException {
        Pet pet = petService.findById(id);
        if (pet == null) {
            return;
        }
        byte[] image = pet.getImages();
        if (image != null) {
            ServletOutputStream os = response.getOutputStream();
            response.setContentType("image/png");
            os.write(image);
            os.close();
        } else {
            response.sendRedirect(DEFAULT_AVATAR_PATH);
        }
    }
}
