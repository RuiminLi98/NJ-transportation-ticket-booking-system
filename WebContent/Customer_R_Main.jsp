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

<input type="button" onclick="test7()" value="Answer customer question" />
<script ...>
function test7(){
 var url = "Customer_representative_answerQ.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test8()" value="Produces a list of train schedules for a specific origin and destination" />
<script ...>
function test8(){
 var url = "Customer_R_schedulesForOandD.jsp";
 window.location.href= url;
}
</script> 
<br/>


<input type="button" onclick="test9()" value="Produces a list of train schedules for a specific station as origin/destination" />
<script ...>
function test9(){
 var url = "Customer_R_schedulesStation.jsp";
 window.location.href= url;
}
</script> 
<br/>


<input type="button" onclick="test10()" value="Produces a list of customers who reserved on a given transit line" />
<script ...>
function test10(){
 var url = "Customer_R_customersForTransitLine.jsp";
 window.location.href= url;
}
</script> 
<br/>


<input type="button" onclick="test11()" value="Produces a list of customers who reserved on a train" />
<script ...>
function test11(){
 var url = "Customer_R_customersForTrain.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test12()" value="Produces a list of customers who reserved on a train and a given transit line" />
<script ...>
function test12(){
 var url = "Customer_R_customersForTrainAndLine.jsp";
 window.location.href= url;
}
</script> 
<br/>

<input type="button" onclick="test87()" value="Exit" />
<script ...>
function test87(){
 var url = "Login.jsp";
 window.location.href= url;
}
</script>
 


</body>
</html>