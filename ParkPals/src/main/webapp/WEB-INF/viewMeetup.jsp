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
<h2>${rating.rating }</h2>
<h2>${rating.comment }</h2>
</c:forEach>

	<c:choose>
	    <c:when test="${not empty sessionScope.loggedInUser }">
	      <h2>Your Account Details</h2>
	        <ul>
	          <li>ID : ${loggedInUser.id } </li>
	          <li>User Name: ${loggedInUser.username } </li>
	          <li>${loggedInUser.firstName} ${loggedInUser.lastName }</li>
	        </ul>
	   </c:when>
	<c:otherwise>
	      <h1>Not logged in</h1>
	</c:otherwise>
	</c:choose>



</body>
</html>