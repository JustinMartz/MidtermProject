<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update User Profile</title>
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
	
    <div class="container mt-5">
        <h1 class="text-center">Update User Profile</h1>

        <div class="row justify-content-center">
            <div class="col-lg-6">
                <form action="updateUserInfo.do" method="POST">
                    <div class="form-group">
                        <label for="username">User Name:</label>
                        <input type="text" class="form-control" id="username" name="username" value="${loggedInUser.username}" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" value="${loggedInUser.password}" required>
                    </div>

                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="${loggedInUser.firstName}" required>
                    </div>

                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="${loggedInUser.lastName}" required>
                    </div>

                    <div class="form-group">
                        <label for="aboutme">About Me:</label>
                        <input type="text" class="form-control" id="aboutme" name="aboutme" value="${loggedInUser.aboutme}">
                    </div>

                    <div class="form-group">
                        <label for="imageUrl">Profile Image URL:</label>
                        <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${loggedInUser.imageUrl}">
                    </div>

                    <div class="form-group">
                        <label for="street">Street:</label>
                        <input type="text" class="form-control" id="street" name="street" value="${loggedInUser.address.street}">
                    </div>

                    <div class="form-group">
                        <label for="street2">Unit/Suite/Apartment:</label>
                        <input type="text" class="form-control" id="street2" name="street2" value="${loggedInUser.address.street2}">
                    </div>

                    <div class="form-group">
                        <label for="city">City:</label>
                        <input type="text" class="form-control" id="city" name="city" value="${loggedInUser.address.city}">
                    </div>

                    <div class="form-group">
                        <label for="state">State:</label>
                        <input type="text" class="form-control" id="state" name="state" value="${loggedInUser.address.state}">
                    </div>

                    <div class="form-group">
                        <label for="zipCode">Zip Code:</label>
                        <input type="text" class="form-control" id="zipCode" name="zipCode" value="${loggedInUser.address.zipCode}">
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="${loggedInUser.address.phone}">
                    </div>

                    <input type="hidden" name="id" value="${loggedInUser.id}">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
