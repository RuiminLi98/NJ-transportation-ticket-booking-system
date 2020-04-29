<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>delete information of train schedule</title>
</head>
<body>
<h1>delete information of train schedule</h1>


	<b>Train_ID:</b>
	<br>
	<input type="text" name="Train_ID"  min= 1 required>
	<br>
	<br>
	<b>transit_line_name:</b>
	<br>
	<input type="password" name="transit_line_name" min= 1 required>
	<br>
<input type="button" onclick="test()" value="Back" />
<script ...>
function test(){
 var url = "Customer_R_Main.jsp";
 window.location.href= url;
}
</script> 


</body>
</html>