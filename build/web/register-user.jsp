<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 6:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp"%>
<%
    try {
        getConnection();

        int userID, dealerID;

        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT MAX(userID) FROM Person");
        if (resultSet.next()) {
            userID = resultSet.getInt(1) + 1;
        } else {
            userID = 0;
        }

        if (request.getParameter("dealer") != null) {
            resultSet = statement.executeQuery("SELECT MAX(dealerID) FROM Person");
            if (resultSet.next()) {
                dealerID = resultSet.getInt(1) + 1;
            } else {
                dealerID = 0;
            }

        } else {
            dealerID = 0;
        }


        String insertSQL = "INSERT INTO Person (userID,dealerID,name,username,password,address,city,province,postalcode,phonenum,email,balance,sales,numUsers,accesslevel) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";


        PreparedStatement preparedStatement = con.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String city = request.getParameter("city");


        preparedStatement.setInt(1, userID);
        preparedStatement.setInt(2, dealerID);
        preparedStatement.setString(3, name);
        preparedStatement.setString(4, username);
        preparedStatement.setString(5, password);
        preparedStatement.setString(6, address);
        preparedStatement.setString(7, city);
        preparedStatement.setString(8, request.getParameter("province"));
        preparedStatement.setString(9, request.getParameter("postalcode"));
        preparedStatement.setString(10, request.getParameter("phonenumber"));
        preparedStatement.setString(11, request.getParameter("email"));
        preparedStatement.setDouble(12, 100);
        preparedStatement.setDouble(13, 0);
        preparedStatement.setInt(14, 0);
        preparedStatement.setInt(15, 3);

        preparedStatement.executeUpdate();

        session.setAttribute("curUser", username);
        session.setAttribute("curName", name);
        session.setAttribute("clearance", 3);

        con.close();
        response.sendRedirect("index.jsp");

    }catch(Exception e){
        out.print(e);
    }
%>