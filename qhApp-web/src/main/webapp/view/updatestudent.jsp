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
                    enroldate: {
                        validators: {
                            notEmpty: {
                                message: '入学日期必须填写'
                            }
                        }
                    }
                }
            });


            $('[name="gender"]').bootstrapSwitch({
                onText: "男",
                offText: "女",
                onColor: "success",
                offColor: "info",
                size: "small",
                //如果开关处于关的状态下不会获取到value值，Controller的param则不会接收到
                onSwitchChange: function (event, state) {
                    if (state == true) {
                        $(this).val("1");
                    } else {
                        $(this).val("0");
                    }
                }
            });


            $('#datetimepicker').datetimepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true,
                showMeridian: false,
                minView: 2,
                maxView: 2

            });

            //解决更改了时间却无法隐藏模态框的异常
            $('#datetimepicker').datetimepicker().on('changeDate', function(ev) {
            }).on('hide', function(event) {
                event.preventDefault();
                event.stopPropagation();
            });
        })


        function updateStudent(){
            $('#form').data('bootstrapValidator').validate();
            var flag = $('#form').data("bootstrapValidator").isValid();
            if (flag == false) {
                return;
            }
            $.ajax({
                url:'student/updateStudent',
                type:'post',
                dataType:'json',
                data:$('#form').serialize(),
                success:function(result){
                    if(result==true){
                        mframe.reload();
                        $('#form').data('bootstrapValidator').resetForm();
                        $('#form').get(0).reset();
                        closeModal();
                    }else{
                        tip('操作提示','修改失败',400);
                    }
                }
            });
        }

    </script>
</head>
<body>
<div style="margin:10px">
    <form class="well" id="form">
        <div class="form-group" style="display: none">
            <%--<label>姓名</label>--%>
            <input type="text" class="form-control" placeholder="请输入学生姓名..." name="stuId" value="${param.stuId}">
        </div>
        <div class="form-group">
            <label>姓名</label>
            <input type="text" class="form-control" placeholder="请输入学生姓名..." name="name" value="${stu.name}">
        </div>
        <div class="form-group">
            <label>年龄</label>
            <input type="text" class="form-control" placeholder="请输入整数..." name="age" value="${stu.age}">
        </div>
        <div class="form-group">
            <label>性别</label>
            <div>
                <input name="gender" type="checkbox" data-size="small" value="1" <c:if test="${stu.gender==1}">checked</c:if>>
            </div>
        </div>
        <div class="form-group">
            <label>联系方式</label>
            <input type="text" class="form-control" placeholder="请输入手机号..." name="tele" value="${stu.tele}">
        </div>
        <div class="form-group">
            <label>入学日期</label>
            <input type="text" id="datetimepicker" name="enroldate" class="form-control" value="${stu.enroldate}">
        </div>
        <div class="form-group">
            <label>微信</label>
            <input type="text" class="form-control" placeholder="请输入微信号..." name="wxh" value="${stu.wxh}">
        </div>
        <div class="form-group">
            <label>联系住址</label>
            <input type="text" class="form-control" placeholder="请输入家庭住址..." name="address" value="${stu.address}">
        </div>
        <div class="form-group">
            <label>备注</label>
            <textarea class="form-control" rows="3" name="memo">${stu.memo}</textarea>
        </div>

        <button class="btn" onclick="updateStudent()">确认修改</button>
    </form>
</div>
</body>
</html>
