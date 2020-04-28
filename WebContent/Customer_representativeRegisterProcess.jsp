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
		String ssn = request.getParameter("ssn");
		String repeat = request.getParameter("repeat");
		if(username_str == null || password_str == null || repeat == null || first_name == null || last_name == null || ssn == null || 
				username_str.isEmpty() || password_str.isEmpty() || repeat.isEmpty() || first_name.isEmpty() || last_name.isEmpty() || ssn.isEmpty()){
			out.print("you must not leave empty field");
		}else if(!repeat.equals(password_str)){
			out.print("passwords are not identical");
		}else{	
			//get database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String query = null;
			query = "select * from Employee where username='"+ username_str +"'";
			//ask sql
			ResultSet result = stmt.executeQuery(query);
			boolean success = result.first();
			
			Statement stmt2 = con.createStatement();			
			String query2 = null;
			query2 = "select * from Employee where SSN='"+ ssn +"'";
			ResultSet result2 = stmt2.executeQuery(query2);
			boolean success2 = result2.first();
			if(success || success2){
				out.print("username is already existed or SSN is already existed");
			}
				else{
				//Make an insert statement for the customer table:
				PreparedStatement insert = con.prepareStatement("INSERT INTO Employee(username, password, First_name, last_name, SSN)" +
						" VALUES (?, ?, ?, ?, ?);");
				insert.setString(1, username_str);
				insert.setString(2, password_str);
				insert.setString(3, first_name);
				insert.setString(4, last_name);
				insert.setString(5, ssn);
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
<a href="customer_representativeRegister.jsp">back</a>
</body>
</html>