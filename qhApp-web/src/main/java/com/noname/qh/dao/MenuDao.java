package com.noname.qh.dao;

import org.springframework.stereotype.Repository;
import com.noname.qh.entity.Menu;

import java.util.List;

/**
 * Created by noname on 2017/4/19.
 */
@Repository("MenuDao")
public interface MenuDao {
    public List<Menu> listMenus(String parent_id);

    public String getUrlData(String menu_id);
}
