package com.skilldistillery.parkpals.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.parkpals.data.UserDAO;

@Controller
public class UserController {
	@Autowired
	private UserDAO userDao;
}
