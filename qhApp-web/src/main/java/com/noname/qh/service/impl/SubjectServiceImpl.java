package com.noname.qh.service.impl;

import com.noname.qh.dao.SubjectDao;
import com.noname.qh.entity.Subject;
import com.noname.qh.service.SubjectService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/9.
 */
@Service("SubjectService")
public class SubjectServiceImpl implements SubjectService{

    @Resource(name="SubjectDao")
    private SubjectDao subjectDao;

    @Override
    public List<Subject> getSubjectList(Map map) {
        return subjectDao.getSubjectList(map);
    }

    @Override
    public int getCountSubject() {
        return subjectDao.getCountSubject();
    }

    @Override
    public String addSubject(Subject subject) {
        String result="false";
        subject.setCreatetime(new Timestamp(System.currentTimeMillis()));
        //检测冲突
        int isClash=subjectDao.isExist(subject.getSubName());
        if(isClash>=1){
            result="clash";
            return result;
        }
        int count=subjectDao.addSubject(subject);
        if(count>=1){
            result="true";
        }
        return result;
    }

    @Override
    public boolean deleteSubject(String arrs) {
        boolean result=false;
        String[] subId=arrs.split("-");
        for(String id:subId){
            subjectDao.deleteSubject(Long.valueOf(id));
        }
        result=true;
        return result;
    }
}
