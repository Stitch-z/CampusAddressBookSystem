package com.service;

import com.po.Accounts;

public interface AccountsService {
    //通过账号密码查找
    Accounts findAccountByAccountByPwd(String account,String pwd);
    //通过账号查找
    Accounts findAccountByAccount(String account);
    //添加账号
    void addAccounts(Accounts accounts);
    //修改密码
    void updatePassword(Accounts accounts);

    void deleteAccount(String account);

    void updateAccounts(Accounts accounts);
}
