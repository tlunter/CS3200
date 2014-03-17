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

public class CastManager {
    DataSource ds;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet results = null;

    String readAllCast = "SELECT * FROM `cast`";
    String readAllCastForActor = "SELECT * FROM `cast` WHERE `actorId` = ?";
    String readAllCastForMovie = "SELECT * FROM `cast` WHERE `movieId` = ?";
    String createCast = "INSERT INTO `cast` (`id`,`characterName`,`actorId`,`movieId`) VALUES (?,?,?,?)";
    String readCast = "SELECT * FROM `cast` WHERE `id` = ?";
    String updateCast = "UPDATE `cast` SET `id` = ?, `characterName` = ?, `actorId` = ?, `movieId` = ? WHERE `id` = ?";
    String deleteCast = "DELETE FROM `cast` WHERE `id` = ?";

    public CastManager() {
        try {
            Context jndi = new InitialContext();
            ds = (DataSource) jndi.lookup("java:comp/env/jdbc/cs3200_hw4");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public void deleteCast(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(deleteCast);
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

    public Cast readCast(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readCast);
            statement.setInt(1, id);
            results = statement.executeQuery();

            if (results.next()) {
                Cast cast = new Cast();
                cast.setId(results.getInt("id"));
                cast.setCharacterName(results.getString("characterName"));
                cast.setActor(results.getInt("actorId"));
                cast.setMovie(results.getInt("movieId"));

                return cast;
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

    public void updateCast(Integer id, Cast cast) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(updateCast);
            statement.setInt(1, cast.getId());
            statement.setString(2, cast.getCharacterName());
            statement.setInt(3, cast.getActor());
            statement.setInt(4, cast.getMovie());
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

    public void createCast(Cast cast) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(createCast);
            statement.setObject(1, cast.getId());
            statement.setString(2, cast.getCharacterName());
            statement.setInt(3, cast.getActor());
            statement.setInt(4, cast.getMovie());
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

    public List<Cast> readAllCast() {
        List<Cast> casts = new ArrayList<Cast>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllCast);
            results = statement.executeQuery();
            
            while (results.next()) {
                Cast cast = new Cast();
                cast.setId(results.getInt("id"));
                cast.setCharacterName(results.getString("characterName"));
                cast.setActor(results.getInt("actorId"));
                cast.setMovie(results.getInt("movieId"));
                casts.add(cast);
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
        
        return casts;
    }

    public List<Cast> readAllCastForActor(Integer actorId) {
        List<Cast> casts = new ArrayList<Cast>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllCastForActor);
            statement.setInt(1, actorId);
            results = statement.executeQuery();
            
            while (results.next()) {
                Cast cast = new Cast();
                cast.setId(results.getInt("id"));
                cast.setCharacterName(results.getString("characterName"));
                cast.setActor(results.getInt("actorId"));
                cast.setMovie(results.getInt("movieId"));
                casts.add(cast);
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
        
        return casts;
    }

    public List<Cast> readAllCastForMovie(Integer movieId) {
        List<Cast> casts = new ArrayList<Cast>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllCastForMovie);
            statement.setInt(1, movieId);
            results = statement.executeQuery();
            
            while (results.next()) {
                Cast cast = new Cast();
                cast.setId(results.getInt("id"));
                cast.setCharacterName(results.getString("characterName"));
                cast.setActor(results.getInt("actorId"));
                cast.setMovie(results.getInt("movieId"));
                casts.add(cast);
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
        
        return casts;
    }
}
