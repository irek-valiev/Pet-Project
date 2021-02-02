package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.innopolis.petproject.entities.Role;
import ru.innopolis.petproject.entities.TypePet;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.PetService;
import ru.innopolis.petproject.service.RoleService;
import ru.innopolis.petproject.service.TypePetService;
import ru.innopolis.petproject.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private RoleService roleService;
    private UserService userService;
    private PetService petService;
    private TypePetService typePetService;

    @Autowired
    public AdminController(RoleService roleService, UserService userService, PetService petService, TypePetService typePetService) {
        this.roleService = roleService;
        this.userService = userService;
        this.petService = petService;
        this.typePetService = typePetService;
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String adminPanel() {
        return "admin";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/roles")
    public String rolesList(Model model) {
        model.addAttribute("all_roles", roleService.findAll());
        model.addAttribute("new_role", new Role());
        return "admin/role_list";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/roles/{id}")
    public String deleteRole(@PathVariable("id") Long id) {
        roleService.delete(id);
        return "redirect:/admin/roles";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/roles")
    public String saveRole(@ModelAttribute("new_role") Role role) {
        roleService.save(role);
        return "redirect:/admin/roles";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users")
    public String usersList(Model model) {
        model.addAttribute("all_users", userService.findAll());
        return "admin/user_list";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/{id}")
    public String editUser(@PathVariable("id") Long id, Model model) {
        model.addAttribute("edit_user", userService.findById(id));
        model.addAttribute("all_roles", roleService.findAll());
        return "admin/edit_user";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/users")
    public String saveUser(@ModelAttribute("edit_user") User editUser) {
        User currentUser = userService.findById(editUser.getId());
        userService.update(currentUser, editUser);
        return "redirect:/admin/users";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id) {
        userService.delete(id);
        return "redirect:/admin/users";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/pets")
    public String petsList(Model model) {
        model.addAttribute("all_pets", petService.findAll());
        return "admin/pet_list";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/pets/{id}")
    public String deletePet(@PathVariable("id") Long id) {
        petService.delete(id);
        return "redirect:/admin/pets";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/types-pet")
    public String typesList(Model model) {
        model.addAttribute("all_types", typePetService.findAll());
        model.addAttribute("new_type", new TypePet());
        return "admin/type_pet_list";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/types-pet/{id}")
    public String deleteType(@PathVariable("id") Long id) {
        typePetService.delete(id);
        return "redirect:/admin/types-pet";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/types-pet")
    public String saveType(@ModelAttribute("new_type") TypePet typePet) {
        typePetService.save(typePet);
        return "redirect:/admin/types-pet";
    }

}
