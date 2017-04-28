package com.noname.qh.service;

import net.sf.json.JSONArray;

/**
 * Created by noname on 2017/4/19.
 */
public interface MenuService {
    public JSONArray getMenusList(String parent_id);

    public String getUrlData(String menu_id);
}
