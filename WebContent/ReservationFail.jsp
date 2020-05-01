<style><%@include file="/WEB-INF/css/simpleStyle.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation Failed</title>
</head>
<body>
<%
		out.println("Invalid selection of stops or transit line, please search and reserve again with correct information."); 
%>
<br>
<a href="Search.jsp">Search</a>
<br>
<a href="ViewReservation.jsp">View Reservation</a>
<br>
<a href="Reservation.jsp">Make a new Reservation</a>
</body>
</html>