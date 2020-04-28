 

<style><%@include file="/WEB-INF/css/blackStyle.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
ResultSet rs=null;
String origin = null;
String destination=null;
String dep_time = null;
String arr_time = null;
int ID;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Reservation</title>
</head>
<body>
<form method="get">
	<h1>My Reservation</h1>
		<table>
			<tr>
				<td><b>Origin</b></td>
				<td><b>Destination</b></td>
				<td><b>Departure Time</b></td>
				<td><b>Arrival Time</b></td>
				<td><b>Reservation Date</b></td>
				<td><b>Total Fare</b></td>
				<td><b>View</b></td>
				<td><b>Cancel</b></td>
			</tr>
			
			<%
			String customerName=request.getParameter("customer_name");
					out.println("welcome: " + customerName);
			if(customerName == null){
				out.print("Please log in first.");
				response.sendRedirect("Login.jsp");
				return;
				} 
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
			
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String username = customerName;
				String sql = "select t1.reservation_number, t1.origin_city, t1.origin_state,t1.dep_date, t1.arr_date, t2.dest_city, t2.dest_state, t1.dep_time, t2.arr_time, t1.total_fare, t1.reservation_date from(select r.reservation_number, s.city as origin_city, s.state as origin_state, r.dep_date, r.arr_date, st.departure_time as dep_time, r.total_fare, r.reservation_date from TrainTicketing.Reservation as r, TrainTicketing.Station as s, TrainTicketing.Stop as st where r.dep_Station_ID = s.station_ID and s.station_ID = st.station_ID and customer_username='"+username+"'"+")t1 join (select r.reservation_number, s.city as dest_city, s.state as dest_state, st.arrival_time as arr_time from TrainTicketing.Reservation as r, TrainTicketing.Station as s, TrainTicketing.Stop as st where r.arr_Station_ID = s.station_ID and st.station_ID = s.station_ID and customer_username='"+username+"'"+")t2 on t1.reservation_number = t2.reservation_number";
				rs = stmt.executeQuery(sql);
				
				
			%> 
			<% while(rs.next()){%>
				<tr>
					<%
						origin = rs.getString(2)+"-"+rs.getString(3);
						destination = rs.getString(6)+"-"+rs.getString(7);
						SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
						SimpleDateFormat timeF = new SimpleDateFormat("hh:mm");
						dep_time = dateF.format(rs.getDate(4))+" "+timeF.format(rs.getTimestamp(8));
						arr_time = dateF.format(rs.getDate(5))+" "+timeF.format(rs.getTimestamp(9));
						ID = rs.getInt(1);
					%>
					<td><%=origin %></td>
					<td><%=destination%></td>
					<td><%=dep_time%></td>
					<td><%=arr_time%></td>
					<td><%=rs.getDate(11)%></td>
					<td><%=rs.getFloat(10) %></td>
					<td> <a href="Customer_re_editIndivResv.jsp?reservation=<%=ID%>">Edit</a></td>
					
 
					
					
				</tr>
			<%} %>
		</table>
		<%
		rs.close();
		stmt.close();
		con.close();
		%>
<input type="button" onclick="test7()" value="Exit" />
<script ...>
function test7(){
 var url = "Customer_R_Main.jsp";
 window.location.href= url;
}


</script>
</form>
</body>
</html>

