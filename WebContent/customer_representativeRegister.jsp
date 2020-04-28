<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register for Customer Representative</title>
</head>
<body>
	<h1>create an account</h1>
	<form method="post" action="Customer_representativeRegisterProcess.jsp">
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
		<b>SSN:</b><br>
		<input type="text" name = "ssn" min= 1 required><br>
		<br>
		<br>
		<input type="submit" value="create Account">
	</form>
	<form action="Login.jsp">	
		<input type="submit" value="back">
	</form>
</body>
</html>