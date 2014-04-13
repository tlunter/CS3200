package HW6;

import javax.persistence.NamedQuery;
import javax.xml.bind.annotation.*;
import java.util.List;

/**
 * Created by tlunter on 4/4/14.
 */
@XmlRootElement
@XmlAccessorType(value=XmlAccessType.FIELD)
public class Sites {
    @XmlElement(name="site")
    private List<Site> sites;

    public Sites() {}

    public Sites(List<Site> sites) {
        this.sites = sites;
    }

    public List<Site> getSites() {
        return sites;
    }

    public void setSites(List<Site> sites) {
        this.sites = sites;
    }
}
