package com.noname.qh.controller;

import com.noname.qh.entity.Subject;
import com.noname.qh.service.SubjectService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.xml.crypto.Data;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/9.
 */
@Controller
@RequestMapping("subject")
public class SubjectController {

    @Resource(name = "SubjectService")
    private SubjectService subjectService;
    @Resource(name = "PageHelper")
    private PageHelper pageHelper;
    @Resource(name = "DataGridUtils")
    private DataGridUtils dataGridUtils;

    @RequestMapping("tolistsubject")
    public String toListSubject() {
        return "listsubject";
    }


    @RequestMapping("getSubjectList")
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    @ResponseBody
    public JSONObject getSubjectList(@RequestParam("limit") String limit, @RequestParam("offset") String offset) {
        Map<String, String> map = new HashMap<String, String>();
        pageHelper.autoPage(limit, offset, map);
        List<Subject> subs = subjectService.getSubjectList(map);
        int count = subjectService.getCountSubject();
        return dataGridUtils.parseJSON(count, subs);
    }

    @RequestMapping("toAddSubject")
    public String toAddSubject() {
        return "addsubject";
    }

    @RequestMapping("addSubject")
    @Transactional
    @ResponseBody
    public String addSubject(Subject subject) {
        return subjectService.addSubject(subject);
    }

    @RequestMapping("deleteSubject")
    @Transactional
    @ResponseBody
    public boolean deleteSubject(@RequestParam("arrs") String arr) {
        return subjectService.deleteSubject(arr);
    }
}
