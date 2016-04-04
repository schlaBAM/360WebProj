<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 11:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="default-stylesheets.jsp" %>
    <link type="text/css" rel="stylesheet" href="css/login-style.css">
</head>
<body>
<%@include file="header.jsp" %>

<div id="login-div">
    <h1>Login page</h1><br>

    <form action="login-verify.jsp" method="post">
        <input class="input" type="text" name="username" placeholder="Username">
        <input class="input" type="password" name="password" placeholder="Password"><br>
        <input type="submit" value="Submit">
    </form>
    <br>
    <form action="register.jsp">
        <input type="submit" value="Register">
    </form>

    <%
        String failed = request.getParameter("Failed");
        if (failed != null) {
            if (failed.equals("true")) {
                out.print("Username and/or Password not found, please try again or register!");
            }
        }
    %>

</div>
</body>
</html>
