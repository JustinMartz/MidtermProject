package com.skilldistillery.parkpals.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.MeetupDAO;
import com.skilldistillery.parkpals.data.TrailDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.MeetupRating;
import com.skilldistillery.parkpals.entities.Trail;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class MeetupController {

	@Autowired
	private MeetupDAO meetupDao;
	@Autowired
	private UserDAO userDao;

	@Autowired
	private TrailDAO trailDao;

	@RequestMapping(path = "displayMeetup.do")
	public String displayMeetup(Model model, HttpSession session, int id) {
		User userToCheck = (User) session.getAttribute("loggedInUser");
		Meetup meetup = meetupDao.findMeetupById(id);
		Trail trail = trailDao.findTrailById(id);
		if (userToCheck == null) {
			model.addAttribute("notLoggedIn", true);
			model.addAttribute("trail", trail);
			return "viewTrail";
		}

		System.out.println(id);
		boolean isAttending = false;
		session.setAttribute("isAttending", isAttending);

		if (meetup != null) {
			User user = (User) session.getAttribute("loggedInUser");
			user = userDao.findUserById(user.getId());
			user.getMeetupRatings().size();
			session.setAttribute("loggedInUser", user);
			model.addAttribute("meetup", meetup);

			List<MeetupRating> meetupRatings = user.getMeetupRatings();
			for (MeetupRating meetupRating : meetupRatings) {
				if (meetupRating.getMeetup().getId() == id) {
					isAttending = true;
					System.out.println("***********************");
					System.out.println("USER IS ATTENDING MEETUP " + id);
					System.out.println("***********************");
					session.setAttribute("isAttending", isAttending);
					session.setAttribute("loggedInUser", user);
				}
			}
			return "viewMeetup";
		}

		return "error";
	}

	@RequestMapping(path = "joinMeetup.do")
	public String joinMeetup(Model model, HttpSession session, int meetupId) {
		Meetup meetupToAdd = meetupDao.findMeetupById(meetupId);
		User userToAddToMeetup = (User) session.getAttribute("loggedInUser");

		if (meetupDao.addMeetupToUser(userToAddToMeetup, meetupToAdd)) {
			session.setAttribute("isAttending", true);
			session.setAttribute("loggedInUser", userToAddToMeetup);

			model.addAttribute("meetup", meetupToAdd);
			return "viewMeetup";
		}

		for (Meetup meetup : userToAddToMeetup.getMeetups()) {
			System.out.println("*****************************************");
			System.out.println(meetup + "**********************************************");

		}

		return "error";
	}

	@RequestMapping(path = "unattendMeetup.do")
	public String unattendMeetup(Model model, HttpSession session, int meetupId) {
		Meetup meetupToRemoveThyselfFrom = meetupDao.findMeetupById(meetupId);
		User userToRemoveFromMeetup = (User) session.getAttribute("loggedInUser");

		if (meetupDao.removeUserFromMeetup(userToRemoveFromMeetup, meetupToRemoveThyselfFrom)) {
			session.setAttribute("isAttending", false);
			session.setAttribute("loggedInUser", userToRemoveFromMeetup);
			model.addAttribute("meetup", meetupToRemoveThyselfFrom);
			return "viewMeetup";

		}

		return "error";
	}

}
