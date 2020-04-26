<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>   
<%
    String redirectURL = "Login.jsp";
	if(session.getAttribute("username") == null){response.sendRedirect(redirectURL);}
%>
<style>
  form { display: inline; }
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Trip Detail</title>
<h1>Trip Detail</h1>
</head>
<body>
	<%
		Object obj = session.getAttribute("current_tupples");
		if(obj == null)	response.sendRedirect("Search.jsp");
		List<QueryResultTuple> tuples = (List<QueryResultTuple>)obj;
		int counter = 0;
		String button_index = null;
		for(QueryResultTuple tuple : tuples){
			button_index = request.getParameter("tuple_num" + counter);
			if(button_index != null)	break;
			counter++;
		}
		if(button_index == null)	response.sendRedirect("Search.jsp");
		
		//get tuple that correspond to clicked button
		QueryResultTuple clicked_tuple = tuples.get(counter);
		session.setAttribute("clicked_trip", clicked_tuple); 

	%>
	
	<%
		//get database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		PreparedStatement ps = con.prepareStatement(Tools.stop_info_query);
		PreparedStatement fares =  con.prepareStatement(Tools.fare_query);
		ps.setString(1, clicked_tuple.getTrainsit_line_name());
		fares.setString(1, clicked_tuple.getTrainsit_line_name());

		//ask SQL		
		ResultSet rs = ps.executeQuery();
		ResultSet fare_result = fares.executeQuery();
	%>		
	<b>train ID:</b>	
	<b><%= "#" + clicked_tuple.getTrain_ID() %></b>
	<br>
	<b>transit line name:</b>	
	<b><%= clicked_tuple.getTrainsit_line_name() %></b>
	<br>
	<b>from:</b>
	<b><%= clicked_tuple.getOrigin_station_name() + "-" + clicked_tuple.getOrigin_city() + "-" + clicked_tuple.getOrigin_state() %></b>
	<br>
	<b>to:</b>
	<b><%= clicked_tuple.getDestination_station_name() + "-" + clicked_tuple.getDestination_city() + "-" + clicked_tuple.getDestination_state() %></b>
	<br>
	<b>fair:</b>
	<b><%= "economy: " +  clicked_tuple.getEconomy_fare() +"/ bussiness: " + clicked_tuple.getBussiness_fare() + "/ first " + clicked_tuple.getFirst_fare() %></b>
	<br>
	<b>date:</b>
	<b><%= clicked_tuple.getDate() %></b>
	<br>
	<b>seats:</b>
	<b><%= clicked_tuple.getAvailable() + "/" + clicked_tuple.getTrain_max_seats() %></b>
	<% fare_result.next(); %>
	<br>
	<b>discount rate:</b>
	<b><%= "senior: "  +  fare_result.getFloat(2) +"/ children: " + fare_result.getFloat(3) + "/ disabled: "  + fare_result.getFloat(4)%></b>
	<br>
	<br>
	<table>
		<thead>
			<tr>		
				<th>class</th>
				<th>monthly</th>
				<th>weekly</th>
				<th>one way</th>
				<th>round trip</th>		
		</thead>
		<%= Tools.getFareHtml(fare_result) %>
	</table>
	<br>
	<table>
		<thead>
			<tr>		
				<th>station ID</th>
				<th>station name</th>
				<th>arrival time</th>
				<th>departure time</th>		
		</thead>
		<%  while(rs.next()){ %>
            <tr><%= Tools.generateRowForStop(rs) %></tr>
        <% } %>
	</table>
	<br>
	<div align="right">
		<form action="Search.jsp">	
			<input type="submit" value="back" align="right">
		</form>
		<form action="Reservation.jsp">	
			<input type="submit" value="reserve" align="right">
		</form>
	</div>
	<%
	//close connection
		fares.close();
		rs.close();
		ps.close();
		con.close();
	%>
</body>
</html>