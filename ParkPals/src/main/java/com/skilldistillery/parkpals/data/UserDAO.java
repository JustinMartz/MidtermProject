package com.skilldistillery.parkpals.data;

import com.skilldistillery.parkpals.entities.Address;
import com.skilldistillery.parkpals.entities.User;

public interface UserDAO {
	
	User findByUsernameAndPassword(String username, String password);
	User addUser(User user);
	Address addAddress(Address address);
	User findUserById(int id);
	Address updateAddress(Address address);
	User update(User user);
	

}
