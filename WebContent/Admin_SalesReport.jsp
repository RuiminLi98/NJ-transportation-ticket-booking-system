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
<title>Sales Report</title>
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
<h1 style="color: #5e9ca0;">Sales Report</h1>
<br>
Select a month for its sales report.
<hr>
   <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
      url = "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing"
      user = "admin"  password = "Group14!"/>

   <form action="Admin_SalesReport.jsp" method="post">
        <table style="with: 50%">
        	<tr>
        	<td>Enter a month like 2020-04</td>
                <td><input type="month" id="month" name="month" value="2020-04"></td>
            </tr>
            
        </table>
        <input type="submit" value="Submit" /></form>
        <div style="color: #5e9ca0;">
		<%
			if(request.getParameter("month") != null && !request.getParameter("month").isEmpty()){
				out.print("Sales report for " + request.getParameter("month") + "<br>");
				Connection conn = DriverManager.getConnection(
				          "jdbc:mysql://mydb.cigic3cefobe.us-east-2.rds.amazonaws.com/TrainTicketing", "admin", "Group14!");
				Statement stmt = conn.createStatement();
				// total reservations of that month
				String sqlStr = "select count(*) as count from Reservation where date_format(reservation_date, '%y-%m') = date_format('"
						+ request.getParameter("month") + "-01', '%y-%m');";
				System.out.println(sqlStr);
				int resultCode;
				ResultSet rs = null;
				try{
					rs = stmt.executeQuery(sqlStr);
					resultCode = 1;
				}catch(Exception e){
					resultCode = -999;								
				}
				rs.next();
				int salesCount = rs.getInt("count");					
				out.print("Number of reservations for the month " + request.getParameter("month") + " is " + salesCount + "<br>");
				// total fare of the month
				sqlStr = "select sum(total_fare) as total_fare from Reservation where date_format(reservation_date, '%y-%m') = date_format('"
						+ request.getParameter("month") + "-01', '%y-%m');";
				try{
					rs = stmt.executeQuery(sqlStr);
					resultCode = 1;
				}catch(Exception e){
					resultCode = -999;								
				}
				rs.next();
				String salesTotal = rs.getString("total_fare");
				if(salesTotal == null || salesTotal.isEmpty()) salesTotal = "0";
				out.print("Total fare sales for the month " + request.getParameter("month") + " is " + salesTotal + "<br>");

				
				
				stmt.close();
				conn.close();
				System.out.println(resultCode);
// 				String responseMsg = "";
// 				if(resultCode == 1)
// 					responseMsg = "Successfully updated employee of SSN: " + request.getParameter("SSN");
// 				else if(resultCode == 0)
// 					responseMsg = "Cannot find this employee of given SSN, no update performed.";
// 				else if(resultCode == -999)
// 					responseMsg = "Error during update, no update performed.";
// 				out.print(responseMsg);
			}%>
		</div>
		<sql:query dataSource = "${snapshot}" var = "result">
	      select concat(class, '') as xxxx, count(*) as count from Reservation where date_format(reservation_date, '%y-%m') = date_format('<%=request.getParameter("month")== null ? "2020-04" : request.getParameter("month")%>-01', '%y-%m') group by class;
	   </sql:query>
		<h2>Number of Sales by Class</h2>
			<table border = "1" width = "50%">
	      <tr>
	         <th>Class</th>
	         <th>Number of Reservations</th>
	      </tr>
	      
	      <c:forEach var = "row" items = "${result.rows}">
	         <tr>
	            <td><c:out value = "${row.xxxx}"/></td>
	            <td><c:out value = "${row.count}"/></td>
	         </tr>
	      </c:forEach>
	   </table>
	   
	   <sql:query dataSource = "${snapshot}" var = "result">
	      select type, count(*) as count from Reservation where date_format(reservation_date, '%y-%m') = date_format('<%=request.getParameter("month")== null ? "2020-04" : request.getParameter("month")%>-01', '%y-%m') group by type;
	   </sql:query>
	   <hr>
	   <h2>Number of Sales by Class</h2>
			<table border = "1" width = "50%">
	      <tr>
	         <th>Type</th>
	         <th>Number of Reservations</th>
	      </tr>
	      
	      <c:forEach var = "row" items = "${result.rows}">
	         <tr>
	            <td><c:out value = "${row.type}"/></td>
	            <td><c:out value = "${row.count}"/></td>
	         </tr>
	      </c:forEach>
	   </table>
</body>
</html>