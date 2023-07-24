package com.skilldistillery.parkpals.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "park_visit")
public class ParkVisit {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private int id;
	private String title;
	private String description;
	@Column(name = "wildlife_seen")
	private String wildlifeSeen;
	@Column(name = "arrival_date")
	@CreationTimestamp
	private LocalDateTime arrivalDate;
	@Column(name = "depart_date")
	@UpdateTimestamp
	private LocalDateTime departDate;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@OneToMany(mappedBy = "parkVisit")
	private List<VisitImage> visitImages;
	
	public ParkVisit() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getWildlifeSeen() {
		return wildlifeSeen;
	}

	public void setWildlifeSeen(String wildlifeSeen) {
		this.wildlifeSeen = wildlifeSeen;
	}

	public LocalDateTime getArrivalDate() {
		return arrivalDate;
	}

	public void setArrivalDate(LocalDateTime arrivalDate) {
		this.arrivalDate = arrivalDate;
	}

	public LocalDateTime getDepartDate() {
		return departDate;
	}

	public void setDepartDate(LocalDateTime departDate) {
		this.departDate = departDate;
	}
	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<VisitImage> getVisitImages() {
		return visitImages;
	}

	public void setVisitImages(List<VisitImage> visitImages) {
		this.visitImages = visitImages;
	}

	@Override
	public String toString() {
		return "ParkVisit [id=" + id + ", title=" + title + ", description=" + description + ", wildlifeSeen="
				+ wildlifeSeen + ", arrivalDate=" + arrivalDate + ", departDate=" + departDate + "]";
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
		ParkVisit other = (ParkVisit) obj;
		return id == other.id;
	}
	

}
