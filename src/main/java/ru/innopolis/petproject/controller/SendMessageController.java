package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.innopolis.petproject.entities.Message;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.MessageService;
import ru.innopolis.petproject.service.UserService;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;

@Controller
@RequestMapping("/user")
public class SendMessageController {
    private User toUser;
    private UserService toUserServ;
    private MessageService messageService;

    @Autowired
    SendMessageController(MessageService messageService, UserService toUser) {
        toUserServ = toUser;
        this.messageService = messageService;
    }

    @GetMapping("/sending_messages")
    public String openPage(@RequestParam(value = "to", required = false) Long id, Model model) {
        if (id != null) {
            toUser = toUserServ.findById(id);
            model.addAttribute("to", toUser.getLogin());
        }
        return "sending_messages";
    }

    @PostMapping("/sending_messages")
    public String send(@AuthenticationPrincipal User user,
                       HttpServletRequest request,
                        Model model) {

        String messageBody = request.getParameter("message");
        Message message = new Message();
        message.setMessageBody(messageBody);
        message.setFromUser(user);
        message.setToUser(toUser);
        message.setDateWrite(new Date(System.currentTimeMillis()));
        messageService.save(message);
        model.addAttribute("to", toUser.getLogin());
        return "sending_messages";
    }
}
