package com.skilldistillery.parkpals.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.parkpals.data.TrailDAO;
import com.skilldistillery.parkpals.entities.Trail;

@Controller
public class TrailController {

	@Autowired
	private TrailDAO trailDao; 
	
	@RequestMapping(path = "displayTrail.do")
	public String displayTrail(Model model, HttpSession session, int id) {
		
		Trail trail = trailDao.findTrailById(id);
		if (trail != null) {
			model.addAttribute("trail", trail);
			return "viewTrail";
		}
		return "error";
	}
}
