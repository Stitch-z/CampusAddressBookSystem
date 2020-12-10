package com.service;

import java.util.List;

import com.po.Liaison;

public interface LiaisonService {
    
    List<Liaison> findLiaisonByAccountRole(String account,String role);
    List<Liaison> findLiaisonByLaccountLnameLrole(String laccount,String lrole,String lname);
    List<Liaison> findLiaisonByLaccountLphoneLrole(String laccount,String lrole,String lphone);
    void addLiaison(Liaison liaison);
    void deleteLiaisonsSelected(int[] lnoArray,String laccount);
    void deleteLiaison(String laccount, int lno);
    void updateLiaison(Liaison liaison);

    //通过账号和联系人编号准确找到联系人
    Liaison findLiaisonByLaccountLnumber(String laccount,String lnumber);

}
