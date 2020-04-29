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
<h1>Post and View Your Questions</h1>
<form method="post" action="QuestionProcess.jsp">
	<b>Ask a Question:</b>
	<br>
	<input type="text" name="Question"  min= 1 required>
	<br>
	<br>
	<br>
	<input type="submit" value="Post My Question">
</form>
<br>
	<a href="ViewQuestion.jsp">View Your Questions</a>
	<br>


</body>
</html>