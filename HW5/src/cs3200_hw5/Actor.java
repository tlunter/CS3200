package cs3200_hw5;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by tlunter on 3/28/14.
 */
@Entity
@NamedQueries({
    @NamedQuery(name="Actor.findAll", query="SELECT a FROM Actor a"),
    @NamedQuery(name="Actor.getCastingForActor", query="SELECT c FROM Casting c WHERE c.actorInMovie = :actorInMovie"),
    @NamedQuery(name="Actor.getMoviesForActor", query="SELECT m FROM Casting c JOIN c.movieActedIn m WHERE c.actorInMovie = :actorInMovie")
})
public class Actor implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String firstName;
    private String lastName;
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;
    @OneToMany(mappedBy = "actorInMovie")
    private List<Casting> moviesIn;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public List<Casting> getMoviesIn() {
        return moviesIn;
    }

    public void setMoviesIn(List<Casting> moviesIn) {
        this.moviesIn = moviesIn;
    }
}
