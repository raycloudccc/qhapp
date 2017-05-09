package com.noname.qh.utils;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;

/**
 * Created by noname on 2017/5/8.
 */
public class JsonDateValueProcessor implements JsonValueProcessor {
    @Override
    public Object processArrayValue(Object o, JsonConfig jsonConfig) {
        return process(o);
    }

    @Override
    public Object processObjectValue(String s, Object o, JsonConfig jsonConfig) {
        return process(o);
    }

    private Object process(Object value) {
        if (value instanceof Date) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.UK);
            return sdf.format(value);
        } else if (value instanceof java.sql.Timestamp || value instanceof java.util.Date) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.UK);
            return sdf.format(value);
        }
        return value == null ? "" : value.toString();
    }
}
