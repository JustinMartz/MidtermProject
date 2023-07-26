package com.skilldistillery.parkpals.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.Park;

@Service
@Transactional
public class MeetupDaoImpl implements MeetupDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Meetup findMeetupById(int id) {
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		Meetup meetup = em.find(Meetup.class, id);
		System.out.println(meetup);
		return meetup;

	}

}
