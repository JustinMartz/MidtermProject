package com.skilldistillery.parkpals.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.MeetupRating;
import com.skilldistillery.parkpals.entities.MeetupRatingId;
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
	public boolean addMeetupToUser(User user, Meetup meetup) {
		boolean added = false;
		User curUser = em.find(User.class, user.getId());
		
		System.out.println("********************************************");
		System.out.println("********************************************");
		System.out.println("********************************************");
		System.out.println("User: " + user.getUsername());
		System.out.println("Meetup: " + meetup.getName());
		
		for (MeetupRating rating : user.getMeetupRatings()) {
			if (rating.getMeetup().getId() == meetup.getId()) {
				System.out.println("USER ALREADY PARTICIPANT OF MEETUP");
				return added;
			}

		}
		
			MeetupRatingId id = new MeetupRatingId(user.getId(), meetup.getId());
			System.out.println("MeetupRatingId: " + id);
			MeetupRating newParticipant = new MeetupRating();
			System.out.println("MeetupRating: " + newParticipant);
			newParticipant.setId(id);
			newParticipant.setUser(user);
			newParticipant.setMeetup(meetup);
			System.out.println("MeetupRating: " + newParticipant);
			curUser.addMeetupRating(newParticipant);
			em.persist(newParticipant);
			em.flush();
			added = true;
			
		return added;

	}

}
