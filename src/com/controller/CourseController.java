package com.controller;

import com.po.Course;
import com.po.Notify;
import com.po.StudentCourse;
import com.po.User;
import com.service.NotifyService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.CourseService;

import java.util.ArrayList;
import java.util.List;

@Controller
public class CourseController {
    @Autowired
    private CourseService courseService;

    @Autowired
    private UserService userService;

    @Autowired
    private NotifyService notifyService;

    //显示课程控制器
    @RequestMapping("/courselist")
    public String courselist(String saccount,String flag,String addLiaisonCheckMsg,String applyCourse,Model model) {

        //查询全部课程
        List<Course> allCourseList = courseService.findAllCourse();

        if("all".equals(flag)) {
            model.addAttribute("courseList",allCourseList);
            model.addAttribute("flag",flag);
            model.addAttribute("applyCourse",applyCourse);
            model.addAttribute("addLiaisonCheckMsg",addLiaisonCheckMsg);
            return "course/courselist";
        }
        //查询已选课程
        List<StudentCourse> list = courseService.findSelectedCourses(saccount);

        if ("notSelected".equals(flag)) {

            for (int i=0;i<list.size();i++) {
                StudentCourse studentCourse = list.get(i);
                for (int j=0;j<allCourseList.size();j++) {
                    if (allCourseList.get(j).getCaccount().equals(studentCourse.getCaccount())) {
                        allCourseList.remove(j);
                        break;
                    }
                }
            }
            model.addAttribute("courseList",allCourseList);
/*            model.addAttribute("flag",flag);
            model.addAttribute("applyCourse",applyCourse);
            return "course/courselist";*/
        }

        else if("selected".equals(flag)) {
            if (!list.isEmpty()) {
                List<Course> courseList = new ArrayList<Course>();
                for (int i=0;i<list.size();i++) {
                    StudentCourse studentCourse = (StudentCourse) list.get(i);
                    Course course = courseService.findCourseByCaccount(studentCourse.getCaccount());
                    courseList.add(course);
                }
                model.addAttribute("courseList",courseList);
            }
        }
        model.addAttribute("flag",flag);
        model.addAttribute("applyCourse",applyCourse);
        return "course/courselist";
    }

    //显示教师所教课程
    @RequestMapping("/teacherCourselist")
    public String teacherCourselist(String taccount,String flag,String applyCourse,Model model) {
        List<Course> courseList = courseService.findCoursesByTaccount(taccount);
        User user = userService.findUserByUaccount(taccount);
        model.addAttribute("cteacher",user.getUname());
        model.addAttribute("courseList",courseList);
        model.addAttribute("applyCourse",applyCourse);
        model.addAttribute("flag",flag);
        return "course/courselist";
    }

    //根据课程名称模糊查询课程
    @RequestMapping("/toSelectCourselist")
    public String toSelectCourselist(String account,String flag,String role,String key,Model model) {
        if ("教师".equals(role)) {
            List<Course> courseList = courseService.findCoursesByTaccountKey(account,key);
            model.addAttribute("courseList",courseList);
        }
        else if("学生".equals(role)) {

            //查询已选课程
            List<StudentCourse> list = courseService.findSelectedCourses(account);

            if ("selected".equals(flag)) {
                if (!list.isEmpty()) {
                    List<Course> courseList = new ArrayList<Course>();
                    for (int i=0;i<list.size();i++) {
                        StudentCourse studentCourse = (StudentCourse) list.get(i);
                        Course course = courseService.findCourseByCaccountKey(studentCourse.getCaccount(),key);
                        if (course!=null) courseList.add(course);
                    }
                    model.addAttribute("courseList",courseList);
                }
            }

            else if ("notSelected".equals(flag)) {
                //查询全部课程
                List<Course> allCourseList = courseService.findAllCourse();
                for (int i=0;i<list.size();i++) {
                    StudentCourse studentCourse = list.get(i);
                    for (int j=0;j<allCourseList.size();j++) {
                        if (allCourseList.get(j).getCaccount().equals(studentCourse.getCaccount())) {
                            allCourseList.remove(j);
                            break;
                        }
                    }
                }
                List<Course> courseList = new ArrayList<Course>();
                for (int i=0;i<allCourseList.size();i++) {
                    Course course = courseService.findCourseByCaccountKey(allCourseList.get(i).getCaccount(),key);
                    if (course!=null) courseList.add(course);
                }
                model.addAttribute("courseList",courseList);
            }
            else if("all".equals(flag)) {
                List<Course> courseList = courseService.findCoursesByKey(key);
                model.addAttribute("courseList",courseList);
            }

            model.addAttribute("flag",flag);

        }

        return "course/courselist";
    }


    @RequestMapping("/addCourse")
    public String addCourse(Course course, Model model) {
        Course course1 = courseService.findCourseByCaccount(course.getCaccount());
        if ("".equals(course.getCaccount())) {
            model.addAttribute("applyCourse","请输入课程编号！");
        }
        else if("".equals(course.getCname())) {
            model.addAttribute("applyCourse","请输入课程名称！");
        }
        else if("".equals(course.getTaccount())) {
            model.addAttribute("applyCourse","请输入教师编号！");
        }
        else if("".equals(course.getCteacher())) {
            model.addAttribute("applyCourse","请输入教师姓名！");
        }
        else if (course1!=null) {
            model.addAttribute("applyCourse","课程已存在，创建课程失败！");
        }
        else {
            String taccount = course.getTaccount();
            User user = userService.findUserByUaccount(taccount);
            Notify notify = new Notify();
            notify.setNfrom(taccount);
            notify.setNfromName(user.getUname());
            notify.setNtoRole("管理员");
            notify.setNcourse(course.getCaccount());
            notify.setNcourseName(course.getCname());
            notify.setNcourseTaccount(course.getTaccount());
            notify.setNcourseTeacher(course.getCteacher());
            notify.setNcontent("申请创建课程《"+course.getCname()+"》");
            notify.setNstate("未审核");
            notify.setNtype("消息");

            //先查找消息表里面有没有提交过该消息且未审核过的
            Notify notify2 = notifyService.findNotifyToAdmin(notify);
            if (notify2!=null) {
                model.addAttribute("applyCourse","已提交过该申请，请不要重复提交！");
            }
            else {
                notifyService.addNotify(notify);
                model.addAttribute("applyCourse","已提交申请，等待审核！");
            }
        }

        model.addAttribute("taccount",course.getTaccount());
        return "redirect:teacherCourselist";
    }

    //删除课程
    @RequestMapping("/deleteCourse")
    public String deleteCourse(String caccount,String flag,Model model) {
        courseService.deleteCourse(caccount);
        courseService.deleteSc_tableByCaccount(caccount);
        model.addAttribute("flag",flag);
        return "redirect:courselist";
    }

}
