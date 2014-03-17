package cs3200_hw4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MovieManager {
    DataSource ds;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet results = null;

    String readAllMovies = "SELECT * FROM `movie`";
    String createMovie = "INSERT INTO `movie` (`id`,`title`,`posterImage`,`releaseDate`) VALUES (?,?,?,?)";
    String readMovie = "SELECT * FROM `movie` WHERE `id` = ?";
    String updateMovie = "UPDATE `movie` WHERE `id` = ?, `title` = ?, `posterImage` = ?, releaseDate = ? WHERE `id` = ?";
    String deleteMovie = "DELETE FROM `movie` WHERE `id` = ?";

    public MovieManager() {
        try {
            Context jndi = new InitialContext();
            ds = (DataSource) jndi.lookup("java:comp/env/jdbc/cs3200_hw4");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public void deleteMovie(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(deleteMovie);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Movie readMovie(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readMovie);
            statement.setInt(1, id);
            results = statement.executeQuery();
            if (results.next()) {
                Movie movie = new Movie();
                movie.setId(results.getInt("id"));
                movie.setTitle(results.getString("title"));
                movie.setPosterImage(results.getString("posterImage"));
                movie.setReleaseDate(results.getString("releaseDate"));
                return movie;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public void updateMovie(Integer id, Movie movie) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(updateMovie);
            statement.setInt(1, movie.getId());
            statement.setString(2, movie.getTitle());
            statement.setString(3, movie.getPosterImage());
            statement.setDate(4, new Date(movie.getReleaseDate().getTime()));
            statement.setInt(5, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void createMovie(Movie movie) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(createMovie);
            statement.setObject(1, movie.getId());
            statement.setString(2, movie.getTitle());
            statement.setString(3, movie.getPosterImage());
            statement.setDate(4, new Date(movie.getReleaseDate().getTime()));
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Movie> readAllMovies() {
        List<Movie> movies = new ArrayList<Movie>();
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllMovies);
            results = statement.executeQuery();
            while (results.next()) {
                Movie movie = new Movie();
                movie.setId(results.getInt("id"));
                movie.setTitle(results.getString("title"));
                movie.setPosterImage(results.getString("posterImage"));
                movie.setReleaseDate(results.getString("releaseDate"));
                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return movies;
    }
}
