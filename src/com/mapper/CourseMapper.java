package com.mapper;

import java.util.List;

import com.po.Course;
import com.po.StudentCourse;

public interface CourseMapper {
    //通过学生编号查询所选的所有课程编号
    List<StudentCourse> findSelectedCourses(String saccount);

/*    //通过学号编号查询未选的所有课程编号
    List<StudentCourse> findNotSelectedCourses(String saccount);*/

    Course selectCourseByCaccount(String caccount);

    List<Course> selectCoursesByTaccount(String taccount);

    //根据教师号和关键字查询课程
    List<Course> selectCoursesByTaccountKey(Course course);

    //根据课程号和关键字查询课程
    Course selectCoursesByCaccountKey(Course course);

    void updateSc_tableByCaccount(StudentCourse studentCourse);

    List<StudentCourse> selectStudentByCaccount(String caccount);

    List<Course> selectAllCourses();

    void insertSc_table(StudentCourse studentCourse);

    void deleteSc_table(StudentCourse studentCourse);

    void insertCourse(Course course);

    void deleteCourseByCaccount(String caccount);

    List<Course> selectCoursesByKey(String cname);

    void deleteSc_tableByCaccount(String caccount);

    //通过账号查看所有通话记录
//    List<History> selectHistoryByHaccount(String haccount);
//    //删除通话记录
//    void deleteHistoryByHnoByHaccount(History history);
//
//    List<History> selectHistoryByHaccountByHphone(History history);
//
//    void updateHistory(History history);
}
