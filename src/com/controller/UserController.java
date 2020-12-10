package com.controller;

import com.po.Accounts;
import com.service.AccountsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.po.User;
import com.service.UserService;

import javax.servlet.http.HttpSession;
import java.util.List;

/*
 * 个人账户管理控制类
 */
@Controller
public class UserController {
    @Autowired
    private AccountsService accountsService;

    @Autowired
    private UserService userService;

    //查看所有账户信息
    @RequestMapping("/findAllUser")
    public String findAllUser(String becomeAdmin,String deleteAccountMsg,String addAccountMsg,String urole,Model model) {
        List<User> userList = userService.findAllUserByUrole(urole);
        model.addAttribute("userList",userList);
        model.addAttribute("flag",urole);
        model.addAttribute("urole",urole);
        model.addAttribute("addAccountMsg",addAccountMsg);
        model.addAttribute("becomeAdmin",becomeAdmin);
        model.addAttribute("deleteAccountMsg",deleteAccountMsg);
        return "user/userlist";
    }

    //查看个人账户信息
    @RequestMapping("/userlist")
    public String userList(String uaccount,Model model) {
        User user1 = userService.findUserByUaccount(uaccount);
        model.addAttribute("user", user1);
        model.addAttribute("account", uaccount);
        return "user/userinfo";
    }

    //修改个人账户信息
    @RequestMapping("/userupdate")
    public String userUpdate(User user,Model model) {
        userService.updateUser(user);
        //重新把账号的值赋给uaccount，以便修改后可以根据账号查询个人信息
        model.addAttribute("uaccount",user.getUaccount());
        model.addAttribute("account", user.getUaccount());
        return "redirect:userlist";
    }

    //升为管理员
    @RequestMapping("/becomeAdmin")
    public String becomeAdmin(String urole,String account,Model model) {
        User user = userService.findUserByUaccount(account);
        user.setUrole("管理员");
        userService.updateUser(user);
        Accounts accounts = accountsService.findAccountByAccount(account);
        accounts.setRole("管理员");
        accountsService.updateAccounts(accounts);
        model.addAttribute("urole",urole);
        model.addAttribute("becomeAdmin","更改权限成功！");
        return "redirect:findAllUser";
    }

    //删除账户
    @RequestMapping("/deleteAccount")
    public String deleteAccount(String account,String flag,Model model) {
        userService.deleteUserByUaccount(account);
        accountsService.deleteAccount(account);
        model.addAttribute("urole",flag);
        model.addAttribute("deleteAccountMsg","删除账号成功！");
        return "redirect:findAllUser";
    }

    //跳转到修改密码页面
    @RequestMapping("/toUpdatePwd")
    public String toUpdatePwd(String uaccount,String pwd,Model model) {
        //把从common页面传过来的账号密码传到updatePwd页面
        model.addAttribute("uaccount",uaccount);
        model.addAttribute("pwd",pwd);
        return "user/updatePwd";
    }

    //修改密码控制器
    @RequestMapping("/updatePwd")
    public String updatePwd(String uaccount, String pwd, String oldPwd, String newPwd, String confirmPwd, Model model, HttpSession session) {
        if ("".equals(oldPwd)) {
            model.addAttribute("pwdMsg","请输入原密码！");
            return "user/updatePwd";
        }
        else if("".equals(newPwd)) {
            model.addAttribute("pwdMsg","请输入新密码！");
            return "user/updatePwd";
        }
        else if ("".equals(confirmPwd)) {
            model.addAttribute("pwdMsg","请输入确认密码！");
            return "user/updatePwd";
        }
        else if (!(pwd.equals(oldPwd))) {
            model.addAttribute("pwdMsg","原密码输入错误！");
            return "user/updatePwd";
        }
        else if (newPwd.length()<8) {
            model.addAttribute("pwdMsg","密码格式不正确！");
            return "user/updatePwd";
        }
        else if (!(newPwd.equals(confirmPwd))) {
            model.addAttribute("pwdMsg","两次新密码不一致！");
            return "user/updatePwd";
        }

        Accounts accounts = new Accounts();
        accounts.setAccount(uaccount);
        accounts.setPwd(newPwd);
        accountsService.updatePassword(accounts);

        User user = new User();
        user.setUaccount(uaccount);
        user.setUpwd(newPwd);
        userService.updateUser(user);
        session.invalidate();
        model.addAttribute("msg","密码修改成功，请重新登录！");
        return "login";
    }

    @RequestMapping("/out")
    public String out(HttpSession session) {
        session.invalidate();
        return "login";
    }

    @RequestMapping("/addAccount")
    public String addAccount(User user,String confirmUpwd, Model model) {
        Accounts account = accountsService.findAccountByAccount(user.getUaccount());

        if ("".equals(user.getUaccount())) {
            model.addAttribute("addAccountMsg","请输入账号！");
        }
        else if("".equals(user.getUpwd())) {
            model.addAttribute("addAccountMsg","请输入密码！");
        }
        else if("".equals(confirmUpwd)) {
            model.addAttribute("addAccountMsg","请输入确认密码！");
        }
        else if("".equals(user.getUname())) {
            model.addAttribute("addAccountMsg","请输入名字！");
        }
        else if("".equals(user.getUphone())) {
            model.addAttribute("addAccountMsg","请输入手机号码！");
        }
        else if (!confirmUpwd.equals(user.getUpwd())) {
            model.addAttribute("addAccountMsg","密码不一致，创建账户失败");
        }
        else if (account!=null) {
            model.addAttribute("addAccountMsg","账号已存在，创建账户失败");
        }
        else {
            Accounts account2 = new Accounts();
            account2.setAccount(user.getUaccount());
            account2.setPwd(user.getUpwd());
            account2.setRole(user.getUrole());
            accountsService.addAccounts(account2);
            userService.addUser(user);
            model.addAttribute("addAccountMsg","创建账户成功！");
        }
        model.addAttribute("urole",user.getUrole());
        return "redirect:findAllUser";
    }
}
