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
				String username_str = (String)session.getAttribute("username");
				String query = null;
				if(user_type_str.equals("Customer")){
					/*query = "select * from Customer where username='"+ username_str + 
							"' and password='" + password_str + "';";
					ResultSet result = stmt.executeQuery(query);
					boolean success = result.first();
					result.close(); */
					/* if(success){ */
						String depart = request.getParameter("Origin");
						//session.setAttribute("Origin", depart);
						String arrival = request.getParameter("Destination");
						//session.setAttribute("Destination", arrival);
						String ticketClass = request.getParameter("Class");
						//session.setAttribute("Class",ticketClass);
						ResultSet originalSeat = stmt.executeQuery("SELECT seat_number FROM TrainTicketing.Reservation WHERE reservation_number="+rsid+";");
						originalSeat.next();
						int originalSeatNum = originalSeat.getInt(1);
						originalSeat.close();
						int seatnum = Integer.parseInt(request.getParameter("seat_number"));
						//session.setAttribute("seat_number", seatnum);
						String type = request.getParameter("Type");
						//session.setAttribute("Type",type);
						String discount = request.getParameter("Discount");
						//session.setAttribute("Discount",discount);
						String representative = request.getParameter("Representative");
						//session.setAttribute("Representative",representative);
						String transit_line = request.getParameter("Transit_line");
						int ssn =0;
						boolean assist = false;
						if(!representative.equals("None")){
							int idx = Tools.findUsername(representative);
							String[] splited = representative.split(" ");
							String repFirstName = splited[0];
							String repLastName = splited[1];
							String temp = splited[3];
							String cpusername = representative.substring(idx,representative.length()-1);
							ResultSet rep = stmt.executeQuery("SELECT SSN FROM TrainTicketing.Employee where First_name='"+repFirstName+"'and last_name='"+repLastName+"' and username='"+cpusername+"';");
							rep.next();
							ssn = rep.getInt("SSN");
							rep.close();
							assist = true;
						}
						double booking_fee = 1.0;
						/* PreparedStatement ps = con.prepareStatement(Tools.big_query);
						ps.setString(1, depart.split("-")[0]);
						ps.setString(2, arrival.split("-")[0]);
						ResultSet reservation = ps.executeQuery(); */
						Timestamp today = new Timestamp(System.currentTimeMillis());
						
						String findOrigin = "SELECT station_ID FROM TrainTicketing.Station WHERE city='"+depart.split("-")[0]+"' and state='"+depart.split("-")[1]+"';";
						ResultSet originRS = stmt.executeQuery(findOrigin);
						int dep_station_id=0;
						if(originRS.next()){
							dep_station_id = originRS.getInt(1);
						}
						originRS.close();
						
						String findDestination = "SELECT station_ID FROM TrainTicketing.Station WHERE city='"+arrival.split("-")[0]+"' and state='"+arrival.split("-")[1]+"';";
						ResultSet destRS = stmt.executeQuery(findDestination);
						int arr_station_id = 0;
						if(destRS.next()){
							arr_station_id = destRS.getInt(1);
						}
						destRS.close();
						
						if(dep_station_id == arr_station_id){
							response.sendRedirect("ReservationFail.jsp");
							return;
						}
						
						ResultSet checkTransitLine = stmt.executeQuery("select transit_line_name, train_ID from TrainTicketing.Stop where station_ID="+dep_station_id+" and transit_line_name = '"+transit_line+"' and transit_line_name in (select transit_line_name from TrainTicketing.Stop where station_ID="+arr_station_id+" and transit_line_name ='"+ transit_line+"')");
						if(!checkTransitLine.next()){
							
							checkTransitLine.close();
							response.sendRedirect("ReservationFail.jsp");
							return;
						}
						
						
						int train_id = checkTransitLine.getInt(2);
						checkTransitLine.close();
						Date origin_date = Date.valueOf(request.getParameter("Date"));
						/* ResultSet dest_rs = stmt.executeQuery("SELECT arrival_time from TrainTicketing.Stop where station_ID ="+destination_id+";");
						dest_rs.next(); */
						Date destination_date = Date.valueOf(request.getParameter("Date"));
						//out.print(reservation.getString(2));
						//reservation.close();
						
						
						if(ticketClass.equals("Economy")){
							ResultSet econFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Economy_fare where transit_line_name ='"+transit_line+"';");
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
							ResultSet bussFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Business_fare where transit_line_name ='"+transit_line+"';");
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
							ResultSet firstFare = stmt.executeQuery("SELECT * FROM TrainTicketing.First_fare where transit_line_name ='"+transit_line+"';");
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
						ResultSet discountRs = stmt.executeQuery("SELECT * FROM TrainTicketing.Fare where transit_line_name ='"+transit_line+"';");
						discountRs.next();
						if(discount.equals("Senior")){
							discountNum = discountRs.getFloat(2);
						}else if(discount.equals("Children")){
							discountNum = discountRs.getFloat(3);
						}else if(discount.equals("Disabled")){
							discountNum = discountRs.getFloat(4);
						}
						discountRs.close();
			
						String findAvailable = "SELECT available_number_of_seats FROM TrainTicketing.Train_schedule WHERE train_ID="+train_id+" and transit_line_name='"+transit_line+"';";
						ResultSet findAva = stmt.executeQuery(findAvailable);
						int available = 0;
						if(findAva.next()){
							available = findAva.getInt(1);
						}
						findAva.close();
						
						String reserved = "SELECT sum(seat_number) FROM TrainTicketing.Reservation WHERE dep_Train_ID="+train_id+" and dep_date=?";
						PreparedStatement pstmt2 = con.prepareStatement(reserved);
						pstmt2.setDate(1,origin_date);
						ResultSet reservedRS = pstmt2.executeQuery();
						int reservedSeat = 0;
						if(reservedRS.next()){
							reservedSeat = reservedRS.getInt(1);
						}
						reservedRS.close();
						
/* 						String findSeat = "SELECT available_number_of_seats FROM TrainTicketing.Train_schedule WHERE train_ID="+train_id+";";
						ResultSet oldSeat = stmt.executeQuery(findSeat);
						oldSeat.next();
						int oldSeatNum = oldSeat.getInt(1); */
						
						if(seatnum- originalSeatNum + reservedSeat  > available){
							out.print("You can reserve at most "+(available + originalSeatNum-reservedSeat)+ " seats.");
							stmt.close();
							con.close();
							return;
						}
						
						total_fare = fare*discountNum*seatnum+booking_fee;
						String sql;
						if(assist){
							sql = "UPDATE TrainTicketing.Reservation SET total_fare="+total_fare+",seat_number="+seatnum+",class='"+ticketClass+"',booking_fee="+booking_fee+",reservation_date=?"+",dep_Train_ID="+train_id+",dep_Transit_line_name='"+transit_line+"',dep_Station_ID="+dep_station_id+",dep_Date=?"+",arr_Train_ID="+train_id+",arr_Transit_line_name='"+transit_line+"',arr_Station_ID="+arr_station_id+",arr_date=?"+",assist_representative_SSN="+ssn+",type='"+type+"',discount='"+discount+"' WHERE reservation_number="+rsid+";";
						}else{
							sql = "UPDATE TrainTicketing.Reservation SET total_fare="+total_fare+",seat_number="+seatnum+",class='"+ticketClass+"',booking_fee="+booking_fee+",reservation_date=?"+",dep_Train_ID="+train_id+",dep_Transit_line_name='"+transit_line+"',dep_Station_ID="+dep_station_id+",dep_Date=?"+",arr_Train_ID="+train_id+",arr_Transit_line_name='"+transit_line+"',arr_Station_ID="+arr_station_id+",arr_date=?"+",type='"+type+"',discount='"+discount+"'WHERE reservation_number="+rsid+";";
						}
						PreparedStatement pstmt = con.prepareStatement(sql);
						pstmt.setTimestamp(1,today);
						pstmt.setDate(2,origin_date);
						pstmt.setDate(3,destination_date);
						pstmt.executeUpdate();
						
						
						response.sendRedirect("SuccessfulEditReservation.jsp");
						
						/* int newSeatNum = oldSeatNum +originalSeatNum - seatnum;
						oldSeat.close();
						if(newSeatNum < 0){
							out.print("You can reserve at most "+oldSeatNum+ " seats.");
							stmt.close();
							con.close();
							return;
						}else{
							String updateSeat = "UPDATE TrainTicketing.Train_schedule SET available_number_of_seats="+newSeatNum+" WHERE train_ID ="+train_id+";";
							//int insert = stmt.executeUpdate(insertQuery);
							int update = stmt.executeUpdate(updateSeat);
							stmt.close();
							con.close();
							response.sendRedirect("SuccessfulEditReservation.jsp");
						} */
						
						
					
				}else{
					out.print("Invalid user type, please log in with proper type.");
					response.sendRedirect("Login.jsp");
					
					return;
				}
				
		%>


</body>
</html>