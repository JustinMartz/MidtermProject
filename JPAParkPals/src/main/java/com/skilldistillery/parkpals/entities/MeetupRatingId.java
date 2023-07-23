package com.skilldistillery.parkpals.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class MeetupRatingId implements Serializable{
	
	private static final long serialVersionUID = -3674082374943312242L;

	@Column(name = "user_id")
	private int userId;
	
	@Column(name = "meetup_id")
	private int meetupId;

	public MeetupRatingId() {
	}
	
	public MeetupRatingId(int userId, int meetupId) {
		this.userId = userId;
		this.meetupId = meetupId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getMeetupId() {
		return meetupId;
	}

	public void setMeetupId(int meetupId) {
		this.meetupId = meetupId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "MeetupRatingId [userId=" + userId + ", meetupId=" + meetupId + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(meetupId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MeetupRatingId other = (MeetupRatingId) obj;
		return meetupId == other.meetupId && userId == other.userId;
	}
	
	
	


}










// user id, meetup_id, comment, rating, create_date, last_update