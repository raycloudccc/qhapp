package com.noname.qh.dao;

import com.noname.qh.entity.Classroom;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/6/6.
 */
@Repository("ClassroomDao")
public interface ClassroomDao {
    public List<Classroom> listClassroom(Map map);

    public int CountClassroom();

    public int saveClass(Classroom classroom);

    public int isExist(String className);

    public void deleteClass(Long classId);
}
