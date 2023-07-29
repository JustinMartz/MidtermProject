package com.skilldistillery.parkpals.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.parkpals.data.ParkDAO;
import com.skilldistillery.parkpals.data.UserDAO;
import com.skilldistillery.parkpals.entities.User;

@Controller
public class UserCRUDController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	private ParkDAO parkDao;

	@RequestMapping(path = "deactivateAccount.do", method = RequestMethod.POST)
	public String deactivateAccount(Model model, HttpSession session) {
		User currentUser = (User) session.getAttribute("loggedInUser");
		if (currentUser != null) {
			Boolean deactivatedAccount = userDao.deactivateUser(currentUser.getId());
			if (deactivatedAccount == true) {
				return "home";
			} else {
				return "error";
			}
		}

		return "login";
	}

	@RequestMapping(path = "addFriend.do", method = RequestMethod.POST)
	public String addFriend(@RequestParam("friendId") int friendId, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		if (loggedInUser != null) {
			User friend = userDao.findUserById(friendId);
			if (friend != null) {
				userDao.addFriend(loggedInUser, friend);
			}
		}

		return "redirect:/friendprofile.do?userId=" + friendId;

	}

	@RequestMapping(path = "removeFriend.do", method = RequestMethod.POST)
	public String removeFriend(@RequestParam("friendId") int friendId, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		if (loggedInUser != null) {
			User friend = userDao.findUserById(friendId);
			if (friend != null) {
				userDao.removeFriend(loggedInUser, friend);

			}
		}

		return "redirect:/friendprofile.do?userId=" + friendId;
	}

	@RequestMapping(path = "friendprofile.do", method = RequestMethod.GET)
	public String viewFriendProfile(@RequestParam("userId") int userId, Model model, HttpSession session) {
		User friendProfile = userDao.findUserById(userId);
		User user = (User) session.getAttribute("loggedInUser");
		if (friendProfile != null) {
			model.addAttribute("friend", friendProfile);
			if (user.getFriends().contains(friendProfile)) {
				model.addAttribute("isFriend", true);
			} else {
				model.addAttribute("isFriend", false);
			}
			model.addAttribute("parks", parkDao.findAllParks());
			return "friendprofile";
		}
		return "error";
	}
	@RequestMapping(path = "searchFriends.do", method = RequestMethod.GET)
	public String searchFriends(@RequestParam("name") String name, Model model, HttpSession session) {
	    User loggedInUser = (User) session.getAttribute("loggedInUser");

	    if (loggedInUser != null) {
	        List<User> searchResults = userDao.searchForUserByName(name);
	        if(searchResults != null) {
	        	if(searchResults.contains(loggedInUser)) {
	        		searchResults.remove(loggedInUser);
	        	}
	        	model.addAttribute("searchResults", searchResults);
	        } else {
	        model.addAttribute("error", "No User Found");
	    }
	    }
	    model.addAttribute("parks", parkDao.findAllParks());
	   	    return "profile";
	}

}