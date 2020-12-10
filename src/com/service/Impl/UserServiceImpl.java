package com.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mapper.UserMapper;
import com.po.User;
import com.service.UserService;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    public User findUserByUaccount(String uaccount) {
        // TODO Auto-generated method stub
        return userMapper.selectUserByUaccount(uaccount);
    }

    public void updateUser(User user) {
        // TODO Auto-generated method stub
        userMapper.updateUser(user);
    }

    @Override
    public void addUser(User user) {
        // TODO Auto-generated method stub
        userMapper.addUser(user);
        
    }

    @Override
    public List<User> findAllUser() {
        return userMapper.selectAllUsers();
    }

    @Override
    public List<User> findAllUserByUrole(String urole) {
        return userMapper.selectUsersByUrole(urole);
    }

    @Override
    public void deleteUserByUaccount(String uaccount) {
        userMapper.deleteUserByUaccount(uaccount);
    }


}
