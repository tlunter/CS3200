package cs3200_hw5;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by tlunter on 3/30/14.
 */
@Entity
public class Casting implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String characterName;
    @Temporal(TemporalType.DATE)
    private Date dateActedInMovie;
    @ManyToOne
    private Movie movieActedIn;
    @ManyToOne
    private Actor actorInMovie;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCharacterName() {
        return characterName;
    }

    public void setCharacterName(String character) {
        this.characterName = character;
    }

    public Date getDateActedInMovie() {
        return dateActedInMovie;
    }

    public void setDateActedInMovie(Date dateActedInMovie) {
        this.dateActedInMovie = dateActedInMovie;
    }

    public Movie getMovieActedIn() {
        return movieActedIn;
    }

    public void setMovieActedIn(Movie movieActedIn) {
        this.movieActedIn = movieActedIn;
    }

    public Actor getActorInMovie() {
        return actorInMovie;
    }

    public void setActorInMovie(Actor actorInMovie) {
        this.actorInMovie = actorInMovie;
    }
}
