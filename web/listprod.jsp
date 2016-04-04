<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Cashmere Freeway</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

    <!--[if lte IE 8]>
    <script src="js/html5shiv.js"></script><![endif]-->
    <script src="js/jquery.min.js"></script>
    <script src="js/skel.min.js"></script>
    <script src="js/skel-layers.min.js"></script>
    <script src="js/init.js"></script>
    <script src='http://code.jquery.com/jquery-1.10.1.min.js'></script>
    <script src="jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="http://d1ml0gfpm9yj9s.cloudfront.net/scrollIt.min.js"></script>
    <script src="js/scrollIt.min.js" type="text/javascript"></script>

    <noscript>
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link type="text/css" rel="stylesheet" href="css/skel.css"/>
        <link type="text/css" rel="stylesheet" href="css/style-large.css"/>

    </noscript>
    <link type="text/css" rel="stylesheet" href="css/listprod-style.css"/>
    <!--<noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-large.css" />
    </noscript>
-->
    <script>$(function () {
        $.scrollIt();
    });</script>
</head>
<body>

<%@ include file="header.jsp" %>
<%--<%@include file="jdbc.jsp"%>--%>

<h2>Browse Products By Category and Search by Product Name:</h2>

<form method="get" action="listprod.jsp">
    <p align="left">
        <select size="1" name="categoryName">
            <option>All</option>

            <%

                // Could create category list dynamically - more adaptable, but a little more costly
                String url = "jdbc:mysql://localhost:3306/beerproject";
                String uid = "root";
                String pw = "1234";

                Connection con = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    con = DriverManager.getConnection(url, uid, pw);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                try {
                    Statement statement = con.createStatement();
                    ResultSet rst = statement.executeQuery("SELECT DISTINCT category FROM Product");
                    while (rst.next())
                        out.println("<option>" + rst.getString(1) + "</option>");
                } catch (SQLException ex) {
                    out.println(ex);
                }

            %>

            <input type="text" name="productName" size="50" placeholder="Item">
        </select><input type="submit" value="Submit"><input type="reset" value="Reset"></p>
</form>

<%
    // Get product name to search for
    String name = request.getParameter("productName");
    String category = request.getParameter("categoryName");

    boolean hasNameParam = name != null && !name.equals("");
    boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
    String filter = "", sql = "";

    if (hasNameParam && hasCategoryParam) {
        filter = "<h3>Products containing '" + name + "' in category: '" + category + "'</h3>";
        name = '%' + name + '%';
        sql = "SELECT productID, name, category, price  FROM Product WHERE name LIKE ? AND category LIKE ? AND amount>0";
    } else if (hasNameParam) {
        filter = "<h3>Products containing '" + name + "'</h3>";
        name = '%' + name + '%';
        sql = "SELECT productID, name, category, price FROM Product WHERE name LIKE ? AND amount>0";
    } else if (hasCategoryParam) {
        filter = "<h3>Products in category: '" + category + "'</h3>";
        sql = "SELECT productID, name, category, price FROM Product WHERE category = ? AND amount>0";
    } else {
        filter = "<h3>All Products</h3>";
        sql = "SELECT productID, name, category, price FROM Product WHERE amount>0";
    }

    out.println(filter);

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    try {

        PreparedStatement pstmt = con.prepareStatement(sql);
        if (hasNameParam) {
            pstmt.setString(1, name);
            if (hasCategoryParam) {
                pstmt.setString(2, category);
            }
        } else if (hasCategoryParam) {
            pstmt.setString(1, category);
        }

        ResultSet rst = pstmt.executeQuery();

        out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
        out.println("<th>Category</th><th>Price</th></tr>");
        while (rst.next()) {
            out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
                    + "&price=" + rst.getDouble(4) + "\">Add to Cart</a></td>");

            String itemCategory = rst.getString(3);

            String color = "#000000";

            out.println("<td><a href='product-page.jsp?id=" + rst.getInt(1) + "'>" + rst.getString(2) + "</a></td>"
                    + "<td>" + itemCategory + "</td>"
                    + "<td>" + currFormat.format(rst.getDouble(4)) + "</td></tr>");
        }
        out.println("</table></font>");
        closeConnection();
    } catch (SQLException ex) {
        out.println(ex);
    }
%>

</body>
</html>
