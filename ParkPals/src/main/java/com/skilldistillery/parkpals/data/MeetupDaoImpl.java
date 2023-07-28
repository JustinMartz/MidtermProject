package com.skilldistillery.parkpals.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.MeetupComment;
import com.skilldistillery.parkpals.entities.MeetupRating;
import com.skilldistillery.parkpals.entities.MeetupRatingId;
import com.skilldistillery.parkpals.entities.Trail;
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
	public List<Meetup> findAllMeetups() {
		String query = "SELECT m FROM Meetup m WHERE m.active='true'";
		return em.createQuery(query, Meetup.class).getResultList();
	}

	@Override
	public List<MeetupRating> findAllMeetupRatingsForMeetup(Meetup meetup) {
		int meetupId = meetup.getId();
		String query = "SELECT mr FROM MeetupRating mr JOIN Meetup m ON m.id = mr.meetup.id WHERE m.id = :id";
		List<MeetupRating> temp = em.createQuery(query, MeetupRating.class).setParameter("id", meetupId)
				.getResultList();
		System.out.println("************************************************");
		System.out.println("in findAllMeetupRatingsForMeetup()");
		for (MeetupRating rating : temp) {
//			System.out.println(rating);
		}
		return temp;

	}

	@Override
	public boolean addMeetupToUser(User user, Meetup meetup) {
		boolean added = false;
		User curUser = em.find(User.class, user.getId());
//		if (! curUser.getActive() ) {
//			return false; 
//		}
//		DELETE THIS COMMENT LATER THIS IS JUST A REFERENCE TO REMEMBER!
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

	@Override
	public boolean removeUserFromMeetup(User user, Meetup meetup) {
		User curUser = em.find(User.class, user.getId());

		for (MeetupRating rating : user.getMeetupRatings()) {
			if (rating.getMeetup().getId() == meetup.getId()) {
				MeetupRating ratingToRemove = em.find(MeetupRating.class, rating.getId());

				curUser.removeMeetupRating(ratingToRemove);
				em.remove(ratingToRemove);
				return true;
			}
		}

		return false;
	}

	@Override
	public boolean deleteMeetup(User user, Meetup meetup) {
		User creator = em.find(User.class, user.getId());
		Meetup meetupToDelete = em.find(Meetup.class, meetup.getId());

		// get all meetupratings associated with meetupToDelete
		// remove those from database
		System.out.println("==================================");
		System.out.println("All MeetupRatings associated with Meetup: " + meetup.getName());
		System.out.println("==================================");
		for (MeetupRating rating : findAllMeetupRatingsForMeetup(meetup)) {
			System.out.println("ARE WE EVEN GETTING HERE");
			System.out.println(rating);
			// remove rating from database
			em.remove(rating);
			em.flush();
		}

		// get all meetupcomments associated with meetupToDelete
		// those all to inactive

		System.out.println("*******************************");
		System.out.println("*******************************");
		System.out.println("*******************************");
		System.out.println(creator);
		System.out.println(meetupToDelete);

		meetupToDelete.setActive(false);
		System.out.println(meetupToDelete);

		creator.removeMeetup(meetupToDelete);
		System.out.println("WE HERE NOW");

		meetupToDelete.setCreator(creator);
		em.merge(meetupToDelete);
		em.merge(creator);

		return true;
	}

	@Override
	public List<MeetupComment> findAllMeetupCommentsForMeetup(int meetupId) {
		String query = "SELECT mc FROM MeetupComment mc JOIN Meetup m ON m.id = mc.meetup.id WHERE m.id = :id";
		List<MeetupComment> comments = em.createQuery(query, MeetupComment.class).setParameter("id", meetupId)
				.getResultList();

		return comments;
	}

	@Override
	public Meetup createMeetup(User user, Meetup meetup, Trail trailId) {
		Meetup meetupToCreate = new Meetup();
		User userWhoCreatesMeetup = em.find(User.class, user.getId());
		Trail trailForMeetupCreation = em.find(Trail.class, trailId);
		meetupToCreate.setActive(true);
		meetupToCreate.setName(meetup.getName());
		meetupToCreate.setMeetupDate(meetup.getMeetupDate());
		meetupToCreate.setStartTime(meetup.getStartTime());
		meetupToCreate.setEndTime(meetup.getEndTime());
		meetupToCreate.setDescription(meetup.getDescription());
		meetupToCreate.setImageUrl(meetup.getImageUrl());
		meetupToCreate.setCreator(userWhoCreatesMeetup);
		meetupToCreate.setTrail(trailForMeetupCreation);
		trailForMeetupCreation.addMeetup(meetupToCreate);
		addMeetupToUser(userWhoCreatesMeetup,meetupToCreate);
		userWhoCreatesMeetup.addMeetup(meetupToCreate);
		em.persist(meetupToCreate);
		em.flush();
		return meetup;
	}

}
