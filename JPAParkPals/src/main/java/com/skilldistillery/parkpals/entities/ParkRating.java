package com.skilldistillery.parkpals.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "park_rating")
public class ParkRating {
	
		@EmbeddedId
		private ParkRatingId id;
		private int rating;
		@Column(name = "image_url")
		private String imageUrl;
		
		private String comment;

		@Column(name = "create_date")
		@CreationTimestamp
		private LocalDateTime createDate;

		@Column(name = "last_update")
		@UpdateTimestamp
		private LocalDateTime lastUpdate;
		
		public ParkRating() {
			
		}

		public ParkRatingId getId() {
			return id;
		}

		public void setId(ParkRatingId id) {
			this.id = id;
		}

		public int getRating() {
			return rating;
		}

		public void setRating(int rating) {
			this.rating = rating;
		}

		public String getImageUrl() {
			return imageUrl;
		}

		public void setImageUrl(String imageUrl) {
			this.imageUrl = imageUrl;
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

		@Override
		public String toString() {
			return "ParkRating [id=" + id + ", rating=" + rating + ", imageUrl=" + imageUrl + ", comment=" + comment
					+ ", createDate=" + createDate + ", lastUpdate=" + lastUpdate + "]";
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
			ParkRating other = (ParkRating) obj;
			return Objects.equals(id, other.id);
		}
		
		
		
		

}
