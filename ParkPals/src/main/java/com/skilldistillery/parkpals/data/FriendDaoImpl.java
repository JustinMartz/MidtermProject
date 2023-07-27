package com.skilldistillery.parkpals.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.User;

@Service
@Transactional
public class FriendDaoImpl implements FriendDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User findUserById(int userId) {
		return em.find(User.class, userId);

	}

	@Override
	public void addFriend(User user, User friend) {
		if (user.getFriends() == null) {
			user.setFriends(new ArrayList<>());
		}
		if (!user.getFriends().contains(friend)) {
			user.getFriends().add(friend);
			friend.getFriends().add(user);

			em.merge(user);
			em.merge(friend);
		}
	}

	@Override
	public void removeFriend(User user, User friend) {
		if (user.getFriends() != null && user.getFriends().contains(friend)) {
			user.getFriends().remove(friend);
			friend.getFriends().remove(user);

			em.merge(user);
			em.merge(friend);
		}
	}

}
