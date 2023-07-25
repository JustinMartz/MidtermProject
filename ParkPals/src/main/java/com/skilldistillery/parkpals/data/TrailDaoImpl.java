package com.skilldistillery.parkpals.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.parkpals.entities.Trail;
@Service
@Transactional
public class TrailDaoImpl implements TrailDAO {
	
	@PersistenceContext
	private EntityManager em;
	@Override
	public Trail findTrailById(int id) {
	return em.find(Trail.class, id);
	}
}
