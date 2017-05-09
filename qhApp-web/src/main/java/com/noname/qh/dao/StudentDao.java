package com.noname.qh.dao;

import com.noname.qh.entity.Student;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/2.
 */
@Repository("StudentDao")
public interface StudentDao {
    public List<Student> getStudentList(Map map);

    public int countStudent(int status);

    public Student getStudentInfo(String studentId);

    public int updateStudent(Student student);

    public int addStudent(Student student);

    public void deleteStudent(String stuId);
}
