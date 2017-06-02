package com.noname.qh.service.impl;

import com.noname.qh.dao.StudentDao;
import com.noname.qh.entity.Student;
import com.noname.qh.service.StudentService;
import com.noname.qh.utils.DataGridUtils;
import com.noname.qh.utils.PageHelper;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.HashedMap;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

/**
 * Created by noname on 2017/5/2.
 */
@Service("StudentService")
public class StudentServiceImpl implements StudentService{

    @Resource(name="StudentDao")
    private StudentDao studentDao;
    @Resource(name="DataGridUtils")
    private DataGridUtils dataGridUtils;
    @Resource(name="PageHelper")
    private PageHelper pageHelper;

    @Override
    public JSONObject getStudentList(Map map) {
        List<Student> studentList=studentDao.getStudentList(map);
        int total=studentDao.countStudent((int)(map.get("status")));
        return dataGridUtils.parseJSON(total,studentList);
    }

    @Override
    public Student getStudentInfo(String studentId) {
        return studentDao.getStudentInfo(studentId);
    }

    @Override
    public boolean updateStudent(Student student) {
        boolean result=false;
        int count= studentDao.updateStudent(student);
        if (count >= 1) {
            result=true;
        }
        return result;
    }

    @Override
    public boolean addStudent(Student student) {
        boolean result=false;
        student.setStatus(1);
        student.setCreatetime(new Timestamp(System.currentTimeMillis()));
        int count=studentDao.addStudent(student);
        if(count>=1){
            result=true;
        }
        return result;
    }

    @Override
    public boolean deleteStudent(String arr) {
        boolean result=false;
        String ids[] =arr.split("&");
        Map<String,Object> map=new HashedMap();
        map.put("status",0);
        for(String id:ids){
            map.put("stuid",id);
            studentDao.deleteStudent(map);
        }
        result=true;
        return result;
    }

    @Override
    public void exportStudentData(HttpServletResponse response) {
        OutputStream out=null;
        List<Student> studentList=studentDao.getAllValidStudents(1);
        XSSFWorkbook workbook=new XSSFWorkbook();
        XSSFSheet sheet=workbook.createSheet();
        CellStyle style=workbook.createCellStyle();
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);

        Row title=sheet.createRow(0);
        createCellAndStyle(title,0,"序号",style);
        createCellAndStyle(title,1,"姓名",style);
        createCellAndStyle(title,2,"年龄",style);
        createCellAndStyle(title,3,"性别",style);
        createCellAndStyle(title,4,"手机",style);
        createCellAndStyle(title,5,"微信",style);
        createCellAndStyle(title,6,"住址",style);
        createCellAndStyle(title,7,"备注",style);
        createCellAndStyle(title,8,"入学时间",style);

        for(int x=0;x<studentList.size();x++){
            Student student=studentList.get(x);
            Row row=sheet.createRow(x+1);
            createCellAndStyle(row,0,String.valueOf(x+1),style);
            createCellAndStyle(row,1,student.getName(),style);
            createCellAndStyle(row,2,student.getAge()==null?"":String.valueOf(student.getAge()),style);
            createCellAndStyle(row,3,student.getGender()==1?"男":"女",style);
            createCellAndStyle(row,4,student.getTele(),style);
            createCellAndStyle(row,5,student.getWxh(),style);
            createCellAndStyle(row,6,student.getAddress(),style);
            createCellAndStyle(row,7,student.getMemo(),style);
            createCellAndStyle(row,8,new SimpleDateFormat("yyyy-MM-dd").format(student.getEnroldate()),style);
        }

        try {
            out=response.getOutputStream();
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename="
                    + URLEncoder.encode("学生列表.xlsx", "UTF-8"));
            workbook.write(out);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            if(out!=null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }


    private void createCellAndStyle(Row row, int col, String value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }


}
