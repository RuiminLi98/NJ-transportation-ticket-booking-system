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
<title>Revenue Per Customer</title>
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
<h1 style="color: #5e9ca0;">Revenue Per Customer (by desc order)</h1>
   <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
      url = "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing"
      user = "admin"  password = "Group14!"/>

   <sql:query dataSource = "${snapshot}" var = "result">
      select c.username as username, c.first_name, c.last_name, sum(r.total_fare) as total_fare_per_customer, count(*) as number_of_reservations
		from Customer c, Reservation r
		where c.username = r.customer_Username
		group by username
		order by total_fare_per_customer desc;
   </sql:query>

   <table border = "1" width = "100%">
      <tr>
         <th>User ID</th>
         <th>First Name</th>
         <th>Last Name</th>
         <th>Total Fare</th>
         <th># of Reservations</th>         
      </tr>
      
      <c:forEach var = "row" items = "${result.rows}">
         <tr>
            <td><c:out value = "${row.username}"/></td>
            <td><c:out value = "${row.first_name}"/></td>
            <td><c:out value = "${row.last_name}"/></td>
            <td>$<c:out value = "${row.total_fare_per_customer}"/></td>
            <td><c:out value = "${row.number_of_reservations}"/></td>            
         </tr>
      </c:forEach>
   </table>

</body>
</html>