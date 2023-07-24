<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register New User</title>
</head>


<body>
<h1>Register Your New User HERE! </h1>
<div>
<form action="submitUser.do" method=POST>
User Name: <input type="text"  name="username" required><br>
Password: <input type="text"  name="password" required><br>
<br>
First Name: <input type="text"  name="firstName" required> <br>
Last Name: <input type="text"  name="lastName" required> <br>
<br>
About Me:<input type="text"  name="aboutme"><br>
<br>
Address:<br>
Street: <input type="text"  name="street" required><br>
City: <input type="text"  name="city" required><br>
State: <input type="text"  name="state" required><br>
Zip Code: <input type="text"  name="zipCode" required><br>
<input type="submit" value="click to continue"><br>
</form>

</div>


</body>
</html>