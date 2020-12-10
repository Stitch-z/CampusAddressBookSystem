package com.mapper;

import org.apache.ibatis.annotations.Param;

import com.po.Accounts;

public interface AccountsMapper {
    //登录时通过账号和密码验证
    Accounts selectAccountsByAccountByPwd(@Param("account")String account,@Param("pwd")String pwd);
    //注册时通过账号验证
    Accounts selectAccountsByAccount(@Param("account")String account);
    //注册成功时添加账号到数据库
    void addAccounts(Accounts accounts);
    //修改密码
    void updatePassword(Accounts accounts);

    void deleteAccount(String account);

    void updateAccounts(Accounts accounts);
}
