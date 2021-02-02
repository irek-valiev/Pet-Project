package ru.innopolis.petproject.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.File;
import java.util.Date;

/**
 * Класс для описания объекта "Питомец"
 */

@Entity
@Data
@Table(name = "pet", schema = "public")
public class Pet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_user", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_typepet", nullable = false)
    private TypePet typePet;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "sex", nullable = false)
    private String sex;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "birthday", nullable = false)
    private Date birthday;

    @Column(name = "alive", nullable = false)
    private boolean alive;

    @Column(name = "id_father")
    private Long father_id;

    @Column(name = "id_mother")
    private Long mother_id;

    @Column(name = "image")
    private byte[] images;

    public String toString() {
        return "Pet[" +
                "id='" + id + "'" +
                "user='" + user + "']";
    }
}
