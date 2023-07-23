package com.skilldistillery.parkpals.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class TrailRatingId implements Serializable {

	private static final long serialVersionUID = 7586833326728930828L;
	
	@Column(name = "user_id")
	private int userId;
	
	@Column(name = "trail_id")
	private int trailId;

	public TrailRatingId() {
	}

	public TrailRatingId(int userId, int trailId) {
		this.userId = userId;
		this.trailId = trailId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getTrailId() {
		return trailId;
	}

	public void setTrailId(int trailId) {
		this.trailId = trailId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "TrailRatingId [userId=" + userId + ", trailId=" + trailId + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(trailId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TrailRatingId other = (TrailRatingId) obj;
		return trailId == other.trailId && userId == other.userId;
	}
	
	
	

}
