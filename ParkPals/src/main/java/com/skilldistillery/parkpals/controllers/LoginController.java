package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.parkpals.data.ParkDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class LoginController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	private ParkDAO parkDao;
	
	
	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String showLoginPage(Model model) {
	
		return "login";
		
	}
	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String showLoginPage(Model model, String userName, String passWord, HttpSession session) {
		User user = userDao.findByUsernameAndPassword(userName, passWord);
		System.out.println("****************************");
		System.out.println(" " + userName + passWord);
		System.out.println("****************************");
		if(user == null) {
			return "home";
		}else {
			session.setAttribute("loggedInUser", user);
			return "profile";
		}
		
	}
	@RequestMapping(path = "profile.do", method = RequestMethod.GET)
	public String showProfile(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "login";
		}
		
		session.setAttribute("loggedInUser", userDao.findByUsernameAndPassword(user.getUsername(), user.getPassword()));
		return "profile";
	}
	
	@RequestMapping(path = "logout.do")
	 public String logout(Model model, HttpSession session) {
	  String viewName = null;
	  model.addAttribute("parks", parkDao.findAllParks());
	  session.removeAttribute("loggedInUser");
	  viewName = "home";
	  return viewName;

	 }
}
