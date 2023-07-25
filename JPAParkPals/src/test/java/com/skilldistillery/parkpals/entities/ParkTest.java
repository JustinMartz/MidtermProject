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

class ParkTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Park park;

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
		park = em.find(Park.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		park = null;
	}

	@Test
	void test_Park_basic() {
		assertNotNull(park);
		assertEquals("Grand Canyon National Park", park.getName());
		assertEquals("Unique Geological Layers: The exposed rock layers in the Grand Canyon offer a remarkable geological history, "
				+ "displaying millions of years of Earth's history. "
				+ "These layers consist of different colors, "
				+ "textures, and compositions, providing valuable insights into the planet's geological evolution.", 
				park.getNotableFeatures());
	}

	@Test
	void test_Park_mapping_to_Address() {
		assertNotNull(park);
		assertNotNull(park.getAddress());
		assertEquals("Flagstaff", park.getAddress().getCity());

	}

	@Test
	void test_Park_mapping_to_isActive() {
		assertNotNull(park.getActive());
	}

	@Test
	void test_Park_mapping_to_parkRating() {
		assertNotNull(park);
		assertNotNull(park.getParkRatings());
		assertTrue(park.getParkRatings().size() > 0);

	}
	
	@Test
	void test_Park_to_ParkVisit_list() {
		assertNotNull(park);
		assertNotNull(park.getParkVisits());
		assertTrue(park.getParkVisits().size() > 0);
		assertEquals("My first time", park.getParkVisits().get(0).getTitle());
	}
	
	@Test
	void test_Park_to_Trail_list() {
		assertNotNull(park);
		assertNotNull(park.getTrails());
		assertTrue(park.getTrails().size() > 0);
	}

}
