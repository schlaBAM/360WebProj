<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 2015-12-02
  Time: 2:02 PM
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
<%@include file="header.jsp"%>
<%@include file="jdbc.jsp"%>
<%
    //Check if admin
    if(b){
        if (c != 1){
            response.sendRedirect("index.jsp");
        }
    }else{
        response.sendRedirect("index.jsp");
    }
%>

<div>
    <h2>Items in warehouse</h2>

    <table>
        <tbody>
        <tr>
            <td></td>
            <th>Product Name</th>
            <th>Category</th>
            <th>Price($)</th>
            <th>Units</th>
            <th></th>
        </tr>

        <%
            try{
                getConnection();

                //Get all products, print to table
                String sql = "SELECT productID, name, category, price, amount FROM Product";
                Statement statement = con.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);

                while(resultSet.next()){
                    String item = "<form action='update-product.jsp' method='get'><tr>" +
                            "<td><input type='hidden' name='id' value='" + resultSet.getInt(1) + "'/></td>" +
                            "<td><input type='text' name='name' value='" + resultSet.getString(2) + "'/></td>" +
                            "<td><input type='text' name='category' value='" + resultSet.getString(3) + "'/></td>" +
                            "<td><input type='number' name='price' min=0 value='" + resultSet.getDouble(4) + "'/></td>" +
                            "<td><input type='number' name='amount' min=0 value='" + resultSet.getInt(5) + "'/></td>" +
                            "<td><input type='submit' value='Update' /></td></tr></form>";
                    out.print(item);
                }


            }catch (Exception e){
                out.print(e);
            }finally{
                con.close();
            }





        %>


        </tbody>
    </table>


</div>


</body>
</html>
