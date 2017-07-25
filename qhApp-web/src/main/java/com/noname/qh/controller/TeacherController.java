package com.noname.qh.controller;

import com.noname.qh.entity.Classroom;
import com.noname.qh.entity.TeacherSchedule;
import com.noname.qh.utils.JsonDateValueProcessor;
import com.sun.net.httpserver.HttpContext;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
    public JSONObject getTeacherList(@RequestParam(required = false,value="limit") String limit, @RequestParam(required = false,value="offset") String offset,@RequestParam(required = false,value="searchText") String search) {
        System.out.println("search:"+search);
        return teacherService.listTeacher(limit, offset,1,search);
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
        System.out.println("值："+teacher);
        model.put("allsub", allSub);
        return "updateteacher";
    }

    @RequestMapping("updateTeacher")
    @Transactional
    @ResponseBody
    public boolean updateTeacher(Teacher teacher,@RequestParam("subids") String subids) {
        if(teacher.getGender()==null){
            teacher.setGender(2);
        }
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
        if(teacher.getGender()==null){
            teacher.setGender(2);
        }
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

    @RequestMapping("exportData")
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void exportData(HttpServletResponse response){
        teacherService.exportData(response);
    }


    @RequestMapping("checkTeacherSchedule")
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public String toCheckSchedule(@RequestParam("teacherId") Long teacherId,ModelMap modelMap){
        List<List<TeacherSchedule>> scheduleList=teacherService.getTeacherSchedule(teacherId);
        modelMap.put("scheduleList",scheduleList);
        modelMap.put("teacherId",teacherId);
        return "teacherschedule";
    }

    @RequestMapping("toAddSchedule")
    public String addSchedule(@RequestParam("teacherId") Long teacherId,@RequestParam("week") String week){
        return "addSchedule";
    }

    @RequestMapping("techerSelectSubJSON")
    @ResponseBody
    public JSONArray techerSelectSubJSON(@RequestParam("teacherId") Long teacherId){
        Map<String,Object> sqlMap=new HashMap<String,Object>();
        sqlMap.put("teacherId",teacherId);
        sqlMap.put("flag",0);
        return teacherService.getTeacherSelectSubJSON(sqlMap);
    }

    @RequestMapping("addTeacherSchedule")
    public String addTeacherSchedule(@RequestParam(required = false,value="teacherId") Long teacherId,@RequestParam(required=false,value="week") int week,ModelMap modelMap){
        List<Subject> subList=teacherService.teacherSub(teacherId);
        List<Classroom> classList=teacherService.classList();
        modelMap.put("subList",subList);
        modelMap.put("classList",classList);
        return "addteacherschedule";
    }

    @RequestMapping("affirmAddSchedule")
    @ResponseBody
    public String affirmAddSchedule(@RequestParam("stime") String stime,@RequestParam("etime") String etime,@RequestParam("week") int week,@RequestParam("subjectId") long subjectId,
                                    @RequestParam("classId") long classId,@RequestParam("studentId") long studentId,@RequestParam("teacherId") long teacherId){
        SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
        Time start=null;
        Time end=null;
        try {
            Date sdate=sdf.parse(stime);
            start=new Time(sdate.getTime());
            Date edate=sdf.parse(etime);
            end=new Time(edate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        TeacherSchedule schedule=new TeacherSchedule();
        schedule.setWeek(week);
        schedule.setClassId(classId);
        schedule.setStudentId(studentId);
        schedule.setTeacherId(teacherId);
        schedule.setCreateTime(new Timestamp(System.currentTimeMillis()));
        schedule.setSubjectId(subjectId);
        schedule.setStime(start);
        schedule.setEtime(end);
        return teacherService.insertSchedule(schedule);
    }

    @RequestMapping("teacherScheduleJsonArray")
    @ResponseBody
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public JSONArray teacherScheduleJsonArray(@RequestParam("teacherId") long teacherId){
        List<List<TeacherSchedule>> scheduleList=teacherService.getTeacherSchedule(teacherId);
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Time.class,new JsonDateValueProcessor());
        config.registerJsonValueProcessor(Timestamp.class,new JsonDateValueProcessor());
        for(int x=0;x<scheduleList.size();x++){
            List<TeacherSchedule> row= scheduleList.get(x);
            for(int y=0;y<row.size();y++){
                if(row.get(y)==null){
                    row.remove(y);
                    row.add(y,new TeacherSchedule());
                }
            }
        }

        JSONArray arr=new JSONArray();
        JSONArray listJsonArray=arr.fromObject(scheduleList,config);
        return listJsonArray;
    }


    @RequestMapping("removeSchedule")
    @ResponseBody
    public boolean removeSchedule(@RequestParam("id") long id){
        return teacherService.removeSchedule(id);
    }
}
