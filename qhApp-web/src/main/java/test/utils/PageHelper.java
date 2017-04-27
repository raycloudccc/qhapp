package test.utils;

import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by noname on 2017/4/27.
 */
@Component("PageHelper")
public class PageHelper {
    public void autoPage(String pageNo, String pageSize, Map map){
        int pagesize = parseIntValue(pageSize, -1);
        if (pagesize <= 0) {
            pagesize = 10;
        }
        int pagestart = parseIntValue(pageNo, -1);
        if (pagestart > 1) {
            pagestart = (pagestart - 1) * pagesize+1;
            map.put("start", pagestart);
            map.put("end", pagesize*pagesize);
        } else {
            pagestart = 0;
            map.put("start", pagestart);
            map.put("end", pagesize);
        }

    }

    public static int parseIntValue(String value, int defaultValue) {
        if (value == null || value.trim().length() == 0) {
            return defaultValue;
        }
        int result = defaultValue;
        try {
            result = Long.valueOf(value.trim()).intValue();
        } catch (NumberFormatException e) {
            result = defaultValue;
        }
        return result;
    }
}
