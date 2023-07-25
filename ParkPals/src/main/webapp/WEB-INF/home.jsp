<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>