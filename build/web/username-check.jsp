<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 4:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp"%>
<%
    getConnection();
    String username = request.getParameter("username");

    //Check if username is taken
    String userCheckSQL = "SELECT username FROM Person WHERE username=?";

    PreparedStatement preparedStatement = con.prepareStatement(userCheckSQL);
    preparedStatement.setString(1, username);
    ResultSet resultSet = preparedStatement.executeQuery();

    if(!resultSet.next()){
        session.setAttribute("username", username);
        response.sendRedirect("register-user-info.jsp");

    }else{
        out.print("User already exists");
    }





    con.close();
%>