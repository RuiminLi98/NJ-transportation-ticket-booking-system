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
<title>Insert title here</title>
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
    <h1>search</h1>
    	<b>origin:</b>
        <select name="origin">
        <%  while(allCitySet.next()){ %>
            <option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
        <% } %>
        </select>
        <b>destination:</b>
        <select name="destination">
        
        <%
    	allCitySet = stmt.executeQuery("SELECT city,state FROM TrainTicketing.Station;");
        %>
        
        <%  while(allCitySet.next()){ %>
            <option><%= allCitySet.getString(1) + "-" + allCitySet.getString(2) %></option>
        <% } %>
        </select>
        
        <%
    		allCitySet.close();
    		dates = stmt.executeQuery("SELECT departure_time FROM TrainTicketing.Train_schedule;");
        %>
        
        <b>departure date:</b>
		<input type="date" id="start" name="depature_date" value="2020-04-22">        
        <b>approximate search date:</b>
		<input type="checkbox" value="true" name="approximate" />
		
		<input type="submit" value="search">
</form>
<%
	ResultSet reservation_count = 
	stmt.executeQuery("select dep_Train_ID, dep_Transit_line_name, count(*), dep_date from Reservation group by dep_Train_ID, dep_Transit_line_name, dep_date;");

%>

<%
	String origin_info = request.getParameter("origin");
	String destination_info = request.getParameter("destination");
	String date_info = request.getParameter("depature_date");
	boolean approximate_boolean = request.getParameterValues("approximate") == null? false:true;
	List<QueryResultTuple> tuples = null;
	if(origin_info == null || destination_info == null || date_info == null)	return;
	else{	//construct query
		PreparedStatement ps = con.prepareStatement(Tools.big_query);
		ps.setString(1, origin_info.split("-")[0]);
		ps.setString(2, destination_info.split("-")[0]);
		//out.print(ps);
		ResultSet available = ps.executeQuery();
		//out.print(available);
		//out.print(Arrays.toString((Tools.resultSetToList(available)).toArray()));

		tuples = Tools.limit_date(Tools.resultSetToList(available), approximate_boolean, reservation_count, date_info);
		//out.println("-----------");
		//out.println(Tools.toJsArray(tuples));
		//out.println("-----------");
	}
%>
<body>
	<table>
	<thead>
		<tr>		
				<th>train_ID</th>
				<th>line name</th>
				<th>origin_arrival_time</th>
				<th>origin_departure_time</th>
				<th>destination_arrival_time</th>
				<th>destination_departure_time</th>
				<th>economy fare</th>
				<th>business fare</th>
				<th>first fare</th>
				<th>origin name</th>
				<th>destination name</th>
				<th>available</th>
				<th>date</th>
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