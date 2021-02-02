package ru.innopolis.petproject.entities;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

/**
 * Класс для описания объекта "Случка Питомца"
 */
@Entity
@Data
@Table(name = "mating_pets", schema = "public")
public class MatingPets {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "from_pet", nullable = false)
    private Pet fromPet;

    @ManyToOne
    @JoinColumn(name = "to_pet", nullable = false)
    private Pet toPet;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date_mating", updatable = false)
    private Date dateMating;

    @Column(name = "done")
    private Boolean isDone;

    @Override
    public String toString() {
        return "MatingPets[" +
                "id='" + id + "'" +
                "fromPet='" + fromPet +
                "toPet='" + toPet +
                "dateMating='" + dateMating +
                "isDone='" + isDone + "']";
    }
}
