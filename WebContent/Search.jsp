<style><%@include file="/WEB-INF/css/style.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>    
<%
	ResultSet dates = null;
	ResultSet allCitySet = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search</title>
</head>
<%
	//get database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//ask SQL
	allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
%>
<form method="post" action="Search.jsp">
    <h1>Search</h1>
    	<b>origin:</b>
        <select name="origin">
        <%  while(allCitySet.next()){ %>
            <option <%=Tools.process_default_select(request.getParameter("origin"),allCitySet.getString(1) + "-" + allCitySet.getString(2)) %>><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
        <% } %>
        </select>
        <b>destination:</b>
        
        <select name="destination">
        <%
    	allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
        %>
        
        <%  while(allCitySet.next()){ %>
            <option  <%=Tools.process_default_select(request.getParameter("destination"),allCitySet.getString(1) + "-" + allCitySet.getString(2)) %>><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
        <% } %>
        </select>
        
        <%
    		allCitySet.close();
    		dates = stmt.executeQuery("SELECT departure_time FROM TrainTicketing.Train_schedule;");
        %>
        
        <b>Sorting by:</b>
        <select name="sort">
				<option value="train_ID">train_ID</option>
				<option value="line_name">line name</option>
				<option value="origin_arrival_time">origin_arrival_time</option>
				<option value="origin_departure_time">origin_departure_time</option>
				<option value="destination_arrival_time">destination_arrival_time</option>
				<option value="destination_departure_time">destination_departure_time</option>
				<option value="economy_fare">economy fare</option>
				<option value="business_fare">business fare</option>
				<option value="first fare">first fare</option>
				<option value="origin_name">origin name</option>
				<option value="destination_name">destination name</option>
				<option value="available">available</option>
				<option value="date">date</option>
		</select>
		<input type="date" id="start" name="depature_date" value=<%= Tools.getTodayDateString() %>>        
		
        <b>approximate search date:</b>
		<input type="checkbox" value="true" name="approximate" />
		
		<input type="submit" value="search">
</form>
<%
	ResultSet reservation_count = 
	stmt.executeQuery("select dep_Train_ID, dep_Transit_line_name, sum(seat_number), dep_date from Reservation group by dep_Train_ID, dep_Transit_line_name, dep_date;");

%>

<%
	String origin_info = request.getParameter("origin");
	String destination_info = request.getParameter("destination");
	String date_info = request.getParameter("depature_date");
	boolean approximate_boolean = request.getParameterValues("approximate") == null? false:true;
	String sorting_by = request.getParameter("sort");
	List<QueryResultTuple> tuples = null;
	if(origin_info == null || destination_info == null || date_info == null || sorting_by == null)	return;
	else{
		PreparedStatement ps = con.prepareStatement(Tools.big_query);
		ps.setString(1, origin_info.split("-")[0]);
		ps.setString(2, destination_info.split("-")[0]);
		ResultSet available = ps.executeQuery();
		tuples = Tools.limit_date(Tools.resultSetToList(available), approximate_boolean, reservation_count, date_info);
		Tools.sort(tuples, sorting_by);
		session.setAttribute("current_tupples", tuples); 
		
		//close
		available.close();
		ps.close();
	}
%>
<body>
	<table>
	<thead>
		<tr>		
				<th>train_ID</th>
				<th>line name</th>
				<th>origin arrival</th>
				<th>origin departure</th>
				<th>destination arrival</th>
				<th>destination departure</th>
				<th>economy fare</th>
				<th>business fare</th>
				<th>first fare</th>
				<th>origin</th>
				<th>destination</th>
				<th>available</th>
				<th>date</th>
				<th>detail</th>
		</tr>
		<%= Tools.toHtml(tuples) %>
	</table>
<%
	//close connection
	dates.close();
	stmt.close();
	con.close();
%>
</body>
</html>