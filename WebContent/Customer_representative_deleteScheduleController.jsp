<style><%@include file="/WEB-INF/css/style2.css"%></style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="group14_train.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.regex.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String trainID_str = request.getParameter("Train_ID");
		String transit_line_name_str = request.getParameter("transit_line_name");

		PreparedStatement insert = con.prepareStatement("DELETE FROM TrainTicketing.Train_schedule WHERE train_ID = ? AND transit_line_name = ? ;");
		insert.setInt(1,Integer.parseInt(trainID_str));
		insert.setString(2,transit_line_name_str);
		
		try{
			insert.executeUpdate();
		} catch (Exception e){
			response.sendRedirect("Customer_representative_deleteScheduleFail.jsp");
		}
		out.println("Delete schedule successful");
		//close connection
		stmt.close();
		con.close();
	%>
</body>
</html>