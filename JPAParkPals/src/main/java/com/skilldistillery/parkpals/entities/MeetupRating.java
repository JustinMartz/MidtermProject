package com.skilldistillery.parkpals.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "meetup_rating")
public class MeetupRating {

	@EmbeddedId
	private MeetupRatingId id;
	private int rating;

	private String comment;

	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;

//	@ManyToOne
//	@JoinColumn(name = "meetup_id")
//	private Meetup meetup;

	public MeetupRating() {

	}

	public MeetupRatingId getId() {
		return id;
	}

	public void setId(MeetupRatingId id) {
		this.id = id;
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

//	public Meetup getMeetup() {
//		return meetup;
//	}
//
//	public void setMeetup(Meetup meetup) {
//		this.meetup = meetup;
//	}

	@Override
	public String toString() {
		return "MeetupRating [id=" + id + ", rating=" + rating + ", comment=" + comment + ", createDate=" + createDate
				+ ", lastUpdate=" + lastUpdate + "]";
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
		MeetupRating other = (MeetupRating) obj;
		return Objects.equals(id, other.id);
	}

}
