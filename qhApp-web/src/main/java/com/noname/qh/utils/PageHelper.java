package com.noname.qh.utils;

import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by noname on 2017/4/27.
 */
@Component("PageHelper")
public class PageHelper {
    /**
     * 自动分页
     * @param limit 每页的条数
     * @param offset  偏移量
     * @param map  需要添加前两个数据的map
     */
    public void autoPage(String limit, String offset, Map map){
        int pagesize = parseIntValue(offset, -1);
        int pagestart = parseIntValue(limit, -1);
            map.put("start", pagesize);
            map.put("end", pagestart);
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
