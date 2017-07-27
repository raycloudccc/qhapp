<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/4/26
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%--<html>--%>
<%--<head>--%>
    <%--<title>添加教师</title>--%>
    <style>
        form div {
            margin-bottom: 5px
        }

        form input {
            margin-left: 5px
        }

    </style>
    <script type="text/javascript">
        $(function () {
            $('form').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    name: {
                        message: '用户名验证失败',
                        validators: {
                            notEmpty: {
                                message: '姓名不可为空'
                            },
                            regexp: {
                                regexp: /^[\u4E00-\u9FA5A-Za-z]+$/,
                                message: '姓名只可以是中英文'
                            }

                        }
                    },
                    age: {
                        validators: {
                            regexp: {
                                regexp: /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i,
                                message: '年龄必须是0到120之间的整数'
                            }
                        }
                    },
                    tele: {
                        validators: {
                            regexp: {
                                regexp: /^(13|15|18)\d{9}$/i,
                                message: '手机号码格式不正确'
                            }
                        }
                    },
                    wxh: {
                        validators: {
                            regexp: {
                                regexp: /^[a-zA-Z\d_]{5,}$/,
                                message: '微信号格式不正确'
                            }
                        }
                    },
                    email: {
                        validators: {
                            emailAddress: {
                                message: '邮箱格式有误'
                            }
                        }
                    },
                    sub: {
                        validators: {
                            notEmpty: {
                                message: '学科必须填写'
                            }
                        }
                    }
                }
            });
        });

        function add() {
            //如果存在空字段，则不让其提交
            $('#form').data('bootstrapValidator').validate();
            var flag = $('#form').data("bootstrapValidator").isValid();
            if (flag == false) {
                return;
            }
            var arr = $("#form").data("bootstrapValidator").getFieldElements('sub').val();
            var subIds = arr.join("-");
            $.ajax({
                url: 'teacher/addTeacher',
                type: 'POST',
                dataType: 'json',
                data: $.param({subids: subIds}) + '&' + $('#form').serialize(),
                success: function (result) {
                    if (result == true) {
                        closeModal();
                        mframe.reload();
                        //清空所有验证
                        $('#form').data('bootstrapValidator').resetForm();
                        //清空表单数据
                        $('#form')[0].reset();
                    } else {
                        parent.showtip('添加失败');
                    }
                }
            });
        }


        $(function () {
            $('[name="gender"]').bootstrapSwitch({
                onText: '男',
                offText: "女",
                onColor: "success",
                offColor: "info",
                size: "small",
                onSwitchChange: function (event, state) {
                    if (state == true) {
                        $(this).val("1");
                    } else {
                        $(this).val("000")
                    }
                }
            })
        });


    </script>
<%--</head>--%>
<%--<body>--%>
<div style="margin:10px;">
    <form class="well" id="form">
        <div class="form-group"><label>姓名</label>
            <input type="text" class="form-control" placeholder="请输入教师姓名..." name="name">
        </div>
        <div class="form-group">
            <label>学科</label>
            <select multiple class="form-control" name="sub">
                <c:forEach items="${allsub}" var="sub">
                    <option value="${sub.subId}">${sub.subName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group"><label>年龄</label>
            <input type="text" class="form-control" placeholder="请输入文字..." name="age">
        </div>
        <div class="form-group">
            <label>性别</label>
            <div>
                <input name="gender" type="checkbox" data-size="small">
            </div>
        </div>
        <div class="form-group"><label>手机</label>
            <input type="text" class="form-control" placeholder="请输入手机号..." name="tele">
        </div>
        <div class="form-group"><label>邮箱</label>
            <input type="text" class="form-control" placeholder="请输入邮箱..." name="email">
        </div>
        <div class="form-group"><label>微信</label>
            <input type="text" class="form-control" placeholder="请输入微信号..." name="wxh">
        </div>
        <div class="form-group"><label>住址</label>
            <input type="text" class="form-control" placeholder="请输入联系住址..." name="address">
        </div>
        <div class="form-group"><label>备注</label>
            <textarea class="form-control" rows="3" name="memo"></textarea>
        </div>
        <button class="btn" onclick="add()">确认添加</button>
    </form>
</div>
<%--</body>--%>
<%--</html>--%>
