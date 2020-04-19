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
<body>
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
        
        <b>departure date</b>
        <select name="depature_date">
        <%  while(dates.next()){ %>
            <option><%= dates.getTimestamp(1)%></option>
        <% } %>
        </select>
        <b>approximate search date:</b>
		<input type="checkbox" value="true" name="approximate" />
		<input type="submit" value="search">
</form>

<%
	String origin_info = request.getParameter("origin");
	String destination_info = request.getParameter("destination");
	String date_info = request.getParameter("depature_date");
	boolean approximate_boolean = request.getParameterValues("approximate") == null? false:true;
	out.println(origin_info);
	out.println(destination_info);
	out.println(date_info);
	out.println(approximate_boolean);
	if(origin_info == null || destination_info == null || date_info == null)	return;
	else{	//construct query
		PreparedStatement ps = con.prepareStatement(Tools.big_query);
		ps.setString(1, origin_info.split("-")[0]);
		ps.setString(2, destination_info.split("-")[0]);
		if(approximate_boolean){
			
		}else{
			
		}
		
	}
%>

<%
	//close connection
	dates.close();
	stmt.close();
	con.close();
%>
</html>

		