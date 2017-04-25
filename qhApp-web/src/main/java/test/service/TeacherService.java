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

    public void insertTeacher(Teacher teacher);

    public void deleteTeacher(Teacher teacher);

    public void updateTeacher(Teacher teacher);

    public Teacher selectTeacherById(String teacher_id);

    public JSONObject listTeacher(int status);

    public List<Subject> allSub();

}
