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
<title>Big Daddy Customer</title>
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
<h1 style="color: #5e9ca0;">Big Daddy Customer</h1>
   <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
      url = "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing"
      user = "admin"  password = "Group14!"/>

   <sql:query dataSource = "${snapshot}" var = "result">
      select customer_Username, count(*) as reservations
		from Reservation
		group by customer_Username
		order by count(*) desc
		limit 1;
   </sql:query>

   <table border = "1" width = "100%">
      <tr>
         <th>Customer Name</th>
         <th># of Reservations</th>         
      </tr>
      
      <c:forEach var = "row" items = "${result.rows}">
         <tr>
            <td><c:out value = "${row.customer_Username}"/></td>
            <td><c:out value = "${row.reservations}"/></td>            
         </tr>
      </c:forEach>
   </table>

</body>
</html>