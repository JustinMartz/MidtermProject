<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Friend's profile</title>
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
							<li class="nav-item"><a class="nav-link" href="profile.do">Welcome!
									${loggedInUser.firstName}</a></li>
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="profile.do">View My Profile</a></li>
							<li class="nav-item"><a class="nav-link" href="logout.do">Log
									Out</a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link" href="register.do">Register</a>
							</li>
							<li class="nav-item"><a class="nav-link" href="login.do">Log
									In</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>

	<div class="middle-container">
		<div class="middle-block">
			<!-- Middle block Top -->
			<h1 class="text-center">User Profile</h1>
			<p class="text-center">
				Username: ${friend.username}<br> First Name:
				${friend.firstName}<br> Last Name: ${friend.lastName}<br>
				About Me: ${friend.aboutme}

			</p>
			<h2>Meetups Attending:</h2>
			<c:forEach items="${friend.meetupRatings }" var="meetupRating">
				<strong><a
					href="displayMeetup.do?id=${meetupRating.meetup.id}">${meetupRating.meetup.name }</a></strong>
				<br>
			</c:forEach>
			<!-- Middle Block Bottom-->
		</div>


		<c:if test="${isFriend eq true }">
			<form action="removeFriend.do" method="post">
				<input type="hidden" name="friendId" value="${friend.id }">
				<button type="submit">Remove Friend</button>
			</form>
		</c:if>
		<h1>Friend status: ${isFriend }</h1>
		<c:if test="${isFriend ne true }">
			<form action="addFriend.do" method="post">
				<input type="hidden" name="friendId" value="${friend.id }">
				<button type="submit">Let's Be Friends</button>
			</form>
		</c:if>
</body>
</html>