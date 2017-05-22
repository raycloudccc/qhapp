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
            var flag = $('#editTeacher').form('validate');
            var subids=$('#sub').combo('getValues').join(',');
            if (flag) {
                $.ajax({
                    url: 'teacher/updateTeacher',
                    type: 'POST',
                    dataType: 'json',
                    data: $.param({subids:subids})+'&'+$('#editTeacher').serialize(),
                    success: function (result) {
                        if (result == true) {
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


        $(function () {
            $('#sub').combobox({
                url: 'teacher/teacherSelectedSub?teacherId=' +${teacher.teacherId},
                valueField: 'subId',
                textField: 'subName'
            });
        });


    </script>
</head>
<body>
<form id="editTeacher">
    <table>
        <tr style="display: none">
            <td><input name="teacherId" class="easyui-textbox" style="width:120px" value="${teacher.teacherId}"></td>
        </tr>
        <tr>
            <td>姓名:</td>
            <td><input name="name" class="easyui-textbox" style="width:120px" value="${teacher.name}"
                       data-options="required:true,validType:'name'"></td>
        </tr>
        <tr>
            <td>年龄:</td>
            <td><input name="age" class="easyui-textbox" style="width:120px" value="${teacher.age}"
                       data-options="validType:'age'"></td>
        </tr>
        <tr>
            <td>性别:</td>
            <td><select id="gender" class="easyui-combobox" name="gender" style="width:120px;">
                <option value="1">男</option>
                <option value="2" <c:if test="${teacher.gender==2}">selected="selected"</c:if>>女</option>
            </select></td>
        </tr>
        <tr>
            <td>手机:</td>
            <td><input name="tele" class="easyui-textbox" style="width:120px" value="${teacher.tele}"
                       data-options="validType:'mobile'"></td>
        </tr>
        <tr>
            <td>邮箱:</td>
            <td><input name="email" class="easyui-textbox" style="width:120px" value="${teacher.email}"
                       validtype="email"></td>
        </tr>
        <tr>
            <td>微信:</td>
            <td><input name="wxh" class="easyui-textbox" style="width:120px" value="${teacher.wxh}"
                       data-options="validType:'wxh'"></td>
        </tr>
        <tr>
            <td>地址:</td>
            <td><input name="address" class="easyui-textbox" style="width:120px" value="${teacher.address}"></td>
        </tr>
        <tr>
            <td>学科:</td>
            <td><select id="sub" class="easyui-combobox" data-options="multiple:true,editable:false"
                        style="width:120px;">

            </select></td>
        </tr>
        <tr>
            <td>备注:</td>
            <td><textarea name="memo" style="width: 120px;">${teacher.memo}</textarea></td>
        </tr>

    </table>
    <div style="margin-left: 50px;">
        <a href="#" class="easyui-linkbutton" onclick="save()">保存</a>
        <a href="#" class="easyui-linkbutton" onclick="cancel()">取消</a>
    </div>
</form>
</body>
</html>
