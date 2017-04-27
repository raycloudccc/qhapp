package test.dao;

import org.springframework.stereotype.Repository;
import test.entity.Subject;
import test.entity.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/4/24.
 */
@Repository("TeacherDao")
public interface TeacherDao {
    public int insertTeacher(Teacher teacher);

    public int deleteTeacher(String arr);

    public int updateTeacher(Teacher teacher);

    public Teacher selectTeacherById(String teacher_id);

    /**
     *
     * @param map 教师的状态,开始条数，结束条数
     * @return
     */
    public List<Teacher> listTeacher(Map map);

    public int countTeacher(int status);

    public List<Subject> allSub();

}
