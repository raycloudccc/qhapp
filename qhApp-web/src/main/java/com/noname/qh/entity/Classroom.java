package com.noname.qh.entity;

import java.sql.Timestamp;

/**
 * Created by noname on 2017/6/6.
 */
public class Classroom {
    private Long classId;
    private String className;
    private Timestamp createTime;

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
        return "Classroom{" +
                "classId=" + classId +
                ", className='" + className + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
