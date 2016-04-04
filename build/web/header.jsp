<%@ page import="java.util.HashMap" %>

<header id="header" class="skel-layers-fixed">
    <h1><a href="index.jsp"><img id="bannerLogo" src="images/cashmere.png"/></a></h1>
    <nav id="nav">
        <ul>
            <%@include file="clearance-check.jsp" %>
            <%
                //Find Permissions
                if (b) {
                    if (c == 1) {
                        out.print("<li>Admin Signed in<ul><li><a href='update-items-page.jsp'>Update Items</a></li></li>");
                        out.print("<li><a href='sales.jsp'>Sales</a></li></ul>");
                    }
                }
                HashMap productlist = (HashMap) session.getAttribute("productList");
                if (productlist != null) {
                    out.print("<li><a href='showcart.jsp'>Shopping Cart</a></li>");

                }
            %>
            <li><a href="listprod.jsp">Buy Beer</a>
                <ul id="nav_about">
                    <li><a href="listprod.jsp?categoryName=Weed">IPA's</a></li>
                    <li><a href="listprod.jsp?categoryName=Opioids">Wheat Beer</a></li>
                    <li><a href="listprod.jsp?categoryName=Meth">Cheap Stuff</a></li>
                    <li><a href="listprod.jsp?categoryName=Hallucinogens">Dark Beer</a></li>
                    <li><a href="listprod.jsp?categoryName=Pills">Light Beer</a></li>
                    <li><a href="listprod.jsp?categoryName=Lager">Lager</a></li>
                </ul>
            </li>
            <li><a href="contactus.html">Contact</a></li>
            <li>
                <%
                    if (request.getSession().getAttribute("curUser") != null) {
                        out.print("<a href=\"user-page.jsp\" class=\"button special\">" + request.getSession().getAttribute("curName") + "</a>" +
                                "<ul><li><a href=\"user-page.jsp\">View Profile</a></li>" +
                                "<li><a href=\"sign-out.jsp\">Sign out</a></li></ul>");
                    } else {

                        out.print("<a href=\"login.jsp\" class=\"button special\">Login</a>");
                    }
                %>
            </li>
        </ul>
    </nav>
</header>

