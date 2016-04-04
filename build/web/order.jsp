<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <%@include file="default-stylesheets.jsp" %>
</head>
<body style="background-color: white">

<%--<%@ include file="header.jsp" %>--%>

<%
    // Get customer id
    String username = request.getParameter("username");
// Get password
    String password = request.getParameter("password");
// Get shopping cart
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
    double curTotal = (Double) session.getAttribute("curTotal");
    SimpleDateFormat dfmt = new SimpleDateFormat("yyyy-MM-dd");

    try {
        if (username == null || username.equals(""))
            out.println("<h1>Invalid username.  Go back to the previous page and <a href='checkout.jsp'>try again.</a></h1>");
        else if (productList == null)
            out.println("<h1>Your shopping cart is empty!</h1>");
        else {
            // Check if username is same as signed in
            try {
                String curUser = session.getAttribute("curUser").toString();
                if (!curUser.equals(username)) {
                    throw new Exception("Failed");
                }
            } catch (Exception e) {
                out.println("<h1>Username not the same.  Go back to the previous page and try again, or sign out.</h1>");

                return;
            }

            // Get database connection
            getConnection();

            String sql = "SELECT id, name, username, password, balance FROM Person WHERE username = ?";


            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rst = pstmt.executeQuery();
            int orderId = 0;
            String custName = "";


            if (!rst.next()) {
                out.println("<h1>Username not found.  Go back to the previous page and try again.</h1>");
            } else {
                int id = rst.getInt(1);
                custName = rst.getString(2);
                username = rst.getString(3);
                String dbpassword = rst.getString(4);
                double balance = rst.getDouble(5);

                if (balance < curTotal) {
                    out.println("<h1>Not enough money in account, please add more credits</h1>");
                    return;
                }

                // make sure the password on the database is the same as the one the user entered
                if (!dbpassword.equals(password)) {
                    out.println("The password you entered was not correct.  Please go back and try again.<br>");
                    return;
                }


                // Enter order information into database
                sql = "INSERT INTO Orders (personID, cost) VALUES(?, 0);";

                // Retrieve auto-generated key for orderId
                pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setInt(1, id);
                pstmt.executeUpdate();
                ResultSet keys = pstmt.getGeneratedKeys();
                keys.next();
                orderId = keys.getInt(1);

                out.println("<h1>Your Order Summary</h1>");
                out.println("<table><tr><th align=\"right\">Product Id</th><th align=\"right\">Product Name</th><th align=\"right\">Quantity</th><th align=\"right\">Price</th><th align=\"right\">Subtotal</th></tr>");

                double total = 0;
                Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
                NumberFormat currFormat = NumberFormat.getCurrencyInstance();
                try {
                    while (iterator.hasNext()) {
                        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                        String productId = (String) product.get(0);
                        out.print("<tr><td align=\"left\">" + productId + "</td>");
                        out.print("<td align=\"left\">" + product.get(1) + "</td>");
                        out.print("<td align=\"left\">" + product.get(3) + "</td>");
                        String price = (String) product.get(2);
                        double pr = Double.parseDouble(price);
                        int qty = ((Integer) product.get(3)).intValue();
                        out.print("<td align=\"left\">" + currFormat.format(pr) + "</td>");
                        out.print("<td align=\"left\">" + currFormat.format(pr * qty) + "</td></tr>");
                        out.println("</tr>");
                        total = total + pr * qty;

                        con.createStatement().execute("UPDATE Product SET amount=amount-" + qty + " WHERE ProductID='" + productId + "'");
                        sql = "INSERT INTO OrderInfo (orderID, productID, productamount, orderdate, shipDate) VALUES (?, ?, ?, ?)";

                        pstmt = con.prepareStatement(sql);
                        pstmt.setInt(1, orderId);
                        pstmt.setInt(2, Integer.parseInt(productId));
                        pstmt.setInt(3, qty);
                        Date curDate = new Date(System.currentTimeMillis());


                        pstmt.setDate(4, java.sql.Date.valueOf(dfmt.format(curDate)));

                        //TODO Add timestamp to orderinfo
                        pstmt.executeUpdate();
                    }
                } catch (Exception e) {
                    out.print(e);
                }
                out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                        + "<td align=\"right\">" + currFormat.format(total) + "</td></tr>");
                out.println("</table>");

                // Update order total
                sql = "UPDATE Orders SET cost=? WHERE orderId=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setDouble(1, total);
                pstmt.setInt(2, orderId);
                pstmt.executeUpdate();

                balance = balance - curTotal;
                sql = "UPDATE Person SET balance=? WHERE id=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setDouble(1, balance);
                pstmt.setInt(2, id);
                pstmt.executeUpdate();

                out.println("<h1>Order completed.  Will be shipped soon...</h1>");
                out.println("<h1>Your order reference number is: " + orderId + "</h1>");
                out.println("<h1>Shipping to customer: " + username + " Name: " + custName + "</h1>");
                out.println("<h1>Your new balance is: " + currFormat.format(balance));

                // Clear session variables (cart)
                session.setAttribute("productList", null);
            }
        }
    } catch (SQLException ex) {
        out.println(ex);
    } finally {
        try {
            if (con != null)
                con.close();
        } catch (SQLException ex) {
            out.println(ex);
        }
    }
%>
<br><br>

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
