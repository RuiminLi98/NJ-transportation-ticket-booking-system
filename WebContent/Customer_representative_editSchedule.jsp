<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
	ResultSet allCitySet = null;
	ResultSet date = null;
	ResultSet representative=null;
	ResultSet available = null;
	boolean selected = true;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Schedule</title>
</head>
<body>
<h1>add information of train schedule</h1>
	<%	
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
			
	%>
	<form method="post" action="Customer_representative_editScheduleController.jsp">
		<b>existing train_ID:</b><br>
		<input type="text" name="train_ID" min= 1 required><br>
		<br>
		<b>new train_ID:</b><br>
		<input type="text" name="new_train_ID" min= 1 required><br>
		<br>
		<b>existing transit_line_name:</b><br>
		<input type="text" name="transit_line_name" min= 1 required><br>
		<br>
		<b>new transit_line_name:</b><br>
		<input type="text" name="new_transit_line_name" min= 1 required><br>
		<br>
		<b>new available_number_of_seats:</b><br>
		<input type="text" name="available_number_of_seats" min= 1 required><br>
		<br>
		<b>new number_of_stops:</b><br>
		<input type="text" name="number_of_stops" min= 1 required><br>
		<br>
		<b>new departure_time:(format xx:xx:xx)</b><br>
		<input type="text" name="departure_time" min= 1 required><br>
		<br>
		<b>new arrival_time:(format xx:xx:xx)</b><br>
		<input type="text" name="arrival_time" min= 1 required><br>
		<br>
		<b>new travel_time:</b><br>
		<input type="text" name="travel_time" min= 1 required><br>
		<br>
		<input type="submit" value="create_train_schedule">
	</form>
	<form action="Customer_R_Main.jsp">	
		<input type="submit" value="back">
	</form>
</body>
</html>

 