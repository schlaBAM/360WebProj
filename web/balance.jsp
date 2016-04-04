<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 10:10 PM
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
<%@include file="jdbc.jsp"%>
<div>
    <h1>Balance</h1>
<%
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    getConnection();
    Double balance = 0.0;
    String sql = "SELECT username, password, balance FROM Person WHERE username=\"" + session.getAttribute("curUser") + "\"";
    Statement statement = con.createStatement();
    try {
        ResultSet resultSet = statement.executeQuery(sql);

        resultSet.next();

        String username = resultSet.getString(1);
        String password = resultSet.getString(2);
        balance = resultSet.getDouble(3);
        session.setAttribute("balance", balance);
    }catch(Exception e){
        out.print(e);
    }

%>
<p>Current Balance: <% out.print(currFormat.format(balance)); %></p>
</div>
<form method="get" action="add-credit.jsp">
    Add credits: <input name="addedBalance" type="number"/>
    <input type="submit" value="submit"/>
</form>

</body>
</html>
