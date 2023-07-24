package com.skilldistillery.parkpals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAParkPals");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_User_basic() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
		assertEquals("Cortnie", user.getFirstName());
	}

	@Test
	void test_User_to_list_of_User() {
		assertNotNull(user);
		assertNotNull(user.getFriends());
		assertTrue(user.getFriends().size() > 0);
		assertEquals("Sam", user.getFriends().get(1).getFirstName());
	}

	@Test
	void test_User_mapping_to_meetupRating_OneToMany() {
		assertNotNull(user);
		assertNotNull(user.getMeetupRatings());
		assertTrue(user.getMeetupRatings().size() > 0);
	}
	@Test
	void test_User_mapping_to_isActive() {
		assertNotNull(user.getActive());
	}
	@Test
	void test_User_address_mapping() {
		assertNotNull(user.getAddress());
		assertEquals("Smith",user.getAddress().getCity());
	}
	@Test
	void test_User_meetup_mapping() {
		assertNotNull(user.getMeetups());
		assertTrue(user.getMeetups().size()>0);
	}
	@Test
	void test_User_meetuprating_mapping() {
		assertNotNull(user);
		assertNotNull(user.getMeetupRatings());
		assertTrue(user.getMeetupRatings().size() > 0);
	}
	
	@Test
	void test_User_parkrating_mapping() {
		assertNotNull(user);
		assertNotNull(user.getParkRatings());
		assertTrue(user.getParkRatings().size() > 0);
	}
	@Test
	void test_User_trailrating_mapping() {
		assertNotNull(user);
		assertNotNull(user.getTrailRatings());
		assertTrue(user.getTrailRatings().size() > 0);
	}
//	@Test
//	void test_User_meetupComment_mapping() {
//		assertNotNull(user);
//		assertNotNull(user.getMeetupComments());
//		assertTrue(user.getMeetupComments().size() > 0);
//	}
	
	@Test
	void test_User_mapping_to_parkvisit() {
		assertNotNull(user);
		assertNotNull(user.getParkVisits());
		assertTrue(user.getParkVisits().size() > 0);
	}
	
}
		
		
				
