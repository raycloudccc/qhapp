package test.service.impl;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import test.dao.TeacherDao;
import test.entity.Subject;
import test.entity.Teacher;
import test.service.TeacherService;
import test.utils.DataGridUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by noname on 2017/4/24.
 */
@Service("TeacherService")
public class TeacherServiceImpl implements TeacherService{

    @Resource(name="TeacherDao")
    private TeacherDao teacherDao;
    @Resource(name="DataGridUtils")
    private DataGridUtils dataGridUtils;

    @Override
    public void insertTeacher(Teacher teacher) {
        teacherDao.insertTeacher(teacher);
    }

    @Override
    public void deleteTeacher(Teacher teacher) {

    }

    @Override
    public void updateTeacher(Teacher teacher) {

    }

    @Override
    public Teacher selectTeacherById(String teacher_id) {
        return null;
    }

    @Override
    public JSONObject listTeacher(int status) {
        int total=teacherDao.countTeacher(status);
        List<Teacher> teacherList= teacherDao.listTeacher(status);
        return dataGridUtils.parseJSON(total,teacherList);
    }

    @Override
    public List<Subject> allSub() {
        return teacherDao.allSub();
    }


}
