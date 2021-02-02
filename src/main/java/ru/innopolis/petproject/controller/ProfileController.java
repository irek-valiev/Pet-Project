package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.UserService;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    private UserService userService;

    @Autowired
    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public String viewProfile(@PathVariable("id") Long id,
                              @AuthenticationPrincipal User user, Model model) {
        User currentUser = userService.findById(id);
        if (user != null && user.getId() == currentUser.getId()) {
            return "redirect:/user/profile";
        }
        model.addAttribute("user", currentUser);
        model.addAttribute("loginUser", user);
        return "view_profile";
    }


}
