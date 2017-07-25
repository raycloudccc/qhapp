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
                $('#subjectTable').bootstrapTable({
                    url: 'getSubjectList',
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
                        width:30
                    },
                        {
                            field: 'Number',
                            title: '序号',
                            formatter: function (value, row, index) {
                                return index+1;
                            },
                            width:100
                        },
                        {
                            field: 'subName',
                            title: '学科',
                            width:700
                        }]
                });
            });

            function addSubject(){
                top.openWithWin('subject/toAddSubject',400);
            }

            function reload(){
                var opt = {
                    url: "getSubjectList",
                    silent: true
                };
                $("#subjectTable").bootstrapTable('refresh', opt);
            }


            function deleteSubject(){
                var arrs=new Array();
                var selecteds = $('#subjectTable').bootstrapTable('getSelections');
                $(selecteds).each(function(index,value){
                    arrs.push(value.subId);
                })
                var rowids=arrs.join("-");
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
                            tip('操作提示', '删除失败', 400);
                        }
                    }
                })
            }

    </script>
</head>
<body>
<div style="height:100% " id="father">
    <table id="subjectTable"></table>
    <div id="tool">
        <button type="button" class="btn btn-success" onclick="addSubject()">添加学科</button>
        <button type="button" class="btn btn-danger" onclick="deleteSubject()">删除学科</button>
    </div>
</div>
</body>
</html>
