<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Questions</title>
</head>
<body>

	<%
		String qid = request.getParameter("Qid");
		int Qid=Integer.parseInt(qid);
		String Customer = request.getParameter("Customer");
		String Response = request.getParameter("Response");
		
			//get database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			PreparedStatement update=con.prepareStatement("UPDATE `TrainTicketing`.`Questions` SET `Response` =? WHERE (`Qid` = ?);");
			update.setString(1, Response);
			update.setInt(2, Qid);
			
			update.executeUpdate();
			
			
			
			
			//close connection
			
			update.close();
			con.close();
			
		
	%>
	Thank you for answering the questions!
	<br>
	
	You can
	<a href="Customer_representative_answerQ.jsp">Answer More Questions</a>
	<br>
	Or
	<a href="Logout.jsp">Logout</a>

</body>
</html>