package com.noname.qh.entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by noname on 2017/4/24.
 */
public class Teacher implements Serializable{

    private Long teacherId;
    private String name;
    private Integer age;
    private int gender;
    private String tele;
    private String email;
    private String wxh;
    private String address;
    private String sub_id;
    private int status;
    private String memo;
    private Timestamp createtime;
    private String sub_name;

    public String getSub_name() {
        return sub_name;
    }

    public void setSub_name(String sub_name) {
        this.sub_name = sub_name;
    }

    public Long getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Long teacherId) {
        this.teacherId = teacherId;
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

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getTele() {
        return tele;
    }

    public void setTele(String tele) {
        this.tele = tele;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getSub_id() {
        return sub_id;
    }

    public void setSub_id(String sub_id) {
        this.sub_id = sub_id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "teacherId='" + teacherId + '\'' +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", gender=" + gender +
                ", tele='" + tele + '\'' +
                ", email='" + email + '\'' +
                ", wxh='" + wxh + '\'' +
                ", address='" + address + '\'' +
                ", sub_id='" + sub_id + '\'' +
                ", status=" + status +
                ", memo='" + memo + '\'' +
                ", createtime=" + createtime +
                ", sub_name='" + sub_name + '\'' +
                '}';
    }
}
