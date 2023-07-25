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

class AddressTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address address;

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
		address = em.find(Address.class, 5);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		address = null;
	}

	@Test
	void test_Address_basic() {
		assertNotNull(address);
		assertEquals("20 South Entrance Road Grand Canyon", address.getStreet());
		assertEquals("Flagstaff", address.getCity());
	}
	@Test
	void test_address_to_user_mapping() {
		assertNotNull(address);
		assertEquals(5,address.getId());
	}
	@Test
	void test_address_to_park_mapping() {
		assertNotNull(address);
		assertEquals("Grand Canyon National Park",address.getPark().getName());
	}
	


}
