<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Login Page</h1>

        <div class="row justify-content-center">
            <div class="col-lg-4">
                <form action="login.do" method="POST">
                    <div class="form-group">
                        <label for="userName">User Name:</label>
                        <input type="text" class="form-control" id="userName" name="userName" required>
                    </div>

                    <div class="form-group">
                        <label for="passWord">Password:</label>
                        <input type="password" class="form-control" id="passWord" name="passWord" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
