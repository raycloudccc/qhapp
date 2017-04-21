package test.dao;

import org.springframework.stereotype.Repository;
import test.entity.Menu;

import java.util.List;

/**
 * Created by noname on 2017/4/19.
 */
@Repository("MenuDao")
public interface MenuDao {
    public List<Menu> listMenus(String parent_id);
}
