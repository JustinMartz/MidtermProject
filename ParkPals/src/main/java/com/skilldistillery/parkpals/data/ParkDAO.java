package com.skilldistillery.parkpals.data;

import java.util.List;

import com.skilldistillery.parkpals.entities.Park;

public interface ParkDAO {

	public List<Park> findAllParks();

	public Park findParkById(int id);
	
}
