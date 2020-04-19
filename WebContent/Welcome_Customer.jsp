<%
    String redirectURL = "Login.jsp";
	if(session.getAttribute("username") == null){response.sendRedirect(redirectURL);}
%>

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
 	
	<input type="button" value="Search" onClick="window.location.href='Search.jsp'"> 
	<input type="button" value="Logout" onClick="window.location.href='Logout.jsp'"> 
</body>
</html>