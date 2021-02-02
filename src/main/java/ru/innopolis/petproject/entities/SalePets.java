package ru.innopolis.petproject.entities;

import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Класс для описания объекта "Продажа Питомца"
 */
@Entity
@Data
@Table(name = "sale_pets", schema = "public")
public class SalePets {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_pet", nullable = false)
    private Pet pet;

    @ManyToOne
    @JoinColumn(name = "old_owner", nullable = false)
    private User oldOwner;

    @Column(name = "price")
    private BigDecimal price;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date_sale")
    private Date dateSale;

    @Override
    public String toString() {
        return "SalePets[" +
                "id='" + id + "'" +
                "Pet='" + pet +
                "oldOwner='" + oldOwner +
                "price='" + price +
                "dateSale='" + dateSale + "']";
    }
}
