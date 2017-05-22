<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/5/10
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <script type="text/javascript">
        $.extend($.fn.validatebox.defaults.rules, {
            subname: {
                validator: function(value){
                    return /^[\u4e00-\u9fa5_a-zA-Z0-9_]{1,20}$/.test(value);
                },
                message: '请输入长度为1-20的中英文或者数字'
            }
        });


        function add() {
            var flag = $('#addSubject').form('validate');
            if (flag) {
                $('#addSubject').form('submit', {
                    url: 'subject/addSubject',
                    type: 'POST',
                    dataType: 'json',
                    data: $('#addSubject').serialize(),
                    success: function (result) {
                        if (result == 'true') {
                            mframe.reload();
                            cancel();
                            $.messager.show({
                                title: '操作提示',
                                msg: '添加成功',
                                timeout: 2000,
                                showType: 'slide'
                            });
                        } else if(result=="clash"){
                            $.messager.alert('操作提示', '该学科已经存在', '');
                        }else {
                            $.messager.alert('操作提示', '添加失败', '');
                        }
                    }

                });
            }
        }


        function cancel() {
            $('#w').window('close');
        }
    </script>
</head>
<body>
<form id="addSubject">
    <div style="margin-bottom: 5px">名称:
        <input name="subName" class="easyui-textbox" style="width:120px"
                   data-options="required:true,validType:'subname'">
    </div>
    <a href="#" class="easyui-linkbutton" onclick="add()">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="cancel()">取消</a>

</form>
</body>
</html>