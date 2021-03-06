package com.noname.qh.service;

import com.noname.qh.entity.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/4/24.
 */

public interface TeacherService {

    public boolean insertTeacher(Teacher teacher,String subids);

    public boolean deleteTeacher(String arr);

    public boolean updateTeacher(Teacher teacher,String subids);

    public Teacher selectTeacherById(Long teacher_id);

    public JSONObject listTeacher(String pageNo, String pageSize, int status,String search);

    public List<Subject> allSub();

    public JSONArray teacherSelectedSub(Long teacherId);

    public void exportData(HttpServletResponse response);

    public List<List<TeacherSchedule>> getTeacherSchedule(Long teacherId);

    public JSONArray getTeacherSelectSubJSON(Map map);

    public List<Subject> teacherSub(Long teacherId);

    public List<Classroom> classList();

    public String insertSchedule(TeacherSchedule schedule);

    public boolean removeSchedule(long id);

}
