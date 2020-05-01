<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
ResultSet rs=null;
String Customer=null;
String Question = null;
String Response = null;
String keyword=null;
int Qid;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Results</title>
</head>
<body>
<form method="get">
	<h1>Search Results</h1>
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
				keyword=request.getParameter("keyword");
				PreparedStatement myquestions=con.prepareStatement("select * from Questions q where q.Customer=? and q.Question like '%"+keyword+"%';");
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
		<br>
		<br>
		<a href="SearchQuestion.jsp">Search for Questions</a>
		
		<br>
		<br>
		<a href="Question.jsp">Ask More Questions!</a>
		
		<br>
		<br>
		<a href="Logout.jsp">Logout</a>
		
</form>
</body>
</html>