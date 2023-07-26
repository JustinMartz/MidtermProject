<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Park Pals - National Park Network</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Park Pals</h1>
        <h2 class="text-center">A National Park Network</h2>

        <div class="text-center mt-4">
            <a href="login.do" class="btn btn-secondary mt-3">Login</a> <br>
            <br>
            <a href="register.do" class="btn btn-primary">Register a New User</a><br>
        </div>

        <h2 class="text-center">${DELETEME}</h2>

        <table class="table table-bordered mt-5">
            <thead>
                <tr>
                    <th>Park Name</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="park" items="${parks}">
                    <tr>
                        <td><a href="displayPark.do?id=${park.id}">${park.name}</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
