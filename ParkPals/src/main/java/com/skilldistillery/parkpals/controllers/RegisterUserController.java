
package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.Address;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class RegisterUserController {
	
	@Autowired
	private UserDAO userDao;
	@RequestMapping(path= {"/", "home.do"})
	public String home(Model model) {
//		model.addAttribute("DELETEME", userDao.findByUsernameAndPassword("admin", "1234"));
		return "home";
	}
	
	@RequestMapping(path = "register.do")
	public String register(Model model, HttpSession session) {
		
		return "register";
	}
	@RequestMapping(path= "submitUser.do")
	public String continueRegistration(Model model, User user, Address address, HttpSession session) {
	// Add error checking for proper input fields to create user. 
		model.addAttribute("user", user);
		 System.out.println("**" + user);
		System.out.println("**" + address);
		userDao.addAddress(address);
		user.setAddress(address);
		userDao.addUser(user);
		
		return "profile"; 
		
	}
	
	
}
