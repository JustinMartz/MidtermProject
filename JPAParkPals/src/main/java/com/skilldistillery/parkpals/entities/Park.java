package com.skilldistillery.parkpals.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

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
	private boolean active;
	@Column(name = "website_url")
	private String websiteUrl;
	
	public Park() {
		
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

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getWebsiteUrl() {
		return websiteUrl;
	}

	public void setWebsiteUrl(String websiteUrl) {
		this.websiteUrl = websiteUrl;
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
