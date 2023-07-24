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

class TrailRatingTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private TrailRating trailRating;

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
		TrailRatingId trailRatingId = new TrailRatingId(1, 1);
		trailRating = em.find(TrailRating.class, trailRatingId);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		trailRating = null;
	}

	@Test
	void test() {
		assertNotNull(trailRating);
		assertEquals(5, trailRating.getRating());
	}
	
	@Test
	void test_mapping_trailrating_to_user() {
		assertNotNull(trailRating);
		assertNotNull(trailRating.getUser());
		assertEquals("Cortnie", trailRating.getUser().getFirstName());
	}
	
	@Test
	void test_mapping_trailrating_to_trail() {
		assertNotNull(trailRating);
		assertEquals("25.8315n",trailRating.getTrail().getLongitude());

		
	}

}









