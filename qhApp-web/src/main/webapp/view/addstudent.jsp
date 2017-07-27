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
    <%--<jsp:include page="header.jsp"></jsp:include>--%>
    <style type="text/css">
        .cell {
            margin: 10px;
        }
    </style>

    <script type="text/javascript">
        var current = new Date();
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


            $('#datetimepicker').val(current.getFullYear() + "-" + (current.getMonth() + 1) + "-" + current.getDate())
            $('#datetimepicker').datetimepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true,
                showMeridian: false,
                minView: 2,
                maxView: 2

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
            })
        });


        function addStudent(){
            $('#form').data('bootstrapValidator').validate();
            var flag = $('#form').data("bootstrapValidator").isValid();
            if (flag == false) {
                return;
            }
            $.ajax({
                url:'student/addStudent',
                type:'post',
                data:$('form').serialize(),
                dataType:'json',
                success:function(result){
                    if(result==true){
                        closeModal();
                        mframe.reload();
                        //清空所有验证
                        $('#form').data('bootstrapValidator').resetForm();
                        //清空表单数据
                        $('#form')[0].reset();
                    }else{
                        parent.showtip('添加失败');
                    }
                }
            })
        }
    </script>
</head>
<body>
<div style="margin:10px">
    <form class="well" id="form" >
        <div class="form-group">
            <label>姓名</label>
            <input type="text" class="form-control" placeholder="请输入学生姓名..." name="name">
        </div>
        <div class="form-group">
            <label>年龄</label>
            <input type="text" class="form-control" placeholder="请输入整数..." name="age">
        </div>
        <div class="form-group">
            <label>性别</label>
            <div>
                <input name="gender" type="checkbox" data-size="small">
            </div>
        </div>
        <div class="form-group">
            <label>联系方式</label>
            <input type="text" class="form-control" placeholder="请输入手机号..." name="tele">
        </div>
        <div class="form-group">
            <label>入学日期</label>
            <input type="text" id="datetimepicker" name="enroldate" class="form-control">
        </div>
        <div class="form-group">
            <label>微信</label>
            <input type="text" class="form-control" placeholder="请输入微信号..." name="wxh">
        </div>
        <div class="form-group">
            <label>联系住址</label>
            <input type="text" class="form-control" placeholder="请输入家庭住址..." name="address">
        </div>
        <div class="form-group">
            <label>备注</label>
            <textarea class="form-control" rows="3" name="memo"></textarea>
        </div>

        <button class="btn" onclick="addStudent()">确认添加</button>
    </form>
</div>
</body>
</html>
