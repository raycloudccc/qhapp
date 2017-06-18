package com.noname.qh.service;

import com.noname.qh.entity.Classroom;
import net.sf.json.JSONObject;

import java.util.Map;

/**
 * Created by noname on 2017/6/6.
 */
public interface ClassroomService {
    public JSONObject listClassroom(String pageNo,String pageSize,Map map);

    public String saveClass(Classroom classroom);

    public String deleteClass(String ids);
}
