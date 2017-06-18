<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/6/7
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="header.jsp"></jsp:include>
    <script>
        $(function () {
            $('#tt').edatagrid({
                title: '教室列表',
                fit: true,
                striped: true,
                rownumbers: true,
                singleSelect: false,
                pagination: true,
                pageSize: 50,
                url: 'getClassList',
                toolbar: $('#tool'),
                queryParams: {
                    name: '',
                    value: ''
                },
                columns: [[
                    {field: 'action', title: '', width: 100, checkbox: true},
                    {field: 'className', title: '教室', width: 80}
                ]]
            });
        });


        function addClass() {
           top.openWithWin("新建教室","classroom/addClass","",300,300);
        }

        function deleteClass() {
            var arr=[];
            var rows=$('#tt').datagrid('getSelections');
            $(rows).each(function(index,value){
                arr.push(value.classId);
            })
            $.ajax({
                url:'deleteClass',
                data:{
                    ids:arr.join("-")
                },
                dataType:'text',
                type:'post',
                success:function(result){
                    if(result=="true"){
                        reload();
                        $.messager.show({
                            title:'操作提示',
                            msg:'删除成功',
                            timeout:2000,
                            showType:'slide'
                        });

                    }else{
                        $.messager.alert('操作提示','删除失败','');
                    }
                }
            });
        }

        function reload(){
            $('#tt').edatagrid('reload');
        }
    </script>


</head>
<body>
<table id="tt"></table>
<div id="tool">
    <a href="#" class="easyui-linkbutton" onclick="addClass()">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="deleteClass()">删除</a>
</div>
</body>
</html>
