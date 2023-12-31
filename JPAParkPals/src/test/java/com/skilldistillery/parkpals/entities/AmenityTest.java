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

class AmenityTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Amenity amenity;

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
		amenity = em.find(Amenity.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		amenity = null;
	}

	@Test
	void test_Amenity_basic() {
		assertNotNull(amenity);
		assertEquals("restroom", amenity.getName());
		assertEquals("indoor restroom ", amenity.getDescription());
	}

	@Test
	void test_Amenity_to_Trail_mapping() {
		assertNotNull(amenity);
		assertNotNull(amenity.getTrails());
		assertTrue(amenity.getTrails().size() > 0);

	}
}
