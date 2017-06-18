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
    <style>
        html,body,#father{
            width:100%;
            height:100%
        }

        .c {
            height: 34px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            //绑定搜索框回车事件
            $('.c').on('keydown',function(event){
                if(event.keyCode==13){
                    reload();
                }
            })


            //数据表格加载
            $('#studentTable').bootstrapTable({
                height: $('#father').height() - 30,
                url: 'getStudentList',
                toolbar: '#tool',
                cache: false,
                pagination: true,
                sidePagination: "server",
                pageSize: 50,
                showToggle: true,
                showRefresh: true,
                queryParams: function (queryParams) {
                    queryParams.search = $('.c').val();
                    return queryParams;
                },
                columns: [
                    {
                        field: 'id',
                        title: '#',
                        checkbox: true
                    },
                    {
                        field: 'name',
                        title: '姓名'
                    }, {
                        field: 'age',
                        title: '年龄'
                    },
                    {
                        field: 'gender',
                        title: '性别'
                    },
                    {
                        field: 'tele',
                        title: '联系方式'
                    },
                    {
                        field: 'wxh',
                        title: '微信号'
                    },
                    {
                        field: 'address',
                        title: '联系住址'
                    },
                    {
                        field: 'memo',
                        title: '备注'
                    },
                    {
                        field: 'enroldate',
                        title: '入学日期'
                    }
                ],
                onCheckAll:function(){
                    alert('全选')
                }
            })
        });


        function reload(){
            $('#studentTable').bootstrapTable('refresh',{
                silent:true,
                url:'getStudentList'
            })
        }


        function addStudent(){
            top.openWithWin('student/toAddStudent',400)
        }
    </script>
</head>
<body>
<div id="father">
    <table id="studentTable"></table>
    <div id="tool">
        <button type="button" class="btn btn-success" onclick="addStudent()">添加学生</button>
        <button type="button" class="btn btn-danger">删除学生</button>
        <button type="button" class="btn btn-info">导出学生信息</button>
        <input type="text" class="c" >
    </div>
</div>
</body>
</html>
