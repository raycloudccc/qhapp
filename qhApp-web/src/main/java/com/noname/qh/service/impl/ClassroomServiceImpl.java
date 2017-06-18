package com.noname.qh.service.impl;

import com.noname.qh.dao.ClassroomDao;
import com.noname.qh.entity.Classroom;
import com.noname.qh.service.ClassroomService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/6/6.
 */
@Service("ClassroomService")
public class ClassroomServiceImpl implements ClassroomService {

    @Resource(name = "ClassroomDao")
    private ClassroomDao classroomDao;
    @Resource(name = "PageHelper")
    private PageHelper pageHelper;
    @Resource(name = "DataGridUtils")
    private DataGridUtils dataGridUtils;

    @Override
    public JSONObject listClassroom(String pageNo, String pageSize, Map map) {
        pageHelper.autoPage(pageNo, pageSize, map);
        List<Classroom> classList = classroomDao.listClassroom(map);
        int count = classroomDao.CountClassroom();
        return dataGridUtils.parseJSON(count, classList);
    }

    @Override
    public String saveClass(Classroom classroom) {
        String result = "false";
        int isexist = classroomDao.isExist(classroom.getClassName());
        if (isexist >= 1) {
            result = "exist";
        } else {
            int count = classroomDao.saveClass(classroom);
            if (count >= 1) {
                return "true";
            }
        }
        return result;
    }

    @Override
    public String deleteClass(String ids) {
        String result="false";
        String[] idArr=ids.split("-");
        for(String id:idArr){
            classroomDao.deleteClass(Long.valueOf(id));
        }
        result="true";
        return result;
    }
}
