<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Meetup Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
          crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="../css/main.css" rel="stylesheet">
    <style>
        /* Add any additional custom styles here */

        .comment-box {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
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
                        <li class="nav-item"><a class="nav-link active"
                                                aria-current="page" href="profile.do">View My Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.do">Log Out</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="register.do">Register</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="login.do">Log In</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-3">
    <h1>${meetup.name}</h1>
    <p>Date: ${meetup.meetupDate}</p>
    <p>Start Time: ${meetup.startTime}</p>
    <p>End Time: ${meetup.endTime}</p>
    <p>Description: ${meetup.description}</p>
    <p>Image URL: ${meetup.imageUrl}</p>
    <p>Trail Description: ${meetup.trail.description}</p>
    <h3>Created by: ${meetup.creator.firstName}</h3>

    <c:forEach var="rating" items="${meetup.meetupRatings}">
        <h2>Trail Rating: ${rating.rating}</h2>
        <h2>Comments about this trail: ${rating.comment}</h2>
    </c:forEach>

    <div class="comment-box">
        <c:forEach var="meetupComment" items="${sessionScope.meetupComments}">
            <h2>${meetupComment.comment}</h2>
            <h3>${meetupComment.user.username}</h3>
            <h4>${meetupComment.commentDate}</h4>
        </c:forEach>
    </div>

    <c:if test="${sessionScope.isAttending eq true}">
        <h1>You are attending this meetup!</h1>
        <form action="unattendMeetup.do">
            <input type="hidden" name="meetupId" value="${meetup.id}">
            <input type="hidden" name="userId" value="${sessionScope.loggedInUser.id}">
            <input type="submit" value="Flake on this meetup">
        </form>

        <form action="addCommentToMeetup.do">
            <input type="text" name="commentText" maxlength="400">
            <input type="hidden" name="id" value="${meetup.id}">
            <input type="submit" value="Submit comment">
        </form>
    </c:if>

    <c:if test="${sessionScope.isAttending eq false}">
        <form action="joinMeetup.do">
            <input type="hidden" name="meetupId" value="${meetup.id}">
            <input type="submit" value="Join this meetup!">
        </form>
    </c:if>

    <c:if test="${sessionScope.loggedInUser.id eq meetup.creator.id}">
        <h1><a href="deleteMeetup.do?id=${meetup.id}">DELETE THIS MEETUP</a></h1>
    </c:if>

</div>

<!-- Bootstrap JS -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>
