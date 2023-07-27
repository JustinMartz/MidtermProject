<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
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
        <h1 class="text-center">User Profile</h1>

        <div class="row justify-content-center">
            <div class="col-lg-6">
                <p class="text-center">
                    Username: ${loggedInUser.username}<br>
                    First Name: ${loggedInUser.firstName}<br>
                    Last Name: ${loggedInUser.lastName}<br>
                    About Me: ${loggedInUser.aboutme}
                    <h2>Meetups Attending:</h2>
                    <c:forEach items="${loggedInUser.meetupRatings }" var="meetupRating">
                    <strong>${meetupRating.meetup.name }</strong><br>
                    </c:forEach>
                </p>

                <form action="deactivateAccount.do" method="POST" class="text-center">
                    <input type="hidden" name="id" value="${loggedInUser.id}">
                    <button type="submit" class="btn btn-danger">Delete My Account Forever</button>
                </form>

                <form action="editProfile.do" method="POST" class="text-center mt-3">
                    <input type="hidden" name="id" value="${loggedInUser.id}">
                    <button type="submit" class="btn btn-primary">Edit Profile</button>
                </form>
                <a href="home.do"> <button  class="btn btn-primary">Home</button></a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
