package com.skilldistillery.parkpals.data;

import java.util.List;

import com.skilldistillery.parkpals.entities.User;

public interface FriendDAO {

	public void addFriend(User user, User friend);

	public void removeFriend(User user, User friend);

	public User findUserById(int userId);



}
