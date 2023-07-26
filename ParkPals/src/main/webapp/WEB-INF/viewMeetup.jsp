<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    
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
<br>
${meetup.startTime }
<br>
${meetup.endTime }
<br>
${meetup.description }
<br>
${meetup.imageUrl }
<br>
${meetup.trail.description}
<br>
${meetup.creator.firstName}


<c:forEach var="rating" items="${meetup.meetupRatings }">
<h2>Trail Rating: ${rating.rating }</h2>
<h2>Comments about this trail: ${rating.comment }</h2>
</c:forEach>

	<c:choose>
	    <c:when test="${not empty sessionScope.loggedInUser }">
	      <h2>Meet Ups:</h2>

			<c:if test="${sessionScope.loggedInUser.id eq meetup.creator.id}">
	        	<p>You are the creator of this meet up!</p>
	        	
	        	</c:if>
	        <c:forEach items="${sessionScope.loggedInUser.meetupRatings }" var="userMeetup">
	        	<c:if test="${userMeetup.meetup.id eq meetup.id}">
	        	<p>You are attending this meet up!</p>
	        	
	        	</c:if>
	        </c:forEach>

	   </c:when>
	<c:otherwise>
	      <h1>Not logged in</h1>
	</c:otherwise>
	</c:choose>



</body>
</html>