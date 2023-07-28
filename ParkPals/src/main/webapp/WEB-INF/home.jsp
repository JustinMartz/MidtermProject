<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Park Pals - National Park Network</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<!-- Custom CSS -->
<link href="../css/main.css" rel="stylesheet">

<style>
body {

	background-repeat: no-repeat;
	background-size: contain;
	background-position: center;
	background-attachment: fixed;
	background-color: #ffffff;
}
</style>
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



	<div class="container mt-5">
		<h1 class="text-center" >Park Pals</h1>
		<h2 class="text-center">A National Park Network</h2>

		<div class="colored-box-container">
			<div class="colored-box">
				<div class="block text">
					Welcome to ParkPals, the ultimate web program for National Park
					enthusiasts. Join our vibrant community to create meetups, <br>make
					friends, and explore the best-rated trails. Unleash the beauty of
					nature with like-minded adventurers at ParkPals!
				</div>
			</div>
		</div>



		<div class="row">
			<c:forEach var="park" items="${parks}">
				<div class="col-md-2 col-lg" container="lg">
					<a href="displayPark.do?id=${park.id}"> <img
						src="../images/${park.imageUrl}" class="img-fluid rounded">
					</a>
					<p class="text-center">${park.name}</p>
				</div>
			</c:forEach>

		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>
</html>
