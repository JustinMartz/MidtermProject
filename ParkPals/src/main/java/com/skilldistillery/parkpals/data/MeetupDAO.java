package com.skilldistillery.parkpals.data;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

public interface MeetupDAO {

	public Meetup findMeetupById(int id);
	public boolean addMeetupToUser(User user, Meetup meetup);


	
}
