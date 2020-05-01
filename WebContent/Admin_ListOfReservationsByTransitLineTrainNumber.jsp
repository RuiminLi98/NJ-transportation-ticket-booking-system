<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List Of Reservations By TransitLine TrainNumber</title>
</head>
<body>
<%
  // check login status, error out if not logged in as admin
  // comment the line below in production
  session.setAttribute("User", "admin");
  if (session.getAttribute("User") != "admin")
  {
    %><jsp:forward page="Admin_NotAdminErrorPage.jsp" /><%
  }else{
	  System.out.println("Logged in as admin, continue.");
  }
%>
<h1 style="color: #5e9ca0;">List Of Reservations By TransitLine TrainNumber</h1>
<br>
<hr>
   <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
      url = "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing"
      user = "admin"  password = "Group14!"/>

   
   
   <form action="Admin_ListOfReservationsByTransitLineTrainNumber.jsp" method="post">
        <table style="with: 50%">
            <tr>
                <td>Transit Line Name</td>
                <td><input type="text" name="transitline" /></td>
            </tr>
            <tr>
                <td>Train Number(number only)</td>
                <td><input type="number" name="trainnumber" /></td>
            </tr>
        </table>
        <input type="submit" value="Submit" /></form>
	<sql:query dataSource = "${snapshot}" var = "result">
      select r.*, c.*, concat(class, '') as reservationclass from Reservation r, Customer c where dep_Transit_line_name='<%=request.getParameter("transitline")== null ? "train" : request.getParameter("transitline")%>' AND dep_Train_ID=<%=request.getParameter("trainnumber")== null ? "0000" : request.getParameter("trainnumber")%> and r.customer_Username=c.username;
   	</sql:query>
   	<hr>
   	<h2>Result: List of Reservations by <%=request.getParameter("transitline")== null ? "train" : request.getParameter("transitline")%> #<%=request.getParameter("trainnumber")== null ? "0000" : request.getParameter("trainnumber")%></h2>
   	<hr>
   	<table border = "1" width = "100%">
      <tr>
         <th>User ID</th>
         <th>First Name</th>
         <th>Last Name</th>
         <th>Total Fare</th>
         <th>Seat Number</th>
         <th>Reservation Class</th>
         <th>Booking Fee</th>
         <th>Reservation Date</th>
         <th>Departure Train ID</th>
         <th>Departure Transit Line Name</th>
         <th>Departure Station ID</th>
         <th>Departure Date</th>
         <th>Arrival Train ID</th>
         <th>Arrival Transit Line Name</th>
         <th>Arrival Station ID</th>
         <th>Arrival Date</th>    
         <th>Assist Representative SSN</th>
         <th>Reservation Number</th>
         <th>Type</th>
         <th>Discount</th>    
      </tr>
      
      <c:forEach var = "row" items = "${result.rows}">
         <tr>
            <td><c:out value = "${row.customer_Username}"/></td>
            <td><c:out value = "${row.first_name}"/></td>
            <td><c:out value = "${row.last_name}"/></td>
            <td>$<c:out value = "${row.total_fare}"/></td>
            <td><c:out value = "${row.seat_number}"/></td>
            <td><c:out value = "${row.reservationclass}"/></td>
            <td>$<c:out value = "${row.booking_fee}"/></td>
            <td><c:out value = "${row.reservation_date}"/></td>
            <td><c:out value = "${row.dep_Train_ID}"/></td>
            <td><c:out value = "${row.dep_Transit_line_name}"/></td>
            <td><c:out value = "${row.dep_Station_ID}"/></td>
            <td><c:out value = "${row.dep_date}"/></td>
            <td><c:out value = "${row.arr_Train_ID}"/></td>
            <td><c:out value = "${row.arr_Transit_line_name}"/></td>
            <td><c:out value = "${row.arr_Station_ID}"/></td>
            <td><c:out value = "${row.arr_date}"/></td>
            <td><c:out value = "${row.assist_representative_SSN}"/></td>
            <td><c:out value = "${row.reservation_number}"/></td>
            <td><c:out value = "${row.type}"/></td>
            <td><c:out value = "${row.discount}"/></td>
         </tr>
      </c:forEach>
   </table>
</body>
</html>