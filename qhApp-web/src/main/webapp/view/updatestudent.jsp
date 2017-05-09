<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/4/25
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <style type="text/css">
        .field{
            margin-bottom:5px;
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
            },


        });


        function save() {
            var flag = $('#editStudent').form('validate');
            if (flag) {
                $('#editStudent').form('submit', {
                    url: 'student/updateStudent',
                    type: 'POST',
                    dataType: 'json',
                    data: $('#editStudent').serialize(),
                    success: function (result) {
                        if (result == 'true') {
                            mframe.reload();
                            cancel();
                            $.messager.show({
                                title: '操作提示',
                                msg: '修改成功',
                                timeout: 2000,
                                showType: 'slide'
                            });
                        } else {
                            $.messager.alert('操作提示', '修改失败', '');
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
<form id="editStudent">
    <div style="display:none"><input name="stuId" class="easyui-textbox" style="width:120px"
                                     value="${stu.stuId}">
    </div>
    <div class="field">姓名:
        <input name="name" class="easyui-textbox" style="width:120px" value="${stu.name}"
               data-options="required:true,validType:'name'">
    </div>
    <div class="field">年龄:
        <input name="age" class="easyui-textbox" style="width:120px" value="${stu.age}"
               data-options="validType:'age'">
    </div>
    <div class="field">性别:
        <select id="gender" class="easyui-combobox" name="gender" style="width:120px;">
            <option value="1">男</option>
            <option value="2" <c:if test="${stu.gender==2}">selected="selected"</c:if>>女</option>
        </select>
    </div>
    <div class="field">手机:
        <input name="tele" class="easyui-textbox" style="width:120px" value="${stu.tele}"
               data-options="validType:'mobile'">
    </div>
    <div class="field">微信:
        <input name="wxh" class="easyui-textbox" style="width:120px" value="${stu.wxh}"
               data-options="validType:'wxh'">
    </div>
    <div class="field">地址:
        <input name="address" class="easyui-textbox" style="width:120px" value="${stu.address}"
               data-options="">
    </div>
    <div class="field">备注:
        <textarea name="memo" style="width: 120px">${stu.memo}</textarea>
    </div>
    <div class="field">入学日期:
        <input name="enroldate" type= "text" class= "easyui-datebox" required ="required" value="${stu.enroldate}" data-options="width:100"> </input>
    </div>

    <a href="#" class="easyui-linkbutton" onclick="save()">保存</a>
    <a href="#" class="easyui-linkbutton" onclick="cancel()">取消</a>
</form>
</body>
</html>
