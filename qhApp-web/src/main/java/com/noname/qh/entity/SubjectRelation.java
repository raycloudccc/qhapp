package com.noname.qh.entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by noname on 2017/5/10.
 */
public class SubjectRelation implements Serializable{
    private Long relaId;
    private Long objId;
    private Long subId;
    private int subFlag;
    private String subName;
    private Timestamp createtime;

    public String getSubName() {
        return subName;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

    public Long getRelaId() {
        return relaId;
    }

    public void setRelaId(Long relaId) {
        this.relaId = relaId;
    }

    public Long getObjId() {
        return objId;
    }

    public void setObjId(Long objId) {
        this.objId = objId;
    }

    public Long getSubId() {
        return subId;
    }

    public void setSubId(Long subId) {
        this.subId = subId;
    }

    public int getSubFlag() {
        return subFlag;
    }

    public void setSubFlag(int subFlag) {
        this.subFlag = subFlag;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "SubjectRelation{" +
                "relaId=" + relaId +
                ", objId=" + objId +
                ", subId=" + subId +
                ", subFlag=" + subFlag +
                ", subName='" + subName + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}
