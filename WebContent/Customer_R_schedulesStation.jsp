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
	List<QueryResultTuple> tuples = null;
	//ask SQL
	allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
%>
<form method="post" action="Customer_R_schedulesStation.jsp">
	<b>Input the name:</b>
 
        <select name="station">
        <%  while(allCitySet.next()){ %>
            <option <%=Tools.process_default_select(request.getParameter("station"),allCitySet.getString(1) + "-" + allCitySet.getString(2)) %>><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
        <% } %>
        </select>
<br>
<br>
	<b>as origin or destination:</b>
        <select name="station_type">
		<option> origin</option>
		<option> destination</option>
        </select>
        
<%
   allCitySet.close();
 %>
  <table>
 <tr><td>train_ID</td><td>transit_line_name</td><td>available_number_of_seats</td><td>number_of_stops</td><td>departure_time</td><td>arrival_time</td><td>travel_time</td></tr>


 
 <%
 	String station_temp=request.getParameter("station_type"); 
 
 if(station_temp != null && station_temp.equals("origin")){
 
	String origin_str=request.getParameter("station");
	PreparedStatement element = con.prepareStatement("select t.* from TrainTicketing.Train_schedule t, TrainTicketing.Route r, TrainTicketing.Station s WHERE t.transit_line_name LIKE r.transit_line_name AND r.origin_station_ID = s.station_ID AND s.city LIKE ?;");
	element.setString(1, origin_str.split("-")[0]);
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
<% } %> 

<% } 
 if(station_temp != null && station_temp.equals("destination")){
 
	String destination_str=request.getParameter("station");
	PreparedStatement element = con.prepareStatement("select t.* from TrainTicketing.Train_schedule t, TrainTicketing.Route r, TrainTicketing.Station s WHERE t.transit_line_name LIKE r.transit_line_name AND r.destination_station_ID = s.station_ID AND s.city LIKE ?;");
	element.setString(1, destination_str.split("-")[0]);
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
<% } %> 
<% } %> 
 </table>

       <input type="submit" value="submit">
</form>

<input type="button" onclick="test87()" value="Exit" />
<script ...>
function test87(){
 var url = "Customer_R_Main.jsp";
 window.location.href= url;
}
</script>
 

</body>
</html>