<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 	
	double discountNum = 1.0;
	double fare = 0.0;
	double total_fare = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
	String username_str = request.getParameter("username");
	String password_str = request.getParameter("password");
	String user_type_str = request.getParameter("user_type");
	if(username_str == null || password_str == null || user_type_str == null
			|| username_str.isEmpty() || password_str.isEmpty()){
		out.print("username, password or user_type is empty");
		return;
	}else{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				String query = null;
				if(user_type_str.equals("Customer")){
					query = "select * from Customer where username='"+ username_str + 
							"' and password='" + password_str + "';";
					ResultSet result = stmt.executeQuery(query);
					boolean success = result.first();
					result.close();
					if(success){
						String depart = request.getParameter("Origin");
						session.setAttribute("Origin", depart);
						String arrival = request.getParameter("Destination");
						session.setAttribute("Destination", arrival);
						String ticketClass = request.getParameter("Class");
						session.setAttribute("Class",ticketClass);
						int seatnum = Integer.parseInt(request.getParameter("seat_number"));
						session.setAttribute("seat_number", seatnum);
						String type = request.getParameter("Type");
						session.setAttribute("Type",type);
						String discount = request.getParameter("Discount");
						session.setAttribute("Discount",discount);
						String representative = request.getParameter("Representative");
						session.setAttribute("Representative",representative);
						String[] splited = representative.split(" ");
						String repFirstName = splited[0];
						String repLastName = splited[1];
						ResultSet rep = stmt.executeQuery("SELECT SSN FROM TrainTicketing.Employee where First_name=‘"+repFirstName+"’and last_name=‘"+repLastName+"’;");
						int ssn = rep.getInt("SSN");
						double booking_fee = 1.0;
						PreparedStatement ps = con.prepareStatement(Tools.big_query);
						ps.setString(1, depart.split("-")[0]);
						ps.setString(2, arrival.split("-")[0]);
						ResultSet reservation = ps.executeQuery();
						Date today = new Date();
						int train_id = reservation.getInt(1);
						String train_line_name = reservation.getString(2);
						int origin_id = reservation.getInt(7);
						int destination_id = reservation.getInt(8);
						Date origin_date = reservation.getDate(4);
						Date destination_date = reservation.getDate(5);
						ResultSet econFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Economy_fare where transit_line_name =‘"+reservation.getString("Trainsit_line_name")+"’;");
						ResultSet bussFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Business_fare where transit_line_name =‘"+reservation.getString("Trainsit_line_name")+"’;");
						ResultSet firstFare = stmt.executeQuery("SELECT * FROM TrainTicketing.First_fare where transit_line_name =‘"+reservation.getString("Trainsit_line_name")+"’;");
						if(ticketClass.equals("Economy")){
							 if(type.equals("One Way")){
								 fare = econFare.getFloat("one_way_fee");
							 }else if(type.equals("Round Trip")){
								 fare = econFare.getFloat("round_trip_fee");
							 }else if(type.equals("Monthly Pass")){
								 fare = econFare.getFloat("monthly_fee");
							 }else{
								fare = econFare.getFloat("weekly_fee"); 
							 }
						}else if(ticketClass.equals("Business")){
							 if(type.equals("One Way")){
								 fare = bussFare.getFloat(4);
							 }else if(type.equals("Round Trip")){
								 fare = bussFare.getFloat(5);
							 }else if(type.equals("Monthly Pass")){
								 fare = bussFare.getFloat(2);
							 }else{
								fare = bussFare.getFloat(3); 
							 }
						}else{
							if(type.equals("One Way")){
								 fare = bussFare.getFloat(4);
							 }else if(type.equals("Round Trip")){
								 fare = bussFare.getFloat(5);
							 }else if(type.equals("Monthly Pass")){
								 fare = bussFare.getFloat(2);
							 }else{
								fare = bussFare.getFloat(3); 
							 }
						}
						ResultSet discountRs = stmt.executeQuery("SELECT * FROM TrainTicketing.Fare where transit_line_name =‘"+reservation.getString("Trainsit_line_name")+"’;");
						
						if(discount.equals("Senior")){
							discountNum = discountRs.getFloat(2);
						}else if(discount.equals("Children")){
							discountNum = discountRs.getFloat(3);
						}else if(discount.equals("Disabled")){
							discountNum = discountRs.getFloat(4);
						}
						econFare.close();
						bussFare.close();
						firstFare.close();
						discountRs.close();
						total_fare = fare*discountNum*seatnum;
						String insertQuery="INSERT INTO TrainTicketing.Reservation(total_fare,seat_number, class, booking_fare, reservation_date,dep_Train_ID, dep_Transit_line_name, dep_Station_ID, dep_Date, arr_Transit_line_name, arr_Station_ID, arr_date, assist_representative_SSN, customer_Username) values ("+total_fare+","+seatnum+",'"+ticketClass+"',"+today+","+train_id+",'"+train_line_name+"',"+origin_id+","+origin_date+","+train_id+",'"+train_line_name+"',"+destination_id+","+destination_date+","+ssn+",'"+username_str+"');";
						
						String findSeat = "SELECT total_number_of_seats FROM TrainTicketing.Train WHERE train_ID="+train_id+";";
						ResultSet oldSeat = stmt.executeQuery(findSeat);
						int oldSeatNum = oldSeat.getInt(1);
						int newSeatNum = oldSeatNum - seatnum;
						oldSeat.close();
						if(newSeatNum < 0){
							out.print("I can reserve at most "+oldSeatNum+ " seats.");
							stmt.close();
							con.close();
							return;
						}else{
							String updateSeat = "UPDATE TrainTicketing.Train SET total_number_of_seats="+newSeatNum+";";
							int insert = stmt.executeUpdate(insertQuery);
							stmt.close();
							con.close();
							response.sendRedirect("SuccessfulReservation.jsp");
						}
					}else{
						out.print("login failed");
					}
					
				}else{
					out.print("Invalid user type");
					return;
				}
				
			}
	%>
<a href="Login.jsp">back to login</a>
</body>
</html>