package com.skilldistillery.parkpals.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Park;

@Service
@Transactional
public class ParkDaoImpl implements ParkDAO{
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Park> findAllParks() {
		
		String query = "SELECT p FROM Park p";
		  return em.createQuery(query, Park.class).getResultList();
		
	}
	
	@Override
	 public Park findParkById(int id) {
	  return em.find(Park.class, id);
	 }

}
