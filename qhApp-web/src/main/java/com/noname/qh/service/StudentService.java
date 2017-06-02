package com.noname.qh.service;

import com.noname.qh.entity.Student;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/2.
 */
public interface StudentService {
    public JSONObject getStudentList(Map map);

    public Student getStudentInfo(String studentId);

    public boolean updateStudent(Student student);

    public boolean addStudent(Student student);

    public boolean deleteStudent(String arr);

    public void exportStudentData(HttpServletResponse response);
}
