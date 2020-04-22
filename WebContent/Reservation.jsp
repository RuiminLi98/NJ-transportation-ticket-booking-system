<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
	ResultSet allCitySet = null;
	ResultSet date = null;
	ResultSet representative=null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation</title>
</head>

	<%	/* String username_str = session.getAttribute("username").toString();
	if(username_str == null || username_str.isEmpty()){
			out.print("username is empty, please log in with correct information or create a new account");
	} */
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
	
	%>
	<form method="post" action="reservationProcess.jsp">
	<h1>Reservation</h1>
		<b>Origin:</b>
		<select name="Origin">
		<% while(allCitySet.next()){%>
			<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
		<%}%> 
		</select>
		<br>
		<b>Destination:</b>
		<select name="Destination">
		<%
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");	
		%>
		<% while(allCitySet.next()){%>
			<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
		<%} %>
	
		<%
			allCitySet.close();
			date = stmt.executeQuery("SELECT departure_time FROM TrainTicketing.Train_schedule;");
		%>
		</select>

		<br>
		<b>Class:</b>
		<select name="Class">
			<option>Economy</option>
			<option>Business</option>
			<option>First</option>
		</select>
		
		<br>
		<b>Number of Ticket:</b><input type="number",name="seat_number">
		
		<br>
		<b>Type:</b>
		<select name="Type">
			<option>One Way</option>
			<option>Round Trip</option>
			<option>Monthly Pass</option>
			<option>Weekly Pass</option>
		</select>
		
		
		<br>
		<b>Discount:</b>
		<select name="Discount">
			<option>None</option>
			<option>Senior</option>
			<option>Children</option>
			<option>Disabled</option>
		</select>
		
		<br>
		<b>Did any representative help you:</b>
		<select name="Representative">
			<option>None</option>
			<%
				representative = stmt.executeQuery("select e.First_name,e.last_name from TrainTicketing.Employee e, TrainTicketing.Customer_representative c where e.SSN = c.SSN;");
			%>
			<% while(representative.next()){ %>
				<option><%= representative.getString(1) + " " + representative.getString(2) %> </option>
			<%} %>
			<%
				representative.close();
			%>
		</select>
		</form>
	    <input type="submit" value="submit">
	
	
	
	

</html>