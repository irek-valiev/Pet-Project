package ru.innopolis.petproject.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.innopolis.petproject.entities.Message;
import ru.innopolis.petproject.entities.User;

import java.util.List;

@Repository
public interface MessageDAO extends JpaRepository<Message, Long> {

    List<Message> findByToUserOrderByDateWriteDesc(User receiver);

    List<Message> findByFromUserOrderByDateWriteDesc(User sender);

    Message findMessageById(Long messageId);

    Message saveAndFlush(Message message);
}
