
package com.skilldistillery.parkpals.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.UserDAO;

@Controller
public class UserController {
	@Autowired
	private UserDAO userDao;
	@RequestMapping(path= {"/", "home.do"})
	public String home(Model model) {
		model.addAttribute("DELETEME", userDao.findByUsernameAndPassword("admin", "1234"));
		return "home";
	}
}
