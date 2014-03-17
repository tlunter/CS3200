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

public class UserManager {
    DataSource ds;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet results = null;

    String readAllUsers = "SELECT * FROM `user`";
    String createUser = "INSERT INTO `user` (`username`,`password`,`firstName`,`lastName`,`email`,`dateOfBirth`) VALUES (?,?,?,?,?,?)";
    String readUser = "SELECT * FROM `user` WHERE `username` = ?";
    String updateUser = "UPDATE `user` SET `username` = ?, `password` = ?, `firstName` = ?, `lastName` = ?, `email` = ?, `dateOfBirth` = ? WHERE `username` = ?";
    String deleteUser = "DELETE FROM `user` WHERE `username` = ?";

    public UserManager() {
        try {
            Context jndi = new InitialContext();
            ds = (DataSource) jndi.lookup("java:comp/env/jdbc/cs3200_hw4");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(String username) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(deleteUser);
            statement.setString(1, username);
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

    public User readUser(String username) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readUser);
            statement.setString(1, username);
            results = statement.executeQuery();

            if (results.next()) {
                User user = new User();
                user.setUsername(results.getString("username"));
                user.setPassword(results.getString("password"));
                user.setFirstName(results.getString("firstName"));
                user.setLastName(results.getString("lastName"));
                user.setEmail(results.getString("email"));
                user.setDateOfBirth(results.getString("dateOfBirth"));

                return user;
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

    public void updateUser(String username, User user) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(updateUser);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getFirstName());
            statement.setString(4, user.getLastName());
            statement.setString(5, user.getEmail());
            statement.setDate(6, new Date(user.getDateOfBirth().getTime()));
            statement.setString(7, username);
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

    public void createUser(User user) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(createUser);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getFirstName());
            statement.setString(4, user.getLastName());
            statement.setString(5, user.getEmail());
            statement.setDate(6, new Date(user.getDateOfBirth().getTime()));
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

    public List<User> readAllUsers() {
        List<User> users = new ArrayList<User>();
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllUsers);
            results = statement.executeQuery();
            while (results.next()) {
                User user = new User();
                user.setUsername(results.getString("username"));
                user.setPassword(results.getString("password"));
                user.setFirstName(results.getString("firstName"));
                user.setLastName(results.getString("lastName"));
                user.setEmail(results.getString("email"));
                user.setDateOfBirth(results.getString("dateOfBirth"));
                users.add(user);
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
        return users;
    }
}

