package test.utils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;

/**
 * Created by noname on 2017/4/24.
 */
@Component("DataGridUtils")
public class DataGridUtils {
    public JSONObject parseJSON(int total,Object obj){
        JSONObject object=new JSONObject();
        JSONArray arr=new JSONArray();
        JSONArray array=arr.fromObject(obj);
        object.put("total",total);
        object.put("rows",array);
        return object;
    }

}
