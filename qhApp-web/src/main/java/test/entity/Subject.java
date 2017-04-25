package test.entity;

import java.io.Serializable;

/**
 * Created by noname on 2017/4/25.
 */
public class Subject implements Serializable{
    private String sub_id;
    private String sub_name;

    public String getSub_id() {
        return sub_id;
    }

    public void setSub_id(String sub_id) {
        this.sub_id = sub_id;
    }

    public String getSub_name() {
        return sub_name;
    }

    public void setSub_name(String sub_name) {
        this.sub_name = sub_name;
    }

    @Override
    public String toString() {
        return "Subject{" +
                "sub_id='" + sub_id + '\'' +
                ", sub_name='" + sub_name + '\'' +
                '}';
    }
}
