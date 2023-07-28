<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<!-- Custom CSS -->
<link href="../css/main.css" rel="stylesheet">
</head>
<body>

	<nav class="navbar navbar-expand-sm navbar-light bg-success">
		<div class="container-fluid ">
			<a class="navbar-brand " href="home.do">Park Pals</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarSupportedContent">
				<ul class="navbar-nav ">
					<c:choose>
						<c:when test="${not empty sessionScope.loggedInUser }">
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="profile.do">View My Profile</a></li>
							<li class="nav-item"><a class="nav-link" href="logout.do">Log
									Out</a></li>
						</c:when>
						<c:otherwise>
						<li class="nav-item">
			 <a class="nav-link" href="register.do">Register</a>
			</li>
							<li class="nav-item"><a class="nav-link" href="login.do">Log
									In</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>



	<h1>${meetup.name }</h1>
	<br> ${meetup.meetupDate }
	<br> ${meetup.startTime }
	<br> ${meetup.endTime }
	<br> ${meetup.description }
	<br> ${meetup.imageUrl }
	<br> ${meetup.trail.description}
	<br> <h3>Created by: </h3>${meetup.creator.firstName}


	<c:forEach var="rating" items="${meetup.meetupRatings }">
		<h2>Trail Rating: ${rating.rating }</h2>
		<h2>Comments about this trail: ${rating.comment }</h2>
	</c:forEach>
	
	<div class="comment-box">
	<c:forEach var="meetupComment" items="${sessionScope.meetupComments }">
	<h2>${meetupComment.comment }</h2>
	<h3>${meetupComment.user.username }</h3>
	<h4>${meetupComment.commentDate }</h4>
	
	</c:forEach>
	</div>
	
	



	<c:if test="${sessionScope.isAttending eq true }">
		<h1>You are attending this meetup!</h1>
		<form action="unattendMeetup.do">
			<input type="hidden" name="meetupId" value="${meetup.id }">
			 <input type="hidden" name="userId" value="${sessionScope.loggedInUser.id }">
			<input type="submit" value="Flake on this meetup">

		</form>
		<form action="addCommentToMeetup.do">
		<input type="text" name="commentText" maxlength=400>
		<input type="hidden" name="id" value="${meetup.id }">
		<input type="submit" value="Submit comment">
		
		
		
		</form>
	</c:if>

	<c:if test="${sessionScope.isAttending eq false }">
		<form action="joinMeetup.do">
			<input type="hidden" name="meetupId" value="${meetup.id }">
			<input type="submit" value="Join this meet up!">

		</form>
	</c:if>

	<c:if test="${sessionScope.loggedInUser.id eq meetup.creator.id}">
	
	<h1><a href="deleteMeetup.do?id=${meetup.id }"> DELETE THIS MEETUP </a></h1>

		
	</c:if>













</body>
</html>