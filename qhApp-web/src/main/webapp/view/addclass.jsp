<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/6/7
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        function save(){
            var check=$('#ff').form('validate');
            if(check==false){
                return;
            }

            $.ajax({
                url:'classroom/saveClass',
                dataType:'text',
                type:'post',
                data:$('#ff').serialize(),
                success:function(result){
                    if(result=='exist'){
                        $.messager.alert('消息提示','该教室已经存在！','');
                    }else if(result=='false'){
                        $.messager.alert('消息提示','添加失败','');
                    }else{
                        cancel();
                        mframe.reload();
                        $.messager.show({
                            title:'操作提示',
                            msg:'操作成功',
                            timeout:2000,
                            showType:'slide'
                        });

                    }
                }
            });
        }

        function cancel(){
            $('#w').window('close');
        }


        $.extend($.fn.validatebox.defaults.rules, {
            name: {
                validator: function(value, param){
                    return /^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$/.test(value);
                },
                message: 'Please enter at least {0} characters.'
            }
        });
    </script>
</head>
<body>
<form id="ff" method="post">
    <div>
        名称:
        <input class="easyui-validatebox" type="text" name="className" data-options="required:true"/>
    </div>
    <div style="margin-top:5px">
        <a href="#" class="easyui-linkbutton" onclick="save()" style="margin-right:5px">保存</a>
        <a href="#" class="easyui-linkbutton" onclick="cancel()">取消</a>
    </div>
</form>
</body>
</html>
