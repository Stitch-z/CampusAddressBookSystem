package com.mapper;

import java.util.List;

import com.po.Liaison;

public interface LiaisonMapper {
    //通过账号查看所有联系人
    List<Liaison> selectLiaisonsByAccountRole(Liaison liaison);
    //通过账号、姓名和身份模糊查询联系人
    List<Liaison> selectLiaisonByLaccountLnameLrole(Liaison liaison);
    //通过账号、手机和身份模糊查询联系人
    List<Liaison> selectLiaisonByLaccountLphoneLrole(Liaison liaison);

    //删除选中的联系人
    void deleteLiaisonByLnoByLaccount(Liaison liaison);
    //添加联系人
    void insertLiaison(Liaison liaison);
    //修改联系人信息
    void updateLiaison(Liaison liaison);

    Liaison selectLiaisonByLaccountLnumber(Liaison liaison);

/*    Liaison selectLiaisonByLnumber(String lnumber);*/
}
