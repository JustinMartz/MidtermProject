<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
${loggedInUser.username}
${loggedInUser.firstName}
${loggedInUser.lastName}
${loggedInUser.aboutme}





<form action="editProfile.do" method=POST>
<input type="hidden" name="id" value="${loggedInUser.id}"/>
<input type="submit" value="EditProfile">
</form>

</body>
</html>