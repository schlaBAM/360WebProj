<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/3/2015
  Time: 1:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp"%>
<%
    try{
        getConnection();

        //Get product details
        int id = Integer.valueOf(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.valueOf(request.getParameter("price"));
        int quantity = Integer.valueOf(request.getParameter("amount"));

        //Update product
        String sql = "UPDATE Product SET name=?, category=?, price=?, amount=? WHERE productID=?";

        PreparedStatement preparedStatement = con.prepareStatement(sql);

        preparedStatement.setString(1, name);
        preparedStatement.setString(2, category);
        preparedStatement.setDouble(3, price);
        preparedStatement.setInt(4, quantity);
        preparedStatement.setInt(5, id);

        preparedStatement.executeUpdate();
//        out.print(preparedStatement.toString());
        response.sendRedirect("update-items-page.jsp");



    }catch (Exception e){
        out.print(e);
    }



%>