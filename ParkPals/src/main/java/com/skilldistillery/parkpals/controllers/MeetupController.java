package com.skilldistillery.parkpals.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.MeetupDAO;
import com.skilldistillery.parkpals.entities.Meetup;

@Controller
public class MeetupController {

	@Autowired
	private MeetupDAO meetupDao;
	
	@RequestMapping(path = "displayMeetup.do")
	public String displayMeetup(Model model, int id) {
		Meetup meetup = meetupDao.findMeetupById(id);
		if (meetup != null) {
			model.addAttribute("meetup", meetup);
			return "viewMeetup";
		}
		
		
		return "error";
	}
	
}
