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
<h1>All the available schedule for you:(choose one)</h1>
	<% 
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String user_type_str = (String)session.getAttribute("type");
				String username_str = request.getParameter("User");
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
						String representative = (String)session.getAttribute("username");
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
								out.println("<a href=\"Customer_reservationProcess_selectLine.jsp?line=" + URLEncoder.encode(checkTransitLine.getString(1),java.nio.charset.StandardCharsets.UTF_8.toString()) + "&train_id=" + Integer.toString(checkTransitLine.getInt(2)) + "\">" + checkTransitLine.getString(1) + ", train ID " + Integer.toString(checkTransitLine.getInt(2)) + "</a><br>");
							} while(checkTransitLine.next());
						}
						
  
					
				}else{
					out.print("Invalid user type, please log in with proper type.");
					response.sendRedirect("Login.jsp");
					return;
				}
				
			
	%>
<!-- <a href="Login.jsp">back to login</a> -->
</body>
</html>