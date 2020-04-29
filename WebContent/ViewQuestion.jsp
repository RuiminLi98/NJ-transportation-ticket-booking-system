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
		<%--<% while(rs.next()){%>
				<tr>
					<%
						origin = rs.getString(2)+"-"+rs.getString(3);
						destination = rs.getString(6)+"-"+rs.getString(7);
						SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
						SimpleDateFormat timeF = new SimpleDateFormat("hh:mm");
						dep_time = dateF.format(rs.getDate(4))+" "+timeF.format(rs.getTimestamp(8));
						arr_time = dateF.format(rs.getDate(5))+" "+timeF.format(rs.getTimestamp(9));
						ID = rs.getInt(1);
					%>
					<td><%=origin %></td>
					<td><%=destination%></td>
					<td><%=dep_time%></td>
					<td><%=arr_time%></td>
					<td><%=rs.getDate(11)%></td>
					<td><%=rs.getFloat(10) %></td>
					<td> <a href="EditReservation.jsp?reservation=<%=ID%>">View</a></td>
					
					<td>
					<a href="DeleteReservation.jsp?reservation=<%=ID%>">Cancel</a>
					</td>
					
					
				</tr>
			<%} %>
		</table>
		<%
		rs.close();
		stmt.close();
		con.close();
		%>
		--%>
</form>
</body>
</html>