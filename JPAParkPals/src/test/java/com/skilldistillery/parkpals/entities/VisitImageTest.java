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

class VisitImageTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private VisitImage visitImage;

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
		visitImage = em.find(VisitImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		visitImage = null;
	}

	@Test
	void test_VisitImage_basic() {
		assertNotNull(visitImage.getCaption());
        assertEquals("beautiful scene", visitImage.getCaption());
	}
	
	@Test
	void test_VisitImage_to_parkvisit() {
		assertNotNull(visitImage);
        assertNotNull(visitImage.getParkVisit());
	}
}