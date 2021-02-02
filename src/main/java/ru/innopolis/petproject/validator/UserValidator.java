package ru.innopolis.petproject.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.UserService;

import java.util.Objects;
import java.util.regex.Pattern;

@Component
public class UserValidator implements Validator {

    private UserService userService;

    @Autowired
    public UserValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "UserForm.Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "UserForm.Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "UserForm.Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "UserForm.Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "UserForm.Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "UserForm.Required");

        if (userService.findByLogin(user.getLogin()) != null) {
            errors.rejectValue("username", "UserForm.DuplicateLogin");
        }

        if (!Objects.equals(user.getConfirmPassword(), user.getPassword())) {
            errors.rejectValue("confirmPassword", "UserForm.DifferentPassword");
        }

        if (!Pattern.compile("^(.+)@(.+)$").matcher(user.getEmail()).matches()) {
            errors.rejectValue("email", "UserForm.InvalidEmail");
        }
    }
}
