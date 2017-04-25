package test.dao;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Repository;
import test.entity.Subject;
import test.entity.Teacher;

import java.util.List;

/**
 * Created by noname on 2017/4/24.
 */
@Repository("TeacherDao")
public interface TeacherDao {
    public void insertTeacher(Teacher teacher);

    public void deleteTeacher(Teacher teacher);

    public void updateTeacher(Teacher teacher);

    public Teacher selectTeacherById(String teacher_id);

    /**
     *
     * @param status 教师的状态
     * @return
     */
    public List<Teacher> listTeacher(int status);

    public int countTeacher(int status);

    public List<Subject> allSub();

}
