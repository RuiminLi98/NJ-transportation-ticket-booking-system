<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
	ResultSet rs = null;
	float total_fare;
	int seat_number;
	String class_str;
	float booking_fee;
	Date reservation_date;
	int train_id;
	String line_name;
	int origin_station;
	Timestamp dep_date;
	int dest_station;
	Timestamp arr_date;
	int rep_ssn;
	String origin_city;
	String origin_state;
	String destination_city;
	String destination_state;
	ResultSet allCitySet = null;
	ResultSet representative = null;
	ResultSet available = null;
	boolean selected = true;
	/*  ResultSet dep_date = null;*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Reservation</title>
</head>
<body>
<form method="post" action="EditReservationProcess.jsp">
	<h1>Reservation Details</h1>
	<%
		int rsid = Integer.parseInt(request.getParameter("id"));
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String query = null;
		query = "SELECT * FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";";
		rs = stmt.executeQuery(query);
	%>
		
	<% 	
			total_fare = rs.getFloat(2);
			seat_number = rs.getInt(3);
			class_str = rs.getString(4);
			booking_fee = rs.getFloat(5);
			reservation_date = rs.getDate(6);
			train_id = rs.getInt(7);
			line_name = rs.getString(8);
			origin_station = rs.getInt(9);
			dep_date = rs.getTimestamp(10);
			dest_station = rs.getInt(13);
			arr_date = rs.getTimestamp(14);
			rep_ssn = rs.getInt(15);
			ResultSet origin_rs = stmt.executeQuery("SELECT city, state FROM TrainTicketing.Station WHERE station_ID ="+origin_station+";");
			origin_city = origin_rs.getString(1);
			origin_state = origin_rs.getString(2);
			ResultSet destination_rs = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station="+dest_station+";");
			destination_city = destination_rs.getString(1);
			destination_state = destination_rs.getString(2);
			origin_rs.close();
			destination_rs.close();
	%>
	<b>Origin:</b>
		<select name="Origin">
		<% while(allCitySet.next()){%>
			<%if(origin_city.equals(allCitySet.getString(1)) && origin_state.equals(allCitySet.getString(2))) {%>
				<option selected><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
			<%}else{ %>
				<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
			<%} %>
		<%}%> 
		</select>
		
		<br>
		<b>Destination:</b>
		<select name="Destination">
		<%
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");	
		%>
		<% while(allCitySet.next()){%>
			<%if(destination_city.equals(allCitySet.getString(1)) && destination_state.equals(allCitySet.getString(2))) {%>
				<option selected><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
			<%}else{ %>
				<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
			<%} %>
		<%} %>
	
		<%
			allCitySet.close();
		%>
		</select>
		<%
			
			
				PreparedStatement ps = con.prepareStatement(Tools.big_query);
				ps.setString(1, origin_city);
				ps.setString(2, destination_city);
				available = ps.executeQuery();
			
			
		%>
		
		<br>
		<b>Departure Date</b>
		<select name="Date">
			<% while(available.next()){	%>
				<%if(!dep_date.before(available.getTimestamp(4)) && !dep_date.after(available.getTimestamp(4))){%>	
					<option selected><%=available.getTimestamp(4)%></option>
				<%}else{ %>
					<option><%=available.getTimestamp(4)%></option>
				<%} %>
			<%}%>
			<% available.close();%>
		</select>
			
		<br>
		<b>Class:</b>
		<select name="Class">
			<%if (session.getAttribute("Class").equals("Economy")){%>
				<option selected>Economy</option>
				<option>Business</option>
				<option>First</option>
			<%}else if(session.getAttribute("Class").equals("Business")){ %>
				<option selected>Business</option>
				<option>Economy</option>
				<option>First</option>
			<% }else{%>
				<option selected>First</option>
				<option>Economy</option>
				<option>Business</option>
			<%} %>
		</select>
		
		<br>
		<b>Number of Ticket:</b><input type="number",name="seat_number">
		
		<br>
		<b>Type:</b>
		<select name="Type">
			<%if(session.getAttribute("Type").equals("One Way")){ %>
				<option selected>One Way</option>
				<option>Round Trip</option>
				<option>Monthly Pass</option>
				<option>Weekly Pass</option>
			<%}else if(session.getAttribute("Type").equals("Round Trip")){ %>
				<option selected>Round Trip</option>
				<option>One Way</option>
				<option>Monthly Pass</option>
				<option>Weekly Pass</option>
			<%}else if(session.getAttribute("Type").equals("Monthly Pass")){ %>
				<option selected>Monthly Pass</option>
				<option>One Way</option>
				<option>Round Trip</option>
				<option>Weekly Pass</option>
			<%}else{ %>
				<option selected>Weekly Pass</option>
				<option>One Way</option>
				<option>Round Trip</option>
				<option>Monthly Pass</option>
			<%} %>
		</select>
		
		
		<br>
		<b>Discount:</b>
		<select name="Discount">
			<%if(session.getAttribute("Discount").equals("None")){ %>
				<option selected>None</option>
				<option>Senior</option>
				<option>Children</option>
				<option>Disabled</option>
			<%}else if(session.getAttribute("Discount").equals("Senior")){ %>
				<option selected>Senior</option>
				<option>None</option>
				<option>Children</option>
				<option>Disabled</option>
			<%}else if(session.getAttribute("Discount").equals("Children")){ %>
				<option selected>Children</option>
				<option>None</option>
				<option>Senior</option>
				<option>Disabled</option>
			<%}else{ %>
				<option selected>Disabled</option>
				<option>None</option>
				<option>Senior</option>
				<option>Children</option>
			<%} %>
		</select>
		
		<br>
		<b>Did any representative help you:</b>
		<select name="Representative">
			<option>None</option>
			<%
				representative = stmt.executeQuery("select e.First_name,e.last_name from TrainTicketing.Employee e, TrainTicketing.Customer_representative c where e.SSN = c.SSN;");
				String name = representative.getString(1) + " " + representative.getString(2);
			
			 while(representative.next()){ 
				if(session.getAttribute("Representative").equals(name)){%>
					<option selected><%= representative.getString(1) + " " + representative.getString(2) %> </option>
					<%} %>
			<%}%>
			<%representative.close();%>
		
		</select>
		
	
	
	
</body>
</html>