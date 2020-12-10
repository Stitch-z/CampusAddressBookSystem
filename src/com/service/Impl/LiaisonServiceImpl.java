package com.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mapper.LiaisonMapper;
import com.po.Liaison;
import com.service.LiaisonService;

@Service
@Transactional
public class LiaisonServiceImpl implements LiaisonService{
    @Autowired
    private LiaisonMapper liaisonMapper;


    public List<Liaison> findLiaisonByAccountRole(String account,String role) {
        // TODO Auto-generated method stub
        Liaison liaison = new Liaison();
        liaison.setLaccount(account);
        liaison.setLrole(role);
        return liaisonMapper.selectLiaisonsByAccountRole(liaison);
    }


    public void addLiaison(Liaison liaison) {
        // TODO Auto-generated method stub
        liaisonMapper.insertLiaison(liaison);
    }


    public void deleteLiaisonsSelected(int[] lnoArray,String laccount) {
        // TODO Auto-generated method stub
        for (int i = 0; i < lnoArray.length; i++) {
            Liaison liaison = new Liaison();
            liaison.setLno(lnoArray[i]);
            liaison.setLaccount(laccount);
            liaisonMapper.deleteLiaisonByLnoByLaccount(liaison);
        }
    }

    @Override
    public void deleteLiaison(String laccount, int lno) {
        Liaison liaison = new Liaison();
        liaison.setLno(lno);
        liaison.setLaccount(laccount);
        liaisonMapper.deleteLiaisonByLnoByLaccount(liaison);
    }


    public void updateLiaison(Liaison liaison) {
        // TODO Auto-generated method stub
        liaisonMapper.updateLiaison(liaison);
    }

    @Override
    public Liaison findLiaisonByLaccountLnumber(String laccount,String lnumber) {
        Liaison liaison = new Liaison();
        liaison.setLaccount(laccount);
        liaison.setLnumber(lnumber);
        return liaisonMapper.selectLiaisonByLaccountLnumber(liaison);
    }

/*    @Override
    public Liaison findLiaisonByLnumber(String lnumber) {
        return liaisonMapper.selectLiaisonByLnumber(lnumber);
    }*/


    @Override
    public List<Liaison> findLiaisonByLaccountLnameLrole(String laccount,String lrole,String lname) {
        // TODO Auto-generated method stub
        Liaison liaison = new Liaison();
        liaison.setLaccount(laccount);
        liaison.setLname(lname);
        liaison.setLrole(lrole);
        return liaisonMapper.selectLiaisonByLaccountLnameLrole(liaison);
    }

    @Override
    public List<Liaison> findLiaisonByLaccountLphoneLrole(String laccount,String lrole, String lphone) {
        Liaison liaison = new Liaison();
        liaison.setLaccount(laccount);
        liaison.setLphone(lphone);
        liaison.setLrole(lrole);
        return liaisonMapper.selectLiaisonByLaccountLphoneLrole(liaison);
    }



}
