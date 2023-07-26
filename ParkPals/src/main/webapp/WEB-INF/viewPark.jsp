<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Explore Park: ${park.name}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
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
    <div class="container">
        <h1>${park.name}</h1>
        <p>Welcome to ${park.name} - a breathtaking national park with a mix of natural wonders and thrilling adventures!</p>
        
        <h2>Highlights:</h2>
        <ul>
            <li>${park.notableFeatures}</li>
        </ul>
        
        <h2>Overview:</h2>
        <p>${park.description}</p>

        <h2>Location:</h2>
        <p>${park.address.street}</p>
        <p>${park.address.street2}</p>
        <p>${park.address.city}, ${park.address.state} ${park.address.zipCode}</p>
        <p>Phone: ${park.address.phone}</p>
        
        <div class="image-container">
            <img src="${park.imageUrl}" alt="${park.name}">
        </div>

        <h2>Explore Trails:</h2>
        <c:forEach var="trail" items="${park.trails}">
            <div class="trail">
                <h3><a href="displayTrail.do?id=${trail.id}">${trail.name}</a></h3>
                <p>${trail.description}</p>
            </div>
        </c:forEach>
    </div>
</body>
</html>
