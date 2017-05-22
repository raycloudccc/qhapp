package com.noname.qh.service;

import com.noname.qh.entity.Subject;

import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/9.
 */
public interface SubjectService {
    public List<Subject> getSubjectList(Map map);

    public int getCountSubject();

    public String addSubject(Subject subject);

    public boolean deleteSubject(String arrs);
}
