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

<title>Search customer by given transit line</title>
</head>
<%
	//get database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
%>
	<form method="post" action="Customer_R_customersForTransitLine.jsp">
    <h1>Search customer by given transit line</h1>
	<b>TransitLine:</b><br>
	<input type="text" name="transit_line"  min= 1 required><br>
    <input type="submit" value="submit">
</form>
<table>
 <tr><td>username</td><td>first_name</td><td>last_name</td><td>email</td><td>address</td><td>city</td><td>state</td><td>zip_code</td><td>telephone</td><td>password</td></tr>
 <% 
 if(request.getParameter("transit_line") != null  ){
 	String transit_line_temp=request.getParameter("transit_line");
	PreparedStatement element = con.prepareStatement("SELECT c.* FROM TrainTicketing.Reservation r, TrainTicketing.Train_schedule t, TrainTicketing.Customer c WHERE t.transit_line_name = r.arr_Transit_line_name AND r.customer_Username LIKE c.username AND t.transit_line_name = ? UNION SELECT c.* FROM TrainTicketing.Reservation r, TrainTicketing.Train_schedule t, TrainTicketing.Customer c WHERE t.transit_line_name = r.dep_Transit_line_name AND r.customer_Username LIKE c.username AND t.transit_line_name = ? ;");
	element.setString(1, transit_line_temp);
	element.setString(2,transit_line_temp);
	ResultSet result = element.executeQuery(); 
	while(result.next()){
		String l1=result.getString(1);
		String l2=result.getString(2);
		String l3=result.getString(3);
		String l4=result.getString(4);
		String l5=result.getString(5);
		String l6=result.getString(6);
		String l7=result.getString(7);
		String l8=result.getString(8);
		String l9=result.getString(9);
		String l10=result.getString(10);
%>

<tr>				<td><% out.print(l1); %></td>
					<td><% out.print(l2); %></td>
					<td><% out.print(l3); %></td>
					<td><% out.print(l4); %></td>
					<td><% out.print(l5); %></td>
					<td><% out.print(l6); %></td>
					<td><% out.print(l7); %></td> 	
					<td><% out.print(l8); %></td>
					<td><% out.print(l9); %></td>
					<td><% out.print(l10); %></td> 					 
</tr>


<% } %>
 <% } %>
	</table>
<input type="button" onclick="test87()" value="Exit" />
<script ...>
function test87(){
 var url = "Customer_R_Main.jsp";
 window.location.href= url;
}
</script>




</body>
</html>