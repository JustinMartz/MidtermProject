package com.skilldistillery.parkpals.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

@Service
@Transactional
public class MeetupDaoImpl implements MeetupDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Meetup findMeetupById(int id) {
		Meetup meetup = em.find(Meetup.class, id);
		System.out.println(meetup);
		return meetup;

	}

	@Override
	public User addMeetupToUser(User user, Meetup meetup) {
		
		if(user.getMeetups().add(meetup)) {
			em.flush();
			return user;
		}

		return null;
	}

}
