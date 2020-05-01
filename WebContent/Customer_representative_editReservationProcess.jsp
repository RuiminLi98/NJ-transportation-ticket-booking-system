<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.sql.Date,java.text.SimpleDateFormat,java.net.URLEncoder"%>
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
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String user_type_str = (String)session.getAttribute("type");
				String username_str = (String)session.getAttribute("Customer_edit_username");
				String query = null;
				if(user_type_str.equals("Customer_representative")){
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
						int seatnum = Integer.parseInt(request.getParameter("seat_number"));
						//session.setAttribute("seat_number", seatnum);
						String type = request.getParameter("Type");
						//session.setAttribute("Type",type);
						String discount = request.getParameter("Discount");
						//session.setAttribute("Discount",discount);
						String representative = request.getParameter("Representative");
						//session.setAttribute("Representative",representative);
						int ssn =-1;
						boolean assist = false;
						if(!representative.equals("None")){
							String[] splited = representative.split(" ");
							String repFirstName = splited[0];
							String repLastName = splited[1];
							ResultSet rep = stmt.executeQuery("SELECT SSN FROM TrainTicketing.Employee where First_name='"+repFirstName+"'and last_name='"+repLastName+"' AND SSN IN (SELECT SSN FROM TrainTicketing.Customer_representative);");
							rep.next();
							ssn = rep.getInt("SSN");
							rep.close();
							assist = true;
						}
						double booking_fee = 1.0;
						/*
						PreparedStatement ps = con.prepareStatement(Tools.big_query);
						ps.setString(1, depart.split("-")[0]);
						ps.setString(2, arrival.split("-")[0]);
						ResultSet reservation = ps.executeQuery();
						*/
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
						
						ResultSet checkTransitLine = stmt.executeQuery("select distinct r.transit_line_name, r.train_ID from TrainTicketing.Stop r where " + Integer.toString(dep_station_id) + " IN (SELECT t.station_ID FROM TrainTicketing.Stop t WHERE t.transit_line_name = r.transit_line_name AND t.train_ID = r.train_ID) AND " + Integer.toString(arr_station_id) + " IN (SELECT t.station_ID FROM TrainTicketing.Stop t WHERE t.transit_line_name = r.transit_line_name AND t.train_ID = r.train_ID);");
						if(!checkTransitLine.next()){
							checkTransitLine.close();
							response.sendRedirect("ReservationFail.jsp");
							return;
						} else {
							session.setAttribute("Customer_reservation_username",username_str);
							session.setAttribute("Customer_reservation_depart",depart);
							session.setAttribute("Customer_reservation_depart_id",Integer.toString(dep_station_id));
							session.setAttribute("Customer_reservation_arrival",arrival);
							session.setAttribute("Customer_reservation_arrival_id",Integer.toString(arr_station_id));
							session.setAttribute("Customer_reservation_ticketClass",ticketClass);
							session.setAttribute("Customer_reservation_seatnum",Integer.toString(seatnum));
							session.setAttribute("Customer_reservation_type",type);
							session.setAttribute("Customer_reservation_discount",discount);
							session.setAttribute("Customer_reservation_representative",representative);
							session.setAttribute("Customer_reservation_ssn",Integer.toString(ssn));
							session.setAttribute("Customer_reservation_date",request.getParameter("Date"));
							do{
								out.println("<a href=\"Customer_representative_editReservationProcess_selectLine.jsp?line=" + URLEncoder.encode(checkTransitLine.getString(1),java.nio.charset.StandardCharsets.UTF_8.toString()) + "&train_id=" + Integer.toString(checkTransitLine.getInt(2)) + "\">" + checkTransitLine.getString(1) + ", train ID " + Integer.toString(checkTransitLine.getInt(2)) + "</a><br>");
							} while(checkTransitLine.next());
						}
						
// 						String transit_line_name = checkTransitLine.getString(1);
// 						int train_ID = checkTransitLine.getInt(2);
						
// 						Date origin_date = Date.valueOf(request.getParameter("Date"));
// 						/* ResultSet dest_rs = stmt.executeQuery("SELECT arrival_time from TrainTicketing.Stop where station_ID ="+destination_id+";");
// 						dest_rs.next(); */
// 						Date destination_date = Date.valueOf(request.getParameter("Date"));
// 						//out.print(reservation.getString(2));
// 						//reservation.close();
// 						if(ticketClass.equals("Economy")){
// 							ResultSet econFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Economy_fare where transit_line_name ='"+transit_line_name+"';");
// 							econFare.next();
// 							 if(type.equals("One Way")){
// 								 fare = econFare.getFloat("one_way_fee");
// 							 }else if(type.equals("Round Trip")){
// 								 fare = econFare.getFloat("round_trip_fee");
// 							 }else if(type.equals("Monthly Pass")){
// 								 fare = econFare.getFloat("monthly_fee");
// 							 }else{
// 								fare = econFare.getFloat("weekly_fee"); 
// 							 }
// 							 econFare.close();
// 						}else if(ticketClass.equals("Business")){
// 							ResultSet bussFare = stmt.executeQuery("SELECT * FROM TrainTicketing.Business_fare where transit_line_name ='"+transit_line_name+"';");
// 							bussFare.next();
// 							 if(type.equals("One Way")){
// 								 fare = bussFare.getFloat(4);
// 							 }else if(type.equals("Round Trip")){
// 								 fare = bussFare.getFloat(5);
// 							 }else if(type.equals("Monthly Pass")){
// 								 fare = bussFare.getFloat(2);
// 							 }else{
// 								fare = bussFare.getFloat(3); 
// 							 }
// 							 bussFare.close();
// 						}else{
// 							ResultSet firstFare = stmt.executeQuery("SELECT * FROM TrainTicketing.First_fare where transit_line_name ='"+transit_line_name+"';");
// 							firstFare.next();
// 							if(type.equals("One Way")){
// 								 fare = firstFare.getFloat(4);
// 							 }else if(type.equals("Round Trip")){
// 								 fare = firstFare.getFloat(5);
// 							 }else if(type.equals("Monthly Pass")){
// 								 fare = firstFare.getFloat(2);
// 							 }else{
// 								fare = firstFare.getFloat(3); 
// 							 }
// 							firstFare.close();
// 						}
// 						ResultSet discountRs = stmt.executeQuery("SELECT * FROM TrainTicketing.Fare where transit_line_name ='"+transit_line_name+"';");
// 						discountRs.next();
// 						if(discount.equals("Senior")){
// 							discountNum = discountRs.getFloat(2);
// 						}else if(discount.equals("Children")){
// 							discountNum = discountRs.getFloat(3);
// 						}else if(discount.equals("Disabled")){
// 							discountNum = discountRs.getFloat(4);
// 						}
// 						discountRs.close();
						
// 						total_fare = fare*discountNum*seatnum+booking_fee;
// 						String sql;
// 						if(assist){
// 							sql = "INSERT INTO TrainTicketing.Reservation(total_fare,seat_number, class, booking_fee, reservation_date,dep_Train_ID, dep_Transit_line_name, dep_Station_ID, dep_Date, arr_Train_ID,arr_Transit_line_name, arr_Station_ID, arr_date, assist_representative_SSN, customer_Username, type, discount) values ("+total_fare+","+seatnum+",'"+ticketClass+"',"+booking_fee+","+"?,"+train_ID+",'"+transit_line_name+"',"+dep_station_id+","+"?,"+train_ID+",'"+transit_line_name+"',"+arr_station_id+","+"?,"+ssn+",'"+username_str+"','"+type+"','"+discount+"'"+");";
// 						}else{
// 							sql = "INSERT INTO TrainTicketing.Reservation(total_fare,seat_number, class, booking_fee, reservation_date,dep_Train_ID, dep_Transit_line_name, dep_Station_ID, dep_Date, arr_Train_ID,arr_Transit_line_name, arr_Station_ID, arr_date,customer_Username, type, discount) values ("+total_fare+","+seatnum+",'"+ticketClass+"',"+booking_fee+","+"?,"+train_ID+",'"+transit_line_name+"',"+dep_station_id+","+"?,"+train_ID+",'"+transit_line_name+"',"+arr_station_id+","+"?"+",'"+username_str+"','"+type+"','"+discount+"'"+");";
// 						}
// 						PreparedStatement pstmt = con.prepareStatement(sql);
// 						pstmt.setTimestamp(1,today);
// 						pstmt.setDate(2,origin_date);
// 						pstmt.setDate(3,destination_date);
// 						try{
// 						pstmt.executeUpdate();}
// 						catch(Exception exp){out.println("The input information is not correct");return;}
// 						String findSeat = "SELECT total_number_of_seats FROM TrainTicketing.Train WHERE train_ID="+train_ID+";";
// 						ResultSet oldSeat = stmt.executeQuery(findSeat);
// 						oldSeat.next();
// 						int oldSeatNum = oldSeat.getInt(1);
// 						int newSeatNum = oldSeatNum - seatnum;
// 						oldSeat.close();
// 						if(newSeatNum < 0){
// 							out.print("I can reserve at most "+oldSeatNum+ " seats.");
// 							stmt.close();
// 							con.close();
// 							return;
// 						}else{
// 							String updateSeat = "UPDATE TrainTicketing.Train SET total_number_of_seats="+newSeatNum+" WHERE train_ID ="+train_ID+";";
// 							//int insert = stmt.executeUpdate(insertQuery);
// 							try{
// 							int update = stmt.executeUpdate(updateSeat);
// 							}catch(Exception e){
// 								out.println("The input information is incorrect");return;
// 							}
// 							stmt.close();
// 							con.close();
// 							response.sendRedirect("customer_representative_SuccessfulReservation.jsp");
// 						}
						
						
					/* }else{
						out.print("login failed");
					} */
					
				}else{
					out.print("Invalid user type, please log in with proper type.");
					response.sendRedirect("Login.jsp");
					return;
				}
				
			
	%>
<!-- <a href="Login.jsp">back to login</a> -->
</body>
</html>