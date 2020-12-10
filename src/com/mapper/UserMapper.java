package com.mapper;

import com.po.User;

import java.util.List;

public interface UserMapper {
    User selectUserByUaccount(String account);
    void updateUser(User user);
    
    void addUser(User user);

    List<User> selectAllUsers();

    List<User> selectUsersByUrole(String urole);

    void deleteUserByUaccount(String uaccount);
}
