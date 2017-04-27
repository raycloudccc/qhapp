package test.service;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import test.entity.Subject;
import test.entity.Teacher;

import java.util.List;

/**
 * Created by noname on 2017/4/24.
 */

public interface TeacherService {

    public boolean insertTeacher(Teacher teacher);

    public boolean deleteTeacher(String arr);

    public boolean updateTeacher(Teacher teacher);

    public Teacher selectTeacherById(String teacher_id);

    public JSONObject listTeacher(String pageNo,String pageSize,int status);

    public List<Subject> allSub();


}
