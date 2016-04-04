<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp"%>
<%

    getConnection();
    String username = session.getAttribute("curUser").toString();
    String balanceSQL = "SELECT balance FROM Person WHERE username='" + username + "'";
    out.println(balanceSQL);
    Statement statement = con.createStatement();
    try {
        ResultSet resultSet = statement.executeQuery(balanceSQL);
        resultSet.next();


        double b1 = Double.valueOf(request.getParameter("addedBalance"));
        double b2 = resultSet.getDouble(1);
        Double newBalance = b1 + b2;
        out.print(newBalance);

        statement.executeUpdate("UPDATE Person SET balance=" + newBalance + " WHERE username='" + username + "'");
        response.sendRedirect("user-page.jsp");
    }catch (Exception e){
        out.print(e);
    }
%>