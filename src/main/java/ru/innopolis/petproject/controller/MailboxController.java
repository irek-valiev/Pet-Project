package ru.innopolis.petproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.innopolis.petproject.entities.Message;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.MessageService;

import java.sql.Date;

@Controller
@RequestMapping("user/profile")
public class MailboxController {
    private final static String MAIL_LIST_TYPE = "t";
    private final static String MESSAGE_ID = "message_id";
    private final static String INBOX = "inbox";
    private final static String OUTBOX = "sent";
    private MessageService messageService;

    @Autowired
    public MailboxController(MessageService messageService) {
        this.messageService = messageService;
    }

    @GetMapping(value = "/messages", params = {MAIL_LIST_TYPE})
    public String messagesList(@RequestParam(MAIL_LIST_TYPE) String type,
                               @AuthenticationPrincipal User user,
                               Model model) {
        if (type.equals(INBOX)) {
            model.addAttribute("messagesList", messageService.findToUserMessages(user));
            model.addAttribute("type", INBOX);
        } else if (type.equals(OUTBOX)) {
            model.addAttribute("messagesList", messageService.findFromUserMessages(user));
            model.addAttribute("type", OUTBOX);
        } else {
            return "error";
        }

        model.addAttribute("username", user.getLogin());
        return "messages";
    }

    @GetMapping(value = "/messages", params = {MAIL_LIST_TYPE, MESSAGE_ID})
    public String showMessage(@RequestParam(MAIL_LIST_TYPE) String type,
                              @RequestParam(MESSAGE_ID) Long messageId,
                              @AuthenticationPrincipal User user,
                              Model model) {
        Message message = messageService.getMessageById(messageId);

        if (type.equals(INBOX) &&
                !message.getToUser().getLogin().equals(user.getLogin())) {
            return "error";
        }
        if (type.equals(OUTBOX) &&
                !message.getFromUser().getLogin().equals(user.getLogin())) {
            return "error";
        }
        if (type.equals("inbox") && message.getDateRead() == null) {
            message.setDateRead(new Date(System.currentTimeMillis()));
            messageService.save(message);
        }

        model.addAttribute("message", message);
        model.addAttribute("username", user.getLogin());
        return "message";
    }
}
