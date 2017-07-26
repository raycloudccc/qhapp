<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/6/28
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<html style="width: 100%;height:100%">--%>
<%--<head>--%>
    <style>
        .popover-content {
            color: red
        }

    </style>
    <script>
        var studentId;
        $('#f').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                student: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '学生不能为空'
                        }
                    }
                },
                stime: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '上课时间不能为空'
                        }
                    }
                },
                etime: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '下课时间不能为空'
                        }
                    }
                }
            }
        });


        $(function () {
            $('#up,#down').datetimepicker(
                {
                    startView: 0,
                    maxView: 0,
                    minView: 0,
                    format: 'hh:ii'
                }
            );


            $('#up,#down').datetimepicker().on('changeDate', function (ev) {
            }).on('hide', function (event) {
                event.preventDefault();
                event.stopPropagation();
            });

            $('#stuList').css('height', 520);
            $('#stuList').attr('class', 'well');
            $('#stuList').css('overflow', 'hidden');
//            $('#stuList').css('overflow-y', 'scroll');


            $('#studentTable').bootstrapTable({
                height: 450,
                url: 'student/getStudentList',
                cache: false,
                pagination: true,
                sidePagination: "server",
                pageSize: 50,
                border: true,
                singleSelect: true,
                columns: [
                    {
                        field: 'id',
                        title: '#',
                        width: 20,
                        checkbox: true
                    },
                    {
                        field: 'name',
                        title: '姓名',
                        width: 80
                    }, {
                        field: 'age',
                        title: '年龄',
                        width: 25,
                        formatter: function (value, row, index) {
                            if (value == 0) {
                                return '';
                            } else {
                                return value;
                            }

                        }
                    },
                    {
                        field: 'gender',
                        title: '性别',
                        width: 20,
                        formatter: function (value, row, index) {
                            if (value == 1) {
                                return '男';
                            } else {
                                return '女';
                            }
                        }
                    },
                    {
                        field: 'tele',
                        title: '联系方式',
                        width: 100
                    },
                    {
                        field: 'wxh',
                        title: '微信号',
                        width: 100
                    },
                    {
                        field: 'memo',
                        title: '备注',
                        width: 100
                    },
                    {
                        field: 'enroldate',
                        title: '入学日期'
                    }
                ]
                ,
                onLoadSuccess: function (data) {
                    $("#studentTable tbody tr").each(function (index, value) {
                        $(this).find("input[type='checkbox']").change(function () {
                            if ($(this).is(':checked') == true) {
                                $('#studentName').val(data.rows[index].name);
                                studentId = data.rows[index].stuId;
                            } else {
                                studentId = undefined;
                                $('#studentName').val("")
                            }
                        })

                    })
                }
            })


        })


        function addTeacherSchedule() {
            $("#f").data('bootstrapValidator').resetForm();
            $('#f').data('bootstrapValidator').validate();
            var val = $('#f').data("bootstrapValidator").isValid();
            var start = $('#up').val();
            var end = $('#down').val();
            var teacherId = '${param.teacherId}';
            if (end < start) {
                bindButtonAndShow('下课时间必须大于上课时间', '提交失败');
                return;
            }
            if (val == false) {
                return;
            } else {
                $.ajax({
                    url: 'teacher/affirmAddSchedule',
                    type: 'post',
                    dataType: 'text',
                    data: $('#f').serialize() + "&" + $.param({stime: start}) + "&" + $.param({etime: end}) + "&" + $.param({teacherId: teacherId}) + "&" + $.param({studentId: studentId}),
                    success: function (result) {
                        if ('true' == result) {
                            parent.closeSecond();
                            parent.reload();
                        } else if (
                            'conflict' == result
                        ) {
                            alert('选择的时间段已经被分配')
                        } else {
                            alert('添加课程失败')
                        }
                    }
                });
            }
        }

        $(function () {
            $('#up,#down').datetimepicker().on('changeDate', function (ev) {
            }).on('hide', function (event) {
                event.preventDefault();
                event.stopPropagation();
            });
        })

        $(function () {
            $('#studentName').focus(function () {
                parent.changeWid(1110);
                $('#stuList').show();
            })
        })

        function closeWin() {
            parent.closeSecond();
        }

        function bindButtonAndShow(content, title) {
            $('button:eq(2)').popover({
                content: content,
                title: title,
                trigger: 'focus',
                delay: 1000
            })
            $('button:eq(2)').popover('show');
        }



    </script>
<%--</head>--%>
<%--<body>--%>
<div style="overflow: auto">
    <div style="margin:10px;width:380px;float:left" id="a">
        <form id="f" class="well">
            <div class="form-group">
                <label>星期</label>
                <input type="text" class="form-control" name="week"
                       placeholder="请输入名称" value="${param.week}">
            </div>
            <div class="form-group">
                <label>学生</label>
                <input type="text" class="form-control" id="studentName"
                       placeholder="点击选择学生" name="student" readonly="readonly">
            </div>
            <div class="form-group">
                <label>学科</label>
                <select class="form-control" name="subjectId">
                    <c:forEach items="${subList}" var="sub">
                        <option value="${sub.subId}">${sub.subName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>教室</label>
                <select class="form-control" name="classId">
                    <c:forEach items="${classList}" var="classroom">
                        <option value="${classroom.classId}">${classroom.className}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>上课时间</label>
                <input type="text" class="form-control" id="up"
                       data-date-format="yyyy-mm-dd hh:ii" name="stime">
            </div>
            <div class="form-group">
                <label>下课时间</label>
                <input type="text" class="form-control" id="down"
                       data-date-format="yyyy-mm-dd hh:ii" name="etime">
            </div>
            <button onclick="addTeacherSchedule()" type="button" class="btn">确认添加</button>
            <button onclick="closeWin()" type="button" class="btn" style="float:right">关闭</button>
        </form>
    </div>
    <div style="display:none;float:left;margin:10px;overflow-y: hidden" id="stuList" class="border">
        <table id="studentTable"></table>
    </div>
</div>
<%--</body>--%>
<%--</html>--%>
