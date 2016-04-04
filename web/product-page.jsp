<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/3/2015
  Time: 6:27 PM
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
        #details{
            float:right;
            margin-right: 30%;
            margin-top:2em;
        }
        img{
            width:35%;
        }

    </style>
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="jdbc.jsp"%>
<%
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    int id = Integer.valueOf(request.getParameter("id"));
    String sql = "SELECT * FROM Product WHERE productID='" + id + "'";
    String name = null;
    int amount = 0;
    double price = 0;
    String category = null;
    String schedule = null;
    try{
        getConnection();
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        name = resultSet.getString(2);
        amount = resultSet.getInt(3);
        price = resultSet.getDouble(4);
        category = resultSet.getString(5);
        schedule = resultSet.getString(6);

    }catch (Exception e){
        out.print(e);
    }
    if(category.equals("Cocaine")){
        out.print("<img src='images/cocaine.jpg'/>");
    }else if(category.equals("Weed")){
        out.print("<img src='images/weed.jpg'/>");
    }else if(category.equals("Hallucinogens"))
        out.print("<img src='images/hallucinogens.png'/>");
    else if(category.equals("Opioids"))
        out.print("<img src='images/opioids.jpg'/>");
    else if(category.equals("Pills"))
        out.print("<img src='images/pills.jpg'/>");
    else if(category.equals("Meth"))
        out.print("<img src='images/meth.jpg'/>");
    else if(category.equals("Paraphernalia"))
        out.print("<img src='images/paraphernalia.jpg'/>");




%>
<%--TODO ADD PRODUCT DETAILS--%>


<div id="details">
    <h2><%=name%></h2>
    <h3>Inventory:</h3>
    <h3><%=amount%></h3>
    <h3>Price: </h3>
    <h3><%=currFormat.format(price)%></h3>
    <h3>Category: </h3>
    <h3><%=category%></h3>
    <%
        out.print("<a href=\"addcart.jsp?id=" + id + "&name=" + name
                + "&price=" + price + "\">Add to Cart</a>");
    %>
</div>


</body>
</html>
