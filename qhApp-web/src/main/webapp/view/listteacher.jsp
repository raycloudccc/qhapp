<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/4/25
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>教师列表</title>
    <jsp:include page="header.jsp"></jsp:include>
    <script type="text/javascript">
        $(function () {
            $('#tt').edatagrid({
                title:'教师列表',
                fit:true,
                striped:true,
                rownumbers:true,
                singleSelect:true,
                url: 'getTeacherList',
                columns: [[
                    {field: 'name', title: '姓名', width: 100},
                    {field: 'age', title: '年龄', width: 100},
                    {field: 'gender', title: '性别', width: 100,
                        formatter: function(value,row,index){
                            if (value=='1'){
                                return '男';
                            } else {
                                return '女';
                            }
                        }
                    },
                    {field: 'tele', title: '手机', width: 100},
                    {field: 'email', title: '邮箱', width: 100},
                    {field: 'wxh', title: '微信', width: 100},
                    {field: 'address', title: '联系地址', width: 100},
                    {field: 'sub_name', title: '学科', width: 100},
                    {field: 'memo', title: '备注', width: 100}
                ]]
            });

        });


    </script>
</head>
<body>
<table id="tt"></table>

</body>
</html>
