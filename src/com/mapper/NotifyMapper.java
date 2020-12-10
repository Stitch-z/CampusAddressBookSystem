package com.mapper;

import com.po.Notify;

import java.util.List;

public interface NotifyMapper {

    List<Notify> selectNotifiesByNtoNtype(Notify notify);

    void insertNotify(Notify notify);

    void deleteNotifyByNno(int nno);

    void updateNotifyByNno(Notify notify);

    Notify selectNotifyToAdmin(Notify notify);

    Notify selectNotifyToTeacher(Notify notify);

    List<Notify> selectNotifiesByRole(String ntoRole);
}
