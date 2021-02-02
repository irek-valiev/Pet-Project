package ru.innopolis.petproject.service;

import ru.innopolis.petproject.entities.Message;
import ru.innopolis.petproject.entities.User;
import java.util.List;

/**
 * Методы класса {@link Message}
 */
public interface MessageService {

    void save(Message message);

    List<Message> findToUserMessages(User user);

    List<Message> findFromUserMessages(User user);

    Message getMessageById(Long messageId);
}
