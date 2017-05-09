package com.noname.qh.service.impl;

import com.noname.qh.dao.StudentDao;
import com.noname.qh.entity.Student;
import com.noname.qh.service.StudentService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/2.
 */
@Service("StudentService")
public class StudentServiceImpl implements StudentService{

    @Resource(name="StudentDao")
    private StudentDao studentDao;
    @Resource(name="DataGridUtils")
    private DataGridUtils dataGridUtils;
    @Resource(name="PageHelper")
    private PageHelper pageHelper;

    @Override
    public JSONObject getStudentList(Map map) {
        List<Student> studentList=studentDao.getStudentList(map);
        int total=studentDao.countStudent((int)(map.get("status")));
        return dataGridUtils.parseJSON(total,studentList);
    }

    @Override
    public Student getStudentInfo(String studentId) {
        return studentDao.getStudentInfo(studentId);
    }

    @Override
    public boolean updateStudent(Student student) {
        boolean result=false;
        int count= studentDao.updateStudent(student);
        if (count >= 1) {
            result=true;
        }
        return result;
    }

    @Override
    public boolean addStudent(Student student) {
        boolean result=false;
        student.setStatus(1);
        student.setCreatetime(new Timestamp(System.currentTimeMillis()));
        int count=studentDao.addStudent(student);
        if(count>=1){
            result=true;
        }
        return result;
    }

    @Override
    public boolean deleteStudent(String arr) {
        boolean result=false;
        String ids[] =arr.split("&");
        for(String id:ids){
            studentDao.deleteStudent(id);
        }
        result=true;
        return result;
    }
}
