package com.noname.qh.controller;

import net.sf.json.JSONArray;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.noname.qh.service.MenuService;

import javax.annotation.Resource;

/**
 * Created by noname on 2017/4/19.
 */
@Controller
@RequestMapping("/menu")
public class MenuController {
    @Resource(name="MenuService")
    private MenuService menuService;

    @ResponseBody
    @RequestMapping("listmenus")
    public JSONArray listMenus(@Param("parend_id") String parent_id){
       return menuService.getMenusList(parent_id);
    }


    @ResponseBody
    @RequestMapping("getUrlData")
    public String getUrlData(@Param("menu_id") String menu_id){
       return menuService.getUrlData(menu_id);
    }
}
