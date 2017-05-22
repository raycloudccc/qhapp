<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/4/25
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <jsp:include page="header.jsp"></jsp:include>
    <script type="text/javascript">
        $(function () {
            $('#tt').edatagrid({
                title: '学科列表',
                fit: true,
                striped: true,
                rownumbers: true,
                singleSelect: false,
                pagination: true,
                pageSize:50,
                url: 'getSubjectList',
                toolbar:$('#tool'),
                queryParams: {
                    name: '',
                    value: ''
                },
                columns: [[
                    {field: 'action', title: '', width: 100, checkbox: true},
                    {field: 'subName', title: '学科', width: 100}
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
            parent.openWithWin('添加学科', 'subject/toAddSubject', '', 250, 150);
        }

        function dele() {
            var arr = [];
            var rows = $('#tt').datagrid('getSelections');
            $(rows).each(function () {
                arr.push(this.subId);
            });
            var arrs = arr.join("&");
            $.ajax({
                url: 'deleteSubject',
                type: 'POST',
                dataType: 'json',
                data: {
                    arrs: arrs
                },

                success: function (result) {
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

        //教师查询，通过指定字段查询，name:字段名称，value：用户输入值
        function qq(value, name) {
            $('#tt').datagrid('load', {
                'name': name,
                'value': value
            });
        }

    </script>
</head>
<body>
<div id="tool">
    <a href="#" class="easyui-linkbutton" onclick="add()">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="dele()">删除</a>
</div>
<table id="tt"></table>
</body>
</html>
