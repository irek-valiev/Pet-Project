package ru.innopolis.petproject.entities;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.*;

/**
 * Класс для описания объекта "Роль пользователя"
 */

@Entity
@Data
@Table(name = "role", schema = "public")
public class Role implements GrantedAuthority {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Transient
    @OneToMany(mappedBy = "role")
    private Set<User> users;

    @Override
    public String toString() {
        return "Role[" +
                "id='" + id + "'" +
                "name='" + name + "']";
    }

    @Override
    public String getAuthority() {
        return name;
    }
}
