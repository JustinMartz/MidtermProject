package com.skilldistillery.parkpals.data;

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
//			e.printStackTrace();
			System.err.println("Invalid username or password");
		}

		return user;
	}

	@Override
	public User addUser(User user) {
		try {
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
	public User update(User user, int id) {
		User updatedUser = new User();
		  updatedUser.setId(id);
		  int addressId = findUserById(id).getAddress().getId();
		  Address address = findAddressBy(id);
		  updatedUser = em.merge(user);
		  return updatedUser;
		updatedUser.setAddress(findAddressById(findUserById(id).getAddress().getId()));

		return managedProfile;
	}

	@Override
	public Address updateAddress(Address address) {
		Address managedAddress = new Address();
		managedAddress.setId(address.getId());
		managedAddress.setCity(address.getCity());
		managedAddress = em.merge(address);

		return managedAddress;
	}
	
	@Override
	public Address findAddressById(int id) {

		return em.find(Address.class, id);
	}
}
