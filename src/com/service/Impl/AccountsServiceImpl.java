package com.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mapper.AccountsMapper;
import com.po.Accounts;
import com.service.AccountsService;

@Service
@Transactional
public class AccountsServiceImpl implements AccountsService {

    @Autowired
    private AccountsMapper accountsMapper;

    public Accounts findAccountByAccountByPwd(String account, String pwd) {
        // TODO Auto-generated method stub
        return accountsMapper.selectAccountsByAccountByPwd(account, pwd);
    }

    public void addAccounts(Accounts accounts) {
        // TODO Auto-generated method stub
        accountsMapper.addAccounts(accounts);;
    }

    @Override
    public void updatePassword(Accounts accounts) {
        accountsMapper.updatePassword(accounts);
    }

    @Override
    public void deleteAccount(String account) {
        accountsMapper.deleteAccount(account);
    }

    @Override
    public void updateAccounts(Accounts accounts) {
        accountsMapper.updateAccounts(accounts);
    }

    public Accounts findAccountByAccount(String account) {
        // TODO Auto-generated method stub
        return accountsMapper.selectAccountsByAccount(account);
    }

}
