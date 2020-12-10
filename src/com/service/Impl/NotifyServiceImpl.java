package com.service.Impl;

import com.mapper.NotifyMapper;
import com.po.Notify;
import com.service.NotifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class NotifyServiceImpl implements NotifyService {
    @Autowired
    private NotifyMapper notifyMapper;

    @Override
    public List<Notify> findNotifiesByNtoNtype(Notify notify) {
        return notifyMapper.selectNotifiesByNtoNtype(notify);
    }

    @Override
    public void addNotify(Notify notify) {
        notifyMapper.insertNotify(notify);
    }

    @Override
    public void deleteNotifiesSelected(int[] nnoArray) {
        for (int i = 0; i < nnoArray.length; i++) {
            notifyMapper.deleteNotifyByNno(nnoArray[i]);
        }
    }

    @Override
    public void updateNotify(int nno,String nstate) {
        Notify notify = new Notify();
        notify.setNno(nno);
        notify.setNstate(nstate);
        notifyMapper.updateNotifyByNno(notify);
    }

    @Override
    public Notify findNotifyToAdmin(Notify notify) {
        return notifyMapper.selectNotifyToAdmin(notify);
    }

    @Override
    public Notify findNotifyToTeacher(Notify notify) {
        return notifyMapper.selectNotifyToTeacher(notify);
    }

    @Override
    public List<Notify> findNotifiesByRole(String ntoRole) {
        return notifyMapper.selectNotifiesByRole(ntoRole);
    }

}
