package com.noname.qh.controller;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.noname.qh.entity.Subject;
import com.noname.qh.entity.Teacher;
import com.noname.qh.service.TeacherService;
import com.noname.qh.utils.PageHelper;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by noname on 2017/4/24.
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @Resource(name = "TeacherService")
    private TeacherService teacherService;
    @Resource(name = "PageHelper")
    private PageHelper pageHelper;


    @RequestMapping("tolistteacher")
    public String toListTeacher() {
        return "listteacher";
    }

    @RequestMapping("getTeacherList")
    @ResponseBody
    public JSONObject getTeacherList(@RequestParam("page") String pageNo, @RequestParam("rows") String pageSize, @RequestParam("name") String name, @RequestParam("value") String value) {
        return teacherService.listTeacher(pageNo, pageSize, 1, name, value);
    }

    @RequestMapping("allSub")
    @ResponseBody
    public List<Subject> allSub() {
        return teacherService.allSub();
    }

    @RequestMapping("toUpdateTeacher")
    public String toUpdateTeacher(@RequestParam("teacher_id") String teacherId, ModelMap model) {
        Teacher teacher = teacherService.selectTeacherById(Long.valueOf(teacherId));
        List<Subject> allSub = teacherService.allSub();
        model.put("teacher", teacher);
        model.put("allsub", allSub);
        return "updateteacher";
    }

    @RequestMapping("updateTeacher")
    @Transactional
    @ResponseBody
    public boolean updateTeacher(Teacher teacher,@RequestParam("subids") String subids) {
        return teacherService.updateTeacher(teacher,subids);
    }

    @RequestMapping("toAddTeacher")
    public String toAddTeacher(ModelMap model) {
        List<Subject> allSub = teacherService.allSub();
        model.put("allsub", allSub);
        return "addteacher";
    }


    @RequestMapping("getAllSub")
    @ResponseBody
    public JSONArray getAllSub() {
        List<Subject> subs = teacherService.allSub();
        JSONArray arr = new JSONArray();
        return arr.fromObject(subs);
    }

    @RequestMapping("addTeacher")
    @ResponseBody
    @Transactional
    public boolean addTeacher(@RequestParam("subids") String subids,Teacher teacher) {
        return teacherService.insertTeacher(teacher,subids);
    }

    @RequestMapping("deleteTeacher")
    @ResponseBody
    @Transactional
    public boolean deleteTeacher(@RequestParam("arrs") String arrs) {
        return teacherService.deleteTeacher(arrs);
    }


    @RequestMapping("teacherSelectedSub")
    @ResponseBody
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public JSONArray teacherSelectedSub(@RequestParam("teacherId") Long teacherId){
        return teacherService.teacherSelectedSub(teacherId);
    }
}
