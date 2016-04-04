<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>

<HTML>
<HEAD>
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
    <link type="text/css" rel="stylesheet" href="css/showcart-style.css"/>
    <noscript>
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link type="text/css" rel="stylesheet" href="css/skel.css"/>
        <link type="text/css" rel="stylesheet" href="css/style-large.css"/>

    </noscript>

    <!--<noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-large.css" />
    </noscript>
-->
    <script>$(function () {
        $.scrollIt();
    });</script>

</HEAD>
<BODY>

<%@ include file="header.jsp" %>
<%@include file="jdbc.jsp"%>
<script>
    function update(newid, newqty) {
        window.location = "showcart.jsp?update=" + newid + "&newqty=" + newqty;
    }
</script>
<br><br><br>
    <%
        // Get the current list of products
        HashMap productList = (HashMap) session.getAttribute("productList");
        ArrayList product = new ArrayList();
        String id = request.getParameter("delete");
        String update = request.getParameter("update");
        String newqty = request.getParameter("newqty");

// check if shopping cart is empty
        if (productList == null) {
            out.println("<H1>Your shopping cart is empty!</H1>");
            productList = new HashMap();
        } else {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();

            // if id not null, then user is trying to remove that item from the shopping cart
            if (id != null && (!id.equals(""))) {
                if (productList.containsKey(id)) {
                    productList.remove(id);
                }
            }

            // if update isn't null, the user is trying to update the quantity
            if (update != null && (!update.equals(""))) {
                if (productList.containsKey(update)) { // find item in shopping cart
                    product = (ArrayList) productList.get(update);
                    product.set(3, (new Integer(newqty))); // change quantity to new quantity
                } else {
                    productList.put(id, product);
                }
            }

            // print out HTML to print out the shopping cart
            out.println("<H1>Your Shopping Cart</H1><br>");
            out.print("<TABLE><TR><TH>Product Name</TH><TH>Quantity</TH>");
            out.println("<TH>Price</TH><TH>Subtotal</TH><TH></TH><th></th></TR>");

            int count = 0;
            double total = 0;
            // iterate through all items in the shopping cart
            Iterator iterator = productList.entrySet().iterator();
            while (iterator.hasNext()) {
                count++;
                Map.Entry entry = (Map.Entry) (iterator.next());
                product = (ArrayList) entry.getValue();
//                int curId = Integer.valueOf(product.get(0).toString());
                int curId = Integer.valueOf(product.get(0).toString());
                int max = Integer.MAX_VALUE;

                //Find max value
                try{
                    getConnection();
                    ResultSet resultSet = con.prepareStatement("SELECT amount FROM Product WHERE productID='" + curId + "'").executeQuery();
                    resultSet.next();
                    max = resultSet.getInt(1);
                    con.close();

                }catch (Exception e){
                    out.print("alert(" + e + ")");
                }


                // read in values for that product ID

                out.print("<TR>" +
                        "<form action='showcart.jsp'><input type='hidden' name='update' value='" + product.get(0) + "'/>");
//                        "<TD>" + product.get(0) + "</TD>");
                out.print("<TD><a href='product-page.jsp?id=" + product.get(0).toString() + "'>" + product.get(1) + "</a></TD>");

                out.print("<TD ALIGN=CENTER><INPUT TYPE=\"number\" name=\"newqty\" size=\"3\" max='" + max +"' value=\""
                        + product.get(3) + "\"></TD>");
                double pr = Double.parseDouble((String) product.get(2));
                int qty = ((Integer) product.get(3)).intValue();

                // print out values for that product from shopping cart
                out.print("<TD>" + currFormat.format(pr) + "</TD>");
                out.print("<TD>" + currFormat.format(pr * qty) + "</TD>");
                // allow the customer to delete items from their shopping cart by clicking here
                out.println("<TD ALIGN = CENTER><A HREF=\"showcart.jsp?delete="
                        + product.get(0) + "\">Remove Item</A></TD>");
                // allow customer to change quantities for a product in their shopping cart
                out.println("<td><input type='submit' value='update'></form>");

//                out.println("<TD ALIGN = LEFT><INPUT TYPE=BUTTON OnClick=\"update("
//                        + product.get(0) + ", document.form1.newqty" + count + ".value)\" VALUE=\"Update Quantity\">");


                out.println("</TR>");
                // keep a running total for all items ordered
                total = total + pr * qty;
            }
            // print out order total
            out.println("<TR><td></td><td></td><td></tD><TD ALIGN=LEFT><B>Order Total</B></TD>"
                    + "<TD ALIGN=LEFT>" + currFormat.format(total) + "</TD>");
//            out.println("<TD ALIGN = CENTER><INPUT TYPE=BUTTON OnClick=\"update("
//                    + product.get(0) + ", document.form1.newqty" + count + ".value)\" VALUE=\"Update Quantity\"></TR>");
            out.println("</TABLE>");

            session.setAttribute("curTotal", total);
            //give user option to check out
            String curUser = (String) session.getAttribute("curUser");
            if (curUser == null) {
                out.println("<h2><a href='login.jsp'>Log in</a></h2>");
            } else {
                out.println("<H2><A HREF=\"checkout.jsp\">Check Out</A></H2>");
            }
        }
// set the shopping cart
        session.setAttribute("productList", productList);
// give the customer the option to add more items to their shopping cart
    %>
    <H2><A HREF="listprod.jsp">Continue Shopping</A></H2>

</BODY>
</HTML>



