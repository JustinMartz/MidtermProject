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


class ParkVisitTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ParkVisit parkVisit;

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
		parkVisit = em.find(ParkVisit.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		parkVisit = null;
	}

	@Test
	void test_ParkVisit_basic() {
		assertNotNull(parkVisit);
		assertEquals("I did not see anything out there", parkVisit.getWildlifeSeen());
		assertEquals(2020, parkVisit.getArrivalDate().getYear());
	}
	
	@Test
	void test_ParkVisit_mapping_to_user() {
		assertNotNull(parkVisit);
		assertNotNull(parkVisit.getUser());
		assertEquals("Cortnie", parkVisit.getUser().getFirstName());
		
		
	}
	@Test
	void test_ParkVisit_mapping_to_visitImage() {
		assertNotNull(parkVisit);
		assertNotNull(parkVisit.getVisitImages());
		assertEquals("beautiful scene", parkVisit.getVisitImages().get(0).getCaption());
		
		
	}
	
	@Test
	void test_ParkVisit_to_Park() {
		assertNotNull(parkVisit);
		assertNotNull(parkVisit.getPark());
		assertEquals("Grand Canyon National Park", parkVisit.getPark().getName());
	}

}
