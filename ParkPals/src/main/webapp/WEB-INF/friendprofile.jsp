<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Friend's Profile</title>
<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
    crossorigin="anonymous">
<!-- Custom CSS -->
<link href="css/main.css" rel="stylesheet">
<style>
.console-container {
    display: flex;
    height: 100vh;
}

.left-block, .right-block {
    flex: 1;
    padding: 20px;
    border: 2px solid #ccc;
    border-radius: 10px;
    margin: 5px;
    overflow-y: auto; /* Enable vertical scrolling */
    max-height: calc(100vh - 20px);
}

.middle-container {
    flex: 3;
    display: flex;
    flex-direction: column;
    margin: 5px;
}

.middle-block {
    flex: 1;
    padding: 20px;
    border: 2px solid #ccc;
    border-radius: 10px;
    margin-bottom: 10px;
    overflow-y: auto; /* Enable vertical scrolling */
  
}
</style>
</head>
<body>
    <nav class="navbar navbar-expand-sm navbar-light bg-success">
	  <div class="container-fluid ">
		<a class="navbar-brand " href="home.do">Park Pals</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		  <span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
		  <ul class="navbar-nav ">
			<c:choose>
			<c:when test="${not empty sessionScope.loggedInUser }">
			<li class="nav-item">
			 Welcome! ${loggedInUser.firstName}
			 </li>
			<li class="nav-item">
			  <a class="nav-link active" aria-current="page" href="profile.do">View My Profile</a>
			</li>
			<li class="nav-item">
			  <a class="nav-link active" aria-current="page" href="editProfile.do">Edit My Profile</a>
			</li>
			<li class="nav-item">
			<a class="nav-link" href="logout.do">Log Out</a>
			</li>
			 </c:when>
			 <c:otherwise>
			 <li class="nav-item">
			 <a class="nav-link" href="register.do">Register</a>
			</li>
			<li class="nav-item">
			 <a class="nav-link" href="login.do">Log In</a>
			</li>			
			 </c:otherwise>
			 </c:choose>
		  </ul>		  
		</div>
	  </div>
	</nav>

    <div class="console-container">
        <div class="left-block">
            <!-- Friends List -->
            <h2>${friend.username}'s Friends</h2>
            <c:forEach items="${friend.friends}" var="viewFriend">
                <p>
                    <a href="friendprofile.do?userId=${viewFriend.id}">${viewFriend.firstName}
                        ${viewFriend.lastName}</a>
                </p>
            </c:forEach>
              <c:if test="${isFriend eq true }">
                    <form action="removeFriend.do" method="post">
                        <input type="hidden" name="friendId" value="${friend.id }">
                        <button type="submit">Remove Friend</button>
                    </form>
                </c:if>
                <c:if test="${isFriend ne true }">
                    <form action="addFriend.do" method="post">
                        <input type="hidden" name="friendId" value="${friend.id }">
                        <button type="submit">Let's Be Friends</button>
                    </form>
                </c:if>
        </div>

        <div class="middle-container">
            <div class="middle-block">
                <!-- Middle block Top -->
              <table>
              		<tr>
              		<td>
                <div class="image-container">
					<img src="images/${friend.imageUrl}" alt="Profile Photo"
						class="profile-image" style="width:250px; height:auto;" align="left" >
						</td>
						<td width="40%">
<br>
				</div>

                <h1 class="text-center">${friend.username}'s Profile</h1>
                <p class="text-center">
                    Username: ${friend.username}<br> First Name:
                    ${friend.firstName}<br> Last Name: ${friend.lastName}<br>
                    About Me: ${friend.aboutme}
                </p>
                </td>
                </tr>
                </table>
                <div class="list-group">

					<!-- Middle block -->
					<h2>Meetups Attending:</h2>
					<c:forEach items="${friend.meetupRatings }" var="meetupRating">
						<div class="d-flex w-100 justify-content-between">
							<a href="displayMeetup.do?id=${meetupRating.meetup.id}" class="list-group-item list-group-item-action active" aria-current="true"><h4>${meetupRating.meetup.name}</h4>
							<h5 class="mb-1">${meetupRating.meetup.description }</h5>
							<img src="images/${meetupRating.meetup.imageUrl }" style="height: 100px; width: auto;">
						</div>
						<br>
						</a>
					</c:forEach>

				</div>
                <!-- Middle Block Bottom-->
            </div>

           
        </div>

        <div class="right-block">
        <div class="list-group">
        
            <h4>Explore The Parks</h4>
            <c:forEach var="park" items="${parks}">
                <a href="displayPark.do?id=${park.id}" class="list-group-item list-group-item-action">${park.name}</a>
                <br>
            </c:forEach>
        </div>
    </div>
</div>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>