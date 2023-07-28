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

class MeetupTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Meetup meetup;

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
		meetup = em.find(Meetup.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		meetup = null;
	}

	@Test
	void test_Meetup_basic() {
		assertNotNull(meetup);
		assertEquals("Challenging route", meetup.getDescription());
		
	}
	@Test
	void test_Meetup_mapping_to_trail_ManyToOne() {
		assertNotNull(meetup);
		assertNotNull(meetup.getTrail());
		assertEquals("111.8427W", meetup.getTrail().getLongitude());
		
	}
	@Test
	void test_Meetup_mapping_to_user() {
		assertNotNull(meetup);
		assertNotNull(meetup.getCreator());
		assertEquals("Cortnie",meetup.getCreator().getFirstName());
		
	}
	@Test
	void test_Meetup_mapping_to_meetupComments() {
		assertNotNull(meetup);
		assertNotNull(meetup.getMeetupComments());
		assertTrue(meetup.getMeetupComments().size() > 0);
		
	}
	
	@Test
	void test_active_returns_true() {
		assertNotNull(meetup);
		assertNotNull(meetup.getActive());
		assertTrue(meetup.getActive());
	}
	

}
