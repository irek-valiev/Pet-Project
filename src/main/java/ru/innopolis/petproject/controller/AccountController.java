package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.UserService;
import ru.innopolis.petproject.validator.EditUserValidator;

@Controller
@RequestMapping("/user")
public class AccountController {
    private EditUserValidator userValidator;
    private UserService userService;

    @Autowired
    public AccountController(EditUserValidator userValidator, UserService userService) {
        this.userValidator = userValidator;
        this.userService = userService;
    }

    @GetMapping("/profile")
    public String userAccount(@AuthenticationPrincipal User auth, Model model) {
        model.addAttribute("user", userService.findById(auth.getId()));
        model.addAttribute("user_id", auth.getId());
        return "profile";
    }

    @GetMapping("/profile/edit")
    public String editAccount(@AuthenticationPrincipal User user, Model model) {
        User editUser = new User();
        editUser.setFirstName(user.getFirstName());
        editUser.setLastName(user.getLastName());
        editUser.setEmail(user.getEmail());

        model.addAttribute("edit_user", editUser);
        return "edit_profile";
    }

    @PostMapping("/profile/edit")
    public String submitEditAccount(
            @AuthenticationPrincipal User currentUser,
            @ModelAttribute("edit_user") User editUser,
            BindingResult bindingResult) {

        userValidator.validate(editUser, bindingResult);

        if (bindingResult.hasErrors()) {
            return "edit_profile";
        }

        userService.update(currentUser, editUser);

        return "redirect:/user/profile";
    }
}
