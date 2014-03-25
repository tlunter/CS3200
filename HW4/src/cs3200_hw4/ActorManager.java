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

public class ActorManager {
    DataSource ds;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet results = null;

    String readAllActors = "SELECT * FROM `actor`";
    String createActor = "INSERT INTO `actor` (`id`, `firstName`, `lastName`,`dateOfBirth`) VALUES (?,?,?,?)";
    String readActor = "SELECT * FROM `actor` WHERE `id` = ?";
    String updateActor = "UPDATE `actor` SET `id` = ?, `firstName` = ?, `lastName` = ?, `dateOfBirth` = ? WHERE `id` = ?";
    String deleteActor = "DELETE FROM `actor` WHERE `id` = ?";

    public ActorManager() {
        try {
            Context jndi = new InitialContext();
            ds = (DataSource)jndi.lookup("java:comp/env/jdbc/cs3200_hw4");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public void deleteActor(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(deleteActor);
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

    public Actor readActor(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readActor);
            statement.setInt(1, id);
            results = statement.executeQuery();
            
            if (results.next()) {
                Actor actor = new Actor();
                actor.setId(results.getInt("id"));
                actor.setFirstName(results.getString("firstName"));
                actor.setLastName(results.getString("lastName"));
                actor.setDateOfBirth(results.getString("dateOfBirth"));
                
                return actor;
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

    public void updateActor(Integer id, Actor actor) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(updateActor);
            statement.setInt(1, actor.getId());
            statement.setString(2, actor.getFirstName());
            statement.setString(3, actor.getLastName());
            statement.setDate(4, new Date(actor.getDateOfBirth().getTime()));
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

    public void createActor(Actor actor) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(createActor);
            statement.setObject(1, actor.getId());
            statement.setString(2, actor.getFirstName());
            statement.setString(3, actor.getLastName());
            statement.setDate(4, new Date(actor.getDateOfBirth().getTime()));
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

    public List<Actor> readAllActors() {
        List<Actor> actors = new ArrayList<Actor>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllActors);
            results = statement.executeQuery();
            while (results.next()) {
                Actor actor = new Actor();
                actor.setId(results.getInt("id"));
                actor.setFirstName(results.getString("firstName"));
                actor.setLastName(results.getString("lastName"));
                actor.setDateOfBirth(results.getString("dateOfBirth"));
                actors.add(actor);
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

        return actors;
    }
}
