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
			assertEquals("111.8427W", trail.getLongitude());
			assertEquals("Tanner Trail", trail.getName());
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
			assertTrue(trail.getMeetups().size() > 0);
		}
		
		@Test
		void test_Trail_to_rating_mapping_OnToMany() {
			assertNotNull(trail);
			assertNotNull(trail.getTrailRatings());
			assertTrue(trail.getTrailRatings().size() > 0);
		}

		@Test
		void test_Trail_to_Park() {
			assertNotNull(trail);
			assertNotNull(trail.getPark());
			assertEquals("Grand Canyon National Park", trail.getPark().getName());
		}
}
