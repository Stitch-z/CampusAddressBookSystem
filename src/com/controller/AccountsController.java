package com.controller;

import javax.servlet.http.HttpSession;

import com.po.Liaison;
import com.service.LiaisonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.po.Accounts;
import com.po.User;
import com.service.AccountsService;
import com.service.UserService;

import java.util.List;

/*
 * 账户控制器类
 */

@Controller
public class AccountsController {

    @Autowired
    private AccountsService accountsService;

    @Autowired
    private UserService userService;

    @Autowired
    private LiaisonService liaisonService;


    //登录功能控制
    @RequestMapping("/login")
    public String login(String account, String pwd, Model model, HttpSession session) {
        Accounts accounts = accountsService.findAccountByAccountByPwd(account, pwd);
        if (accounts != null) {
//            session.setAttribute("uaccount", accounts.getAccount());
            //一开始用的model，因为页面跳转信息会丢失，所以改用了session来存入account
            session.setAttribute("account", account);
            session.setAttribute("pwd",pwd);
            session.setAttribute("role",accounts.getRole());

            User user = userService.findUserByUaccount(account);
            session.setAttribute("name",user.getUname());

            if ("管理员".equals(accounts.getRole())) {
                model.addAttribute("urole","学生");
                return "redirect:findAllUser";
            }
            else {
                model.addAttribute("laccount",account);
                model.addAttribute("lrole","学生");
                return "redirect:liaisonlist";
            }
        }
        model.addAttribute("msg", "账号或密码错误，请重新输入！");
        return "login";

    }

    //注册功能控制
    @RequestMapping("/register")
    public String register(Accounts accounts, String confirmPwd,String uname, String phone, Model model) {
        Accounts accounts1 = accountsService.findAccountByAccount(accounts.getAccount());
        if (accounts1 != null) {
            model.addAttribute("fail", "账号已存在！");
            return "register";
        } else if ("".equals(accounts.getAccount())) {
            model.addAttribute("fail", "未输入账号！");
            return "register";
        } else if ("".equals(phone)) {
            model.addAttribute("fail", "未输入手机号码！");
            return "register";
        } else if ("".equals(accounts.getPwd())) {
            model.addAttribute("fail", "未输入密码！");
            return "register";
        } else if ("".equals(confirmPwd)) {
            model.addAttribute("fail", "请再次输入密码！");
            return "register";
        } else if (!accounts.getPwd().equals(confirmPwd)) {
            model.addAttribute("fail", "密码输入不一致！");
            return "register";
        }
        else {
            boolean vis = true;
            for (int i = 0; i < phone.length(); i++) {
                if (phone.charAt(i) <'0' || phone.charAt(i)>'9')
                    vis = false;
            }
            if (!vis) {
                model.addAttribute("fail", "手机号码格式不正确！");
                return "register";
            } else {
                //业务层添加账户的信息进表accounts
                accountsService.addAccounts(accounts);

                //业务层添加账户信息到user表
                User user = new User();
                user.setUaccount(accounts.getAccount());
                user.setUpwd(accounts.getPwd());
                user.setUphone(phone);
                user.setUname(uname);
                user.setUrole(accounts.getRole());
                userService.addUser(user);
                model.addAttribute("msg", "注册成功！");
                return "login";
            }
        }

    }

    //跳转到注册页面
    @RequestMapping("/toregister")
    public String toregister() {
        return "register";
    }


}
