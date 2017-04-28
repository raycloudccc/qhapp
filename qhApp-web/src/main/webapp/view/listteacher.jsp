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
                title: '教师列表',
                fit: true,
                striped: true,
                rownumbers: true,
                singleSelect: false,
                pagination: true,
                footer: $('#fb'),
                url: 'getTeacherList',
                columns: [[
                    {field: 'action', title: '', width: 100, checkbox: true},
                    {
                        field: 'name', title: '姓名', width: 80,
                        formatter: function (value, row, index) {
                            var val = '<a href="#" onclick="edit(\'' + row.teacherId + '\')">' + value + '</a>';
                            return val;
                        }
                    },
                    {
                        field: 'age', title: '年龄', width: 50,
                        formatter: function (value, row, index) {
                            if (value == 0) {
                                return;
                            } else {
                                return value;
                            }
                        }
                    },
                    {
                        field: 'gender', title: '性别', width: 50,
                        formatter: function (value, row, index) {
                            if (value == '1') {
                                return '男';
                            } else {
                                return '女';
                            }
                        }
                    },
                    {field: 'tele', title: '手机', width: 100},
                    {field: 'email', title: '邮箱', width: 130},
                    {field: 'wxh', title: '微信', width: 120},
                    {field: 'address', title: '联系地址', width: 200},
                    {field: 'sub_name', title: '学科', width: 60},
                    {field: 'memo', title: '备注', width: 200}
                ]]
            });
        });

        function edit(teacherId) {
            var data = {
                'teacher_id': teacherId
            }
            parent.openWithWin("编辑教师", 'teacher/toUpdateTeacher', data, 250, 370);
        }


        function reload() {
            $('#tt').edatagrid('reload');
        }


        function add() {
            parent.openWithWin('添加教师', 'teacher/toAddTeacher', '', 250, 370);
        }

        function dele() {
            var arr = [];
            var rows = $('#tt').datagrid('getSelections');
            $(rows).each(function () {
                arr.push(this.teacher_id);
            });
            var arrs = arr.join("&");
            $.ajax({
                url: 'deleteTeacher',
                type: 'POST',
                dataType: 'json',
                data: {
                    arrs: arrs
                },

                success: function (result) {
                    alert(result)
                    if (result == true) {
                        reload();
                        cancel();
                        $.messager.show({
                            title: '操作提示',
                            msg: '删除成功',
                            timeout: 2000,
                            showType: 'slide'
                        });
                    } else {
                        $.messager.alert('操作提示', '修改失败', '');
                    }
                }
            });
        }

        function cancel() {
            $('#w').window('close');
        }

    </script>
</head>
<body>
<table id="tt"></table>
<div id="fb">
    <a href="#" class="easyui-linkbutton" onclick="add()">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="dele()">删除</a>
</div>
</body>
</html>
