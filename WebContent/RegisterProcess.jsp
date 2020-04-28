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
		String first_name = request.getParameter("first name");
		String last_name = request.getParameter("last name");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zip_code = request.getParameter("zip_code");
		String telephone = request.getParameter("telephone");
		String repeat = request.getParameter("repeat");
		
		
		if(username_str == null || password_str == null || repeat == null || first_name == null || last_name == null || email == null || address == null ||
				city == null || state == null || zip_code == null || telephone == null || 
				username_str.isEmpty() || password_str.isEmpty() || repeat.isEmpty() || first_name.isEmpty() || last_name.isEmpty() || email.isEmpty() ||
				address.isEmpty() || city.isEmpty() || state.isEmpty() || zip_code.isEmpty() || telephone.isEmpty()){
			out.print("you must not leave empty field");
		}else if(!repeat.equals(password_str)){
			out.print("passwords are not identical");
		}else if(!Tools.isEmailAddress(email)){
			out.print("email format is not correct");
		}else if(!Tools.isInteger(telephone) || !Tools.isInteger(zip_code)){
			out.print("telephone number and zip code must be integer");
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
				PreparedStatement insert = con.prepareStatement("INSERT INTO Customer(username, password, first_name, last_name, email, address, city, state, zip_code, telephone)" +
						" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				insert.setString(1, username_str);
				insert.setString(2, password_str);
				insert.setString(3, first_name);
				insert.setString(4, last_name);
				insert.setString(5, email);
				insert.setString(6, address);
				insert.setString(7, city);
				insert.setString(8, state);
				insert.setInt(9, Integer.parseInt(zip_code));
				insert.setInt(10, Integer.parseInt(telephone));
				out.print(insert.toString());
				
				//Run the query against the DB
				insert.executeUpdate();
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
<br>
<a href="customer_register.jsp">back</a>
</body>
</html>