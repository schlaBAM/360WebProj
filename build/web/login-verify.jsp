<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 11:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="jdbc.jsp"%>
<%@include file="header.jsp"%>

<%
    getConnection();

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String SQL = "SELECT username, password, name, accesslevel FROM Person WHERE username=? AND password=?";
    PreparedStatement preparedStatement = con.prepareStatement(SQL);
    preparedStatement.setString(1, username);
    preparedStatement.setString(2, password);
    try {
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            if (resultSet.getString(1).equals(username) && resultSet.getString(2).equals(password)) {
                session.setAttribute("curUser", username);
                session.setAttribute("curName", resultSet.getString(3));
                session.setAttribute("clearance", resultSet.getInt(4));
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("login.jsp?Failed=true");
                out.println(username + ": " + resultSet.getString(1) + ", " + password + ": " + resultSet.getString(2));
                out.print(preparedStatement.toString());
            }
        } else {
            response.sendRedirect("login.jsp?Failed=true");
            out.println(username + " " + password);
            out.print(preparedStatement.toString());
        }
    }catch (Exception e){
        out.print(e);
    }



%>
