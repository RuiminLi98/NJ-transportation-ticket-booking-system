<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
ResultSet rs=null;
String origin = null;
String destination=null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Reservation</title>
</head>
<body>
<form method="post">
	<h1>My Reservation</h1>
		<table>
			<tr>
				<td>Origin</td>
				<td>Destination</td>
				<td>Departure Time</td>
				<td>Arrival Time</td>
				<td>Edit</td>
				<td>Delete</td>
			</tr>
			
			<%
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
			
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String username = request.getParameter("username");
				rs = stmt.executeQuery("SELECT reservation_number,dep_Station_ID, arr_Station_ID, dep_date, arr_date FROM TrainTicketing.Reservation WHERE customer_username ='"+username+"';");
			%> 
			<% while(rs.next()){%>
				<tr>
					<%
						int origin_id = rs.getInt(2);
						ResultSet origin_rs = stmt.executeQuery("SELECT city, state FROM TrainTicketing.Station WHERE station_ID ="+origin_id+";");
						origin = origin_rs.getString(1);
						int destination_id = rs.getInt(3);
						ResultSet destination_rs = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station="+destination_id+";");
						destination = destination_rs.getString(1);
					%>
					<td><%=origin %></td>
					<td><%=destination%></td>
					<td><%=rs.getDate(4)%></td>
					<td><%=rs.getDate(5)%></td>
					<td> <a href="EditReservation.jsp?id=<%=rs.getInt(1)%>">Edit</a></td>
					<td> <a href="DeleteReservation.jsp?id=<%=rs.getInt(1)%>">Cancel</a></td>
				</tr>
			<%} %>
		</table>
		origin_rs.close();
		destination_rs.close();
		rs.close()
		stmt.close();
		con.close();
</form>
</body>
</html>