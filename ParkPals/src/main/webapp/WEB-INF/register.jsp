<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register New User</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
</head>

<body>
    <div class="container mt-5">
        <h1 class="text-center">Register Your New User HERE!</h1>
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <form action="submitUser.do" method="POST">
                    <div class="form-group">
                        <label for="username">User Name:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="aboutme">About Me:</label>
                        <input type="text" class="form-control" id="aboutme" name="aboutme">
                    </div>
                    <div class="form-group">
                        <label>Address:</label>
                        <input type="text" class="form-control" name="street" placeholder="Street" required>
                        <input type="text" class="form-control mt-2" name="city" placeholder="City" required>
                        <input type="text" class="form-control mt-2" name="state" placeholder="State" required>
                        <input type="text" class="form-control mt-2" name="zipCode" placeholder="Zip Code" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Click to continue</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
