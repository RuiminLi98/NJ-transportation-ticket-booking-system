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
<title>Add Customer</title>
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
<h1 style="color: #5e9ca0;">Add a Customer</h1>
<br>
All forms must be filled.
<hr>
   <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
      url = "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing"
      user = "admin"  password = "Group14!"/>

   <sql:query dataSource = "${snapshot}" var = "result">
      SELECT * from Employee;
   </sql:query>
   
   <form action="Admin_AddCustomer.jsp" method="post">
        <table style="with: 50%">
        	<tr>
                <td>First Name</td>
                <td><input type="text" name="firstName" /></td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td><input type="text" name="lastName" /></td>
            </tr>
            <tr>
                <td>UserName</td>
                <td><input type="text" name="username" /></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="password" /></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><input type="text" name="email" /></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><input type="text" name="address" /></td>
            </tr>
            <tr>
                <td>City</td>
                <td><input type="text" name="city" /></td>
            </tr>
            <tr>
                <td>State</td>
                <td><input type="text" name="state" /></td>
            </tr>
            <tr>
                <td>Zip Code</td>
                <td><input type="number" name="zipcode" /></td>
            </tr>
            <tr>
                <td>Telephone</td>
                <td><input type="number" name="telephone" /></td>
            </tr>
        </table>
        <input type="submit" value="Submit" /></form>
        <div style="color: #5e9ca0;">
		<%
			if(request.getParameter("firstName") != null && !request.getParameter("firstName").isEmpty()
			&& request.getParameter("lastName") != null && !request.getParameter("lastName").isEmpty()
			&& request.getParameter("username") != null && !request.getParameter("username").isEmpty()
			&& request.getParameter("password") != null && !request.getParameter("password").isEmpty()
			&& request.getParameter("email") != null && !request.getParameter("email").isEmpty()
			&& request.getParameter("address") != null && !request.getParameter("address").isEmpty()
			&& request.getParameter("city") != null && !request.getParameter("city").isEmpty()
			&& request.getParameter("state") != null && !request.getParameter("state").isEmpty()
			&& request.getParameter("zipcode") != null && !request.getParameter("zipcode").isEmpty()
			&& request.getParameter("telephone") != null && !request.getParameter("telephone").isEmpty()
			){
				Connection conn = DriverManager.getConnection(
				          "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing", "admin", "Group14!");
				Statement stmt = conn.createStatement();
				String sqlStr = "insert into Customer values ('" 
				+ request.getParameter("username") + "', '"
				+ request.getParameter("firstName") + "', '"
				+ request.getParameter("lastName") + "', '"
			    + request.getParameter("email") + "', '"
	    		+ request.getParameter("address") + "', '"
   				+ request.getParameter("city") + "', '"
				+ request.getParameter("state") + "', "
				+ request.getParameter("zipcode") + ", "
			    + request.getParameter("telephone") + ", '"
				+ request.getParameter("password") + "');";
				System.out.println(sqlStr);
				int resultCode;
				try{
					resultCode = stmt.executeUpdate(sqlStr);				
				}catch(Exception e){
					resultCode = -999;								
				}			
				stmt.close();
				conn.close();
				System.out.println(resultCode);
				String responseMsg = resultCode == -999 ? "No new customer has been" : "New customer: " + request.getParameter("username");
				out.print(responseMsg);
			}%> added.
		</div>
</body>
</html>