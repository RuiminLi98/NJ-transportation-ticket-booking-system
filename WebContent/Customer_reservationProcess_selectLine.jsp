<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.sql.Date,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	String username_str = (String)session.getAttribute("Customer_reservation_username");
	String depart = (String)session.getAttribute("Customer_reservation_depart");
	int dep_station_id = Integer.parseInt((String)session.getAttribute("Customer_reservation_depart_id"));
	String arrival = (String)session.getAttribute("Customer_reservation_arrival");
	int arr_station_id = Integer.parseInt((String)session.getAttribute("Customer_reservation_arrival_id"));
	String ticketClass = (String)session.getAttribute("Customer_reservation_ticketClass");
	int seatnum = Integer.parseInt((String)session.getAttribute("Customer_reservation_seatnum"));
	String type = (String)session.getAttribute("Customer_reservation_type");
	String discount = (String)session.getAttribute("Customer_reservation_discount");
	String representative = (String)session.getAttribute("Customer_reservation_representative");
	String date_string = (String)session.getAttribute("Customer_reservation_date");
	int ssn = Integer.parseInt((String)session.getAttribute("Customer_reservation_ssn"));
	boolean assist = !(ssn == -1);
	
		String transit_line_name = request.getParameter("line");
		int train_ID = Integer.parseInt(request.getParameter("train_id"));
	
		Date origin_date = Date.valueOf(date_string);
		Timestamp today = new Timestamp(System.currentTimeMillis());
		double discountNum = 1.0;
		double fare = 0.0;
		double total_fare = 0.0;
		double booking_fee = 1.0;
		
		/* ResultSet dest_rs = stmt.executeQuery("SELECT arrival_time from TrainTicketing.Stop where station_ID ="+destination_id+";");
		dest_rs.next(); */
		Date destination_date = origin_date;
		//out.print(reservation.getString(2));
		//reservation.close();
		if(ticketClass.equals("Economy")){
			ResultSet econFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Economy_fare where transit_line_name ='"+transit_line_name+"';");
			econFare.next();
			 if(type.equals("One Way")){
				 fare = econFare.getFloat("one_way_fee");
			 }else if(type.equals("Round Trip")){
				 fare = econFare.getFloat("round_trip_fee");
			 }else if(type.equals("Monthly Pass")){
				 fare = econFare.getFloat("monthly_fee");
			 }else{
				fare = econFare.getFloat("weekly_fee"); 
			 }
			 econFare.close();
		}else if(ticketClass.equals("Business")){
			ResultSet bussFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Business_fare where transit_line_name ='"+transit_line_name+"';");
			bussFare.next();
			 if(type.equals("One Way")){
				 fare = bussFare.getFloat(4);
			 }else if(type.equals("Round Trip")){
				 fare = bussFare.getFloat(5);
			 }else if(type.equals("Monthly Pass")){
				 fare = bussFare.getFloat(2);
			 }else{
				fare = bussFare.getFloat(3); 
			 }
			 bussFare.close();
		}else{
			ResultSet firstFare = stmt.executeQuery("SELECT * FROM TrainTicketing.First_fare where transit_line_name ='"+transit_line_name+"';");
			firstFare.next();
			if(type.equals("One Way")){
				 fare = firstFare.getFloat(4);
			 }else if(type.equals("Round Trip")){
				 fare = firstFare.getFloat(5);
			 }else if(type.equals("Monthly Pass")){
				 fare = firstFare.getFloat(2);
			 }else{
				fare = firstFare.getFloat(3); 
			 }
			firstFare.close();
		}
		ResultSet discountRs = stmt.executeQuery("SELECT * FROM TrainTicketing.Fare where transit_line_name ='"+transit_line_name+"';");
		discountRs.next();
		if(discount.equals("Senior")){
			discountNum = discountRs.getFloat(2);
		}else if(discount.equals("Children")){
			discountNum = discountRs.getFloat(3);
		}else if(discount.equals("Disabled")){
			discountNum = discountRs.getFloat(4);
		}
		discountRs.close();
	
		total_fare = fare*discountNum*seatnum+booking_fee;
		String sql;
		if(assist){
			sql = "INSERT INTO TrainTicketing.Reservation(total_fare,seat_number, class, booking_fee, reservation_date,dep_Train_ID, dep_Transit_line_name, dep_Station_ID, dep_Date, arr_Train_ID,arr_Transit_line_name, arr_Station_ID, arr_date, assist_representative_SSN, customer_Username, type, discount) values ("+total_fare+","+seatnum+",'"+ticketClass+"',"+booking_fee+","+"?,"+train_ID+",'"+transit_line_name+"',"+dep_station_id+","+"?,"+train_ID+",'"+transit_line_name+"',"+arr_station_id+","+"?,"+ssn+",'"+username_str+"','"+type+"','"+discount+"'"+");";
		}else{
			sql = "INSERT INTO TrainTicketing.Reservation(total_fare,seat_number, class, booking_fee, reservation_date,dep_Train_ID, dep_Transit_line_name, dep_Station_ID, dep_Date, arr_Train_ID,arr_Transit_line_name, arr_Station_ID, arr_date,customer_Username, type, discount) values ("+total_fare+","+seatnum+",'"+ticketClass+"',"+booking_fee+","+"?,"+train_ID+",'"+transit_line_name+"',"+dep_station_id+","+"?,"+train_ID+",'"+transit_line_name+"',"+arr_station_id+","+"?"+",'"+username_str+"','"+type+"','"+discount+"'"+");";
		}
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setTimestamp(1,today);
		pstmt.setDate(2,origin_date);
		pstmt.setDate(3,destination_date);
		try{
		pstmt.executeUpdate();}
		catch(Exception exp){out.println("The input information is not correct");return;}
		String findSeat = "SELECT total_number_of_seats FROM TrainTicketing.Train WHERE train_ID="+train_ID+";";
		ResultSet oldSeat = stmt.executeQuery(findSeat);
		oldSeat.next();
		int oldSeatNum = oldSeat.getInt(1);
		int newSeatNum = oldSeatNum - seatnum;
		oldSeat.close();
		if(newSeatNum < 0){
			out.print("I can reserve at most "+oldSeatNum+ " seats.");
			stmt.close();
			con.close();
			return;
		}else{
			String updateSeat = "UPDATE TrainTicketing.Train SET total_number_of_seats="+newSeatNum+" WHERE train_ID ="+train_ID+";";
			//int insert = stmt.executeUpdate(insertQuery);
			try{
			int update = stmt.executeUpdate(updateSeat);
			}catch(Exception e){
				out.println("The input information is incorrect");return;
			}
			stmt.close();
			con.close();
			response.sendRedirect("customer_representative_SuccessfulReservation.jsp");
		}
%>
</body>
</html>