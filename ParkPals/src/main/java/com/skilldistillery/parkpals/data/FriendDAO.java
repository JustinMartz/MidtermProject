package com.skilldistillery.parkpals.data;

import com.skilldistillery.parkpals.entities.Meetup;
import com.skilldistillery.parkpals.entities.User;

public interface FriendDAO {

	Meetup findFriendId(int id);

	public User findFriendById(int id);

}
