<style><%@include file="/WEB-INF/css/simpleStyle.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edited</title>
</head>
<body>
<%
		out.println("You have successfully edit a reservation!"); 
%>
<br>
<a href="ViewReservation.jsp">View Reservation</a>
<br>
<a href="Reservation.jsp">Make a new Reservation</a>
<br>
<%
	if(session.getAttribute("username") ==null){
%>
<a href="Login.jsp">Back to Log in Page</a>
<%}else{%>
<a href="Welcome_Customer.jsp">Back to Welcome Page</a>
<%} %>
</body>
</html>