<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	<h1>create an account</h1>
	<form method="post" action="RegisterProcess.jsp">
		username:<input type="text" name="username">
		<br>
		password:<input type="password" name="password">
		<br>
		repeat password:<input type="password" name="repeat">
		<br>
		first name:<input type="text" name="first name">
		<br>
		last name:<input type="text" name="last name">
		<br>
		email:<input type="text" name="email">
		<br>
		address:<input type="text" name="address">
		<br>
		city:<input type="text" name="city">
		<br>
		state:<input type="text" name="state">
		<br>
		zip code:<input type="text" name = "zip_code">
		<br>
		telephone:<input type="text" name = "telephone">
		<br>
		<input type="submit" value="create Account"><a href="Login.jsp">back</a>
	</form>
</body>
</html>