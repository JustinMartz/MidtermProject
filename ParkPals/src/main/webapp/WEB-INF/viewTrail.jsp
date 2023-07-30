<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trail Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
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
			 <a class="nav-link" href="profile.do">Welcome! ${loggedInUser.firstName}</a>
			 </li>
			<li class="nav-item">
			  <a class="nav-link active" aria-current="page" href="profile.do">View My Profile</a>
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

    <div class="container mt-5">
        <h1 class="text-center">${trail.name}</h1>
        <p class="lead text-center">Welcome to this amazing kick frog trail!</p>
        <div class="row mt-4">
            <div class="col-md-6">
                <p>${trail.description}</p>
                <p>Latitude: ${trail.latitude}</p>
                <p>Longitude: ${trail.longitude}</p>
                <p>Length: ${trail.lengthInMiles} miles</p>
                <p><img src="${trail.imageUrl}"></p>
            </div>
            <div class="col-md-6">
                <div class="row">
                <div class="col-md-12  text-right">
                <h2>Meetups</h2>
                <form action="createMeetup.do">
                <input type="hidden" name="id" value="${trail.id }">
                <input type="submit" value="Create meetup at this trail">
                </form></div></div>
                <ul class="list-group">
                    <c:forEach var="meetup" items="${trail.meetups}">
                       <c:if test="${meetup.active }">
                        <li class="list-group-item">
                            <a href="displayMeetup.do?id=${meetup.id}">${meetup.name}</a>
                            <c:if test="${notLoggedIn }"><div class="alert alert-warning alert-dismissible fade show" role="alert">
  <strong>Holy guacamole!</strong>Must be logged in to view this meetup.
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div></c:if>
                            <br>
                            ${meetup.description}
                        </li>
                        </c:if>
                    </c:forEach>
                </ul>
                <h2 class="mt-4">Amenities</h2>
                <ul class="list-group">
                    <c:forEach var="amenity" items="${trail.amenities}">
                        <li class="list-group-item">${amenity.name}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
