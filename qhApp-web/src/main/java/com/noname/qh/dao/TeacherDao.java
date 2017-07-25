package com.noname.qh.dao;

import com.noname.qh.entity.SubjectRelation;
import com.noname.qh.entity.TeacherSchedule;
import org.springframework.stereotype.Repository;
import com.noname.qh.entity.Subject;
import com.noname.qh.entity.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/4/24.
 */
@Repository("TeacherDao")
public interface TeacherDao {
    public int insertTeacher(Teacher teacher);

    public int deleteTeacher(Map map);

    public int updateTeacher(Teacher teacher);

    public Teacher selectTeacherById(Long teacher_id);

    /**
     *
     * @param map 教师的状态,开始条数，结束条数
     * @return
     */
    public List<Teacher> listTeacher(Map map);

    public int countTeacher(Map map);

    public List<Subject> allSub();

    public List<SubjectRelation> getSubInfo(Map map);

    public int countTeacherBySub(Map map);

    public List<Long> getTeacherListBySubName(Map map);

    public void insertSubjectRelation(SubjectRelation relation);

    public void deleteSubjectRelation(Map map);

    public List<Teacher> listAllValidTeachers(int status);

    public List<TeacherSchedule> getSingleDayTeacherSchedule(Map map);

    public Integer getMaxCount(Long teacherId);

    public List<Subject> getSubInfoByTeacherId(Map map);

    public void insertSchedule(TeacherSchedule schedule);

    public int checkScheduleConflict(Map map);

    public void removeSchedule(long id);
}
