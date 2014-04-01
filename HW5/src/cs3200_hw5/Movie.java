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
        @NamedQuery(name="Movie.getAllMovies", query="SELECT m FROM Movie m"),
        @NamedQuery(name="Movie.getReviewsForMovie", query="SELECT r FROM Review r WHERE r.movieReviewed = :movieReviewed"),
        @NamedQuery(name="Movie.getCastingForMovie", query="SELECT c FROM Casting c WHERE c.movieActedIn = :movieActedIn")
})
public class Movie implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String title;
    private String posterImage;
    @Temporal(TemporalType.DATE)
    private Date releaseDate;
    @OneToMany(mappedBy = "movieReviewed")
    private List<Review> reviews;
    @OneToMany(mappedBy = "movieActedIn")
    private List<Casting> casting;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPosterImage() {
        return posterImage;
    }

    public void setPosterImage(String posterImage) {
        this.posterImage = posterImage;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public List<Casting> getCasting() {
        return casting;
    }

    public void setCasting(List<Casting> casting) {
        this.casting = casting;
    }
}
