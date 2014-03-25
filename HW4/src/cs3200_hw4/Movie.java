package cs3200_hw4;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class Movie {
    Integer id;
    String title;
    String posterImage;
    Date releaseDate;

    public Movie() {}
    public Movie(Integer id, String title, String posterImage, Date releaseDate) {
        this.id = id;
        this.title = title;
        this.posterImage = posterImage;
        this.releaseDate = releaseDate;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return this.id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return this.title;
    }

    public void setPosterImage(String posterImage) {
        this.posterImage = posterImage;
    }

    public String getPosterImage() {
        return this.posterImage;
    }
    public void setReleaseDate(String releaseDate) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            this.releaseDate = format.parse(releaseDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public Date getReleaseDate() {
        return this.releaseDate;
    }
}
