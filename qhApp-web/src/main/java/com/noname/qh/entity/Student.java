package com.noname.qh.entity;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by noname on 2017/5/2.
 */
public class Student implements Serializable {
    private Long stuId;
    private String name;
    private Integer age;
    private Integer gender;
    private String tele;
    private String wxh;
    private String address;
    private Integer status;
    private String memo;
    private Date enroldate;
    private Timestamp createtime;

    public void setStuId(Long stuId) {
        this.stuId = stuId;
    }

    public Long getStuId() {
        return stuId = stuId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getTele() {
        return tele;
    }

    public void setTele(String tele) {
        this.tele = tele;
    }

    public String getWxh() {
        return wxh;
    }

    public void setWxh(String wxh) {
        this.wxh = wxh;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Date getEnroldate() {
        return enroldate;
    }

    public void setEnroldate(Date enroldate) {
        this.enroldate = enroldate;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Student{" +
                "StuId=" + stuId +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", gender=" + gender +
                ", tele='" + tele + '\'' +
                ", wxh='" + wxh + '\'' +
                ", address='" + address + '\'' +
                ", status=" + status +
                ", memo='" + memo + '\'' +
                ", enroldate=" + enroldate +
                ", createtime=" + createtime +
                '}';
    }
}
