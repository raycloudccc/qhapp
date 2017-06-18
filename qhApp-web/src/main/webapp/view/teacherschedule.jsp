<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            background-color: #c1d5ce;
        }

        .title {
            width: 120px;
            height: 35px;
            background-color: #6ac9cc
        }
    </style>

    <script>
        //单元格悬浮效果
        $(".cell").hover(
            function () {
                $(".cell").css('background-color', '#c1d5ce')
                $(this).css('background-color', '#fff')
            },
            function () {
                $(this).css('background-color', '#c1d5ce')
            }
        );

        //取消右键菜单
        $(document).ready(function () {
            $(document).bind("contextmenu", function (e) {
                return false;
            });
        });

        //右键添加增加课程按钮
        $('.title').mousedown(function (e) {
            if (e.which == 3) {
                $('#caidan').menu('show', {
//                    left:$(this).offset().left-$('#win').parent().offset().left,
//                    top: ($(this).offset().top-$('#win').parent().offset().top)
                    left:200,
                    top:200
            });
            }
        })


        $('#caidan').menu({
            onClick: function (item) {
                var data={
                    "week":item.text,
                    "teacherId":'${teacherId}'
                }
                top.openWithWin("添加课程","teacher/toAddSchedule",data,"");
            },
            onShow:function(){
                alert('显示')
            },
            onHide:function(){
                alert('消失')
            }

        });


    </script>
</head>
<body>
<div id="win">
    <div id="caidan" class="easyui-menu" style="width:120px" data-options="inline:false,hideOnUnhover:false,duration:10000">
        <div>添加课程</div>
    </div>
    <div>
        <table border="1" cellspacing="0" cellpadding="0">
            <tr>
                <td class="title">星期一</td>
                <td class="title">星期二</td>
                <td class="title">星期三</td>
                <td class="title">星期四</td>
                <td class="title">星期五</td>
                <td class="title">星期六</td>
                <td class="title">星期日</td>
            </tr>
            <c:forEach items="${scheduleList}" var="row">
                <tr>
                    <c:forEach items="${row}" var="cell">
                        <td>
                            <c:choose>
                                <c:when test="${cell.subjectName==null}">
                                    <div class="cell"></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="cell">${cell.subjectName}-${cell.className}[${cell.stime}-${cell.etime}]</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </div>


</div>
</body>
</html>
