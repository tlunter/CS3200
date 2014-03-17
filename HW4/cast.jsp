<?xml version="1.0"?>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="cs3200_hw4.*,java.util.*,jga.*" %>
<%@include file="includes/header.jsp" %>
<%
    CastManager castMgr = new CastManager();
    ActorManager actorMgr = new ActorManager();
    MovieManager movieMgr = new MovieManager();

    String action = request.getParameter("action");
    Integer currentId = Utils.parseInt(request.getParameter("current-id"));
    Integer currentMovie = Utils.parseInt(request.getParameter("current-movie-id"), null);
    Integer currentActor = Utils.parseInt(request.getParameter("current-actor-id"), null);

    if ("create".equals(action)) {
        Cast newCast = new Cast();
        newCast.setId(Utils.parseInt(request.getParameter("id"), null));
        newCast.setCharacterName(request.getParameter("character-name"));
        newCast.setActor(Utils.parseInt(request.getParameter("actor-id"), null));
        newCast.setMovie(Utils.parseInt(request.getParameter("movie-id"), null));
        castMgr.createCast(newCast);
    } else if ("update".equals(action)) {
        Cast updatedCast = castMgr.readCast(currentId);
        updatedCast.setId(Utils.parseInt(request.getParameter("edit-id"), null));
        updatedCast.setCharacterName(request.getParameter("edit-character-name"));
        updatedCast.setActor(Utils.parseInt(request.getParameter("edit-actor-id"), null));
        updatedCast.setMovie(Utils.parseInt(request.getParameter("edit-movie-id"), null));
        castMgr.updateCast(currentId, updatedCast);
    } else if ("delete".equals(action)) {
        castMgr.deleteCast(currentId);
    }

    List<Cast> casts;
    String baseFormPath = "cast.jsp?";
    
    if (currentMovie != null) {
        casts = castMgr.readAllCastForMovie(currentMovie);
        baseFormPath += String.format("current-movie-id=%s&", currentMovie);
    } else if (currentActor != null) {
        casts = castMgr.readAllCastForActor(currentActor);
        baseFormPath += String.format("current-actor-id=%s&", currentActor);
    } else {
        casts = castMgr.readAllCast();
    }
    List<Actor> actors = actorMgr.readAllActors();
    List<Movie> movies = movieMgr.readAllMovies();
%>
<style type="text/css">
td {
    padding: 2px;
}
</style>
<form action="<%= baseFormPath %>" method="post" class="form-inline">
    <table>
        <tr>
            <th>Id</th><th>Character Name</th><th>Actor</th><th>Movie</th><th>Controls</th>
        </tr>
        <tr>
            <td>
                <input type="text" class="form-control" name="id" id="input-id" placeholder="Id">
            </td>
            <td>
                <input type="text" class="form-control" name="character-name" id="input-cast" placeholder="Character Name">
            </td>
            <td>
                <select class="form-control" name="actor-id">
<%
    for (Actor actor : actors) {
%>
                    <option value="<%= actor.getId() %>"><%= actor.getFirstName() %> <%= actor.getLastName() %></option>
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
    for (Cast cast : casts) {
        if ("edit".equals(action) && cast.getId().equals(currentId)) {
%>
        <tr>
            <td><input type="text" class="form-control" name="edit-id" value="<%= cast.getId() %>"></td>
            <td><input type="text" class="form-control" name="edit-character-name" value="<%= cast.getCharacterName() %>"></td>
            <td>
                <select class="form-control" name="edit-actor-id">
<%
    for (Actor actor : actors) {
%>
                    <option value="<%= actor.getId() %>"<% if (cast.getActor().equals(actor.getId())) { %> selected<% } %>><%= actor.getFirstName() %> <%= actor.getLastName() %></option>
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
                    <option value="<%= movie.getId() %>"<% if (cast.getMovie().equals(movie.getId())) { %> selected<% } %>><%= movie.getTitle() %></option>
<%
    }
%>
                </select>
            </td>
            <td>
                <button type="submit" name="action" value="update">Update</button>
                <input type="hidden" name="current-id" value="<%= currentId %>">
                <a href="<%= baseFormPath %>">Cancel</a>
            </td>
        </tr>
<%
        } else {
            Actor a = actorMgr.readActor(cast.getActor());
%>
        <tr>
            <td><%= cast.getId() %></td>
            <td><%= cast.getCharacterName() %></td>
            <td><%= a.getFirstName() %> <%= a.getLastName() %></td>
            <td><%= movieMgr.readMovie(cast.getMovie()).getTitle() %></td>
            <td>
                <a href="<%= baseFormPath %>action=edit&current-id=<%= cast.getId()%>">Edit</a>
                <a href="<%= baseFormPath %>action=delete&current-id=<%= cast.getId()%>">Delete</a>
            </td>
        </tr>
<%
        }
    }
%>
    </table>
</form>
<%@include file="includes/footer.jsp" %>
