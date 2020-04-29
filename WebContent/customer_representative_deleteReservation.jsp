<style><%@include file="/WEB-INF/css/reservation.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
 
 <%	ResultSet name=null; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Reservation</title>
</head>
<body>
<%			
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement stmt = con.createStatement(); %>
	<form method="post" action="Customer_re_deleteIndiv.jsp">
 	
 	<select name="customer_name">
	<option>Choose the customer name</option>
	<%
	name = stmt.executeQuery("select c.username from TrainTicketing.Customer c;");
	%>
	<% while(name.next()){ %>
		<option><%= name.getString(1)%> </option>
	<%}%>
	<%name.close();%>
	</select>
	<br>	
		
 	<input type="submit" value="submit" />
	</form>	

		<input type="button" onclick="test()" value="Back" />
		<script ...>
			function test(){
 			var url = "Customer_R_Main.jsp";
 			window.location.href= url;
		}
		</script> 
</body>
</html>