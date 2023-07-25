<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="updateUserInfo.do" method=POST>
User Name: <input type="text" value="${loggedInUser.username}"  name="username" required><br>
Password: <input type="text" value="${loggedInUser.password}" name="password" required><br>
First Name: <input type="text" value="${loggedInUser.firstName}" name="firstName" required><br>
Last Name: <input type="text" value="${loggedInUser.lastName}" name="lastName" required><br>
About Me: <input type="text" value="${loggedInUser.aboutme}" name="aboutme"><br>
Profile Image URL: <input type="text" value="${loggedInUser.imageUrl}" name="imageUrl"><br>
Street: <input type="text" value="${loggedInUser.address.street}" name="street"><br>
Unit/Suite/Apartment: <input type="text" value="${loggedInUser.address.street2}" name="street2"><br>
City: <input type="text" value="${loggedInUser.address.city}" name="city"><br>
State: <input type="text" value="${loggedInUser.address.state}" name="state"><br>
Zip Code: <input type="text" value="${loggedInUser.address.zipCode}" name="zipCode"><br>
Phone: <input type="text" value="${loggedInUser.address.phone}" name="phone"><br>
<input type="hidden" name="id" value="${loggedInUser.id}"/>
<input type="submit" value="Save Changes">

</form>
</body>
</html>