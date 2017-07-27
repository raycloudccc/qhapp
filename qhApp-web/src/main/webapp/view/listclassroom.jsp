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
            $('#classTable').bootstrapTable({
                url: 'getClassList',
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
                toolbar: $('#tool'),
                columns: [{
                    field: 'id',
                    checkbox: true,
                    title: '#',
                    width: 30
                },
                    {
                        field: 'Number',
                        title: '序号',
                        formatter: function (value, row, index) {
                            return index + 1;
                        },
                        width: 100
                    },
                    {
                        field: 'className',
                        title: '教室',
                        width: 700
                    }]
            });
        });

        function addSubject() {
            top.openWithWin('classroom/addClass', 400);
        }

        function reload() {
            var opt = {
                url: "getClassList",
                silent: true
            };
            $("#classTable").bootstrapTable('refresh', opt);
        }


        function deleteSubject() {
            var arrs = new Array();
            var selecteds = $('#subjectTable').bootstrapTable('getSelections');
            $(selecteds).each(function (index, value) {
                arrs.push(value.subId);
            })
            var rowids = arrs.join("-");
            $.ajax({
                url: 'deleteSubject',
                type: 'post',
                dataType: 'json',
                data: {
                    arrs: rowids
                },
                success: function (result) {
                    if (result == true) {
                        reload();
                    } else {
                        showtip('操作提示', '删除失败', 400);
                    }
                }
            })
        }


        function addClass(){
            top.openWithWin('classroom/addClass',400);
        }

        function deleteClass(){
            var arrs=new Array();
            var selecteds = $('#classTable').bootstrapTable('getSelections');
            $(selecteds).each(function(index,value){
                arrs.push(value.classId);
            })
            var rowids=arrs.join("-");
            $.ajax({
                url: 'deleteClass',
                type: 'post',
                dataType: 'json',
                data: {
                    ids: rowids
                },
                success: function (result) {
                    if (result == true) {
                        reload();
                    } else {
                        showtip('操作提示', '删除失败', 400);
                    }
                }
            })
        }
    </script>


</head>
<body>
<div style="height:100% " id="father">
    <table id="classTable"></table>
    <div id="tool">
        <button type="button" class="btn btn-success" onclick="addClass()">添加教室</button>
        <button type="button" class="btn btn-danger" onclick="deleteClass()">删除教室</button>
    </div>
</div>
</body>
</html>
