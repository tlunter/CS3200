package cs3200_hw4;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class Comment {
    Integer id;
    String comment;
    Date date;
    String userUsername;
    Integer movieId;

    public Comment() {}
    public Comment(Integer id, String comment, Date date, String userUsername, Integer movieId) {
        this.id = id;
        this.comment = comment;
        this.date = date;
        this.userUsername = userUsername;
        this.movieId = movieId;
    }
    public Comment(Integer id, String comment, Date date, User user, Movie movie) {
        this.id = id;
        this.comment = comment;
        this.date = date;
        this.userUsername = user.getUsername();
        this.movieId = movie.getId();
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return this.id;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getComment() {
        return this.comment;
    }

    public void setDate(String date) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            this.date = format.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public Date getDate() {
        return this.date;
    }

    public void setUser(User user) {
        this.userUsername = user.getUsername();
    }

    public void setUser(String userUsername) {
        this.userUsername = userUsername;
    }

    public String getUser() {
        return this.userUsername;
    }

    public void setMovie(Movie movie) {
        this.movieId = movie.getId();
    }

    public void setMovie(Integer movieId) {
        this.movieId = movieId;
    }

    public Integer getMovie() {
        return this.movieId;
    }
}
