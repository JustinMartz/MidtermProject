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
User Name: <input type="text" value="${loggedInUser.username}"  name="userName" required><br>
Password: <input type="text" value="${loggedInUser.password}" name="passWord" required><br>
User Name: <input type="text" value="${loggedInUser.firstName}" name="userName" required><br>
Password: <input type="text" value="${loggedInUser.lastName}" name="passWord" required><br>

</form>
</body>
</html>