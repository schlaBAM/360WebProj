<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="default-stylesheets.jsp"%>
    <link type="text/css" rel="stylesheet" href="css/register-style.css"/>
</head>
<body>
<%@include file="header.jsp"%>
<div id="register-div">
    <h1>Register now</h1>

    <br><br>

    <p align = "center"><strong>First, let's check if your username is free to use!</strong></p>

    <form action="username-check.jsp" method="post">
        <input class="input" type="text" name="username" placeholder="Username">
        <br>
        <input type="submit" value="Register">
    </form>

</div>


</body>
</html>
