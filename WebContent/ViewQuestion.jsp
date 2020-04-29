<style><%@include file="/WEB-INF/css/blackStyle.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
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
<title>My Questions</title>
</head>
<body>
<form method="get">
	<h1>My Questions</h1>
		<table>
			<tr>
				<td><b>Question</b></td>
				<td><b>Response</b></td>
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
				Customer = (String)session.getAttribute("username");
				PreparedStatement myquestions=con.prepareStatement("select*from Questions q where q.Customer=?;");
				myquestions.setString(1, Customer);
				rs=myquestions.executeQuery();
				
			%> 
		<% while(rs.next()){%>
				<tr>
					<%
						Question = rs.getString(3);
						Response = rs.getString(4);
						if(Response==null){Response="Please wait for our Customer Representative's feedback";}
						
					%>
					<td><%=Question %></td>
					<td><%=Response%></td>
				
					
					
				</tr>
			<%} %>
		</table>
		<%
		rs.close();
		myquestions.close();
		con.close();
	
		%>
		
</form>
</body>
</html>