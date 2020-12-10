package com.controller;

import java.util.ArrayList;
import java.util.List;

import com.po.*;
import com.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/*
 * 通讯录管理控制器
 */

@Controller
public class LiaisonController {
    @Autowired
    private LiaisonService liaisonService;

    @Autowired
    private UserService userService;

    @Autowired
    private CourseService courseService;

    //查看所有联系人控制器
    @RequestMapping("/liaisonlist")
    public String liaisonList(String laccount, String addLiaisonCheckMsg, String lrole, String sendMsg, Model model) {
        List<Liaison> list = liaisonService.findLiaisonByAccountRole(laccount, lrole);
        model.addAttribute("liaisonList", list);
        model.addAttribute("lrole", lrole);
        model.addAttribute("addLiaisonCheckMsg", addLiaisonCheckMsg);
        model.addAttribute("sendMsg", sendMsg);
        return "liaison/liaisonlist";
    }

    //模糊查询联系人控制器
    @RequestMapping("/toselectliaisonlist")
    public String toselectliaisonlist(String key, Liaison liaison, Model model) {
        int cnt = 0;
        for (int i = 0; i < key.length(); i++) {
            if (key.charAt(i) >= '0' && key.charAt(i) <= '9')
                cnt++;
        }
        if (cnt == key.length()) {
            List<Liaison> list = liaisonService.findLiaisonByLaccountLphoneLrole(liaison.getLaccount(), liaison.getLrole(), key);
            model.addAttribute("liaisonList", list);
            model.addAttribute("lrole", liaison.getLrole());
            return "liaison/liaisonlist";
        } else {
            List<Liaison> list = liaisonService.findLiaisonByLaccountLnameLrole(liaison.getLaccount(), liaison.getLrole(), key);
            model.addAttribute("liaisonList", list);
            model.addAttribute("lrole", liaison.getLrole());
            return "liaison/liaisonlist";
        }
    }

    @RequestMapping("/liaisoninsert")
    public String liaisonInsert(Liaison liaison, String caccount, String cname, Model model) {
        Liaison liaison1 = liaisonService.findLiaisonByLaccountLnumber(liaison.getLaccount(), liaison.getLnumber());
        if (liaison1 == null) {
            liaisonService.addLiaison(liaison);
            model.addAttribute("addLiaisonCheckMsg", "已成功添加该联系人！");
        } else {
            model.addAttribute("addLiaisonCheckMsg", "该联系人已存在！");
        }
        model.addAttribute("laccount", liaison.getLaccount());
        model.addAttribute("lrole", liaison.getLrole());
        if (caccount != null && cname != null) {
            model.addAttribute("account", liaison.getLaccount());
            model.addAttribute("cname", cname);
            model.addAttribute("caccount", caccount);
            return "redirect:lookCourseLiaisonlist";
        }
        return "redirect:liaisonlist";
    }

    //删除选中的联系人控制器
    @RequestMapping("/liaisonDeleteSelected")
    public String liaisonDeleteAll(int[] lnoArray, String lrole, String laccount, Model model) {
        liaisonService.deleteLiaisonsSelected(lnoArray, laccount);
        model.addAttribute("laccount", laccount);
        model.addAttribute("lrole", lrole);
        return "redirect:liaisonlist";
    }

    //修改联系人信息
    @RequestMapping("/liaisonupdate")
    public String liaisonUpdate(Liaison liaison, Model model) {
        liaisonService.updateLiaison(liaison);
        model.addAttribute("laccount", liaison.getLaccount());
        model.addAttribute("lrole", liaison.getLrole());
        return "redirect:liaisonlist";
    }

    //查看本班同学控制器
    @RequestMapping("/lookCourseLiaisonlist")
    public String lookCourseLiaisonlist(String addLiaisonCheckMsg, String account, String caccount, String cname, Model model) {
        List<StudentCourse> list = courseService.findStudentByCaccount(caccount);
        if (!list.isEmpty()) {
            List<Liaison> liaisonList = new ArrayList<Liaison>();
            for (int i = 0; i < list.size(); i++) {
                StudentCourse studentCourse = (StudentCourse) list.get(i);
                User user = userService.findUserByUaccount(studentCourse.getSaccount());
                if (user != null) {
                    Liaison liaison = new Liaison();
                    liaison.setLaccount(account);
                    liaison.setLnumber(user.getUaccount());
                    liaison.setLname(user.getUname());
                    liaison.setLsex(user.getUsex());
                    liaison.setLphone(user.getUphone());
                    liaison.setLrole(user.getUrole());
                    liaisonList.add(liaison);
                }
            }
            model.addAttribute("liaisonList", liaisonList);
        }
        model.addAttribute("cname", cname);
        model.addAttribute("caccount", caccount);
        model.addAttribute("addLiaisonCheckMsg", addLiaisonCheckMsg);
        return "classmate/classmatelist";
    }

    @RequestMapping("/addTeacher")
    public String addTeacher(Liaison liaison, Model model) {

        Liaison liaison1 = liaisonService.findLiaisonByLaccountLnumber(liaison.getLaccount(), liaison.getLnumber());
        if (liaison1 == null) {
            User user = userService.findUserByUaccount(liaison.getLnumber());
            Liaison liaison2 = liaison;
            liaison2.setLname(user.getUname());
            liaison2.setLsex(user.getUsex());
            liaison2.setLrole(user.getUrole());
            liaison2.setLphone(user.getUphone());
            liaisonService.addLiaison(liaison2);
            model.addAttribute("addLiaisonCheckMsg", "已成功添加该联系人！");
        } else {
            model.addAttribute("addLiaisonCheckMsg", "该联系人已存在！");
        }
        model.addAttribute("flag", "all");
        return "redirect:courselist";
    }

}
