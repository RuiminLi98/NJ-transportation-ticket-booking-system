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
	<%
		out.println("welcome: " + session.getAttribute("type") + " " +session.getAttribute("username")); 
 	%>
 	
 <br/>
 
<input type="button" onclick="test()" value="Add Reservation" />
<script ...>
function test(){
 var url = "Customer_representative_addReservation.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test2()" value="Edit Reservation" />
<script ...>
function test2(){
 var url = "Customer_representative_editReservation.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test3()" value="Delete Reservation" />
<script ...>
function test3(){
 var url = "customer_representative_deleteReservation.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test4()" value="add information of train schedule" />
<script ...>
function test4(){
 var url = "Customer_representative_addSchedule.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test5()" value="edit information of train schedule" />
<script ...>
function test5(){
 var url = "Customer_representative_editSchedule.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test6()" value="delete information of train schedule" />
<script ...>
function test6(){
 var url = "Customer_representative_deleteSchedule.jsp";
 window.location.href= url;
}
</script> 
<br/>


<input type="button" onclick="test7()" value="Exit" />
<script ...>
function test7(){
 var url = "Login.jsp";
 window.location.href= url;
}
</script>
 


</body>
</html>