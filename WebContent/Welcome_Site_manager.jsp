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
<title>welcome site's manager</title>
</head>
<body>
	<%
		out.println("welcome: " + session.getAttribute("type") + " " +session.getAttribute("username")); 
 	%>
	<a href="Logout.jsp">Logout</a>
</body>
</html>