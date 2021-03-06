<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/4/23
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>账户信息</title>
    <jsp:include page="header.jsp"></jsp:include>
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid({
                title:'账户信息',
                fit:true,
                striped:true,
                rownumbers:true,
                singleSelect:true,
                url: 'getAccountInfo',
                queryParams: {
                    uuid: '1'
                },
                columns: [[
                    {
                        field: 'nickname', title: '昵称', width: 100,
                        formatter: function (value, row, index) {
                            if (row.user) {
                                return row.user.name;
                            } else {
                                return value;
                            }
                        }
                    },
                    {field: 'name', title: '用户名', width: 100},
                    {field: 'tele', title: '联系方式', width: 100},
                    {field: 'email', title: '邮箱', width: 100}
                ]]
            });

        });


    </script>
</head>
<body>
<table id="dg"></table>
</body>
</html>
