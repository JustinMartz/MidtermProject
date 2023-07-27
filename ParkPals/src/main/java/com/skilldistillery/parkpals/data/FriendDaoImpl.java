package com.skilldistillery.parkpals.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

@Service
@Transactional
public class FriendDaoImpl implements FriendDAO	{
	
	@PersistenceContext
	private EntityManager em;
	
	
	@Override
	public User findFriendById(int id) {
		return null;
	}


	@Override
	public Meetup findFriendId(int id) {
		// TODO Auto-generated method stub
		return null;
	}
		


}
