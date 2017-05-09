package com.noname.qh.utils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Component;
import java.sql.Date;

/**
 * Created by noname on 2017/4/24.
 */
@Component("DataGridUtils")
public class DataGridUtils {
    public JSONObject parseJSON(int total,Object obj){
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONObject object=new JSONObject();
        JSONArray arr=new JSONArray();
        JSONArray array=arr.fromObject(obj,jsonConfig);
        object.put("total",total);
        object.put("rows",array);
        return object;
    }

}
