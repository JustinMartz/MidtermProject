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
<h1>${meetup.name }</h1>
<br>
${meetup.meetupDate }
${meetup.startTime }
${meetup.endTime }
${meetup.description }
${meetup.imageUrl }
${meetup.trail }
${meetup.creator}


<c:forEach var="rating" items="${meetup.meetupRatings }">
<h2>${rating.rating }</h2>
<h2>${rating.comment }</h2>
</c:forEach>
</body>
</html>