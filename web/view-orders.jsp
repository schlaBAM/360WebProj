<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 2015-12-02
  Time: 10:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="default-stylesheets.jsp"%>
    <style>
        body{
            background-color:white;
        }
    </style>
</head>
<body>
<%--<%@include file="header.jsp"%>--%>
<%@include file="jdbc.jsp"%>


<%
    try {
        getConnection();
        String curUser = (String) session.getAttribute("curUser");
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        //Get user id
        String sql = "SELECT id FROM Person WHERE username=?";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        preparedStatement.setString(1, curUser);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        int id = resultSet.getInt(1);

        //Get Orders to iterate through
        sql = "SELECT O.orderid, SUM(cost) FROM OrderInfo O JOIN Product P ON O.productID = P.productID JOIN Orders ON Orders.orderID = O.OrderID WHERE personID =? GROUP BY (orderID)";
        preparedStatement = con.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        resultSet = preparedStatement.executeQuery();

        sql = "SELECT name, productamount FROM Product JOIN OrderInfo ON Product.productID = OrderInfo.productID WHERE orderID = ?";
        preparedStatement = con.prepareStatement(sql);
        while (resultSet.next()) {
            out.print("Order Id: " + resultSet.getInt(1) + "<br>");
            out.print("Total: " + currFormat.format(resultSet.getDouble(2)) + "<br>");

            preparedStatement.setInt(1, resultSet.getInt(1));
            ResultSet resultSet1 = preparedStatement.executeQuery();
            while (resultSet1.next()) {
                out.print("Product: " + resultSet1.getString(1) + ", ");
                out.print("Quantity: " + resultSet1.getInt(2) + "<br>");

            }


            out.print("<br>");
        }
    }catch (Exception e){
        out.print(e);
    }

%>

</body>
</html>
