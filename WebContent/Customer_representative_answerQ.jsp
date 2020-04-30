<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
ResultSet rs=null;
String Customer=null;
String Question = null;
String Response = null;
int Qid;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Questions</title>
</head>
<body>
	<h1>Questions Not Answered</h1>
		<table>
			<tr>
				<td><b>Qid</b></td>
				<td><b>Customer</b></td>
				<td><b>Question</b></td>
			</tr>
			
			<%
			if(session.getAttribute("username") == null){
				out.print("Please log in first.");
				response.sendRedirect("Login.jsp");
				return;
				} 
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
			
				//Create a SQL statement
				
				PreparedStatement myquestions=con.prepareStatement("select* from Questions q where q.Response is null;");
			
				rs=myquestions.executeQuery();
				
			%> 
		<% while(rs.next()){%>
				<tr>
					<%
						Qid = rs.getInt(1);
						Customer = rs.getString(2);
						Question=rs.getString(3);
						
					%>
					<td><%=Qid%></td>
					<td><%=Customer%></td>
					<td><%=Question%></td>
				
					
					
				</tr>
			<%} %>
		</table>
		<%
		rs.close();
		myquestions.close();
		con.close();
	
		%>
 <form method="post" action="AnswerProcess.jsp">
	<b>Qid:</b>
	<br>
	<input type="text" name="Qid"  min= 1 required>
	<br>
	<b>Your Response:</b>
	<br>
	<input type="text" name="Response"  min= 1 required>
	<br>
	<input type="submit" value="Post Response">
</form>
<br>
<a href="Logout.jsp">Logout</a>


</body>
</html>