<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete</title>
</head>
<body>
<%
	int rsid = Integer.parseInt(request.getParameter("id"));
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT seat_number,dep_Train_ID FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";");
	String query = "DELETE FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";";
	int delete = stmt.executeUpdate(query);
	
	ResultSet oldSeat = stmt.executeQuery("SELECT total_number_of_seats FROM TrainTicketing.Train WHERE train_ID="+rs.getInt(2)+";");
	int newSeat = rs.getInt(1)+oldSeat.getInt(1);
	oldSeat.close();
	
	int updateSeat = stmt.executeUpdate("UPDATE TrainTicketing.Train SET total_number_of_seats="+newSeat+"WHERE train_ID="+rs.getInt(2)+";");
	rs.close();
	
%>
</body>
</html>