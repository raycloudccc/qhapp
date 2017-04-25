package test.controller;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import test.dao.TeacherDao;
import test.entity.Subject;
import test.entity.Teacher;
import test.service.TeacherService;
import test.utils.DataGridUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by noname on 2017/4/24.
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @Resource(name="TeacherService")
    private TeacherService teacherService;
    @Resource(name="TeacherDao")
    private TeacherDao teacherDao;


    @RequestMapping("tolistteacher")
    public String toListTeacher(){
        return "listteacher";
    }

    @RequestMapping("getTeacherList")
    @ResponseBody
    public JSONObject getTeacherList(ModelMap model){
        return teacherService.listTeacher(1);
    }



    @RequestMapping("insertTeacher")
    @Transactional
    public void a(){
        Teacher t=new Teacher();
        t.setTeacher_id("1");
        t.setName("noname");
        t.setGender(1);
        t.setSub_id("1");
        t.setStatus(1);
        System.out.println(t);
        teacherService.insertTeacher(t);
        System.out.println("aaaa");

    }

    @RequestMapping("allSub")
    @ResponseBody
    public List<Subject> allSub(){
        return teacherService.allSub();
    }
}
