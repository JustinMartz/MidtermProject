package com.skilldistillery.parkpals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
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

@Entity
public class Meetup {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;

	@Column(name = "meetup_date")
	private LocalDateTime meetupDate;
	@Column(name = "start_time")
	private LocalDateTime startTime;
	@Column(name = "end_time")
	private LocalDateTime endTime;
	private String description;
	@Column(name = "image_url")
	private String imageUrl;

	@ManyToOne
	@JoinColumn(name = "trail_id")
	private Trail trail;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User creator;

	@OneToMany(mappedBy = "meetup")
	private List<MeetupRating> meetupRatings;

	@OneToMany(mappedBy = "meetup")
	private List<MeetupComment> meetupComments;
	
	public void addMeetupComment(MeetupComment meetupComment) {
		if (meetupComments == null) {
			meetupComments = new ArrayList<>();
		}
		
		if (!meetupComments.contains(meetupComment)) {
			meetupComments.add(meetupComment);
			meetupComment.setMeetup(this);
		}
	}
	
	public void removeMeetupComment(MeetupComment meetupComment) {
		if (meetupComments != null && meetupComments.contains(meetupComment)) {
			meetupComments.remove(meetupComment);
			meetupComment.setMeetup(null);
		}
	}

	public Meetup() {

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

	public LocalDateTime getMeetupDate() {
		return meetupDate;
	}

	public void setMeetupDate(LocalDateTime meetupDate) {
		this.meetupDate = meetupDate;
	}

	public LocalDateTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalDateTime startTime) {
		this.startTime = startTime;
	}

	public LocalDateTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalDateTime endTime) {
		this.endTime = endTime;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Trail getTrail() {
		return trail;
	}

	public void setTrail(Trail trail) {
		this.trail = trail;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public List<MeetupRating> getMeetupRatings() {
		return meetupRatings;
	}

	public void setMeetupRatings(List<MeetupRating> meetupRatings) {
		this.meetupRatings = meetupRatings;
	}

	public List<MeetupComment> getMeetupComments() {
		return meetupComments;
	}

	public void setMeetupComments(List<MeetupComment> meetupComments) {
		this.meetupComments = meetupComments;
	}

	@Override
	public String toString() {
		return "Meetup [id=" + id + ", name=" + name + ", meetupDate=" + meetupDate + ", startTime=" + startTime
				+ ", endTime=" + endTime + ", description=" + description + ", imageUrl=" + imageUrl + ", trail="
				+ trail + ", creator=" + creator + "]";
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
		Meetup other = (Meetup) obj;
		return id == other.id;
	}

}
