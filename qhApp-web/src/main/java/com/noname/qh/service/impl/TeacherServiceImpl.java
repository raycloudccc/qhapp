package com.noname.qh.service.impl;

import com.noname.qh.entity.SubjectRelation;
import com.noname.qh.entity.TeacherSchedule;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.HashedMap;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import com.noname.qh.dao.TeacherDao;
import com.noname.qh.entity.Subject;
import com.noname.qh.entity.Teacher;
import com.noname.qh.service.TeacherService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/4/24.
 */
@Service("TeacherService")
public class TeacherServiceImpl implements TeacherService {

    @Resource(name = "TeacherDao")
    private TeacherDao teacherDao;
    @Resource(name = "DataGridUtils")
    private DataGridUtils dataGridUtils;
    @Resource(name = "PageHelper")
    private PageHelper pageHelper;

    @Override
    public boolean insertTeacher(Teacher teacher, String subids) {
        teacher.setStatus(1);
        teacher.setCreatetime(new Timestamp(System.currentTimeMillis()));
        boolean result = false;
        int count = teacherDao.insertTeacher(teacher);
        if (count > 0) {
            String[] subarr = subids.split("-");
            insertTeacherRelation(subarr, teacher);
            result = true;
        }
        return result;
    }

    @Override
    public boolean deleteTeacher(String arr) {
        boolean result = false;
        String[] teacher_ids = arr.split("-");
        Map<String, Object> map = new HashedMap();
        map.put("status", 0);
        for (String id : teacher_ids) {
            map.put("teacherid", id);
            teacherDao.deleteTeacher(map);
        }
        result = true;
        return result;
    }

    @Override
    public boolean updateTeacher(Teacher teacher, String subids) {
        boolean result = false;
        int count = teacherDao.updateTeacher(teacher);
        Map<String, Object> map = new HashMap<>();
        map.put("teacherId", teacher.getTeacherId());
        map.put("subFlag", 0);
        teacherDao.deleteSubjectRelation(map);
        String[] subidArr = subids.split("-");
        insertTeacherRelation(subidArr, teacher);
        result = true;
        return result;
    }

    @Override
    public Teacher selectTeacherById(Long teacherId) {
        Teacher teacher = teacherDao.selectTeacherById(teacherId);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("teacherid", teacher.getTeacherId());
        map.put("flag", 0);
        return teacher;
    }

    @Override
    public JSONObject listTeacher(String pageNo, String pageSize, int status,String search) {
        Map<String, Object> map = new HashMap<>();
        map.put("status", status);
        map.put("search","%"+search+"%");
        pageHelper.autoPage(pageNo, pageSize, map);
        int total=teacherDao.countTeacher(map);
        List<Teacher> teacherList = teacherDao.listTeacher(map);
        relevancySub(teacherList);
        return dataGridUtils.parseJSON(total,teacherList);
    }

    @Override
    public List<Subject> allSub() {
        return teacherDao.allSub();
    }


    @Override
    public JSONArray teacherSelectedSub(Long teacherId) {
        /**
         * 获取老师已关联学科，在总学科的json中，如果已经关联则增加selected属性，easyui会自动根据json勾选
         * 未有关联学科则直接返回总学科的json
         */
        JSONArray arr = new JSONArray();
        List<Subject> subs = teacherDao.allSub();
        JSONArray arrays = arr.fromObject(subs);
        Map<String, Object> map = new HashedMap();
        map.put("teacherid", teacherId);
        map.put("flag", 0);
        List<SubjectRelation> relation = teacherDao.getSubInfo(map);
        if (relation.isEmpty()) {
            return arrays;
        }
        JSONArray newArr = new JSONArray();
        for (int x = 0; x < arrays.size(); x++) {
            JSONObject obj = new JSONObject().fromObject(arrays.get(x));
            for (int y = 0; y < relation.size(); y++) {
                long objid = obj.getLong("subId");
                if (objid == relation.get(y).getSubId()) {
                    obj.put("selected", true);
                }
            }
            newArr.add(obj);
        }
        return newArr;
    }

    @Override
    public void exportData(HttpServletResponse response) {
        OutputStream out = null;
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet();
        sheet.autoSizeColumn(0);
        Row titles = sheet.createRow(0);
        CellStyle style = workbook.createCellStyle();
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);

        createCellAndStyle(titles, 0, "序号", style);
        createCellAndStyle(titles, 1, "姓名", style);
        createCellAndStyle(titles, 2, "年龄", style);
        createCellAndStyle(titles, 3, "性别", style);
        createCellAndStyle(titles, 4, "手机", style);
        createCellAndStyle(titles, 5, "邮箱", style);
        createCellAndStyle(titles, 6, "微信", style);
        createCellAndStyle(titles, 7, "联系地址", style);
        createCellAndStyle(titles, 8, "学科", style);
        createCellAndStyle(titles, 9, "备注", style);

        List<Teacher> teacherList = teacherDao.listAllValidTeachers(1);
        relevancySub(teacherList);
        for (int x = 0; x < teacherList.size(); x++) {
            Teacher teacher = teacherList.get(x);
            Row row = sheet.createRow(x + 1);
            createCellAndStyle(row, 0, String.valueOf(x + 1), style);
            createCellAndStyle(row, 1, teacher.getName(), style);
            createCellAndStyle(row, 2, teacher.getAge() == null ? "" : String.valueOf(teacher.getAge()), style);
            createCellAndStyle(row, 3, 1 == teacher.getGender() ? "男" : "女", style);
            createCellAndStyle(row, 4, teacher.getTele(), style);
            createCellAndStyle(row, 5, teacher.getEmail(), style);
            createCellAndStyle(row, 6, teacher.getWxh(), style);
            createCellAndStyle(row, 7, teacher.getAddress(), style);
            createCellAndStyle(row, 8, teacher.getSubName(), style);
            createCellAndStyle(row, 9, teacher.getMemo(), style);
        }
        try {
            out = response.getOutputStream();
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename="
                    + URLEncoder.encode("教师列表.xlsx", "UTF-8"));
            workbook.write(out);
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public List<List<TeacherSchedule>> getTeacherSchedule(Long teacherId) {
        int[] weeks = {1, 2, 3, 4, 5, 6, 7};
        List<List<TeacherSchedule>> scheduleData = new ArrayList<>();
        int max = teacherDao.getMaxCount();
        Map<String, Object> sqlMap = new HashedMap();
        sqlMap.put("teacherId", teacherId);
        for (int x : weeks) {
            sqlMap.put("week", x);
            List<TeacherSchedule> schedule = teacherDao.getSingleDayTeacherSchedule(sqlMap);
            if (schedule.size() < max) {
                //循环添加会改变原数组的长度，新建一个临时存放null值的集合,存放完毕之后在清空
                List<TeacherSchedule> temporary = new ArrayList<>();
                for (int z = 0; z < max - schedule.size(); z++) {
                    temporary.add(null);
                }
                schedule.addAll(temporary);
                temporary.clear();
            }
            scheduleData.add(schedule);
        }

        List<List<TeacherSchedule>> rows = new ArrayList();
        for (int x = 0; x < max; x++) {
            List<TeacherSchedule> row = new ArrayList<>();
            for (int y = 0; y < scheduleData.size(); y++) {
                List<TeacherSchedule> col = scheduleData.get(y);
                for (int z = 0; z < col.size(); z++) {
                    if (z == x) {
                        row.add(col.get(z));
                    }
                }
            }
            rows.add(row);
        }
        return rows;
    }

    @Override
    public JSONArray getTeacherSelectSubJSON(Map map) {
        List<Subject> list = (List<Subject>) teacherDao.getSubInfoByTeacherId(map);
        JSONArray arr = new JSONArray();
        for (Subject sub : list) {
            JSONObject obj = new JSONObject();
            obj.put("id", sub.getSubId());
            obj.put("text", sub.getSubName());
            arr.add(obj);
        }
        return arr;
    }

    /**
     * 获取每个老师的关联学科，同时写入每个对象的
     *
     * @param teacherList 老师集合
     */
    private void relevancySub(List<Teacher> teacherList) {
        for (Teacher tea : teacherList) {
            Map<String, Object> map2 = new HashMap<>();
            map2.put("teacherid", tea.getTeacherId());
            map2.put("flag", 0);
            List<SubjectRelation> rela = teacherDao.getSubInfo(map2);
            StringBuffer subName = new StringBuffer("");
            if (rela.size() < 1) {
                tea.setSubName(String.valueOf(subName));
            } else if (rela.size() == 1) {
                tea.setSubName(rela.get(0).getSubName());
            } else {
                for (int x = 0; x < rela.size(); x++) {
                    subName.append(rela.get(x).getSubName());
                    if (x != rela.size() - 1) {
                        subName.append(",");
                    }
                }
                tea.setSubName(String.valueOf(subName));
            }
        }
    }

    private void insertTeacherRelation(String[] subarr, Teacher teacher) {
        for (String subid : subarr) {
            SubjectRelation relation = new SubjectRelation();
            relation.setObjId(teacher.getTeacherId());
            relation.setSubId(Long.valueOf(subid));
            relation.setSubFlag(0);
            relation.setCreatetime(new Timestamp(System.currentTimeMillis()));
            teacherDao.insertSubjectRelation(relation);
        }
    }

    private void createCellAndStyle(Row row, int col, String value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }
}
