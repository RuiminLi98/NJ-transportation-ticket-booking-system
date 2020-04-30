<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Questions</title>
</head>
<body>

	<h1>Search for Questions</h1>
<form method="post" action="SearchProcess.jsp">
	<b>keyword:</b>
	<br>
	<input type="text" name="keyword"  min= 1 required>
	<br>
	<br>
	<br>
	<input type="submit" value="Search keyword">
</form>
		
			
		
		
		<br>
	
		<br>
		<a href="Question.jsp">Ask More Questions!</a>
		
		<br>
		<br>
		<a href="Logout.jsp">Logout</a>
		

</body>
</html>