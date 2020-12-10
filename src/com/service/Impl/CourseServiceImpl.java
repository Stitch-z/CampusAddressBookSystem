package com.service.Impl;

import java.util.List;

import com.po.Course;
import com.po.StudentCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mapper.CourseMapper;
import com.service.CourseService;

@Service
@Transactional
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<StudentCourse> findSelectedCourses(String saccount) {
        return courseMapper.findSelectedCourses(saccount);
    }

/*
    @Override
    public List<StudentCourse> findNotSelectedCourses(String saccount) {
        return courseMapper.findNotSelectedCourses(saccount);
    }
*/

    @Override
    public Course findCourseByCaccount(String caccount) {
        return courseMapper.selectCourseByCaccount(caccount);
    }

    @Override
    public void addCourse(Course course) {
        courseMapper.insertCourse(course);
    }

    @Override
    public List<Course> findCoursesByTaccount(String taccount) {
        return courseMapper.selectCoursesByTaccount(taccount);
    }

    @Override
    public List<Course> findCoursesByTaccountKey(String taccount, String key) {
        Course course = new Course();
        course.setTaccount(taccount);
        course.setCname(key);
        return courseMapper.selectCoursesByTaccountKey(course);
    }

    @Override
    public void updateSc_tableByCaccount(String saccount, String caccount) {
        StudentCourse studentCourse = new StudentCourse();
        studentCourse.setSaccount(saccount);
        studentCourse.setCaccount(caccount);
        courseMapper.updateSc_tableByCaccount(studentCourse);
    }

    @Override
    public Course findCourseByCaccountKey(String caccount, String key) {
        Course course = new Course();
        course.setCaccount(caccount);
        course.setCname(key);
        return courseMapper.selectCoursesByCaccountKey(course);
    }

    @Override
    public List<StudentCourse> findStudentByCaccount(String caccount) {
        return courseMapper.selectStudentByCaccount(caccount);
    }

    @Override
    public List<Course> findAllCourse() {
        return courseMapper.selectAllCourses();
    }

    @Override
    public void addSc_table(String saccount, String caccount) {
        StudentCourse studentCourse = new StudentCourse();
        studentCourse.setSaccount(saccount);
        studentCourse.setCaccount(caccount);
        courseMapper.insertSc_table(studentCourse);
    }

    @Override
    public void deleteSc_table(String saccount, String caccount) {
        StudentCourse studentCourse = new StudentCourse();
        studentCourse.setSaccount(saccount);
        studentCourse.setCaccount(caccount);
        courseMapper.deleteSc_table(studentCourse);
    }

    @Override
    public void deleteCourse(String caccount) {
        courseMapper.deleteCourseByCaccount(caccount);
    }

    @Override
    public List<Course> findCoursesByKey(String key) {
        return courseMapper.selectCoursesByKey(key);
    }

    @Override
    public void deleteSc_tableByCaccount(String caccount) {
        courseMapper.deleteSc_tableByCaccount(caccount);
    }


}
