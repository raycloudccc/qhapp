<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/6/5
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .cell {
            width: 120px;
            height: 70px;
            background-color: #ccc;
            font-family: "YouYuan";
            font-weight: bold;
            text-align: center;
        }

        .title {
            width: 120px;
            height: 35px;
            background-color: #ccc;
            font-family: "YouYuan";
            font-weight: bold;
            text-align: center;
        }

        #ddd td {
            border: 2px groove #fff;
            text-shadow: 0px -1px #bbb, 1px 1px #fff;
        }

    </style>

    <script>
        //单元格悬浮效果
        $(".cell").hover(
            function () {
                $(".cell").css('background-color', '#ccc')
                $(this).css('background-color', '#fff')
            },
            function () {
                $(this).css('background-color', '#ccc')
            }
        );

        //取消右键菜单
        $(document).ready(function () {
            $(document).bind("contextmenu", function (e) {
                return false;
            });
        });
        //添加星期上的右键菜单事件
        $(function () {
            var titles = $('.title');
            $(titles).each(function (index, value) {
                $(this).mousedown(function (e) {
                    if (e.button == 2) {
                        $.contextMenu({
                            selector: '.title:eq(' + index + ')',
                            items: {
                                foo: {
                                    name: "添加课程到当日", callback: function (key, opt) {
                                        addSchedule($(value).attr('name'))
                                    }
                                }
                            }
                        })
                    }
                })
            })

            eventBind();



        });


        function addSchedule(week) {
            parent.openSecondWin('teacher/addTeacherSchedule?teacherId=${param.teacherId}&week=' + week, 400)
        }


        function reload() {
            $('tr:gt(0)').remove();
            $.ajax({
                dataType: 'json',
                type: 'post',
                url: 'teacher/teacherScheduleJsonArray',
                data: {teacherId: '${param.teacherId}'},
                success: function (data) {
                    $(data).each(function (index, value) {
                        var tr = $('<tr></tr>');
                        $(value).each(function (i, v) {
                            if (v.subjectName&&v.className&&v.stime&&v.etime) {
                                var td = $('<td><div class="cell" lessonid="'+v.scheduleId+'">' + v.subjectName + '<br/>' + v.className + '</br>['+v.stime+'-'+v.etime+']</div></td>');
                                tr.append(td);
                            }else{
                                var td=$('<td><div class="cell"></div></td>')
                                tr.append(td);
                            }
                        });
                        $('#table').append(tr);

                        eventBind();

                    });
                }

            })
        }

        function removeSchedule(id){
            $.ajax({
                url:'teacher/removeSchedule',
                type:'post',
                data:{
                    id:id
                },
                dataType:'json',
                success:function (data) {
                    if(data==true){
                        reload();
                    }else{
                        alert('删除失败');
                    }
                }
            })
        }

        function eventBind(){
            $('.cell').mousedown(function(e){
                if(e.button==2){
                    var id=$(this).attr('lessonid');
                    if(id){
                        $(this).contextmenu({
                            target:'#myMenu1',
                            onItem: function(context,e) {
                                removeSchedule(id);
                            }
                        })
                    }
                }
            })
        }

    </script>
</head>
<body>
<div id="win" style="margin:10px 25px">
    <div id="ddd">
        <table id="table" style="border-collapse: collapse">
            <tr>
                <td class="title" name="1">星期一</td>
                <td class="title" name="2">星期二</td>
                <td class="title" name="3">星期三</td>
                <td class="title" name="4">星期四</td>
                <td class="title" name="5">星期五</td>
                <td class="title" name="6">星期六</td>
                <td class="title" name="7">星期日</td>
            </tr>
            <c:forEach items="${scheduleList}" var="row">
                <tr>
                    <c:forEach items="${row}" var="cell">
                        <td>
                            <c:choose>
                                <c:when test="${cell.scheduleId==null}">
                                    <div class="cell"></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="cell" lessonid="${cell.scheduleId}">${cell.subjectName}<br/>${cell.className}<br/>[<fmt:formatDate
                                            pattern="HH:mm" value="${cell.stime}"/>-<fmt:formatDate pattern="HH:mm"
                                                                                                    value="${cell.etime}"/>]
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<div id="myMenu1">
    <ul class="dropdown-menu" role="menu">
        <li><a tabindex="-1" href="javascript:void(0);">删除该课程</a></li>
    </ul>
</div>

</body>
</html>
