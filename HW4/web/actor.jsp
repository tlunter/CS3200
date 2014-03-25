<?xml version="1.0"?>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="cs3200_hw4.*,java.util.*,jga.*" %>
<%@include file="includes/header.jsp" %>
<%
    ActorManager mgr = new ActorManager();

    String action = request.getParameter("action");
    Integer currentId = Utils.parseInt(request.getParameter("current-id"));

    if ("create".equals(action)) {
        Actor newActor = new Actor();
        newActor.setId(Utils.parseInt(request.getParameter("id"), null));
        newActor.setFirstName(request.getParameter("first-name"));
        newActor.setLastName(request.getParameter("last-name"));
        newActor.setDateOfBirth(request.getParameter("date-of-birth"));
        mgr.createActor(newActor);
    } else if ("update".equals(action)) {
        Actor updatedActor = mgr.readActor(currentId);
        updatedActor.setId(Utils.parseInt(request.getParameter("edit-id"), null));
        updatedActor.setFirstName(request.getParameter("edit-first-name"));
        updatedActor.setLastName(request.getParameter("edit-last-name"));
        updatedActor.setDateOfBirth(request.getParameter("edit-date-of-birth"));
        mgr.updateActor(currentId, updatedActor);
    } else if ("delete".equals(action)) {
        mgr.deleteActor(currentId);
    }

    List<Actor> actors = mgr.readAllActors();
%>
<style type="text/css">
td {
    padding: 2px;
}
</style>
<form action="actor.jsp" method="post" class="form-inline">
    <table>
        <tr>
            <th>Id</th><th>First Name</th><th>Last Name</th><th>Date of Birth</th><th>Controls</th>
        </tr>
        <tr>
            <td>
                <input type="text" class="form-control" name="id" id="input-id" placeholder="Id">
            </td>
            <td>
                <input type="text" class="form-control" name="first-name" id="input-first-name" placeholder="FirstName">
            </td>
            <td>
                <input type="text" class="form-control" name="last-name" id="input-last-name" placeholder="Poster Image">
            </td>
            <td>
                <input type="text" class="form-control" name="date-of-birth" id="input-date-of-birth" placeholder="Release Date">
            </td>
            <td>
                <button name="action" value="create" type="submit" class="btn btn-primary">Create</button>
            </td>
        </tr>
<%
    for (Actor actor : actors) {
        if ("edit".equals(action) && actor.getId().equals(currentId)) {
%>
        <tr>
            <td><input type="text" class="form-control" name="edit-id" value="<%= actor.getId() %>"></td>
            <td><input type="text" class="form-control" name="edit-first-name" value="<%= actor.getFirstName() %>"></td>
            <td><input type="text" class="form-control" name="edit-last-name" value="<%= actor.getLastName() %>"></td>
            <td><input type="text" class="form-control" name="edit-date-of-birth" value="<%= actor.getDateOfBirth() %>"></td>
            <td>
                <button type="submit" name="action" value="update">Update</button>
                <input type="hidden" name="current-id" value="<%= currentId %>">
                <a href="actor.jsp">Cancel</a>
            </td>
        </tr>
<%
        } else {
%>
        <tr>
            <td><%= actor.getId() %></td>
            <td><%= actor.getFirstName() %></td>
            <td><%= actor.getLastName() %></td>
            <td><%= actor.getDateOfBirth() %></td>
            <td>
                <a href="actor.jsp?action=edit&current-id=<%= actor.getId()%>">Edit</a>
                <a href="actor.jsp?action=delete&current-id=<%= actor.getId()%>">Delete</a>
                <a href="cast.jsp?current-actor-id=<%= actor.getId()%>">Cast</a>
            </td>
        </tr>
<%
        }
    }
%>
    </table>
</form>
<%@include file="includes/footer.jsp" %>
