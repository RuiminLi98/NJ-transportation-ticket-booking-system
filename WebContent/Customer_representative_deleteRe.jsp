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
	int rsid = Integer.parseInt(request.getParameter("reservation"));
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT seat_number,dep_Train_ID FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";");
	rs.next();
	int seat = rs.getInt(1);
	int train_id = rs.getInt(2);
	rs.close();
	
	String query = "DELETE FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";";
	int delete = stmt.executeUpdate(query);
	
	
	
	ResultSet oldSeat = stmt.executeQuery("SELECT total_number_of_seats FROM TrainTicketing.Train WHERE train_ID="+train_id+";");
	oldSeat.next();
	int newSeat = seat+oldSeat.getInt(1);
	oldSeat.close();
	String update = "UPDATE TrainTicketing.Train SET total_number_of_seats="+newSeat+" WHERE train_ID="+train_id+";";
	int updateSeat = stmt.executeUpdate(update);
	if(updateSeat > 0){
		response.sendRedirect("Customer_R_Main.jsp");
	}
	
%>
</body>
</html>