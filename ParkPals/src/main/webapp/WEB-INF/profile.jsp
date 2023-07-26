<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <div class="container mt-5">
        <h1 class="text-center">User Profile</h1>

        <div class="row justify-content-center">
            <div class="col-lg-6">
                <p class="text-center">
                    Username: ${loggedInUser.username}<br>
                    First Name: ${loggedInUser.firstName}<br>
                    Last Name: ${loggedInUser.lastName}<br>
                    About Me: ${loggedInUser.aboutme}
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
