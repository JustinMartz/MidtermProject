package com.skilldistillery.parkpals.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

@Entity
public class Amenity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String description;

	@ManyToMany(mappedBy = "amenities")
	private List<Trail> trails;

	public Amenity() {

	}
	
	public void addTrail(Trail trail) {
		if (trails == null) {
			trails = new ArrayList<>();
		}
		
		if (!trails.contains(trail)) {
			trails.add(trail);
			trail.addAmenity(this);
		}
	}
	
	public void removeTrail(Trail trail) {
		if (trails != null && trails.contains(trail)) {
			trails.remove(trail);
			trail.removeAmenity(this);
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Trail> getTrails() {
		return trails;
	}

	public void setTrails(List<Trail> trails) {
		this.trails = trails;
	}

	@Override
	public String toString() {
		return "Amenity [id=" + id + ", name=" + name + ", description=" + description + ", trails=" + trails + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Amenity other = (Amenity) obj;
		return id == other.id;
	}

}
