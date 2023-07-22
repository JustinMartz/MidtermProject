package com.skilldistillery.parkpals.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Trail {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private int id;
	private String name;
	private String description;
	private String longitude;
	private String latitude;
	@Column(name = "length_in_miles")
	private double lengthInMiles;
	private boolean active;
	@Column(name = "image_url")
	private String imageUrl;
	
	public Trail() {
		
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

	

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public double getLengthInMiles() {
		return lengthInMiles;
	}

	public void setLengthInMiles(double lengthInMiles) {
		this.lengthInMiles = lengthInMiles;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	@Override
	public String toString() {
		return "Trail [id=" + id + ", name=" + name + ", description=" + description + ", longitude=" + longitude
				+ ", latitude=" + latitude + ", lengthInMiles=" + lengthInMiles + ", active=" + active + ", imageUrl="
				+ imageUrl + "]";
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
		Trail other = (Trail) obj;
		return id == other.id;
	}
	
	
	

}
