package com.skilldistillery.parkpals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	private Boolean active;
	private String role;
	private String aboutme;
	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "date_created")
	@CreationTimestamp
	private LocalDateTime createDate;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;

	@ManyToMany
	@JoinTable(name = "user_friend", /* SQL association table to join */
			joinColumns = @JoinColumn(name = "user_id"), /* column name in user_friend that matches PK in User */
			inverseJoinColumns = @JoinColumn(name = "friend_id") /*
																	 * identifies column in user_friend that matches PK
																	 * in Actor
																	 */
	)
	private List<User> friends;
	
	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;
	
	@OneToMany(mappedBy = "creator", fetch = FetchType.EAGER)
	private List<Meetup> meetups;
	
	@OneToMany(mappedBy = "user")
	private List<MeetupRating> meetupRatings;
	
	@OneToMany(mappedBy = "user")
	private List<ParkRating> parkRatings;
	
	@OneToMany(mappedBy = "user")
	private List<TrailRating> trailRatings;
	
//	@OneToMany(mappedBy = "user")
//	private List<MeetupComment> meetupComments;
	
	@OneToMany(mappedBy = "user")
	private List<ParkVisit> parkVisits;

	public User() {

	}
	
//	public void addMeetupComment(MeetupComment meetupComment) {
// FIXME
//		if (meetupComments == null) {
//			meetupComments = new ArrayList<>();
//		}
//		
//		if (!meetupComments.contains(meetupComment)) {
//			meetupComments.add(meetupComment);
//			meetupComment.setMeetup(this);
//		}
//	}
//	
//	public void removeMeetupComment(MeetupComment meetupComment) {
	// FIXME
//		if (meetupComments != null && meetupComments.contains(meetupComment)) {
//			meetupComments.remove(meetupComment);
//			meetupComment.setMeetup(null);
//		}
//	}
	
	public void addMeetupRating(MeetupRating meetupRating) {
		if (meetupRatings == null) {
			meetupRatings = new ArrayList<>();
		}
		
		if (!meetupRatings.contains(meetupRating)) {
			meetupRatings.add(meetupRating);
			meetupRating.setUser(this);
		}
	}
	
	public void removeMeetupRating(MeetupRating meetupRating) {
		if (meetupRatings != null && meetupRatings.contains(meetupRating)) {
			meetupRatings.remove(meetupRating);
			meetupRating.setUser(null);
		}
	}
	
	public void addParkRating(ParkRating parkRating) {
		if (parkRatings == null) {
			parkRatings = new ArrayList<>();
		}
		
		if (!parkRatings.contains(parkRating)) {
			parkRatings.add(parkRating);
			parkRating.setUser(this);
		}
	}
	
	public void removeParkRating(ParkRating parkRating) {
		if (parkRatings != null && parkRatings.contains(parkRating)) {
			parkRatings.remove(parkRating);
			parkRating.setUser(null);
		}
	}
	
	public void addTrailRating(TrailRating trailRating) {
		if (trailRatings == null) {
			trailRatings = new ArrayList<>();
		}
		
		if (!trailRatings.contains(trailRating)) {
			trailRatings.add(trailRating);
			trailRating.setUser(this);
		}
	}
	
	public void removeTrailRating(TrailRating trailRating) {
		if (trailRatings != null && trailRatings.contains(trailRating)) {
			trailRatings.remove(trailRating);
			trailRating.setUser(null);
		}
	}
	
	public void addParkVisit(ParkVisit parkVisit) {
		if (parkVisits == null) {
			parkVisits = new ArrayList<>();
		}
		
		if (!parkVisits.contains(parkVisit)) {
			parkVisits.add(parkVisit);
			parkVisit.setUser(this);
		}
	}
	
	public void removeParkVist(ParkVisit parkVisit) {
		if (parkVisits != null && parkVisits.contains(parkVisit)) {
			parkVisits.remove(parkVisit);
			parkVisit.setUser(null);
		}
	}
	
	public void addFriend(User friend) {
		if (friends == null) {
			friends = new ArrayList<>();
		}
		
		if (!friends.contains(friend)) {
			friends.add(friend);
			friend.addFriend(this);
		}
	}
	
	public void removeFriend(User friend) {
		if (friends != null && friends.contains(friend)) {
			friends.remove(friend);
			friend.removeFriend(this);
		}
	}
	

	public Address getAddress() {
		return address;
	}


	public void setAddress(Address address) {
		this.address = address;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getAboutme() {
		return aboutme;
	}

	public void setAboutme(String aboutme) {
		this.aboutme = aboutme;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
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

	public List<User> getFriends() {
		return friends;
	}

	public void setFriends(List<User> friends) {
		this.friends = friends;
	}

	public List<Meetup> getMeetups() {
		return meetups;
	}


	public void setMeetups(List<Meetup> meetups) {
		this.meetups = meetups;
	}


	public List<MeetupRating> getMeetupRatings() {
		return meetupRatings;
	}


	public void setMeetupRatings(List<MeetupRating> meetupRatings) {
		this.meetupRatings = meetupRatings;
	}


	public List<ParkRating> getParkRatings() {
		return parkRatings;
	}


	public void setParkRatings(List<ParkRating> parkRatings) {
		this.parkRatings = parkRatings;
	}


	public List<TrailRating> getTrailRatings() {
		return trailRatings;
	}


	public void setTrailRatings(List<TrailRating> trailRatings) {
		this.trailRatings = trailRatings;
	}


//	public List<MeetupComment> getMeetupComments() {
//		return meetupComments;
//	}
//
//
//	public void setMeetupComments(List<MeetupComment> meetupComments) {
//		this.meetupComments = meetupComments;
//	}


	public List<ParkVisit> getParkVisits() {
		return parkVisits;
	}


	public void setParkVisits(List<ParkVisit> parkVisits) {
		this.parkVisits = parkVisits;
	}


	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", active=" + active + ", role=" + role + ", aboutme=" + aboutme
				+ ", imageUrl=" + imageUrl + ", createDate=" + createDate + ", lastUpdate=" + lastUpdate + "]";
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
		User other = (User) obj;
		return id == other.id;
	}

}
