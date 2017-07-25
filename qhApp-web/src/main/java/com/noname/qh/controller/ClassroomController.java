package com.noname.qh.controller;

import com.noname.qh.entity.Classroom;
import com.noname.qh.service.ClassroomService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by noname on 2017/6/6.
 */
@Controller
@RequestMapping("classroom")
public class ClassroomController {

    @Resource(name="ClassroomService")
    private ClassroomService classroomService;


    @RequestMapping("tolistclass")
    public String tolistclass(){
        return "listclassroom";
    }

    @RequestMapping("getClassList")
    @ResponseBody
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public JSONObject getClassList(@RequestParam("limit") String limit, @RequestParam("offset") String offset){
        Map<String,Object> map=new HashMap();
        return classroomService.listClassroom(limit,offset,map);
    }

    @RequestMapping("addClass")
    public String toAddClass(){
        return "addclass";
    }

    @RequestMapping("saveClass")
    @ResponseBody
    public String saveClass(Classroom classroom){
        return classroomService.saveClass(classroom);
    }

    @RequestMapping("deleteClass")
    @ResponseBody
    public String deleteClass(@RequestParam ("ids") String ids){
        return classroomService.deleteClass(ids);
    }

}
