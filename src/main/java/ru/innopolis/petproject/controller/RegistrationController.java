package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.UserService;
import ru.innopolis.petproject.validator.UserValidator;

@Controller
public class RegistrationController {

    private UserService userService;
    private UserValidator userValidator;

    @Autowired
    public RegistrationController(UserService userService, UserValidator userValidator) {
        this.userService = userService;
        this.userValidator = userValidator;
    }

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @PostMapping("/registration")
    public String processRegistration(
            @ModelAttribute("userForm") User user,
            BindingResult bindingResult,
            Model model) {
        userValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(user);
        return "redirect:/";
    }
}
