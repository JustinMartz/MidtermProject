package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class UpdateUserProfileController {
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path = "editProfile.do")
	public String editUserProfile(Model model, HttpSession session,int id ) {
		User user = userDao.findUserById(id);
		if(user == null) {
			return "home"; //FIXME Work on redirecting this to an error page
		}
		session.setAttribute("loggedInUser", user);
		
		return "editProfile";
	}
	
}
		
			
		
		
		
