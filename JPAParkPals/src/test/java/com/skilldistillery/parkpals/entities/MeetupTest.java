package com.skilldistillery.parkpals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

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
		assertEquals("long and rough, bring water", meetup.getDescription());
		
	}
	@Test
	void test_Meetup_mapping_to_trail_ManyToOne() {
		assertNotNull(meetup);
		assertNotNull(meetup.getTrail());
		assertEquals("25.8315n", meetup.getTrail().getLongitude());
		
	}


	

}
