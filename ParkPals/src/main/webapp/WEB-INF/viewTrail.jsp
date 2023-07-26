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
    <div class="container mt-5">
        <h1 class="text-center">${trail.name}</h1>
        <p class="lead text-center">Welcome to this amazing kick frog trail!</p>
        <div class="row mt-4">
            <div class="col-md-6">
                <p>${trail.description}</p>
                <p>Latitude: ${trail.latitude}</p>
                <p>Longitude: ${trail.longitude}</p>
                <p>Length: ${trail.lengthInMiles} miles</p>
                <p>Image URL: ${trail.imageUrl}</p>
            </div>
            <div class="col-md-6">
                <h2>Meetups</h2>
                <ul class="list-group">
                    <c:forEach var="meetup" items="${trail.meetups}">
                        <li class="list-group-item">
                            <a href="displayMeetup.do?id=${meetup.id}">${meetup.name}</a>
                            <br>
                            ${meetup.description}
                        </li>
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
