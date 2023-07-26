<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-sm navbar-light bg-success">
	  <div class="container-fluid ">
		<a class="navbar-brand " href="#">Park Pals</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		  <span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
		  <ul class="navbar-nav ">
			<c:choose>
			<c:when test="${not empty sessionScope.loggedInUser }">
			<li class="nav-item">
			  <a class="nav-link active" aria-current="page" href="profile.do">View My Profile</a>
			</li>
			<li class="nav-item">
			<a class="nav-link" href="logout.do">Log Out</a>
			</li>
			 </c:when>
			 <c:otherwise>
			<li class="nav-item">
			 <a class="nav-link" href="login.do">Log In</a>
			</li>			
			 </c:otherwise>
			 </c:choose>
		  </ul>		  
		</div>
	  </div>
	</nav>
	
	
	
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
	        	<c:when test="${userMeetup.meetup.id eq meetup.id}">
	        	<p>You are attending this meet up!</p>
	        	
	        	</c:when>
	        </c:forEach>

	   </c:when>
	<c:otherwise>
	      <h1>Not logged in</h1>
	</c:otherwise>
	</c:choose>



</body>
</html>