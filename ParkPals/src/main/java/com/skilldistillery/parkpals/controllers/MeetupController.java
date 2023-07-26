package com.skilldistillery.parkpals.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.MeetupDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class MeetupController {

	@Autowired
	private MeetupDAO meetupDao;
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path = "displayMeetup.do")
	public String displayMeetup(Model model, HttpSession session, int id) {
		System.out.println(id);
		Meetup meetup = meetupDao.findMeetupById(id);
		if (meetup != null) {
			User user = (User) session.getAttribute("loggedInUser");
			user = userDao.findUserById(user.getId());
			user.getMeetupRatings().size();
			session.setAttribute("loggedInUser", user);
			model.addAttribute("meetup", meetup);
			List<Meetup> meetups = user.getMeetups();
			session.setAttribute("userMeetups", meetups);
			return "viewMeetup";
		}
		
		
		return "error";
	}
	
	
	
}
