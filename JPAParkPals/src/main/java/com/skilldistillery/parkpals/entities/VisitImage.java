package com.skilldistillery.parkpals.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "visit_image")
public class VisitImage {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "image_url")
	private String imageUrl;
	private String caption;
	
	@ManyToOne
	@JoinColumn(name = "park_visit_id")
	private ParkVisit parkVisit;

	public VisitImage() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}
	
	
	public ParkVisit getParkVisit() {
		return parkVisit;
	}

	public void setParkVisit(ParkVisit parkVisit) {
		this.parkVisit = parkVisit;
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
		VisitImage other = (VisitImage) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "VisitImage [id=" + id + ", imageUrl=" + imageUrl + ", caption=" + caption + "]";
	}

}
