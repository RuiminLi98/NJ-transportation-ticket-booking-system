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
	username:<input type="text" name="username">
	<br>
	password:<input type="password" name="password">
	<br>
	<select name="user_type">
		<option>Customer</option>
		<option>Customer_representative</option>
		<option>Site_manager</option>
	</select>
	<input type="submit" value="submit"><a href="customer_register.jsp">create account</a>
</form>
</body>
</html>