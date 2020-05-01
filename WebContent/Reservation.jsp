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
	ResultSet route = null;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Reservation</title>
</head>
	
	<%	
		if(session.getAttribute("username") == null){
			out.print("Please log in first.");
			response.sendRedirect("Login.jsp");
			} 
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
			
	%>
	<br>
<%
	if(session.getAttribute("username") ==null){
%>
<a href="Login.jsp">Back to Log in Page</a>
<%}else{%>
<a href="Welcome_Customer.jsp">Back to Welcome Page</a>
<%} %>
	<!-- <script type="text/javascript">
		function setOrigion(){
			//var value = selectObject.value;
			var sel = document.getElementsByName("Origin");
			var index = sel.selectedIndex;
			
			//var selvalue = sel.options[sel.options.selectedIndex].value;
			alter(sel);
		}
	</script>
	
	<script type="text/javascript">
		function setDestination(){
			//var value = selectObject.value;
			var sel = document.getElementsByName("Destination").value;
			//var selvalue = sel.options[sel.options.selectedIndex].value;
			return sel;
		}
	</script> -->
	<form method="post" action="reservationProcess.jsp">
	<h1>Reservation</h1>

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
		<%-- <%
			String origin_info = request.getParameter("Origin");
			String destination_info = request.getParameter("Destination");
			if(origin_info == null && destination_info == null) selected = false;
			else{ 
				PreparedStatement ps = con.prepareStatement(Tools.big_query);
				ps.setString(1, origin_info.split("-")[0]);
				ps.setString(2, destination_info.split("-")[0]);
				available = ps.executeQuery();
			}
			date = stmt.executeQuery("SELECT departure_time FROM TrainTicketing.Stop");
		%> --%>
		<%-- <script type="text/javascript">
			function setOrigin(){
				var oSelected = document.getElementById('Origin').value;
				//var selectValue = oSelected.options[oSelected.selectedIndex].value;
				session.setAttribute("Origin",oSelected);
			}
		</script>
		<%
			String temp2 = (String)session.getAttribute("Origin");
		%> --%>
		<br>
		<div><b>Transit Line</b></div>
		<select name="Transit_line">
		<%
			route = stmt.executeQuery("select transit_line_name from TrainTicketing.Train_schedule");
			while(route.next()){%>
				<option><%=route.getString(1)%></option>
		<%} %>
		
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
		<%
			
		%>
		
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
		<!-- <br>
		<b>Departure Time</b>
		<select>
			
		</select> -->
		
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
				representative = stmt.executeQuery("select e.First_name,e.last_name, e.username from TrainTicketing.Employee e, TrainTicketing.Customer_representative c where e.SSN = c.SSN;");
			%>
			<% while(representative.next()){ %>
				<option><%= representative.getString(1) + " " + representative.getString(2) + " (username: "+ representative.getString(3)+")"%> </option>
			<%}%>
			<%representative.close();%>
		
		</select>
		<br>
	    <input type="submit" value="submit">
	</form>
	
	
	
	

</html>