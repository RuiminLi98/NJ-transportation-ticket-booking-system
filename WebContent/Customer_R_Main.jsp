<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative</title>
</head>
<body>
<h1>Customer Representative</h1>

<input type="button" onclick="test()" value="Add Reservation" />
<script ...>
function test(){
 var url = "Customer_representative_addReservation.jsp";
 window.location.href= url;
}
</script> 
<br/>



<input type="button" onclick="test2()" value="Exit" />
<script ...>
function test2(){
 var url = "Login.jsp";
 window.location.href= url;
}
</script> 


</body>
</html>