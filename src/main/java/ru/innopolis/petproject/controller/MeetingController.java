package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.innopolis.petproject.entities.MatingPets;
import ru.innopolis.petproject.entities.Pet;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.MatingPetsService;
import ru.innopolis.petproject.service.PetService;
import ru.innopolis.petproject.service.UserService;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Controller
public class MeetingController {

    private MatingPetsService matingPetsService;
    private PetService petService;
    private UserService userService;

    @Autowired
    public MeetingController(MatingPetsService matingPetsService, PetService petService, UserService userService) {
        this.matingPetsService = matingPetsService;
        this.petService = petService;
        this.userService = userService;
    }

    @GetMapping("/user/set_meet")
    public String setMeeting(@RequestParam("idpet") Long idPet,
                             @AuthenticationPrincipal User user,
                             Model model) {

        Pet petToMeet = petService.findById(idPet);
        if (petToMeet != null) {
            List<Pet> availableUserPets = petService.findAllPetsOfUser(petToMeet, user);

            model.addAttribute("user", user);
            model.addAttribute("pet", petToMeet);
            model.addAttribute("availableUserPets", availableUserPets);
            model.addAttribute("earliestMeetingDate", LocalDate.now());
            model.addAttribute("matingPetsForm", new MatingPets());
            return "set_meeting";
        } else {
            return "redirect:/user/profile";
        }
    }

    @PostMapping("/user/set_meet")
    public String postMeeting(@ModelAttribute("matingPetsForm") MatingPets matingPets) {

        matingPetsService.save(matingPets);
        return "redirect:/user/profile";
    }

    @GetMapping("/user/meetings")
    public String meetingsList(@AuthenticationPrincipal User auth, Model model) {
        User user = userService.findById(auth.getId());
        List<Pet> userPets = user.getPets();
        List<MatingPets> fromList = new ArrayList<>();
        List<MatingPets> toList = new ArrayList<>();

        for (Pet pet : userPets) {
            List<MatingPets> meetingsFrom = matingPetsService.findByFromPet(pet);
            if (meetingsFrom != null) {
                fromList.addAll(meetingsFrom);
            }

            List<MatingPets> meetingsTo = matingPetsService.findByToPet(pet);
            if (meetingsTo != null) {
                toList.addAll(meetingsTo);
            }
        }

        fromList.sort(Comparator.comparing(MatingPets::getDateMating));
        toList.sort(Comparator.comparing(MatingPets::getDateMating));

        model.addAttribute("user", user);
        model.addAttribute("outcoming_meets", fromList);
        model.addAttribute("incoming_meets", toList);
        return "meetings";
    }

    @PostMapping("user/meetings")
    public String updateMeetingStatus(@AuthenticationPrincipal User auth,
                                      HttpServletRequest request) {
        Long id = Long.valueOf(request.getParameter("meetingId"));
        Boolean isApproved = Boolean.valueOf(request.getParameter("isApproved"));

        MatingPets meeting = matingPetsService.findById(id);
        if (!meeting.getToPet().getUser().getId().equals(auth.getId())) {
            return "error";
        }

        meeting.setIsDone(isApproved);
        matingPetsService.save(meeting);
        return "redirect:/user/meetings";
    }

    @GetMapping("/upcoming_meetings")
    public String doSomething(@AuthenticationPrincipal User auth, Model model){
        List<MatingPets> upcomingApprovedMatings = matingPetsService.getUpcomingApprovedMatings(auth);
        upcomingApprovedMatings.sort(Comparator.comparing(MatingPets::getDateMating));
        if (upcomingApprovedMatings.size() > 5) {
            upcomingApprovedMatings = upcomingApprovedMatings.subList(0, 5);
        }
        model.addAttribute("upcomingMeetings", upcomingApprovedMatings);
        return "page_parts/upcoming_meetings";
    }
}
