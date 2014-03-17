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

public class CommentManager {
    DataSource ds;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet results = null;

    String readAllComments = "SELECT * FROM `comment`";
    String readAllCommentsForUsername = "SELECT * FROM `comment` WHERE `userUsername` = ?";
    String readAllCommentsForMovie = "SELECT * FROM `comment` WHERE `movieId` = ?";
    String createComment = "INSERT INTO `comment` (`id`,`comment`,`date`,`userUsername`,`movieId`) VALUES (?,?,?,?,?)";
    String readComment = "SELECT * FROM `comment` WHERE `id` = ?";
    String updateComment = "UPDATE `comment` SET `id` = ?, `comment` = ?, `date` = ?, `userUsername` = ?, `movieId` = ? WHERE `id` = ?";
    String deleteComment = "DELETE FROM `comment` WHERE `id` = ?";

    public CommentManager() {
        try {
            Context jndi = new InitialContext();
            ds = (DataSource) jndi.lookup("java:comp/env/jdbc/cs3200_hw4");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public void deleteComment(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(deleteComment);
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

    public Comment readComment(Integer id) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readComment);
            statement.setInt(1, id);
            results = statement.executeQuery();

            if (results.next()) {
                Comment comment = new Comment();
                comment.setId(results.getInt("id"));
                comment.setComment(results.getString("comment"));
                comment.setDate(results.getString("date"));
                comment.setUser(results.getString("userUsername"));
                comment.setMovie(results.getInt("movieId"));

                return comment;
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

    public void updateComment(Integer id, Comment comment) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(updateComment);
            statement.setInt(1, comment.getId());
            statement.setString(2, comment.getComment());
            statement.setDate(3, new Date(comment.getDate().getTime()));
            statement.setString(4, comment.getUser());
            statement.setInt(5, comment.getMovie());
            statement.setInt(6, id);
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

    public void createComment(Comment comment) {
        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(createComment);
            statement.setObject(1, comment.getId());
            statement.setString(2, comment.getComment());
            statement.setDate(3, new Date(comment.getDate().getTime()));
            statement.setString(4, comment.getUser());
            statement.setInt(5, comment.getMovie());
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

    public List<Comment> readAllComments() {
        List<Comment> comments = new ArrayList<Comment>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllComments);
            results = statement.executeQuery();
            
            while (results.next()) {
                Comment comment = new Comment();
                comment.setId(results.getInt("id"));
                comment.setComment(results.getString("comment"));
                comment.setDate(results.getString("date"));
                comment.setUser(results.getString("userUsername"));
                comment.setMovie(results.getInt("movieId"));
                comments.add(comment);
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
        
        return comments;
    }

    public List<Comment> readAllCommentsForMovie(Integer movieId) {
        List<Comment> comments = new ArrayList<Comment>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllCommentsForMovie);
            statement.setInt(1, movieId);
            results = statement.executeQuery();
            
            while (results.next()) {
                Comment comment = new Comment();
                comment.setId(results.getInt("id"));
                comment.setComment(results.getString("comment"));
                comment.setDate(results.getString("date"));
                comment.setUser(results.getString("userUsername"));
                comment.setMovie(results.getInt("movieId"));
                comments.add(comment);
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
        
        return comments;
    }

    public List<Comment> readAllCommentsForUsername(String userUsername) {
        List<Comment> comments = new ArrayList<Comment>();

        try {
            connection = ds.getConnection();
            statement = connection.prepareStatement(readAllCommentsForUsername);
            statement.setString(1, userUsername);
            results = statement.executeQuery();
            
            while (results.next()) {
                Comment comment = new Comment();
                comment.setId(results.getInt("id"));
                comment.setComment(results.getString("comment"));
                comment.setDate(results.getString("date"));
                comment.setUser(results.getString("userUsername"));
                comment.setMovie(results.getInt("movieId"));
                comments.add(comment);
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
        
        return comments;
    }
}
