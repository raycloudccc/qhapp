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
    <title>教师列表</title>
    <jsp:include page="header.jsp"></jsp:include>
    <style>

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
            $('#teacherTable').bootstrapTable({
                url: 'getTeacherList',
                cache: false,
                height: $('#father').height() - 30,
                striped: true,
                pagination: true,
                sidePagination: "server",
                pageNumber: 1,
                pageSize: 50,
                pageList: [10, 25, 50, 100],
                dataType: 'json',
                showToggle: true,
                showRefresh: true,
                queryParams: queryParams,
                toolbar: $('#tool'),
                columns: [{
                    field: 'id',
                    checkbox: true,
                    title: '#'
                },
                    {
                        field: 'name',
                        title: '教师',
                        formatter:function(value,row,index){
                            var but="<a href='#' onclick='updateTeacher("+row.teacherId+")'>"+row.name+"</a>";
                            return but;
                        }
                    },
                    {
                        field: 'subName',
                        title: '学科'
                    },
                    {
                        field: 'age',
                        title: '年龄',
                        formatter: function (value) {
                            if ('0' == value) {
                                return '';
                            } else {
                                return value;
                            }
                        }
                    },
                    {
                        field: 'gender',
                        title: '性别',
                        formatter: function (value) {
                            if ('1' == value) {
                                return '男'
                            } else{
                                return '女'
                            }
                        }
                    },
                    {
                        field: 'tele',
                        title: '手机'
                    },
                    {
                        field: 'email',
                        title: '邮箱'
                    }, {
                        field: 'wxh',
                        title: '微信'
                    }, {
                        field: 'address',
                        title: '住址'
                    }, {
                        field: 'memo',
                        title: '备注'
                    }],
                onLoadSuccess:function(data){
                    var rows=data.rows;
                    $(rows).each(function(index,value){
                        $('#teacherTable tbody tr:eq('+index+')').mousedown(function(e){
                            if (e.button == 2) {
                                //右键弹出菜单
                                $.contextMenu({
                                    selector: '#teacherTable tbody tr:eq('+index+')',
                                    items: {
                                        foo: {name: "课表信息", callback: function(key, opt){showScheduleInfo(value.teacherId)}}
                                    }
                                });
                            }
                        })
                    })
                }
            });
        });


        function showScheduleInfo(teacherId){
            top.openWithWin('teacher/checkTeacherSchedule?teacherId='+teacherId,900,900);
        }

        $(document).bind("contextmenu",function(e){
            return false;

        });


        function addTeacher() {
            top.openWithWin("teacher/toAddTeacher", 400);
        }


        function reload() {
            var opt = {
                url: "getTeacherList",
                silent: true
            };
            $("#teacherTable").bootstrapTable('refresh', opt);
        }

        function reload(param) {
            var opt = {
                url: "getTeacherList",
                silent: true,
                searchText: param
            };
            $("#teacherTable").bootstrapTable('refresh', opt);
        }

        function deleteTeacher() {
            var arrs=new Array();
            var selecteds = $('#teacherTable').bootstrapTable('getSelections');
            $(selecteds).each(function(index,value){
                arrs.push(value.teacherId);
            })
            var rowids=arrs.join("-");
            $.ajax({
                url: 'deleteTeacher',
                type: 'post',
                dataType: 'json',
                data: {
                    arrs: rowids
                },
                success: function (result) {
                    if (result == true) {
                        reload();
                    } else {
                        showtip('删除失败');
                    }
                }
            })

        }

        $(function () {
            $('.c').keydown(function (data) {
                if (data.keyCode == 13) {
                    reload($(this).val());
                }
            });
        });

        function queryParams(pageReqeust) {
            pageReqeust.searchText = $(".c").val();
            return pageReqeust;
        }

        function exportTeacher(){
            location.href="exportData";
        }

        function updateTeacher(teacherId){
            top.openWithWin('teacher/toUpdateTeacher?teacher_id='+teacherId,400);
        }
    </script>
</head>
<body>
<div style="height:100% " id="father">
    <table id="teacherTable"></table>
    <div id="tool">
        <button type="button" class="btn btn-success" onclick="addTeacher()">添加教师</button>
        <button type="button" class="btn btn-danger" onclick="deleteTeacher()">删除教师</button>
        <button type="button" class="btn btn-info" onclick="exportTeacher()">导出教师列表</button>
        <input class="c" name="search">
    </div>
</div>

</body>
</html>
