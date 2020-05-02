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
<title>Admin Home Management Page</title>
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
<h1 style="color: #5e9ca0;">Admin Management Interface</h1>
<hr>
<h2>User Management</h2>
	<a href="Admin_AddEmployee.jsp">Add An Employee</a>, <a href="Admin_AddCustomer.jsp">Add A Customer</a> 
	<br>
	<a href="Admin_UpdateEmployee.jsp">Edit An Employee</a>, <a href="Admin_UpdateCustomer.jsp">Edit A Customer</a>
	<br>
	<a href="Admin_DeleteEmployee.jsp">Delete An Employee</a>, <a href="Admin_DeleteCustomer.jsp">Delete A Customer</a>  	
<h2>Sales Report</h2>
	<a href="Admin_SalesReport.jsp">Obtain Sales Report for A Particular Month</a>
<h2>Get List of Reservations</h2>
	<a href="Admin_ListOfReservationsByTransitLineTrainNumber.jsp">By Transit Line And Train Number (e.g. NortheastCorridor #3425)</a>
	<br>
	<a href="Admin_ListOfReservationsByCustomerName.jsp">By Customer Name</a>
<h2>List of Revenue</h2>
	<a href="Admin_ListOfRevenuePerTransitLine.jsp">Per Transit Line</a>
	<br>
	<a href="Admin_ListOfRevenuePerDestinationCity.jsp">Per Destination City</a>
	<br>
	<a href="Admin_ListOfRevenuePerCustomerName.jsp">Per Customer Name</a>
<h2>Big Daddy</h2>
	<a href="Admin_BestCustomer.jsp">Best Customer</a>
<h2>Top Transit Lines</h2>
	<a href="Admin_TopFiveActiveTransitLines.jsp">Top 5 Active Transit Lines</a>
<h2>exit</h2>
	<a href="Login.jsp">exit</a>
</body>
</html>