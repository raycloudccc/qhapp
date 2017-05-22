package com.noname.qh.entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by noname on 2017/4/25.
 */
public class Subject implements Serializable{
    private Long subId;
    private String subName;
    private Timestamp createtime;

    public Long getSubId() {
        return subId;
    }

    public void setSubId(Long subId) {
        this.subId = subId;
    }

    public String getSubName() {
        return subName;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Subject{" +
                "subId='" + subId + '\'' +
                ", subName='" + subName + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}
