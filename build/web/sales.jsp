<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 2015-12-04
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%@include file="default-stylesheets.jsp"%>
    <style>
        body{
            background-color:white;
            padding-top:1em;
        }

    </style>
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="jdbc.jsp"%>
<%
    try {
        getConnection();
        String curUser = (String) session.getAttribute("curUser");
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        String sql = "SELECT P.name, SUM(productamount) as sales FROM OrderInfo O JOIN Product P ON P.productID = O.productID GROUP BY O.productID  ORDER BY sales DESC LIMIT 3";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        out.print("<br><br><h2>Most frequent sales</h2><table><tr><th>Product Name</th><th>Total sales</th></tr>");
        while(resultSet.next()){
            //language=HTML
            out.print("<tr><td>" + resultSet.getString(1) + "</td><td>" + resultSet.getInt(2) + "</td></tr>");
        }
        out.print("</table><br><h2>Orders</h2>");


        //Get user id
        sql = "SELECT id FROM Person WHERE username=?";
        preparedStatement = con.prepareStatement(sql);





        preparedStatement.setString(1, curUser);
        resultSet = preparedStatement.executeQuery();
        resultSet.next();
        int id = resultSet.getInt(1);

        //Get Orders to iterate through
        sql = "SELECT O.orderid, SUM(cost), Orders.personID FROM OrderInfo O JOIN Product P ON O.productID = P.productID JOIN Orders ON Orders.orderID = O.OrderID GROUP BY (orderID)";
        preparedStatement = con.prepareStatement(sql);

        resultSet = preparedStatement.executeQuery();

        sql = "SELECT name, productamount FROM Product JOIN OrderInfo ON Product.productID = OrderInfo.productID AND orderID=?";
        preparedStatement = con.prepareStatement(sql);
        while (resultSet.next()) {
            preparedStatement.setInt(1, resultSet.getInt(1));
            out.print("Order Id: " + resultSet.getInt(1) + "<br>");
            out.print("Total: " + currFormat.format(resultSet.getDouble(2)) + "<br>");
            out.print("Person Id: " + resultSet.getInt(3) + "<br>");


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
