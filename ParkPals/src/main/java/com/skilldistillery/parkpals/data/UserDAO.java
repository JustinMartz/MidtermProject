package com.skilldistillery.parkpals.data;

import com.skilldistillery.parkpals.entities.User;

public interface UserDAO {
	
	User findByUsernameAndPassword(String username, String password);

}
