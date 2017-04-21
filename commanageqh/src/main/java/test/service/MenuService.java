package test.service;

import net.sf.json.JSONArray;
import test.entity.Menu;

import java.util.List;

/**
 * Created by noname on 2017/4/19.
 */
public interface MenuService {
    public JSONArray getMenusList(String parent_id);
}
