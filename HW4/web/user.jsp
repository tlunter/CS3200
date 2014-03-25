<?xml version="1.0"?>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="cs3200_hw4.*,java.util.*" %>
<%@include file="includes/header.jsp" %>
<%
    UserManager mgr = new UserManager();

    String action = request.getParameter("action");
    String currentUsername = request.getParameter("current-username");

    if ("create".equals(action)) {
        User newUser = new User();
        newUser.setUsername(request.getParameter("username"));
        newUser.setPassword(request.getParameter("password"));
        newUser.setFirstName(request.getParameter("first-name"));
        newUser.setLastName(request.getParameter("last-name"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setDateOfBirth(request.getParameter("date-of-birth"));
        mgr.createUser(newUser);
    } else if ("update".equals(action)) {
        User updatedUser = mgr.readUser(currentUsername);
        updatedUser.setUsername(request.getParameter("edit-username"));
        updatedUser.setPassword(request.getParameter("edit-password"));
        updatedUser.setFirstName(request.getParameter("edit-first-name"));
        updatedUser.setLastName(request.getParameter("edit-last-name"));
        updatedUser.setEmail(request.getParameter("edit-email"));
        updatedUser.setDateOfBirth(request.getParameter("edit-date-of-birth"));
        mgr.updateUser(currentUsername, updatedUser);
    } else if ("delete".equals(action)) {
        mgr.deleteUser(currentUsername);
    }

    List<User> users = mgr.readAllUsers();
%>
<style type="text/css">
td {
    padding: 2px;
}
</style>
<form action="user.jsp" method="post" class="form-inline">
    <table>
        <tr>
            <th>Username</th><th>Password</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Date of Birth</th><th>Controls</th>
        </tr>
        <tr>
            <td>
                <input type="text" class="form-control" name="username" id="input-username" placeholder="Username">
            </td>
            <td>
                <input type="text" class="form-control" name="password" id="input-password" placeholder="Password">
            </td>
            <td>
                <input type="text" class="form-control" name="first-name" id="input-first-name" placeholder="First Name">
            </td>
            <td>
                <input type="text" class="form-control" name="last-name" id="input-last-name" placeholder="Last Name">
            </td>
            <td>
                <input type="text" class="form-control" name="email" id="input-email" placeholder="Email">
            </td>
            <td>
                <input type="text" class="form-control" name="date-of-birth" id="input-date-of-birth" placeholder="Date of Birth">
            </td>
            <td>
                <button name="action" value="create" type="submit" class="btn btn-primary">Create</button>
            </td>
        </tr>
<%
    for (User user : users) {
        if ("edit".equals(action) && user.getUsername().equals(currentUsername)) {
%>
        <tr>
            <td><input type="text" class="form-control" name="edit-username" value="<%= user.getUsername() %>"></td>
            <td><input type="text" class="form-control" name="edit-password" value="<%= user.getPassword() %>"></td>
            <td><input type="text" class="form-control" name="edit-first-name" value="<%= user.getFirstName() %>"></td>
            <td><input type="text" class="form-control" name="edit-last-name" value="<%= user.getLastName() %>"></td>
            <td><input type="text" class="form-control" name="edit-email" value="<%= user.getEmail() %>"></td>
            <td><input type="text" class="form-control" name="edit-date-of-birth" value="<%= user.getDateOfBirth() %>"></td>
            <td>
                <button type="submit" name="action" value="update">Update</button>
                <input type="hidden" name="current-username" value="<%= currentUsername %>">
                <a href="user.jsp">Cancel</a>
            </td>
        </tr>
<%
        } else {
%>
        <tr>
            <td><%= user.getUsername() %></td>
            <td><%= user.getPassword() %></td>
            <td><%= user.getFirstName() %></td>
            <td><%= user.getLastName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getDateOfBirth() %></td>
            <td>
                <a href="user.jsp?action=edit&current-username=<%= user.getUsername()%>">Edit</a>
                <a href="user.jsp?action=delete&current-username=<%= user.getUsername()%>">Delete</a>
                <a href="comment.jsp?current-username=<%= user.getUsername()%>">Comments</a>
            </td>
        </tr>
<%
        }
    }
%>
    </table>
</form>
<%@include file="includes/footer.jsp" %>
