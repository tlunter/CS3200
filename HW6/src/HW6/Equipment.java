package HW6;

import javax.persistence.*;
import javax.xml.bind.annotation.*;

/**
 * Created by tlunter on 4/4/14.
 */
@Entity
@XmlRootElement
@XmlAccessorType(value=XmlAccessType.FIELD)
public class Equipment {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @XmlAttribute
    private Integer id;
    @XmlAttribute
    private String name;
    @XmlAttribute
    private String brand;
    @XmlAttribute
    private String description;
    @XmlAttribute
    private Double price;
    @ManyToOne
    @JoinColumn(name="towerId")
    @XmlTransient
    private Tower tower;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Tower getTower() {
        return tower;
    }

    public void setTower(Tower tower) {
        this.tower = tower;
    }
}
