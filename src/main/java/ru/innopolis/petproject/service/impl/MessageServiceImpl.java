package ru.innopolis.petproject.service.impl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.innopolis.petproject.DAO.MessageDAO;
import ru.innopolis.petproject.entities.Message;
import ru.innopolis.petproject.entities.User;
import ru.innopolis.petproject.service.MessageService;

import java.util.List;

@Service
@Log4j2
public class MessageServiceImpl implements MessageService {
    private final MessageDAO messageDAO;

    @Autowired
    public MessageServiceImpl(MessageDAO messageDAO) {
        this.messageDAO = messageDAO;
    }

    @Override
    public void save(Message message) {
        try {
            messageDAO.saveAndFlush(message);
            log.info(message.getFromUser().getLogin() + " отправил сообщение " +
                    message.getToUser().getLogin() + " " +
                    message.toString());
        } catch (Exception e) {
            log.error("При попытке отправить сообщение возникло исключение:" + e.getStackTrace());
        }
    }

    @Override
    public List<Message> findToUserMessages(User user) {
        try {
            List<Message> result = messageDAO.findByToUserOrderByDateWriteDesc(user);
            log.info("Получены исходящие сообщения " + user.toString());
            return result;
        } catch (Exception e) {
            log.error("При попытке получить исходящие сообщения " + user.toString() +
                    "возникло исключение" + e.getStackTrace());
            return null;
        }
    }

    @Override
    public List<Message> findFromUserMessages(User user) {
        try {
            List<Message> result = messageDAO.findByFromUserOrderByDateWriteDesc(user);
            log.info("Получены входящие сообщения " + user.toString());
            return result;
        } catch (Exception e) {
            log.error("При попытке получить входящие сообщения " + user.toString() +
                    "возникло исключение" + e.getStackTrace());
            return null;
        }
    }

    @Override
    public Message getMessageById(Long messageId) {
        try {
            Message result = messageDAO.findMessageById(messageId);
            log.info("Получено сообщение " + result.toString());
            return messageDAO.findMessageById(messageId);
        } catch (Exception e) {
            log.error("При попытке получить сообщение возникло исключение" + e.getStackTrace());
            return null;
        }
    }
}
