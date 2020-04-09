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
		String repeat = request.getParameter("repeat");
		if(username_str == null || password_str == null || repeat == null ||
				username_str.isEmpty() || password_str.isEmpty() || repeat.isEmpty()){
			out.print("username or password is empty");
		}else if(!repeat.equals(password_str)){
			out.print("passwords are not identical");
		}else{
			//get database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String query = null;
			query = "select * from Customer where username='"+ username_str +"'";
			
			//ask sql
			ResultSet result = stmt.executeQuery(query);
			boolean success = result.first();
		
			
			if(success){
				out.print("username is already existed");
			}else{
				//Make an insert statement for the customer table:
				String insert = "INSERT INTO Customer(username, password) VALUES ('" + username_str + "', '" + password_str+"');";
				//Run the query against the DB
				stmt.executeUpdate(insert);
				//close connection
				result.close();
				stmt.close();
				con.close();
				response.sendRedirect("Login.jsp");			
			}
			//close connection
			result.close();
			stmt.close();
			con.close();
		}
	%>
<a href="customer_register.jsp">back</a>
</body>
</html>