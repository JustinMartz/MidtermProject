<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Meetup Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
          crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
    <style>
    body {
    background-image: url("images/meetupbackground.jpeg");
    background-size: cover;
    background-position: center;
    
    }
    .container {
	border: 1px solid #ccc;
	padding: 20px;
	border-radius: 5px;
	background-color: rgba(241,236,228, 0.8);
	display: grid;
}
    </style>
</head>
<body>

<nav class="navbar navbar-expand-sm navbar-light bg-success">
	  <div class="container-fluid ">
		<a class="navbar-brand " href="home.do">Park Pals</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		  <span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
		  <ul class="navbar-nav ">
			<c:choose>
			<c:when test="${not empty sessionScope.loggedInUser }">
			<li class="nav-item">
			 Welcome! ${loggedInUser.firstName}
			 </li>
			<li class="nav-item">
			  <a class="nav-link active" aria-current="page" href="profile.do">View My Profile</a>
			</li>
			<li class="nav-item">
			  <a class="nav-link active" aria-current="page" href="editProfile.do">Edit My Profile</a>
			</li>
			<li class="nav-item">
			<a class="nav-link" href="logout.do">Log Out</a>
			</li>
			 </c:when>
			 <c:otherwise>
			 <li class="nav-item">
			 <a class="nav-link" href="register.do">Register</a>
			</li>
			<li class="nav-item">
			 <a class="nav-link" href="login.do">Log In</a>
			</li>			
			 </c:otherwise>
			 </c:choose>
		  </ul>		  
		</div>
	  </div>
	</nav>
<div class="container">

    <h1>${meetup.name}</h1>
    <p>Date: ${meetup.meetupDate}</p>
    <p>Start Time: ${meetup.startTime}</p>
    <p>End Time: ${meetup.endTime}</p>
    <p>Description: ${meetup.description}</p>
    <p><img src="images/${meetup.imageUrl}"></p>
    <p>Trail Description: ${meetup.trail.description}</p>
    <h3>Created by: ${meetup.creator.firstName}</h3>

    <c:forEach var="rating" items="${meetup.meetupRatings}">
        <h5>Trail Rating: ${rating.rating}</h5>
    </c:forEach>

    <div class="comment-box">
        <c:forEach var="meetupComment" items="${sessionScope.meetupComments}">
            <h6 style="display: inline;">Posted by: ${meetupComment.user.username} , ${meetupComment.commentDate} </h6>
            <h4 style="text-color:black; text-align:left;">${meetupComment.comment}</h4>
            <hr>
        </c:forEach>
    </div>

    <c:if test="${sessionScope.isAttending eq true}">
        <h3>You are attending this meetup!</h3>
        <form action="unattendMeetup.do">
            <input type="hidden" name="meetupId" value="${meetup.id}">
            <input type="hidden" name="userId" value="${sessionScope.loggedInUser.id}">
            <input type="submit" value="Flake on this meetup">
        </form>

        <form action="addCommentToMeetup.do">
            <input type="text" name="commentText" maxlength="400" >
            <input type="hidden" name="id" value="${meetup.id}">
            <input type="submit" value="Submit comment">
        </form>
    </c:if>

    <c:if test="${sessionScope.isAttending eq false}">
        <form action="joinMeetup.do">
            <input type="hidden" name="meetupId" value="${meetup.id}">
            <input type="submit" value="Join this meetup!">
        </form>
    </c:if>

    <c:if test="${sessionScope.loggedInUser.id eq meetup.creator.id}">
        <a href="deleteMeetup.do?id=${meetup.id}">
        <button type="button" class="btn btn-danger">DELETE THIS MEETUP</button></a>
    </c:if>

</div>

<!-- Bootstrap JS -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>
