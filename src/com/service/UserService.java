package com.service;

import com.po.User;

import java.util.List;

public interface UserService {
    //通过账号查找账户
    User findUserByUaccount(String uaccount);

    //更新账户
    void updateUser(User user);

    //添加账户
    void addUser(User user);

    //查找所有账户
    List<User> findAllUser();

    List<User> findAllUserByUrole(String urole);

    void deleteUserByUaccount(String uaccount);
}
