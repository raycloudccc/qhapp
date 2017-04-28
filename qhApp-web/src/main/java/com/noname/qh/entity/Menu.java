package com.noname.qh.entity;

import java.io.Serializable;

/**
 * Created by noname on 2017/4/19.
 */
public class Menu implements Serializable {
    private String menu_id;
    private String menu_name;
    private String parent_id;
    private String url;
    private int seq;

    public String getMenu_id() {
        return menu_id;
    }

    public void setMenu_id(String menu_id) {
        this.menu_id = menu_id;
    }

    public String getMenu_name() {
        return menu_name;
    }

    public void setMenu_name(String menu_name) {
        this.menu_name = menu_name;
    }

    public String getParent_id() {
        return parent_id;
    }

    public void setParent_id(String parent_id) {
        this.parent_id = parent_id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "menu_id='" + menu_id + '\'' +
                ", menu_name='" + menu_name + '\'' +
                ", parent_id='" + parent_id + '\'' +
                ", url='" + url + '\'' +
                ", seq=" + seq +
                '}';
    }
}
