<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Uh oh!</h1>

        <div class="row justify-content-center">
            <div class="col-lg-6">
                <p class="text-center">
                    <strong>Error message:</strong> ${errorMessage }
                </p>

                <p class="text-center sass">
                    Well, look who stumbled into the error zone! 🤨<br>
                    Fear not, it's just a little hiccup in the matrix. 😏<br>
                    But hey, even the best of us make mistakes sometimes. 😜<br>
                    Let's shake it off and get back on track, shall we? 🚀<br>
                </p>

                <p class="text-center">
                    <a href="home.do" class="btn btn-primary">Home</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
