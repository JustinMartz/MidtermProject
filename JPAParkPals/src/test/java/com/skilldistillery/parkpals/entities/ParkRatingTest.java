package com.skilldistillery.parkpals.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ParkRatingTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ParkRating parkRating;

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
		ParkRatingId parkRatingId = new ParkRatingId(1, 1);
		parkRating = em.find(ParkRating.class, parkRatingId);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		parkRating = null;
	}

	@Test
	void test() {
		assertNotNull(parkRating);
		assertEquals(5, parkRating.getRating());
	}
	
	@Test
	void test_mapping_parkrating_to_user() {
		assertNotNull(parkRating);
		assertEquals("Cortnie", parkRating.getUser().getFirstName());
	}

	
}







