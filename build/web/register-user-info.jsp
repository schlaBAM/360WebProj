<%--
  Created by IntelliJ IDEA.
  User: Jeff
  Date: 12/1/2015
  Time: 4:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="default-stylesheets.jsp" %>
    <link type="text/css" rel="stylesheet" href="css/login-style.css">

    <style>
        body {
            background-color: white;
        }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<div id="register-pane">
    <form action="register-user.jsp" method="get">
        <h2>Register Info</h2>
        Full name:
        <input type="text" name="name" size = "15">
        Username:
        <input type="text" name="username"
                         value="<% out.print(request.getSession().getAttribute("username")); %>"size = "15">
        Password:
        <input type="text" name="password"size = "15">
        Address:
        <input type="text" name="address"size = "15">
        City:
        <input type="text" name="city"size = "15">
        Province:
        <select>
            <option value="AB">Alberta</option>
            <option value="BC">British Columbia</option>
            <option value="MB">Manitoba</option>
            <option value="NB">New Brunswick</option>
            <option value="NL">Newfoundland & Labrador</option>
            <option value="NS">Nova Scotia</option>
            <option value="NT">Northwest Territories</option>
            <option value="NU">Nunavut</option>
            <option value="ON">Ontario</option>
            <option value="PE">Prince Edward Island</option>
            <option value="QB">Quebec</option>
            <option value="SK">Saskatchewan</option>
            <option value="YT">Yukon</option>
        </select>
        Postal Code:
        <input type="text" name="postalcode" maxlength="6"size = "15">
        Phone Number:
        <input type="text" name="phonenumber" maxlength="10"size = "15">
        Email:
        <input type="email" name="email"> <br>

        <input type="checkbox" name="dealer" value="dealer">Register me as a dealer!<br><br>

        <input type="submit" name="submit">
    </form>
</div>

</body>
</html>
