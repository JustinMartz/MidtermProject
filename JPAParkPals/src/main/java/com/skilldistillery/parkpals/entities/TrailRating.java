package com.skilldistillery.parkpals.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "trail_rating")
public class TrailRating {

	@EmbeddedId
	private TrailRatingId id;
	private int rating;

	private String comment;

	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;
	
	@ManyToOne
	@JoinColumn(name = "trail_id")
	@MapsId(value = "trailId")
	private Trail trail;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "userId")
	private User user;


	public TrailRating() {

	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public TrailRatingId getId() {
		return id;
	}

	public void setId(TrailRatingId id) {
		this.id = id;
	}

	public Trail getTrail() {
		return trail;
	}

	public void setTrail(Trail trail) {
		this.trail = trail;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public String toString() {
		return "TrailRating [id=" + id + ", rating=" + rating + ", comment=" + comment + ", createDate=" + createDate
				+ ", lastUpdate=" + lastUpdate + "]";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TrailRating other = (TrailRating) obj;
		return Objects.equals(id, other.id);
	}

}
