<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/5/8
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style type="text/css">
        div{
            margin-bottom: 5px;
        }
    </style>

    <script type="text/javascript">
        $.extend($.fn.validatebox.defaults.rules, {
            age: {// 验证年龄
                validator: function (value) {
                    return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
                },
                message: '年龄必须是0到120之间的整数'
            },
            mobile: {// 验证手机号码
                validator: function (value) {
                    return /^(13|15|18)\d{9}$/i.test(value);
                },
                message: '手机号码格式不正确'
            },
            name: {// 验证姓名，可以是中文或英文
                validator: function (value) {
                    return /^[\u4E00-\u9FA5A-Za-z]+$/.test(value);
                },
                message: '姓名输入有误'
            },
            wxh: {// 验证姓名，可以是中文或英文
                validator: function (value) {
                    return /^[a-zA-Z\d_]{5,}$/.test(value);
                },
                message: '请输入正确的微信号'
            }
        });


        function save(){
            var flag = $('#addStudent').form('validate');
            if(flag){
                $('#addStudent').form('submit', {
                    url: 'student/addStudent',
                    type: 'POST',
                    dataType:'json',
                    data: $('#addStudent').serialize(),
                    success: function (result) {
                        if (result=='true') {
                            mframe.reload();
                            cancel();
                            $.messager.show({
                                title: '操作提示',
                                msg: '添加成功',
                                timeout: 2000,
                                showType: 'slide'
                            });
                        } else {
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
<form id="addStudent">
    <div style="display:none"><input name="stuId" class="easyui-textbox" style="width:120px">
    </div>
    <div>姓名:
        <input name="name" class="easyui-textbox" style="width:120px"
               data-options="required:true,validType:'name'">
    </div>
    <div>年龄:
        <input name="age" class="easyui-textbox" style="width:120px"
               data-options="validType:'age'">
    </div>
    <div>性别:
        <select id="gender" class="easyui-combobox" name="gender" style="width:120px">
            <option value="1">男</option>
            <option value="2">女</option>
        </select>
    </div>
    <div>手机:
        <input name="tele" class="easyui-textbox" style="width:120px"
               data-options="validType:'mobile'">
    </div>
    <div>微信:
        <input name="wxh" class="easyui-textbox" style="width:120px"
               data-options="validType:'wxh'">
    </div>
    <div>地址:
        <input name="address" class="easyui-textbox" style="width:120px"
               data-options="">
    </div>
    <div>备注:
        <textarea name="memo" style="width: 120px"></textarea>
    </div>
    <div>入学日期:
        <input name="enroldate" type="text" class="easyui-datebox" required="required"
               data-options="width:100"> </input>
    </div>

    <a href="#" class="easyui-linkbutton" onclick="save()">保存</a>
    <a href="#" class="easyui-linkbutton" onclick="cancel()">取消</a>
</form>
</body>
</html>
