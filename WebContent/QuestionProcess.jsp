<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String Customer = (String)session.getAttribute("username");
		String Question=(String) request.getParameter("Question");
		//get database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		PreparedStatement newquestion=con.prepareStatement("INSERT INTO `TrainTicketing`.`Questions` (`Customer`, `Question`) VALUES (?, ?);"); 
		newquestion.setString(1, Customer);
		newquestion.setString(2, Question);
		newquestion.executeUpdate();
		con.close();
		newquestion.close();
	%>
	<h1>Thank you for your Question! We'll get to you back as soon as possible</h1>
<br>
<a href="ViewQuestion.jsp">View Your Questions</a>

<br>

<a href="Question.jsp">Ask More Questions!</a>

<br>

<a href="Logout.jsp">Logout</a>
</body>
</html>