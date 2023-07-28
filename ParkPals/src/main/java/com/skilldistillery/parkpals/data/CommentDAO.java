package com.skilldistillery.parkpals.data;

import java.util.List;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.MeetupComment;
import com.skilldistillery.parkpals.entities.User;

public interface CommentDAO {

	
	public boolean addCommentToMeetup(User user, Meetup meetup, String comment);
//	public List<Comment> findAllCommentsByMeetup(Meetup meetup);
	public List<MeetupComment> findAllComments();
}
