<style><%@include file="/WEB-INF/css/style2.css"%></style>
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
		<b>username:</b><br>
		<input type="text" name="username" min= 1 required><br>
		<br>
		<b>password:</b><br>
		<input type="password" name="password" min= 1 required><br>
		<br>
		<b>repeat password:</b><br>
		<input type="password" name="repeat" min= 1 required><br>
		<br>
		<b>first name:</b><br>
		<input type="text" name="first name" min= 1 required><br>
		<br>
		<b>last name:</b><br>
		<input type="text" name="last name" min= 1 required><br>
		<br>
		<b>email:</b><br>
		<input type="text" name="email" min= 1 required><br>
		<br>
		<b>address:</b><br>
		<input type="text" name="address" min= 1 required><br>
		<br>
		<b>city:</b><br>
		<input type="text" name="city" min= 1 required><br>
		<br>
		<b>state:</b><br>
		<input type="text" name="state" min= 1 required><br>
		<br>
		<b>zip code:</b><br>
		<input type="text" name = "zip_code" min= 1 required><br>
		<br>
		<b>telephone:</b><br>
		<input type="text" name = "telephone" min= 1 required><br>
		<br>
		<br>
		<input type="submit" value="create Account">
	</form>
	<form action="Login.jsp">	
		<input type="submit" value="back">
	</form>
</body>
</html>