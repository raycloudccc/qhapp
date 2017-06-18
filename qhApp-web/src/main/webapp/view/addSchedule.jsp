<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/6/9
  Time: 13:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        $(function(){
            $('#cc').combobox({
                url:'teacher/techerSelectSubJSON?teacherId=${param.teacherId}',
                valueField:'id',
                textField:'text'

            });
        });
    </script>
</head>
<body>
    <div>
        <div>学科:<input id="cc" class="easyui-combobox"/></div>
        <div>教室:</div>
        <div>上课时间:</div>
    </div>
</body>
</html>
