package com.noname.qh.dao;

import com.noname.qh.entity.Subject;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/9.
 */
@Repository("SubjectDao")
public interface SubjectDao {
    public List<Subject> getSubjectList(Map map);

    public int getCountSubject();

    public int addSubject(Subject subject);

    public void deleteSubject(Long id);

    public int isExist(String subName);

    public String getSubNameById(long subjectId);
}
