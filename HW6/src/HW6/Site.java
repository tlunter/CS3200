package HW6;

import javax.persistence.*;
import javax.xml.bind.annotation.*;
import java.util.List;

/**
 * Created by tlunter on 4/4/14.
 */
@Entity
@XmlRootElement
@XmlAccessorType(value= XmlAccessType.FIELD)
@NamedQuery(name="Site.findAllSites", query="SELECT s FROM Site s")
public class Site {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @XmlAttribute
    private Integer id;
    @XmlAttribute
    private String name;
    @XmlAttribute
    private Double latitude;
    @XmlAttribute
    private Double longitude;
    @OneToMany(mappedBy="site")
    @XmlElement(name="tower")
    private List<Tower> towers;

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

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public List<Tower> getTowers() {
        return towers;
    }

    public void setTowers(List<Tower> towers) {
        this.towers = towers;
    }
}
