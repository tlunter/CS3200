<?xml version="1.0"?>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="cs3200_hw4.*,java.util.*,jga.*" %>
<%@include file="includes/header.jsp" %>
<%
    MovieManager mgr = new MovieManager();

    String action = request.getParameter("action");
    Integer currentId = Utils.parseInt(request.getParameter("current-id"));

    if ("create".equals(action)) {
        Movie newMovie = new Movie();
        newMovie.setId(Utils.parseInt(request.getParameter("id"), null));
        newMovie.setTitle(request.getParameter("title"));
        newMovie.setPosterImage(request.getParameter("poster-image"));
        newMovie.setReleaseDate(request.getParameter("release-date"));
        mgr.createMovie(newMovie);
    } else if ("update".equals(action)) {
        Movie updatedMovie = mgr.readMovie(currentId);
        updatedMovie.setId(Utils.parseInt(request.getParameter("edit-id"), null));
        updatedMovie.setTitle(request.getParameter("edit-title"));
        updatedMovie.setPosterImage(request.getParameter("edit-poster-image"));
        updatedMovie.setReleaseDate(request.getParameter("edit-release-date"));
        mgr.updateMovie(currentId, updatedMovie);
    } else if ("delete".equals(action)) {
        mgr.deleteMovie(currentId);
    }

    List<Movie> movies = mgr.readAllMovies();
%>
<style type="text/css">
td {
    padding: 2px;
}
</style>
<form action="movie.jsp" method="post" class="form-inline">
    <table>
        <tr>
            <th>Id</th><th>Title</th><th>Poster Image</th><th>Release Date</th><th>Controls</th>
        </tr>
        <tr>
            <td>
                <input type="text" class="form-control" name="id" id="input-id" placeholder="Id">
            </td>
            <td>
                <input type="text" class="form-control" name="title" id="input-title" placeholder="Title">
            </td>
            <td>
                <input type="text" class="form-control" name="poster-image" id="input-poster-image" placeholder="Poster Image">
            </td>
            <td>
                <input type="text" class="form-control" name="release-date" id="input-release-date" placeholder="Release Date">
            </td>
            <td>
                <button name="action" value="create" type="submit" class="btn btn-primary">Create</button>
            </td>
        </tr>
<%
    for (Movie movie : movies) {
        if ("edit".equals(action) && movie.getId().equals(currentId)) {
%>
        <tr>
            <td><input type="text" class="form-control" name="edit-id" value="<%= movie.getId() %>"></td>
            <td><input type="text" class="form-control" name="edit-title" value="<%= movie.getTitle() %>"></td>
            <td><input type="text" class="form-control" name="edit-poster-image" value="<%= movie.getPosterImage() %>"></td>
            <td><input type="text" class="form-control" name="edit-release-date" value="<%= movie.getReleaseDate() %>"></td>
            <td>
                <button type="submit" name="action" value="update">Update</button>
                <input type="hidden" name="current-id" value="<%= currentId %>">
                <a href="movie.jsp">Cancel</a>
            </td>
        </tr>
<%
        } else {
%>
        <tr>
            <td><%= movie.getId() %></td>
            <td><%= movie.getTitle() %></td>
            <td><%= movie.getPosterImage() %></td>
            <td><%= movie.getReleaseDate() %></td>
            <td>
                <a href="movie.jsp?action=edit&current-id=<%= movie.getId()%>">Edit</a>
                <a href="movie.jsp?action=delete&current-id=<%= movie.getId()%>">Delete</a>
                <a href="comment.jsp?current-movie-id=<%= movie.getId()%>">Comments</a>
                <a href="cast.jsp?current-movie-id=<%= movie.getId()%>">Cast</a>
            </td>
        </tr>
<%
        }
    }
%>
    </table>
</form>
<%@include file="includes/footer.jsp" %>
