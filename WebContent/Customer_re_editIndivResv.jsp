<style><%@include file="/WEB-INF/css/reservation.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date, java.text.SimpleDateFormat"%>
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
	String rep;
	String origin_city;
	String origin_state;
	String destination_city;
	String destination_state;
	String type;
	String discount;
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
<form method="post" action="Customer_representative_editReservationProcess.jsp">
	<h1>Reservation Details</h1>
	<%
		int rsid = Integer.parseInt(request.getParameter("reservation"));
		session.setAttribute("Customer_edit_reservation",Integer.toString(rsid));
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String query = null;
		query = "SELECT * FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";";
		rs = stmt.executeQuery(query);
	%>
		
	<% 		rs.next();
			total_fare = rs.getFloat(1);
			seat_number = rs.getInt(2);
			class_str = rs.getString(3);
			booking_fee = rs.getFloat(4);
			reservation_date = rs.getDate(5);
			train_id = rs.getInt(6);
			line_name = rs.getString(7);
			origin_station = rs.getInt(8);
			dep_date = rs.getTimestamp(9);
			dest_station = rs.getInt(12);
			arr_date = rs.getTimestamp(13);
			rep_ssn = rs.getInt(14);
			String username_str = rs.getString(15);
			session.setAttribute("Customer_edit_username",username_str);
			type = rs.getString(17);
			discount = rs.getString(18);
			rs.close();
			
			String rep_query = "SELECT e.First_name, e.last_name FROM TrainTicketing.Employee as e, TrainTicketing.Customer_representative as c, TrainTicketing.Reservation as r where r.reservation_number="+rsid+" and c.SSN="+rep_ssn+" and e.SSN=c.SSN;";
			ResultSet rep_str = stmt.executeQuery(rep_query);
			if(rep_str.next()){
				rep = rep_str.getString(1)+" "+ rep_str.getString(2);
				rep_str.close();
			}else{
				rep="None";
			}
			
			String origin = "SELECT city, state FROM TrainTicketing.Station WHERE station_ID ="+origin_station+";";
			ResultSet origin_rs = stmt.executeQuery(origin);
			origin_rs.next();
			origin_city = origin_rs.getString(1);
			origin_state = origin_rs.getString(2);
			origin_rs.close();
			
			String dest = "SELECT city,state FROM TrainTicketing.Station WHERE station_ID="+dest_station+";";
			ResultSet destination_rs = stmt.executeQuery(dest);
			destination_rs.next();
			destination_city = destination_rs.getString(1);
			destination_state = destination_rs.getString(2);
			destination_rs.close();
	
	%>
	<div><b>Origin:</b></div>
		<select name="Origin">
		<%  allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
		while(allCitySet.next()){%>
			<%if(origin_city.equals(allCitySet.getString(1)) && origin_state.equals(allCitySet.getString(2))) {%>
				<option selected><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
			<%}else{ %>
				<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
			<%} %>
		<%}%> 
		</select>
		
		<br>
		<div><b>Destination:</b></div>
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
		<br>
		<div><b>Departure Date</b></div>
		<select name="Date">
			<%
				Date today = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String todaydate = formatter.format(today);%>
				<option><%=todaydate%></option>
				<% for(int i=1; i<=20; i++){
					Calendar cal = Calendar.getInstance();
					cal.setTime(today);
					cal.add(Calendar.DATE,i);
					String temp = formatter.format(cal.getTime());
				%>
				<option><%=temp %></option>
				
			<%} %>
		
		
		</select>
			
		<br>
		<div><b>Class:</b></div>
		<select name="Class">
			<%if (class_str.equals("Economy")){%>
				<option selected>Economy</option>
				<option>Business</option>
				<option>First</option>
			<%}else if(class_str.equals("Business")){ %>
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
		<div><b>Number of Ticket:</b></div><input type="number" name="seat_number" value=<%=seat_number%> min = 1 required>
		
		<br>
		<div><b>Type:</b></div>
		<select name="Type">
			<%if(type.equals("One Way")){ %>
				<option selected>One Way</option>
				<option>Round Trip</option>
				<option>Monthly Pass</option>
				<option>Weekly Pass</option>
			<%}else if(type.equals("Round Trip")){ %>
				<option selected>Round Trip</option>
				<option>One Way</option>
				<option>Monthly Pass</option>
				<option>Weekly Pass</option>
			<%}else if(type.equals("Monthly Pass")){ %>
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
		<div><b>Discount:</b></div>
		<select name="Discount">
			<%if(discount.equals("None")){ %>
				<option selected>None</option>
				<option>Senior</option>
				<option>Children</option>
				<option>Disabled</option>
			<%}else if(discount.equals("Senior")){ %>
				<option selected>Senior</option>
				<option>None</option>
				<option>Children</option>
				<option>Disabled</option>
			<%}else if(discount.equals("Children")){ %>
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
		<div><b>Did any representative help you:</b></div>
		<select name="Representative">
			<option>None</option>
			<%
				representative = stmt.executeQuery("select e.First_name,e.last_name from TrainTicketing.Employee e, TrainTicketing.Customer_representative c where e.SSN = c.SSN;");
				
			 while(representative.next()){ 
				if(rep.equals(representative.getString(1) + " " + representative.getString(2))){%>
					<option selected><%= representative.getString(1) + " " + representative.getString(2) %> </option>
				<%} else{%>
					<option><%= representative.getString(1) + " " + representative.getString(2) %> </option>
				<%} %>
			<%}%>
			<%representative.close();%>
		
		</select>
		<br>
		<input type="submit" value="Save Edit">
	
</form>	
	
</body>
</html>