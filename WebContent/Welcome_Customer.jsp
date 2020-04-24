<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>welcome customer</title>
</head>
<body>
	<%
		out.println("welcome: " + session.getAttribute("type") + " " +session.getAttribute("username")); 
 	%>
 	<br>
	<a href="Search.jsp">search</a>
 	<br>
	<a href="Reservation.jsp">Make a Reservation</a>
	<br>
	<a href="Logout.jsp">Logout</a>
</body>
</html>