<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Explore Park: ${park.name}</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">

<link href="../css/main.css" rel="stylesheet">
<style>
body {
  background-color: rgba (10, 10, 10, 0.2); 
  background-image: url("../images/verdebackground.png");
  background-size: cover;
  background-position: center;
}


h1 {
	font-size: 36px;
	margin-bottom: 10px;
}

h2 {
	font-size: 28px;
	margin-bottom: 10px;
}

p {
	font-size: 16px;
	margin-bottom: 5px;
}

ul {
	list-style: disc;
	padding-left: 20px;
	margin-bottom: 10px;
}

a {
	color: #007bff;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.container {
	border: 1px solid #ccc;
	padding: 20px;
	border-radius: 5px;
	background-color: #f9f9f9;
	max-height: 800px;
	overflow: auto;
}

.image-container {
	text-align: center;
	margin-bottom: 20px;
}

.image-container img {
	max-width: 100%;
	max-height: 300px;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.trail {
	border: 1px solid #ccc;
	padding: 10px;
	border-radius: 5px;
	margin-bottom: 10px;
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

	<div class="container">
		<h1>${park.name}</h1>
		<p>Welcome to ${park.name} - a breathtaking national park with a
			mix of natural wonders and thrilling adventures!</p>

		<h2>Highlights:</h2>
		<ul>
			<li>${park.notableFeatures}</li>
		</ul>

		<h2>Overview:</h2>
		<p>${park.description}</p>

		<h2>Location:</h2>
		<p>${park.address.street}</p>
		<p>${park.address.street2}</p>
		<p>${park.address.city},${park.address.state}
			${park.address.zipCode}</p>
		<p>Phone: ${park.address.phone}</p>

		<div class="image-container">
			<img src="${park.imageUrl}" alt="${park.name}">
		</div>

		<h2>Explore Trails:</h2>
		<c:forEach var="trail" items="${park.trails}">
			<div class="trail">
				<h3>
					<a href="displayTrail.do?id=${trail.id}">${trail.name}</a>
				</h3>
				<p>${trail.description}</p>
			</div>
		</c:forEach>
	</div>
</body>
</html>
