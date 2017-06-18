<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/5/8
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <style type="text/css">
        .field {
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


        function save() {
            var flag = $('#addStudent').form('validate');
            if (flag) {
                $('#addStudent').form('submit', {
                    url: 'student/addStudent',
                    type: 'POST',
                    dataType: 'json',
                    data: $('#addStudent').serialize(),
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

<form class="well">
    <div class="form-group">
        <label>姓名</label>
        <input type="text" class="form-control" placeholder="请输入学生姓名..." name="name">
    </div>
    <div class="form-group">
        <label>年龄</label>
        <input type="text" class="form-control" placeholder="请输入整数..." name="name">
    </div>
    <div class="form-group">
        <label>性别</label>
        <%--<input type="text" class="form-control" placeholder="请输入..." name="name">--%>
    </div>
    <div class="form-group">
        <label>联系方式</label>
        <input type="text" class="form-control" placeholder="请输入手机号..." name="name">
    </div>
    <div class="form-group">
        <label>微信</label>
        <input type="text" class="form-control" placeholder="请输入微信号..." name="name">
    </div>
    <div class="form-group">
        <label>联系住址</label>
        <input type="text" class="form-control" placeholder="请输入家庭住址..." name="name">
    </div>
    <div class="form-group">
        <label>备注</label>
        <input type="text" class="form-control" placeholder="请输入备注文字..." name="name">
    </div>
    <div class="form-group">
        <label>入学日期</label>
        <%--<input type="text" class="form-control" placeholder="请选择入学日期" name="name">--%>
    </div>
    <button type="submit" class="btn">Submit</button>
</form>

</body>
</html>
