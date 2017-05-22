package com.noname.qh.service;

import com.noname.qh.entity.SubjectRelation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.noname.qh.entity.Subject;
import com.noname.qh.entity.Teacher;

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

    public JSONObject listTeacher(String pageNo, String pageSize, int status,String name,String value);

    public List<Subject> allSub();

    public JSONArray teacherSelectedSub(Long teacherId);

}
