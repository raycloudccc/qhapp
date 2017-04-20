package test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import test.entity.Menu;
import test.service.MenuService;

import javax.annotation.Resource;
import java.util.List;

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
    public List<Menu> listMenus(){
        System.out.println("service:"+menuService);
        System.out.println("aaaaaaaaaaa:"+menuService.getMenusList());
       return menuService.getMenusList();
    }

}
