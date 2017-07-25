package com.noname.qh.controller;

import com.noname.qh.entity.Student;
import com.noname.qh.service.StudentService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by noname on 2017/5/2.
 */
@Controller
@RequestMapping("student")
public class StudentController {

    @Resource(name = "StudentService")
    private StudentService studentService;
    @Resource(name = "PageHelper")
    private PageHelper pageHelper;

    @RequestMapping("toliststudent")
    public String toliststudent() {
        return "liststudent";
    }

    @RequestMapping("getStudentList")
    @ResponseBody
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public JSONObject getStudentList(@RequestParam("limit") String limit, @RequestParam("offset") String offset, @RequestParam(required = false,value="search") String search) {
        Map<String, Object> map = new HashMap<>();
        map.put("status", 1);
        if(search==null){
            map.put("search","%%");
        }else{
            map.put("search","%"+search+"%");
        }

        pageHelper.autoPage(limit, offset, map);
        System.out.println("aaaaaaaa:"+studentService.getStudentList(map));
        return studentService.getStudentList(map);
    }


    @RequestMapping("toUpdateStudent")
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public String toUpdateStudent(@RequestParam("stuId") String studentId, ModelMap modelMap) {
        Student stu = studentService.getStudentInfo(studentId);
        modelMap.put("stu", stu);
        return "updatestudent";
    }

    @RequestMapping("updateStudent")
    @Transactional
    @ResponseBody
    public boolean updateStudent(Student student) {
        if(student.getGender()==null){
            student.setGender(2);
        }
        return studentService.updateStudent(student);
    }

    @RequestMapping("toAddStudent")
    public String toAddStudent(){
        return "addstudent";
    }

    @RequestMapping("addStudent")
    @Transactional
    @ResponseBody
    public boolean addStudent(Student student){
        if(student.getGender()==null){
            student.setGender(2);
        }
        return studentService.addStudent(student);
    }


    @RequestMapping("deleteStudent")
    @Transactional
    @ResponseBody
    public boolean deleteStudent(@RequestParam("arrString") String arrs){
        return studentService.deleteStudent(arrs);
    }


    @RequestMapping("exportData")
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void exportStudentData(HttpServletResponse response){
        studentService.exportStudentData(response);
    }

}
