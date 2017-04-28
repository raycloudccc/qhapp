package com.noname.qh.service.impl;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import com.noname.qh.dao.TeacherDao;
import com.noname.qh.entity.Subject;
import com.noname.qh.entity.Teacher;
import com.noname.qh.service.TeacherService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/4/24.
 */
@Service("TeacherService")
public class TeacherServiceImpl implements TeacherService {

    @Resource(name = "TeacherDao")
    private TeacherDao teacherDao;
    @Resource(name = "DataGridUtils")
    private DataGridUtils dataGridUtils;
    @Resource(name="PageHelper")
    private PageHelper pageHelper;

    @Override
    public boolean insertTeacher(Teacher teacher) {
        teacher.setStatus(1);
        teacher.setCreatetime(new Timestamp(System.currentTimeMillis()));
        boolean result=false;
        int count=teacherDao.insertTeacher(teacher);
        if(count>0){
            result=true;
        }
        return result;
    }

    @Override
    public boolean deleteTeacher(String arr) {
        boolean result=false;
        String[] teacher_ids=arr.split("&");
        for(String id:teacher_ids){
            teacherDao.deleteTeacher(id);
        }
        result=true;
        return result;
    }

    @Override
    public boolean updateTeacher(Teacher teacher) {
        boolean result=false;
        int count=teacherDao.updateTeacher(teacher);
        if(count>0){
            result=true;
        }
        return result;
    }

    @Override
    public Teacher selectTeacherById(Long teacherId) {
        return teacherDao.selectTeacherById(teacherId);
    }

    @Override
    public JSONObject listTeacher(String pageNo,String pageSize,int status) {
        int total = teacherDao.countTeacher(status);
        Map<String,Object> map=new HashMap<>();
        map.put("status",status);
        pageHelper.autoPage(pageNo,pageSize,map);
        System.out.println("map:"+map);
        List<Teacher> teacherList = teacherDao.listTeacher(map);
        return dataGridUtils.parseJSON(total, teacherList);
    }

    @Override
    public List<Subject> allSub() {
        return teacherDao.allSub();
    }




}
