<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${park.name}</h1><br>
Welcome to this amazing lovely awesome stupendeous park!! <br>
${park.description }<br>
${park.notableFeatures }<br>
${park.imageUrl }<br>
${park.websiteUrl }<br>
${park.address.street }<br>
${park.address.street2 }<br>
${park.address.city }<br>
${park.address.state }<br>
${park.address.zipCode }<br>
${park.address.phone }<br>
<br>



</body>
</html>