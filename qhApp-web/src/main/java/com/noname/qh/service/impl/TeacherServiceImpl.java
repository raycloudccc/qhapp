package com.noname.qh.service.impl;

import com.noname.qh.entity.SubjectRelation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import com.noname.qh.dao.TeacherDao;
import com.noname.qh.entity.Subject;
import com.noname.qh.entity.Teacher;
import com.noname.qh.service.TeacherService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.ArrayList;
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
    @Resource(name = "PageHelper")
    private PageHelper pageHelper;

    @Override
    public boolean insertTeacher(Teacher teacher,String subids) {
        teacher.setStatus(1);
        teacher.setCreatetime(new Timestamp(System.currentTimeMillis()));
        boolean result = false;
        int count = teacherDao.insertTeacher(teacher);
        if (count > 0) {
            String[] subarr=subids.split("-");
            insertTeacherRelation(subarr,teacher);
            result = true;
        }
        return result;
    }

    @Override
    public boolean deleteTeacher(String arr) {
        boolean result = false;
        String[] teacher_ids = arr.split("&");
        for (String id : teacher_ids) {
            teacherDao.deleteTeacher(id);
        }
        result = true;
        return result;
    }

    @Override
    public boolean updateTeacher(Teacher teacher,String subids) {
        boolean result = false;
        int count = teacherDao.updateTeacher(teacher);
        Map<String,Object> map=new HashMap<>();
        map.put("teacherId",teacher.getTeacherId());
        map.put("subFlag",0);
        teacherDao.deleteSubjectRelation(map);
        String[] subidArr=subids.split(",");
        insertTeacherRelation(subidArr,teacher);
        result =true;
        return result;
    }

    @Override
    public Teacher selectTeacherById(Long teacherId) {
        Teacher teacher= teacherDao.selectTeacherById(teacherId);
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("teacherid",teacher.getTeacherId());
        map.put("flag",0);
        return teacher;
    }

    @Override
    public JSONObject listTeacher(String pageNo, String pageSize, int status, String name, String value) {
        Map<String, Object> map = new HashMap<>();
        map.put("status", status);
        map.put("name", name);
        map.put("value", "%" + value + "%");
        pageHelper.autoPage(pageNo, pageSize, map);
        if ("".equals(name) || "name".equals(name)||"".equals(value)) {
            int total = teacherDao.countTeacher(map);
            List<Teacher> teacherList = teacherDao.listTeacher(map);
            relevancySub(teacherList);
            return dataGridUtils.parseJSON(total, teacherList);
        }else if("subName".equals(name)){
            map.put("flag",0);
            int total =teacherDao.countTeacherBySub(map);
            List<Long> list=teacherDao.getTeacherListBySubName(map);
            List<Teacher> teachers=new ArrayList<>();
            for(Long l:list){
                teachers.add(teacherDao.selectTeacherById(l));
            }
            relevancySub(teachers);
            return dataGridUtils.parseJSON(total, teachers);
        }else{
            return null;
        }
    }

    @Override
    public List<Subject> allSub() {
        return teacherDao.allSub();
    }


    @Override
    public JSONArray teacherSelectedSub(Long teacherId) {
        /**
         * 获取老师已关联学科，在总学科的json中，如果已经关联则增加selected属性，easyui会自动根据json勾选
         * 未有关联学科则直接返回总学科的json
         */
        JSONArray arr=new JSONArray();
        List<Subject> subs=teacherDao.allSub();
        JSONArray arrays=arr.fromObject(subs);
        Map<String,Object> map=new HashedMap();
        map.put("teacherid",teacherId);
        map.put("flag",0);
        List<SubjectRelation> relation= teacherDao.getSubInfo(map);
        if(relation.isEmpty()){
            return arrays;
        }
        JSONArray newArr=new JSONArray();
        for(int x=0;x<arrays.size();x++){
            JSONObject obj= new JSONObject().fromObject(arrays.get(x));
            for(int y=0;y<relation.size();y++){
                long objid=obj.getLong("subId");
                if(objid==relation.get(y).getSubId()){
                    obj.put("selected",true);
                }
            }
            newArr.add(obj);
        }
        return newArr;
    }

    /**
     * 获取每个老师的关联学科，同时写入每个对象的
     * @param teacherList  老师集合
     */
    private void relevancySub(List<Teacher> teacherList){
        for (Teacher tea : teacherList) {
            Map<String, Object> map2 = new HashMap<>();
            map2.put("teacherid", tea.getTeacherId());
            map2.put("flag", 0);
            List<SubjectRelation> rela = teacherDao.getSubInfo(map2);
            StringBuffer subName = new StringBuffer("");
            if (rela.size() < 1) {
                tea.setSubName(String.valueOf(subName));
            }else if(rela.size()==1){
                tea.setSubName(rela.get(0).getSubName());
            }else {
                for (int x = 0; x < rela.size(); x++) {
                    subName.append(rela.get(x).getSubName());
                    if (x != rela.size() - 1) {
                        subName.append(",");
                    }
                }
                tea.setSubName(String.valueOf(subName));
            }
        }
    }

    private void insertTeacherRelation(String[] subarr,Teacher teacher){
        for(String subid:subarr){
            SubjectRelation relation=new SubjectRelation();
            relation.setObjId(teacher.getTeacherId());
            relation.setSubId(Long.valueOf(subid));
            relation.setSubFlag(0);
            relation.setCreatetime(new Timestamp(System.currentTimeMillis()));
            teacherDao.insertSubjectRelation(relation);
        }
    }
}
