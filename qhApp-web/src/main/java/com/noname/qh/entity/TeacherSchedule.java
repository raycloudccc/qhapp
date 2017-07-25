package com.noname.qh.entity;

import java.sql.Time;
import java.sql.Timestamp;

/**
 * Created by noname on 2017/6/5.
 */
public class TeacherSchedule {
    private Long scheduleId;
    private Long teacherId;
    private Long studentId;
    private Time stime;
    private Time etime;
    private int week;
    private Long subjectId;
    private String subjectName;
    private Long classId;
    private String className;
    private Timestamp createTime;

    public Long getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(Long scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Long getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Long teacherId) {
        this.teacherId = teacherId;
    }

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public Time getStime() {
        return stime;
    }

    public void setStime(Time stime) {
        this.stime = stime;
    }

    public Time getEtime() {
        return etime;
    }

    public void setEtime(Time etime) {
        this.etime = etime;
    }

    public int getWeek() {
        return week;
    }

    public void setWeek(int week) {
        this.week = week;
    }

    public Long getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(Long subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public Long getClassId() {
        return classId;
    }

    public void setClassId(Long classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "TeacherSchedule{" +
                "scheduleId=" + scheduleId +
                ", teacherId=" + teacherId +
                ", studentId=" + studentId +
                ", stime=" + stime +
                ", etime=" + etime +
                ", week=" + week +
                ", subjectId=" + subjectId +
                ", subjectName='" + subjectName + '\'' +
                ", classId=" + classId +
                ", className='" + className + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
