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

@Entity
@Table(name = "meetup_comment")
public class MeetupComment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "comment_date")
	private LocalDateTime commentDate;
	private String comment;
	private Boolean active;
	@ManyToOne
	@JoinColumn(name = "reply_id")
	private MeetupComment reply;
	@OneToMany(mappedBy = "reply")
	private List<MeetupComment> replies;
	
	@ManyToOne
	@JoinColumn(name = "meetup_id")
	private Meetup meetup;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	public MeetupComment() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(LocalDateTime commentDate) {
		this.commentDate = commentDate;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public MeetupComment getReply() {
		return reply;
	}

	public void setReply(MeetupComment reply) {
		this.reply = reply;
	}

	public List<MeetupComment> getReplies() {
		return replies;
	}

	public void setReplies(List<MeetupComment> replies) {
		this.replies = replies;
	}

	public Meetup getMeetup() {
		return meetup;
	}

	public void setMeetup(Meetup meetup) {
		this.meetup = meetup;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return Objects.hash(active);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MeetupComment other = (MeetupComment) obj;
		return active == other.active;
	}

	@Override
	public String toString() {
		return "MeetupComment [id=" + id + ", commentDate=" + commentDate + ", comment=" + comment + ", active="
				+ active + "]";
	}

}
