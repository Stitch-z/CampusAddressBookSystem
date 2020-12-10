package com.controller;

import java.util.List;

import com.po.*;
import com.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 * 特别关心控制器
 */

@Controller
public class NotifyController {

    @Autowired
    NotifyService notifyService;

    @Autowired
    UserService userService;

    @Autowired
    CourseService courseService;

    //根据接收方账号查看所有消息通知或者收件箱
    @RequestMapping("/notifylist")
    public String notifylist(String nto,String ntype,String role,String replyMsg,Model model) {
        List<Notify> notifyList = null;
        if("管理员".equals(role)) {
            notifyList = notifyService.findNotifiesByRole(role);
        }
        else {
            Notify notify = new Notify();
            notify.setNto(nto);
            notify.setNtype(ntype);
            notifyList = notifyService.findNotifiesByNtoNtype(notify);
        }
        model.addAttribute("notifyList",notifyList);
        model.addAttribute("replyMsg",replyMsg);
        model.addAttribute("ntype",ntype);
        return "notify/notifylist";
    }

    //提交申请控制器
    @RequestMapping("/sendNotify")
    public String sendNotify(Notify notify,String flag,Model model) {
        User user1 = userService.findUserByUaccount(notify.getNfrom());
        Notify notify1 = notify;
        notify1.setNfromName(user1.getUname());
        notify1.setNtoRole(notify.getNtoRole());

        //先查找消息表里面有没有提交过该消息且未审核过的
        Notify notify2 = notifyService.findNotifyToTeacher(notify1);
        if (notify2!=null) {
            model.addAttribute("applyCourse","已提交过该申请，请不要重复提交！");
        }
        else {
            notifyService.addNotify(notify1);
            model.addAttribute("applyCourse","已提交申请，等待审核！");
        }

        model.addAttribute("saccount",notify.getNfrom());
        model.addAttribute("flag",flag);
        model.addAttribute("caccount",notify.getNcourse());
        return "redirect:courselist";
    }

    //提交课程申请控制器
    @RequestMapping("/sendCourseNotify")
    public String sendCourseNotify(Notify notify,Model model) {
        User user1 = userService.findUserByUaccount(notify.getNfrom());
        Notify notify1 = notify;
        notify1.setNfromName(user1.getUname());
        notify1.setNtoRole(notify.getNtoRole());
        Course course = courseService.findCourseByCaccount(notify.getNcourse());
        notify1.setNcourseName(course.getCname());
        notify1.setNcourseTaccount(course.getTaccount());
        notify1.setNcourseTeacher(course.getCteacher());
        notify1.setNtype(notify.getNtype());

        //先查找消息表里面有没有提交过该消息且未审核过的
        Notify notify2 = notifyService.findNotifyToAdmin(notify1);
        if (notify2!=null) {
            model.addAttribute("applyCourse","已提交过该申请，请不要重复提交！");
        }
        else {
            notifyService.addNotify(notify1);
            model.addAttribute("applyCourse","已提交申请，等待审核！");
        }

        model.addAttribute("taccount",notify.getNcourseTaccount());
        return "redirect:teacherCourselist";
    }

    //删除选中的消息控制器
    @RequestMapping("/notifyDeleteSelected")
    public String notifyDeleteSelected(int[] nnoArray,String ntoRole,String ntype,String nto,Model model) {
        notifyService.deleteNotifiesSelected(nnoArray);
        model.addAttribute("nto",nto);
        model.addAttribute("role",ntoRole);
        model.addAttribute("ntype",ntype);
        return "redirect:notifylist";
    }

    //审核消息的控制器
    @RequestMapping("/notifyExamine")
    public String notifyExamine(Notify notify,Model model) {
        //更新消息通知界面的消息状态
        notifyService.updateNotify(notify.getNno(),notify.getNstate());
        String content = notify.getNcontent();
        //编辑回复消息
        Notify notify1 = new Notify();
        notify1.setNfrom(notify.getNto());
        notify1.setNfromName(notify.getNtoName());
        notify1.setNto(notify.getNfrom());
        notify1.setNtoName(notify.getNfromName());
        notify1.setNcourse(notify.getNcourse());
        notify1.setNstate("未读");
        notify1.setNtype(notify.getNtype());
        Course course = courseService.findCourseByCaccount(notify.getNcourse());
        if(content.contains("申请加入课程")) {
            if ("已同意".equals(notify.getNstate())) {
                courseService.addSc_table(notify.getNfrom(),notify.getNcourse());
//                courseService.updateSc_tableByCaccount(notify.getNfrom(),notify.getNcourse());
                notify1.setNcontent("已同意你加入课程《" + course.getCname() + "》");
            }
            else if("已拒绝".equals(notify.getNstate())){
                notify1.setNcontent("已拒绝你加入课程《" + course.getCname() + "》");
            }
            //发送回复消息
            notifyService.addNotify(notify1);
        }
        else if(content.contains("申请退出课程")) {
            if ("已同意".equals(notify.getNstate())) {
                courseService.deleteSc_table(notify.getNfrom(),notify.getNcourse());
//                courseService.updateSc_tableByCaccount("",notify.getNcourse());
                notify1.setNcontent("已同意你退出课程《" + course.getCname() + "》");
            }
            else if("已拒绝".equals(notify.getNstate())){
                notify1.setNcontent("已拒绝你退出课程《" + course.getCname() + "》");
            }            //发送回复消息
            notifyService.addNotify(notify1);
        }
        model.addAttribute("nto",notify.getNto());
        model.addAttribute("ntype",notify.getNtype());
        return "redirect:notifylist";

    }

    //更新消息状态的控制器
    @RequestMapping("/updateNotify")
    public String updateNotify(Notify notify,Model model) {
        notifyService.updateNotify(notify.getNno(),notify.getNstate());
        model.addAttribute("nto",notify.getNto());
        model.addAttribute("ntype",notify.getNtype());
        return "redirect:notifylist";

    }

    //审核消息的控制器
    @RequestMapping("/notifyAdminExamine")
    public String notifyAdminExamine(Notify notify,Model model) {
        //更新消息通知界面的消息状态
        notifyService.updateNotify(notify.getNno(),notify.getNstate());
        String content = notify.getNcontent();
        //编辑回复消息
        Notify notify1 = new Notify();
        notify1.setNfromName("管理员");
        notify1.setNto(notify.getNfrom());
        notify1.setNtoName(notify.getNfromName());
        notify1.setNstate("未读");
        notify1.setNtype(notify.getNtype());
        if(content.contains("申请创建课程")) {
            if ("已同意".equals(notify.getNstate())) {
                Course course = new Course();
                course.setCaccount(notify.getNcourse());
                course.setCname(notify.getNcourseName());
                course.setTaccount(notify.getNcourseTaccount());
                course.setCteacher(notify.getNcourseTeacher());
                courseService.addCourse(course);
                notify1.setNcontent("已同意你的课程《" + notify.getNcourseName() + "》创建申请");
            }
            else if("已拒绝".equals(notify.getNstate())){
                notify1.setNcontent("已拒绝你的课程《" + notify.getNcourseName() + "》创建申请");
            }
            //发送回复消息
            notifyService.addNotify(notify1);
        }
        else if(content.contains("申请结束课程")) {
            if ("已同意".equals(notify.getNstate())) {
                courseService.deleteCourse(notify.getNcourse());
                courseService.deleteSc_tableByCaccount(notify.getNcourse());
                notify1.setNcontent("已同意你的课程《" + notify.getNcourseName() + "》结束申请");
            }
            else if("已拒绝".equals(notify.getNstate())){
                notify1.setNcontent("已拒绝你的课程《" + notify.getNcourseName() + "》结束申请");
            }
            //发送回复消息
            notifyService.addNotify(notify1);
        }
        model.addAttribute("nto",notify.getNto());
        model.addAttribute("role","管理员");
        model.addAttribute("ntype",notify.getNtype());
        return "redirect:notifylist";

    }

    //发送短信控制器
    @RequestMapping("/sendMsg")
    public String sendMsg(Notify notify,String lrole,Model model) {
        User user = userService.findUserByUaccount(notify.getNfrom());
        User user1 = userService.findUserByUaccount(notify.getNto());
        Notify notify1 = notify;
        notify1.setNfromName(user.getUname());
        notify1.setNtoName(user1.getUname());
        notify1.setNtoRole(user1.getUrole());
        notify1.setNstate("未读");
        notify1.setNtype("短信");
        notifyService.addNotify(notify1);

        model.addAttribute("lrole",lrole);
        model.addAttribute("laccount",notify.getNfrom());
        model.addAttribute("sendMsg","短信发送成功！");
        return "redirect:liaisonlist";
    }

    //发送短信控制器
    @RequestMapping("/replyMsg")
    public String replyMsg(Notify notify,Model model) {
        User user = userService.findUserByUaccount(notify.getNfrom());
        User user1 = userService.findUserByUaccount(notify.getNto());
        Notify notify1 = new Notify();
        notify1.setNfrom(user1.getUaccount());
        notify1.setNfromName(user1.getUname());
        notify1.setNto(user.getUaccount());
        notify1.setNtoName(user.getUname());
        notify1.setNtoRole(user.getUrole());
        notify1.setNcontent(notify.getNcontent());
        notify1.setNstate("未读");
        notify1.setNtype("短信");
        notifyService.addNotify(notify1);

        model.addAttribute("nto",notify1.getNfrom());
        model.addAttribute("ntype",notify1.getNtype());
        model.addAttribute("replyMsg","短信回复成功！");
        return "redirect:notifylist";
    }

}
