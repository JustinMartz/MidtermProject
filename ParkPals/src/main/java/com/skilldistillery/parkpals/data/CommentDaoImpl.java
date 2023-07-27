package com.skilldistillery.parkpals.data;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.MeetupComment;
import com.skilldistillery.parkpals.entities.User;

@Service
@Transactional

public class CommentDaoImpl implements CommentDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public List<MeetupComment> findAllComments() {
		String jpql = "SELECT c FROM MeetupComment c WHERE c.active = 'true'";

		return em.createQuery(jpql, MeetupComment.class).getResultList();

	}

	@Override
	public boolean addCommentToMeetup(User user, Meetup meetup, String meetupComment) {
		Meetup meetupToReceiveComment = em.find(Meetup.class, meetup.getId());
		User commenter = em.find(User.class, user.getId());
		
		if(meetupToReceiveComment != null && commenter != null) {
			MeetupComment newComment = new MeetupComment();
			newComment.setCommentDate(LocalDateTime.now()); 
			newComment.setComment(meetupComment);
			newComment.setActive(true);
			newComment.setMeetup(meetupToReceiveComment);
			newComment.setUser(commenter);
			
			meetupToReceiveComment.addMeetupComment(newComment);
			em.persist(newComment);
			em.flush();
			return true;
		}

		return false;
	}
	
}


















