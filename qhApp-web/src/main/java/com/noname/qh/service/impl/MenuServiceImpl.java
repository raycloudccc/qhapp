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
        List<Menu> menus=menuDao.listMenus(String.valueOf(0));
        for(Menu menu:menus){
            arr.add(recursion(menu));
        }
        return arr;
    }

    @Override
    public String getUrlData(String menu_id) {
        String url=menuDao.getUrlData(menu_id);
        return url;
    }

    private JSONObject recursion(Menu menu) {
        JSONObject obj=new JSONObject();
        obj.put("text",menu.getMenu_name());
        obj.put("href",menu.getUrl());
        //通过这个菜单id查找是否还有子菜单,如果有
        List<Menu> list=menuDao.listMenus(menu.getMenu_id());
        if(!list.isEmpty()){
            //如果不是空，则加入node属性
            JSONArray arr=new JSONArray();
            for(Menu m:list){
                JSONObject node=recursion(m);
                arr.add(node);
                obj.put("nodes",arr);
            }
        }
        return obj;
    }

}
