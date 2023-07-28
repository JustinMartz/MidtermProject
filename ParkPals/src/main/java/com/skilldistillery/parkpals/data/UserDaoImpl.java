package com.skilldistillery.parkpals.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Address;
import com.skilldistillery.parkpals.entities.User;

@Service
@Transactional
public class UserDaoImpl implements UserDAO {
	@PersistenceContext
	private EntityManager em;

	@Override
	public User findUserById(int id) {

		return em.find(User.class, id);
	}

	@Override
	public User findByUsernameAndPassword(String username, String password) {
		String jpql = "SELECT u FROM User u WHERE u.username = :un AND u.password = :pw AND u.active = true";
		User user = null;
		try {
			user = em.createQuery(jpql, User.class).setParameter("un", username).setParameter("pw", password)
					.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Invalid username or password");
		}

		return user;
	}

	@Override
	public User addUser(User user) {
		try {
			user.setActive(true);
			em.persist(user);

		} catch (EntityExistsException e) {
			System.err.print(e);
			return null;
		}
		return user;
	}

	@Override
	public Address addAddress(Address address) {
		try {
			em.persist(address);

		} catch (EntityExistsException e) {
			System.err.print(e);
			return null;
		}
		return address;
	}

	@Override

	public User update(User user, int userId, Address address) {
		User updatedUser = em.find(User.class, userId);
		if (updatedUser != null) {
			updatedUser.setAboutme(user.getAboutme());
			updatedUser.setFirstName(user.getFirstName());
			updatedUser.setLastName(user.getLastName());
			updatedUser.setImageUrl(user.getImageUrl());
			updatedUser.setUsername(user.getUsername());
			updatedUser.setPassword(user.getPassword());
			updatedUser.getAddress().setStreet(address.getStreet());
			updatedUser.getAddress().setStreet2(address.getStreet2());
			updatedUser.getAddress().setCity(address.getCity());
			updatedUser.getAddress().setState(address.getState());
			updatedUser.getAddress().setZipCode(address.getZipCode());

			em.flush();
		}

		return updatedUser;
	}
	@Override
	public Boolean deactivateUser(int id) {
		User userToDeactivate = em.find(User.class, id);
		if(userToDeactivate != null) {
			userToDeactivate.setActive(false);
			return true;
		}
		return false;
	}

	@Override
	public Address findAddressById(int id) {

		return em.find(Address.class, id);
	}
	@Override
	public List<User> findFriendsByUserId(int userId) {
		String jpql = "SELECT f FROM User u JOIN u.friends f WHERE u.id = :userId";
		return em.createQuery(jpql, User.class).setParameter("userId", userId).getResultList();
	}
	
	@Override
	public User addFriend(User user, User friend) {
		if (user.getFriends() == null) {
			user.setFriends(new ArrayList<>());
		}
		if (!user.getFriends().contains(friend)) {
			user.getFriends().add(friend);
			friend.getFriends().add(user);

			em.merge(user);
			em.merge(friend);
		}
		return null;
	}
	
	@Override
	public User removeFriend(User user, User friend) {
		if (user.getFriends() != null && user.getFriends().contains(friend)) {
			user.getFriends().remove(friend);
			friend.getFriends().remove(user);

			em.merge(user);
			em.merge(friend);
		}
		return null;
	}
	
	
}
