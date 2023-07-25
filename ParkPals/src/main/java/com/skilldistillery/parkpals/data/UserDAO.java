package com.skilldistillery.parkpals.data;

import com.skilldistillery.parkpals.entities.Address;
import com.skilldistillery.parkpals.entities.User;

public interface UserDAO {
	
	User findByUsernameAndPassword(String username, String password);
	User addUser(User user);
	Address addAddress(Address address);
	User findUserById(int id);
	Address findAddressById(int id);
	User update(User user, int userId, Address address);
	

}
