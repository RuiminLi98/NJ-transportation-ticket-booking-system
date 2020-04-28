<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Log in</title>
</head>
<body>
<h1>Log in Train Ticketing system</h1>
<form method="post" action="LoginProcess.jsp">
	<b>username:</b>
	<br>
	<input type="text" name="username"  min= 1 required>
	<br>
	<br>
	<b>password:</b>
	<br>
	<input type="password" name="password" min= 1 required>
	<br>
	<br>
	<b>account type:</b>
	<select name="user_type" style="padding-left">
		<option>Customer</option>
		<option>Customer_representative</option>
		<option>Site_manager</option>
	</select>
	<br>
	<br>
	<input type="submit" value="Log In">
</form>

<form method="post" action="customer_register.jsp"><input type="submit" value="create customer account"></form>
	<br>
<form method="post" action="customer_representativeRegister.jsp"><input type="submit" value="create customer representer account"></form>



</body>

</html>