
package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.ParkDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.Address;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class RegisterUserController {
	
	@Autowired
	private UserDAO userDao;
	@Autowired
	private ParkDAO parkDao; 
	@RequestMapping(path= {"/", "home.do"})
	public String home(Model model) {
//		model.addAttribute("DELETEME", userDao.findByUsernameAndPassword("admin", "1234"));
		model.addAttribute("parks", parkDao.findAllParks());
		return "home";
	}
	
	@RequestMapping(path = "register.do")
	public String register(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if(user == null) {
			return "register";
		}else {
			model.addAttribute("parks", parkDao.findAllParks());
			return "profile";
		}

	}
	@RequestMapping(path= "submitUser.do")
	public String continueRegistration(Model model, User user, Address address, HttpSession session) {
		model.addAttribute("user", user);
		userDao.addAddress(address);
		user.setAddress(address);
		userDao.addUser(user);
		session.setAttribute("loggedInUser", user);
		model.addAttribute("parks", parkDao.findAllParks());
		return "profile"; 
		
	}
	
	
}
