package com.skilldistillery.parkpals.data;

import java.util.List;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.MeetupRating;
import com.skilldistillery.parkpals.entities.User;

public interface MeetupDAO {

	public Meetup findMeetupById(int id);
	public boolean addMeetupToUser(User user, Meetup meetup);
	public boolean removeUserFromMeetup(User user, Meetup meetup);
	public boolean deleteMeetup(User user, Meetup meetup);
	public List<Meetup> findAllMeetups();
	public List<MeetupRating> findAllMeetupRatingsForMeetup(Meetup meetup);

}
