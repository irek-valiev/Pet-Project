package ru.innopolis.petproject.entities;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

/**
 * Класс для описания объекта "Сообщение"
 */

@Entity
@Data
@Table(name = "message", schema = "public")
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "from_user", nullable = false)
    protected User fromUser;

    @ManyToOne
    @JoinColumn(name = "to_user", nullable = false)
    protected User toUser;

    @Column(name = "message_body", nullable = false)
    private String messageBody;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date", updatable = false)
    private Date dateWrite;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "read_date")
    private Date dateRead;

    @Override
    public String toString() {
        return "Message[" +
                "id='" + id + "'" +
                "body='" + messageBody + "']";
    }
}
