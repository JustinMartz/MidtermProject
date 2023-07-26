package com.skilldistillery.parkpals.data;

import com.skilldistillery.parkpals.entities.Meetup;

public interface MeetupDAO {

	public Meetup findMeetupById(int id);
	
}
