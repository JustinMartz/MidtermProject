package com.skilldistillery.parkpals.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Park {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private int id;
	private String name;
	private String description;
	@Column(name = "notable_features")
	private String notableFeatures;
	@Column(name = "image_url")
	private String imageUrl;
	private Boolean active;
	@Column(name = "website_url")
	private String websiteUrl;
	
	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;
	
	@OneToMany(mappedBy = "park")
	private List<ParkRating> parkRatings;
	
	@OneToMany(mappedBy="park")
	private List<ParkVisit> parkVisits;
	
	@OneToMany(mappedBy="park")
	private List<Trail> trails;
	
	public Park() {
		
	}
	
	public void addParkRating(ParkRating parkRating) {
		if (parkRatings == null) {
			parkRatings = new ArrayList<>();
		}
		
		if (!parkRatings.contains(parkRating)) {
			parkRatings.add(parkRating);
			parkRating.setPark(this);
		}
	}
	
	public void removeParkRating(ParkRating parkRating) {
		if (parkRatings != null && parkRatings.contains(parkRating)) {
			parkRatings.remove(parkRating);
			parkRating.setPark(null);
		}
	}
	
	public void addParkVisit(ParkVisit parkVisit) {
		if (parkVisits == null) {
			parkVisits = new ArrayList<>();
		}
		
		if (!parkVisits.contains(parkVisit)) {
			parkVisits.add(parkVisit);
			parkVisit.setPark(this);
		}
	}
	
	public void removeParkVisit(ParkVisit parkVisit) {
		if (parkVisits != null && parkVisits.contains(parkVisit)) {
			parkVisits.remove(parkVisit);
			parkVisit.setPark(null);
		}
	}
	
	public void addTrail(Trail trail) {
		if (trails == null) {
			trails = new ArrayList<>();
		}
		
		if (!trails.contains(trail)) {
			trails.add(trail);
			trail.setPark(this);
		}
	}
	
	public void removeTrail(Trail trail) {
		if (trails != null && trails.contains(trail)) {
			trails.remove(trail);
			trail.setPark(null);
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

	public String getNotableFeatures() {
		return notableFeatures;
	}

	public void setNotableFeatures(String notableFeatures) {
		this.notableFeatures = notableFeatures;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getWebsiteUrl() {
		return websiteUrl;
	}

	public void setWebsiteUrl(String websiteUrl) {
		this.websiteUrl = websiteUrl;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<ParkRating> getParkRatings() {
		return parkRatings;
	}

	public void setParkRatings(List<ParkRating> parkRatings) {
		this.parkRatings = parkRatings;
	}

	public List<ParkVisit> getParkVisits() {
		return parkVisits;
	}

	public void setParkVisits(List<ParkVisit> parkVisits) {
		this.parkVisits = parkVisits;
	}

	public List<Trail> getTrails() {
		return trails;
	}

	public void setTrails(List<Trail> trails) {
		this.trails = trails;
	}

	@Override
	public String toString() {
		return "Park [id=" + id + ", name=" + name + ", description=" + description + ", notableFeatures="
				+ notableFeatures + ", imageUrl=" + imageUrl + ", active=" + active + ", websiteUrl=" + websiteUrl
				+ "]";
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
		Park other = (Park) obj;
		return id == other.id;
	}
	
	
	

}
