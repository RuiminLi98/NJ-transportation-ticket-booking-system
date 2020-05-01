<style><%@include file="/WEB-INF/css/blackStyle.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.sql.Date,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
double discountNum = 1.0;
double fare = 0.0;
double total_fare = 0.0;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

			<% 
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				//Create a SQL statement
				Statement stmt = con.createStatement();
				int rsid = Integer.parseInt(request.getParameter("reservation_num"));
				String user_type_str = (String)session.getAttribute("type");
				String username_str = request.getParameter("customer_name");
				String query = null;
						String depart = request.getParameter("Origin");
						String arrival = request.getParameter("Destination");
						String ticketClass = request.getParameter("Class");
						ResultSet originalSeat = stmt.executeQuery("SELECT seat_number FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";");
						originalSeat.next();
						int originalSeatNum = originalSeat.getInt(1);
						originalSeat.close();
						int seatnum = Integer.parseInt(request.getParameter("seat_number"));
						String type = request.getParameter("Type");
						String discount = request.getParameter("Discount");
						String representative = request.getParameter("Representative");
						int ssn =0;
						boolean assist = false;
						if(!representative.equals("None")){
							String[] splited = representative.split(" ");
							String repFirstName = splited[0];
							String repLastName = splited[1];
							ResultSet rep = stmt.executeQuery("SELECT SSN FROM TrainTicketing.Employee where First_name='"+repFirstName+"'and last_name='"+repLastName+"';");
							rep.next();
							ssn = rep.getInt("SSN");
							rep.close();
							assist = true;
						}
						double booking_fee = 1.0;
						PreparedStatement ps = con.prepareStatement(Tools.big_query);
						ps.setString(1, depart.split("-")[0]);
						ps.setString(2, arrival.split("-")[0]);
						ResultSet reservation = ps.executeQuery();
						Timestamp today = new Timestamp(System.currentTimeMillis());
						if(reservation.next()){
						int train_id = reservation.getInt(1);
						String train_line_name = reservation.getString(2);
						int origin_id = reservation.getInt(7);
						int destination_id = reservation.getInt(8);
						Date origin_date = Date.valueOf(request.getParameter("Date"));
 
						Date destination_date = Date.valueOf(request.getParameter("Date"));
 
						
						
						if(ticketClass.equals("Economy")){
							ResultSet econFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Economy_fare where transit_line_name ='"+reservation.getString(2)+"';");
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
							ResultSet bussFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Business_fare where transit_line_name ='"+reservation.getString(2)+"';");
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
							ResultSet firstFare = stmt.executeQuery("SELECT * FROM TrainTicketing.First_fare where transit_line_name ='"+reservation.getString(2)+"';");
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
						ResultSet discountRs = stmt.executeQuery("SELECT * FROM TrainTicketing.Fare where transit_line_name ='"+reservation.getString(2)+"';");
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
							sql = "UPDATE TrainTicketing.Reservation SET total_fare="+total_fare+",seat_number="+seatnum+",class='"+ticketClass+"',booking_fee="+booking_fee+",reservation_date=?"+",dep_Train_ID="+train_id+",dep_Transit_line_name='"+train_line_name+"',dep_Station_ID="+origin_id+",dep_Date=?"+",arr_Train_ID="+train_id+",arr_Transit_line_name='"+train_line_name+"',arr_Station_ID="+destination_id+",arr_date=?"+",assist_representative_SSN="+ssn+",type='"+type+"',discount='"+discount+"' WHERE reservation_number="+rsid+";";
						}else{
							sql = "UPDATE TrainTicketing.Reservation SET total_fare="+total_fare+",seat_number="+seatnum+",class='"+ticketClass+"',booking_fee="+booking_fee+",reservation_date=?"+",dep_Train_ID="+train_id+",dep_Transit_line_name='"+train_line_name+"',dep_Station_ID="+origin_id+",dep_Date=?"+",arr_Train_ID="+train_id+",arr_Transit_line_name='"+train_line_name+"',arr_Station_ID="+destination_id+",arr_date=?"+",type='"+type+"',discount='"+discount+"'WHERE reservation_number="+rsid+";";
						}
						PreparedStatement pstmt = con.prepareStatement(sql);
						pstmt.setTimestamp(1,today);
						pstmt.setDate(2,origin_date);
						pstmt.setDate(3,destination_date);
						pstmt.executeUpdate();
						
						String findSeat = "SELECT total_number_of_seats FROM TrainTicketing.Train WHERE train_ID="+train_id+";";
						ResultSet oldSeat = stmt.executeQuery(findSeat);
						oldSeat.next();
						int oldSeatNum = oldSeat.getInt(1);
						int newSeatNum = oldSeatNum +originalSeatNum - seatnum;
						oldSeat.close();
						if(newSeatNum < 0){
							out.print("You can reserve at most "+oldSeatNum+ " seats.");
							stmt.close();
							con.close();
							return;
						}else{
							String updateSeat = "UPDATE TrainTicketing.Train SET total_number_of_seats="+newSeatNum+" WHERE train_ID ="+train_id+";";
							//int insert = stmt.executeUpdate(insertQuery);
							int update = stmt.executeUpdate(updateSeat);
							stmt.close();
							con.close();
							response.sendRedirect("Customer_representative_SuccessfulEdit.jsp");
						}
						reservation.close();
						}else{
							response.sendRedirect("Customer_representative_EditFail.jsp");
							return;
						}
				
		%>
</body>
</html>