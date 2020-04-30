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
<form method="post" action="Customer_R_schedulesForOandD.jsp">

    <h1>Search by Origin and Destination</h1>
    	<b>origin:</b>
        <select name="origin">
        <%  while(allCitySet.next()){ %>
            <option <%=Tools.process_default_select(request.getParameter("origin"),allCitySet.getString(1) + "-" + allCitySet.getString(2)) %>><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
        <% } %>
        </select>
        <% allCitySet.close(); %>
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
        %>
       <input type="submit" value="submit">
 </form>
 
 <% if(request.getParameter("origin") != null && request.getParameter("destination") != null){ %>
 
 <table>
 <tr><td>train_ID</td><td>transit_line_name</td><td>available_number_of_seats</td><td>number_of_stops</td><td>departure_time</td><td>arrival_time</td><td>travel_time</td></tr>
 <% 
 	String origin_str=request.getParameter("origin");
 	String destination_str=request.getParameter("destination");
	PreparedStatement element = con.prepareStatement("select t.* from TrainTicketing.Train_schedule t, TrainTicketing.Route r, TrainTicketing.Station s1, TrainTicketing.Station s2 WHERE t.transit_line_name LIKE r.transit_line_name AND r.origin_station_ID = s1.station_ID AND r.destination_station_ID = s2.station_ID AND s1.city LIKE ? AND s2.city LIKE ? ;");
	element.setString(1, origin_str.split("-")[0]);
	element.setString(2, destination_str.split("-")[0]);
// 	out.print(origin_str.split("-")[0]);
	ResultSet result = element.executeQuery(); 
	while(result.next()){
		int l1=result.getInt(1);
		String l2=result.getString(2);
		int l3=result.getInt(3);
		int l4=result.getInt(4);
		Time l5=result.getTime(5);
		Time l6=result.getTime(6);
		String l7=result.getString(7);
 %>
 
 <tr>				<td><% out.print(l1); %></td>
 					<td><% out.print(l2); %></td>
 					<td><% out.print(l3); %></td>
 					<td><% out.print(l4); %></td>
 					<td><% out.print(l5); %></td>
 					<td><% out.print(l6); %></td>
 					<td><% out.print(l7); %></td> 					 
 </tr>
 
 </table>
 <% } %>
 <% } %>

<input type="button" onclick="test87()" value="Exit" />
<script ...>
function test87(){
 var url = "Customer_R_Main.jsp";
 window.location.href= url;
}
</script>
 
 
</body>
</html>