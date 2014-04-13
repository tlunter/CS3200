package HW6;

import javax.persistence.*;
import javax.xml.bind.annotation.*;
import java.util.List;

/**
 * Created by tlunter on 4/4/14.
 */
@Entity
@XmlRootElement
@XmlAccessorType(value=XmlAccessType.FIELD)
public class Tower {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @XmlAttribute
    private Integer id;
    @XmlAttribute
    private String name;
    @XmlAttribute
    private Double height;
    @XmlAttribute
    private Integer sides;
    @ManyToOne
    @JoinColumn(name="siteId")
    @XmlTransient
    private Site site;
    @OneToMany(mappedBy="tower", cascade=CascadeType.ALL, orphanRemoval=true)
    @XmlElement(name="equipment")
    private List<Equipment> equipments;

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

    public Double getHeight() {
        return height;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public Integer getSides() {
        return sides;
    }

    public void setSides(Integer sides) {
        this.sides = sides;
    }

    public Site getSite() {
        return site;
    }

    public void setSite(Site site) {
        this.site = site;
    }

    public List<Equipment> getEquipments() {
        return equipments;
    }

    public void setEquipments(List<Equipment> equipments) {
        this.equipments = equipments;
    }
}
