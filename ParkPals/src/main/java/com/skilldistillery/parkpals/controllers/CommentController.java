package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.CommentDAO;
import com.skilldistillery.parkpals.data.MeetupDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class CommentController {

	@Autowired
	private MeetupDAO meetupDao;
	@Autowired
	private CommentDAO commentDao;
	@Autowired
	private UserDAO userDao;

	@RequestMapping(path = "addCommentToMeetup.do")
	public String addCommentToMeetup(Model model, int id, String commentText, HttpSession session) {

		User user = (User) session.getAttribute("loggedInUser");
		Meetup meetup = meetupDao.findMeetupById(id);
		System.out.println("*****************************************************************");
		System.out.println("*****************************************************************");

		if (meetup != null) {
			boolean addedComment = commentDao.addCommentToMeetup(user, meetup, commentText);
			if (addedComment) {
				session.setAttribute("loggedInUser",
						userDao.findByUsernameAndPassword(user.getUsername(), user.getPassword()));
				session.setAttribute("meetupComments", meetupDao.findAllMeetupCommentsForMeetup(id));
				return "viewMeetup";
			}

		}
		return "error";
	}

}