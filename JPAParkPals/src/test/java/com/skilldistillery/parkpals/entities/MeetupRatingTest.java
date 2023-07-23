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

class MeetupRatingTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private MeetupRating meetupRating;

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
		MeetupRatingId meetupRatingId = new MeetupRatingId(1, 1);
		meetupRating = em.find(MeetupRating.class, meetupRatingId);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		meetupRating = null;
	}

	@Test
	void test() {
		assertNotNull(meetupRating);
		assertEquals(2, meetupRating.getRating());
	}

	
}
