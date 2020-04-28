<style><%@include file="/WEB-INF/css/reservation.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date, java.text.SimpleDateFormat"%>
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
<body>
<h1>Add reservation</h1>
	<%	
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
			
	%>
		<form method="post" action="Customer_reservationProcess.jsp">
		
		<div><b>Username:</b></div>
		<input type="text" name="User"  min= 1 required>
		<br/>
		
		<div><b>Origin:</b></div>
		<select name="Origin">
		<% while(allCitySet.next()){%>
			<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
		<%}%> 
		</select>
		<br>
		
		<div><b>Destination:</b></div>
		<select name="Destination">
		<%
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");	
		%>
		<% while(allCitySet.next()){%>
			<option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
		<%} %>
	
		<%
			allCitySet.close();
		%>
		</select>
		

		<%
			String target_Customer=request.getParameter("User");
			String origin_info = request.getParameter("Origin");
			String destination_info = request.getParameter("Destination");
			if(target_Customer == null && origin_info == null && destination_info == null) selected = false;
			else{ 
				PreparedStatement ps = con.prepareStatement(Tools.big_query);
				ps.setString(1, origin_info.split("-")[0]);
				ps.setString(2, destination_info.split("-")[0]);
				available = ps.executeQuery();
			}
			date = stmt.executeQuery("SELECT departure_time FROM TrainTicketing.Stop");
		%>
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
		<%-- <input type="date" name="Date" value =<%=LocalDate.now().toString() %> min=LocalDate.now() max=LocalDate.now().plusDays(30) > --%>
		<%-- <select name="Date">
		<%if(selected){ %>
			<% while(available.next()){	
			%>	
				<option><%=available.getTimestamp(4)%></option>
			<%}%>
			<% available.close();%>
		<%}else{ %>
			<% while(date.next()) {%>
				<%if(date.getTimestamp(1) != null){ %>
					<option><%=date.getTimestamp(1)%></option>
				<%} %>
			<%} %>
			<%date.close(); %>
		<%} %>
		</select> --%>
		<br>
		<div><b>Class:</b></div>
		<select name="Class">
			<option>Economy</option>
			<option>Business</option>
			<option>First</option>
		</select>
		
		<br>
		<div><b>Number of Ticket:</b></div><input type="number" name="seat_number" min= 1 required>
		
		<br>
		<div><b>Type:</b></div>
		<select name="Type">
			<option>One Way</option>
			<option>Round Trip</option>
			<option>Monthly Pass</option>
			<option>Weekly Pass</option>
		</select>
		
		
		<br>
		<div><b>Discount:</b></div>
		<select name="Discount">
			<option>None</option>
			<option>Senior</option>
			<option>Children</option>
			<option>Disabled</option>
		</select>
		
		<br>
		<div><b>Did any representative help you:</b></div>
		<select name="Representative">
			<option>None</option>
			<%
				representative = stmt.executeQuery("select e.First_name,e.last_name from TrainTicketing.Employee e, TrainTicketing.Customer_representative c where e.SSN = c.SSN;");
			%>
			<% while(representative.next()){ %>
				<option><%= representative.getString(1) + " " + representative.getString(2) %> </option>
			<%}%>
			<%representative.close();%>
		
		</select>
		<br>
	    <input type="submit" value="submit">
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