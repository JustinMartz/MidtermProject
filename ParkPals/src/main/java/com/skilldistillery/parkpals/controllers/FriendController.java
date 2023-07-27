package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.parkpals.data.FriendDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.User;

public class FriendController {
	
	@Autowired
	private UserDAO userDao;
	private FriendDAO freindDao;
	


	@RequestMapping(path = "friend.do", method = RequestMethod.GET)
	public String showFriendsList(Model model, HttpSession session, int id) {
		User userInSession = (User) session.getAttribute("loggedInUser");
		
		User notSureWhatToNameThis = 
		
		List<User> friendsList = loggedInUser.getFriends();
		model.addAttribute("friendsList", friendsList);
		return "profile";
		

		
	}
	
	
	
}
