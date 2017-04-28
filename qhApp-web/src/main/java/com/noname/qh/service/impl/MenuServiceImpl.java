package com.noname.qh.service.impl;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import com.noname.qh.dao.MenuDao;
import com.noname.qh.entity.Menu;
import com.noname.qh.service.MenuService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by noname on 2017/4/19.
 */


@Service("MenuService")
public class MenuServiceImpl implements MenuService{
    @Resource(name = "MenuDao")
    private MenuDao menuDao;

    @Override
    public JSONArray getMenusList(String parent_id) {
        JSONArray arr=new JSONArray();
            List<Menu> menus=menuDao.listMenus(parent_id);
            for(Menu menu:menus){
                JSONObject json=new JSONObject();
                json.put("id",menu.getMenu_id());
                json.put("text",menu.getMenu_name());
                json.put("state","closed");
                json.put("url",menu.getUrl());
                arr.add(json);
            }
        return arr;
    }

    @Override
    public String getUrlData(String menu_id) {
        String url=menuDao.getUrlData(menu_id);
        return url;
    }
}
