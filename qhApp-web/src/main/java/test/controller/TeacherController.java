package test.controller;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import test.dao.TeacherDao;
import test.entity.Subject;
import test.entity.Teacher;
import test.service.TeacherService;
import test.utils.PageHelper;

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
    @Resource(name="PageHelper")
    private PageHelper pageHelper;


    @RequestMapping("tolistteacher")
    public String toListTeacher(){
        return "listteacher";
    }

    @RequestMapping("getTeacherList")
    @ResponseBody
    public JSONObject getTeacherList(@RequestParam("page") String pageNo,@RequestParam("rows") String pageSize){
        System.out.println("no:"+pageNo);
        System.out.println("size:"+pageSize);
        return teacherService.listTeacher(pageNo,pageSize,1);
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
        teacherService.insertTeacher(t);

    }

    @RequestMapping("allSub")
    @ResponseBody
    public List<Subject> allSub(){
        return teacherService.allSub();
    }

    @RequestMapping("toUpdateTeacher")
    public String toUpdateTeacher(@RequestParam("teacher_id") String teacher_id, ModelMap model){
        Teacher teacher=teacherService.selectTeacherById(teacher_id);
        List<Subject> allSub=teacherService.allSub();
        model.put("teacher",teacher);
        model.put("allsub",allSub);
        return "updateteacher";
    }

    @RequestMapping("updateTeacher")
    @Transactional
    @ResponseBody
    public boolean updateTeacher(Teacher  teacher){
        return teacherService.updateTeacher(teacher);
    }

    @RequestMapping("toAddTeacher")
    public String toAddTeacher(ModelMap model){
        List<Subject> allSub=teacherService.allSub();
        model.put("allsub",allSub);
        return "addteacher";
    }


    @RequestMapping("addTeacher")
    @ResponseBody
    @Transactional
    public boolean addTeacher(Teacher teacher){
        return teacherService.insertTeacher(teacher);
    }

    @RequestMapping("getAllSub")
    @ResponseBody
    public JSONArray getAllSub(){
        List<Subject> subs=teacherService.allSub();
        JSONArray arr=new JSONArray();
        return arr.fromObject(subs);
    }

    @RequestMapping("deleteTeacher")
    @ResponseBody
    @Transactional
    public boolean deleteTeacher(@RequestParam("arrs") String arrs){
        return teacherService.deleteTeacher(arrs);
    }

}
