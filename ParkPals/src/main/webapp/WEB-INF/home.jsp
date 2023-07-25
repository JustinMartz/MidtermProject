<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Park Pals</title>
</head>
<body>
	<h1>Park Pals</h1>
	<h2>A National Park Network</h2>
<a href="register.do">   Click here to register a new user.</a></br>
<a href="login.do"> Login </a>
	<h2>${DELETEME}</h2>
	<br>
	<c:forEach var="park" items="${parks }"  >
<a href="displayPark.do?id=${park.id}"> ${park.name } </a><br>
</c:forEach>
</body>
</html>