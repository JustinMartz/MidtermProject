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
<h1>${trail.name }</h1><br>
Welcome this amazing kick frog trail!
<br>
${trail.description }<br>
${trail.latitude }<br>
${trail.longitude }<br>
${trail.lengthInMiles }<br>
${trail.imageUrl }<br>
<br>
<c:forEach var="meetup" items="${trail.meetups}">
<h1><a href="displayMeetup.do?id=${meetup.id }">${meetup.name}</a></h1><br>
${meetup.description }
</c:forEach>
<c:forEach var="amenity" items="${trail.amenities}">
<h1>${amenity.name}</h1><br>
</c:forEach>
</body>
</html>