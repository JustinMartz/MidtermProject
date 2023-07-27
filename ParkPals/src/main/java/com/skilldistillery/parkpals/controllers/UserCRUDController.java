package com.skilldistillery.parkpals.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class UserCRUDController {

	@Autowired
	private UserDAO userDao;

	@RequestMapping(path = "deactivateAccount.do", method = RequestMethod.POST)
	public String deactivateAccount(Model model, HttpSession session) {		
		User currentUser = (User) session.getAttribute("loggedInUser");
		if(currentUser != null) {
			Boolean deactivatedAccount = userDao.deactivateUser(currentUser.getId());
			if(deactivatedAccount == true) {
				return "home";
			}
			else {
				return "error";
			}
		}


		return "login";
	}
	
	@RequestMapping (path = "viewFriends.do", method = RequestMethod.GET)
	public String viewFreinds(Model model, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		System.out.println(loggedInUser + "************************************************");
		
		if(loggedInUser != null) {
			List<User> friends = userDao.findFriendsByUserId(loggedInUser.getId());
			System.out.println(friends + "****************************************************");
			model.addAttribute("friends", friends);
			session.setAttribute("friends", friends);
			session.setAttribute("loggedInUser", loggedInUser);
			return "profile";
			
		}
		return "error";
		
	}
	

}