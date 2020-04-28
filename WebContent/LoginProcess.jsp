<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String username_str = request.getParameter("username");
		String password_str = request.getParameter("password");
		String user_type_str = request.getParameter("user_type");
		if(username_str == null || password_str == null || user_type_str == null
				|| username_str.isEmpty() || password_str.isEmpty()){
			out.print("username, password or user_type is empty");
		}else{			
			
			//get database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String query = null;
			if(user_type_str.equals("Customer")){
				query = "select * from Customer where username='"+ username_str + 
						"' and password='" + password_str + "';";
			}else{
				query = "select * from "+ user_type_str +" as x, Employee as e where (e.SSN=x.SSN AND e.username='"+ username_str +"' AND e.password='"+ password_str +"');";
			}
			
			//ask sql
			ResultSet result = stmt.executeQuery(query);
			boolean success = result.first();
			
			//close connection
			result.close();
			stmt.close();
			con.close();
			
			if(success){
				out.print("login success");
				session.setAttribute("username", username_str); 
				session.setAttribute("type", user_type_str); 
				response.sendRedirect("Welcome_"+user_type_str + ".jsp");
				return;
			}else{
				out.print("login failed");
			}
		}
	%>
<a href="Login.jsp">back to login</a>
</body>
</html>