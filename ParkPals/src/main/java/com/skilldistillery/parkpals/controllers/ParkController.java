package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.ParkDAO;
import com.skilldistillery.parkpals.entities.Park;

@Controller
public class ParkController {

	@Autowired
	private ParkDAO parkDao;
	
	@RequestMapping(path = "displayPark.do")
	public String displayPark(Model model, HttpSession session, int id) {
		
		Park park = parkDao.findParkById(id);
		if (park != null) {
			model.addAttribute("park", park);
			return "viewPark";
		}
		
		return "error";
		
	}
}
