<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.util.Date.*,java.text.*" %>
<% 
ResultSet usernames=null;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String trainID_str = request.getParameter("train_ID");
		String new_trainID_str = request.getParameter("new_train_ID");
		String transit_line_name_str = request.getParameter("transit_line_name");
		String new_transit_line_name_str = request.getParameter("new_transit_line_name");
		String availableNumberofseats = request.getParameter("available_number_of_seats");
		String numberofStops = request.getParameter("number_of_stops");
		String departureTime = request.getParameter("departure_time");
		String arrivalTime = request.getParameter("arrival_time");
		String travelTime = request.getParameter("travel_time");
		
		Pattern p = Pattern.compile("(\\d\\d):(\\d\\d):(\\d\\d)");
		Matcher m1 = p.matcher(departureTime);
		Matcher m2 = p.matcher(arrivalTime);
		if(!m1.find() || !m2.find()){
			response.sendRedirect("Customer_representative_editScheduleFail.jsp");
			return;
		}
		java.sql.Time depTime = new java.sql.Time(Integer.parseInt(m1.group(1)),Integer.parseInt(m1.group(2)),Integer.parseInt(m1.group(3)));
		java.sql.Time arrTime = new java.sql.Time(Integer.parseInt(m2.group(1)),Integer.parseInt(m2.group(2)),Integer.parseInt(m2.group(3)));
		
        int origin_ID;
        int destination_ID;
		if(trainID_str == null || transit_line_name_str == null ||  numberofStops == null || departureTime == null || arrivalTime == null || travelTime == null ||
				trainID_str.isEmpty() || transit_line_name_str.isEmpty() ||  numberofStops.isEmpty() || departureTime.isEmpty() || arrivalTime.isEmpty() ||
				travelTime.isEmpty()){
			out.print("you must not leave empty field");
		}else{	
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			PreparedStatement insert = con.prepareStatement("UPDATE Train_schedule SET train_ID = ?, transit_line_name = ?, available_number_of_seats = ?, number_of_stops = ?, departure_time = ?, arrival_time = ?, travel_time = ? WHERE train_ID = ? AND transit_line_name = ?");
			insert.setInt(1, Integer.parseInt(new_trainID_str));
			insert.setString(2, new_transit_line_name_str);
			insert.setInt(3, Integer.parseInt(availableNumberofseats));
			insert.setInt(4, Integer.parseInt(numberofStops));
			insert.setTime(5, depTime);
			insert.setTime(6, arrTime);
			insert.setString(7, travelTime);
			insert.setInt(8, Integer.parseInt(trainID_str));
			insert.setString(9, transit_line_name_str);
			
			
			try{
				insert.executeUpdate();
			} catch (Exception e){
				response.sendRedirect("Customer_representative_editScheduleFail.jsp");
			}
			out.println("Edit schedule successful");
			
			
			//Alert for customers that booked this line
			PreparedStatement Customers=con.prepareStatement("select distinct customer_Username from Reservation r where r.dep_Train_ID=? and r.dep_Transit_line_name=?;");
			Customers.setInt(1, Integer.parseInt(trainID_str));
			Customers.setString(2, transit_line_name_str);
			usernames=Customers.executeQuery();
			
			
			while(usernames.next()){
				PreparedStatement Alert=con.prepareStatement("INSERT INTO `TrainTicketing`.`Questions` (`Customer`, `Question`, `Response`) VALUES (?, 'Alert', 'Your Train Schedule "+transit_line_name_str+" has some changes!'); ");
				Alert.setString(1, usernames.getString(1));
				
				
				Alert.executeUpdate();
				Alert.close();
				
			}
			
			//close connection
			Customers.close();
			stmt.close();
			con.close();
			usernames.close();
		}
	%>
<br>
<a href="Customer_representative_addSchedule.jsp">back</a>
</body>
</html>