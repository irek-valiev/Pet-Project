package ru.innopolis.petproject.entities;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

/**
 * Класс для описания типа питомца
 */

@Entity
@Data
@Table(name = "type_pet", schema = "public")
public class TypePet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "type_name", updatable = false)
    private String typeName;

    @OneToMany(mappedBy = "typePet")
    private List<Pet> pet;

    public String toString() {
        return "Pet[" +
                "id='" + id + "'" +
                "typeName='" + typeName + "']";
    }
}
