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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
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
	  @JoinTable(name="user_friend",						/* SQL association table to join */
	    joinColumns=@JoinColumn(name="user_id"),		/* column name in user_friend that matches PK in User */
	    inverseJoinColumns=@JoinColumn(name="friend_id")	/* identifies column in user_friend that matches PK in Actor */
	  )
	private List<User> friends;


	public User() {
		
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
