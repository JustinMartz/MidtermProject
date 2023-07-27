package com.skilldistillery.parkpals.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.parkpals.data.CommentDAO;
import com.skilldistillery.parkpals.data.MeetupDAO;
import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class CommentController {

	@Autowired
	private MeetupDAO meetupDao;
	@Autowired
	private CommentDAO commentDao;

	@RequestMapping(path = "addCommentToMeetup.do", method = RequestMethod.POST)
	public String addCommentToMeetup(Model model, int meetupId, String commentText, User user) {

		Meetup meetup = meetupDao.findMeetupById(meetupId);
		if (meetup != null) {
			boolean addedComment = commentDao.addCommentToMeetup(user, meetup, commentText);
			if (addedComment) {
				return "viewMeetup";
			}

		}
		return "error";
	}
}