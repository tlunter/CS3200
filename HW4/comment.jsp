<?xml version="1.0"?>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="cs3200_hw4.*,java.util.*,jga.*" %>
<%@include file="includes/header.jsp" %>
<%
    CommentManager commentMgr = new CommentManager();
    UserManager userMgr = new UserManager();
    MovieManager movieMgr = new MovieManager();

    String action = request.getParameter("action");
    Integer currentId = Utils.parseInt(request.getParameter("current-id"));
    
    String currentUsername = request.getParameter("current-username");
    Integer currentMovie = Utils.parseInt(request.getParameter("current-movie-id"), null);

    if ("create".equals(action)) {
        Comment newComment = new Comment();
        newComment.setId(Utils.parseInt(request.getParameter("id"), null));
        newComment.setComment(request.getParameter("comment"));
        newComment.setDate(request.getParameter("date"));
        newComment.setUser(request.getParameter("user-username"));
        newComment.setMovie(Utils.parseInt(request.getParameter("movie-id"), null));
        commentMgr.createComment(newComment);
    } else if ("update".equals(action)) {
        Comment updatedComment = commentMgr.readComment(currentId);
        updatedComment.setId(Utils.parseInt(request.getParameter("edit-id"), null));
        updatedComment.setComment(request.getParameter("edit-comment"));
        updatedComment.setDate(request.getParameter("edit-date"));
        updatedComment.setUser(request.getParameter("edit-user-username"));
        updatedComment.setMovie(Utils.parseInt(request.getParameter("edit-movie-id"), null));
        commentMgr.updateComment(currentId, updatedComment);
    } else if ("delete".equals(action)) {
        commentMgr.deleteComment(currentId);
    }

    List<Comment> comments;
    String baseFormPath = "comment.jsp?";

    if (currentUsername != null) {
        comments = commentMgr.readAllCommentsForUsername(currentUsername);
        baseFormPath += String.format("current-username=%s&", currentUsername);
    } else if (currentMovie != null) {
        comments = commentMgr.readAllCommentsForMovie(currentMovie);
        baseFormPath += String.format("current-movie-id=%s&", currentMovie);
    } else {
        comments = commentMgr.readAllComments();
    }
    List<User> users = userMgr.readAllUsers();
    List<Movie> movies = movieMgr.readAllMovies();
%>
<style type="text/css">
td {
    padding: 2px;
}
</style>
<form action="<%= baseFormPath%>" method="post" class="form-inline">
    <table>
        <tr>
            <th>Id</th><th>Comment</th><th>Date</th><th>User</th><th>Movie</th><th>Controls</th>
        </tr>
        <tr>
            <td>
                <input type="text" class="form-control" name="id" id="input-id" placeholder="Id">
            </td>
            <td>
                <input type="text" class="form-control" name="comment" id="input-comment" placeholder="Comment">
            </td>
            <td>
                <input type="text" class="form-control" name="date" id="input-date" placeholder="Date">
            </td>
            <td>
                <select class="form-control" name="user-username">
<%
    for (User user : users) {
%>
                    <option><%= user.getUsername() %></option>
<%
    }
%>
                </select>
            </td>
            <td>
                <select class="form-control" name="movie-id">
<%
    for (Movie movie : movies) {
%>
<option value="<%= movie.getId() %>"><%= movie.getTitle() %></option>
<%
    }
%>
                </select>
            </td>
            <td>
                <button name="action" value="create" type="submit" class="btn btn-primary">Create</button>
            </td>
        </tr>
<%
    for (Comment comment : comments) {
        if ("edit".equals(action) && comment.getId().equals(currentId)) {
%>
        <tr>
            <td><input type="text" class="form-control" name="edit-id" value="<%= comment.getId() %>"></td>
            <td><input type="text" class="form-control" name="edit-comment" value="<%= comment.getComment() %>"></td>
            <td><input type="text" class="form-control" name="edit-date" value="<%= comment.getDate() %>"></td>
            <td>
                <select class="form-control" name="edit-user-username">
<%
    for (User user : users) {
%>
                    <option<% if (comment.getUser().equals(user.getUsername())) { %> selected<% } %>><%= user.getUsername() %></option>
<%
    }
%>
                </select>
            </td>
            <td>
                <select class="form-control" name="edit-movie-id">
<%
    for (Movie movie : movies) {
%>
                    <option value="<%= movie.getId() %>"<% if (comment.getMovie().equals(movie.getId())) { %> selected<% } %>><%= movie.getTitle() %></option>
<%
    }
%>
                </select>
            </td>
            <td>
                <button type="submit" name="action" value="update">Update</button>
                <input type="hidden" name="current-id" value="<%= currentId %>">
                <a href="<%= baseFormPath%>">Cancel</a>
            </td>
        </tr>
<%
        } else {
%>
        <tr>
            <td><%= comment.getId() %></td>
            <td><%= comment.getComment() %></td>
            <td><%= comment.getDate() %></td>
            <td><%= comment.getUser() %></td>
            <td><%= movieMgr.readMovie(comment.getMovie()).getTitle() %></td>
            <td>
                <a href="<%= baseFormPath%>action=edit&current-id=<%= comment.getId()%>">Edit</a>
                <a href="<%= baseFormPath%>action=delete&current-id=<%= comment.getId()%>">Delete</a>
            </td>
        </tr>
<%
        }
    }
%>
    </table>
</form>
<%@include file="includes/footer.jsp" %>
