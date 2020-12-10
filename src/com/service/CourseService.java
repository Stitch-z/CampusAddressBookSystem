package com.service;

import java.util.List;

import com.po.Course;
import com.po.StudentCourse;

public interface CourseService {
    List<StudentCourse> findSelectedCourses(String saccount);
//    List<StudentCourse> findNotSelectedCourses(String saccount);
    Course findCourseByCaccount(String caccount);
    void addCourse(Course course);
    List<Course> findCoursesByTaccount(String taccount);
    List<Course> findCoursesByTaccountKey(String taccount, String key);
    void updateSc_tableByCaccount(String saccount,String caccount);

    Course findCourseByCaccountKey(String caccount,String key);

    //通过课程编号查看有哪些学生选了这门课
    List<StudentCourse> findStudentByCaccount(String caccount);

    //查看全部课程
    List<Course> findAllCourse();

    void addSc_table(String saccount, String caccount);

    //删掉已选课程
    void deleteSc_table(String saccount, String caccount);

    void deleteCourse(String caccount);

    List<Course> findCoursesByKey(String key);

    void deleteSc_tableByCaccount(String caccount);

}
