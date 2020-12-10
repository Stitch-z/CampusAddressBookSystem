package com.service;

import com.po.Notify;

import java.util.List;

public interface NotifyService {
    List<Notify> findNotifiesByNtoNtype(Notify notify);
    void addNotify(Notify notify);
    void deleteNotifiesSelected(int[] nnoArray);
    void updateNotify(int nno,String nstate);

    //查找消息表里面有没有提交过该消息且未审核过的
    Notify findNotifyToAdmin(Notify notify);

    //查找消息表里面有没有提交过该消息且未审核过的
    Notify findNotifyToTeacher(Notify notify);

    List<Notify> findNotifiesByRole(String ntoRole);

}
