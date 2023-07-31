package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.parkpals.data.ParkDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.Address;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class UpdateUserProfileController {
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private ParkDAO parkDao;

	@RequestMapping(path = "editProfile.do")
	public String editUserProfile(Model model, HttpSession session) {
//		User user = userDao.findUserById(id);
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "home";
			// FIXME Work on redirecting this to an error page
		}
		
		session.setAttribute("loggedInUser", user);

		return "editProfile";
	}

	@RequestMapping(path = "updateUserInfo.do", method = RequestMethod.POST)
	public String updateUserAndAddress(Model model, User user, HttpSession session, Address address,
			@RequestParam int id) {
		User currentUser = (User) session.getAttribute("loggedInUser");
		if (currentUser != null) {

			
			User updateUser = userDao.update(user, currentUser.getId(), address);
			if (updateUser != null) {
				model.addAttribute("parks", parkDao.findAllParks());
				session.setAttribute("loggedInUser", userDao.findByUsernameAndPassword(currentUser.getUsername(), currentUser.getPassword()));
				return "profile";

			}
		}
		model.addAttribute("errorMessage", "Could not update users' info");

		return "error";

	}

}
