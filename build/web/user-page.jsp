<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 9:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="default-stylesheets.jsp" %>
    <style>
        body {
            background-color: white;
        }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="jdbc.jsp" %>
<div>
    <h2>User Page</h2>
    <%

        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        getConnection();
        String sql = "SELECT * FROM Person WHERE username=\"" + session.getAttribute("curUser") + "\"";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        resultSet.next();
        String name = resultSet.getString(4);
        String address = resultSet.getString(7);
        String phonenum = resultSet.getString(11);
        String email = resultSet.getString(12);
        Double balance = resultSet.getDouble(13);


        con.close();
    %>

    <p>Name: <% out.print("<input value='" + name + "'/>"); %></p>
    <p>Address: <% out.print("<input value='" + address + "'/>"); %></p>
    <p>Phone Number: <% out.print("<input value='" + phonenum + "'/>"); %></p>
    <p>Email: <% out.print("<input value='" + email + "'/>"); %></p>
    <p>Balance: <% out.print(currFormat.format(balance)); %></p>
    <a href="balance.jsp">Add more credit</a>
    <a href="view-orders.jsp">Order History</a>
</div>
</body>
</html>
