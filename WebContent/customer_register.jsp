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
		<input type="submit" value="create Account"><a href="Login.jsp">back</a>
	</form>
</body>
</html>