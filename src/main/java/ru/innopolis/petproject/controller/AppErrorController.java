package ru.innopolis.petproject.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AppErrorController implements ErrorController {

    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String errorPage(Model model,
                            HttpServletRequest httpRequest) {
        int errorCode = (Integer) httpRequest.getAttribute("javax.servlet.error.status_code");
        model.addAttribute("errorCode", errorCode);

        return "error_page";
    }

    @Override
    public String getErrorPath() {
        return "/error";
    }
}
