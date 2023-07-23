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

class TrailTest {
		private static EntityManagerFactory emf;
		private EntityManager em;
		private Trail trail;

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
			trail = em.find(Trail.class, 1);
		}

		@AfterEach
		void tearDown() throws Exception {
			em.close();
			trail = null;
		}

		@Test
		void test_Trail_basic() {
			assertNotNull(trail);
			assertEquals("25.8315n", trail.getLongitude());
			assertEquals("Gator hook trail", trail.getName());
		}
		@Test
		void test_Trail_to_Amenity_mapping() {
			assertNotNull(trail);
			assertNotNull(trail.getAmenities());
			assertTrue(trail.getAmenities().size() > 0);
		}
		@Test
		void test_Trail_to_meetup_mapping_OnToMany() {
			assertNotNull(trail);
			assertNotNull(trail.getMeetups());
			assertTrue(trail.getAmenities().size() > 0);
		}

}
