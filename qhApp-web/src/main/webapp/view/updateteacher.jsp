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



        function save() {
            $('#form').data('bootstrapValidator').validate();
            var flag = $('#form').data("bootstrapValidator").isValid();
            if (flag == false) {
                return;
            }
            var subids=$('#sub').val()
            var arr=subids.join("-");
            $.ajax({
                url:'teacher/updateTeacher',
                type:'post',
                dataType:'json',
                data:$.param({subids:arr})+"&"+$("#form").serialize(),
                success:function(result){
                    if(result==true){
                        closeModal();
                        mframe.reload();
                        $('#form').data('bootstrapValidator').resetForm();
                        $('#form').get(0).reset();
                    }else{
                        tip('操作提示','修改失败',400);
                    }
                }
            })
        }


        //动态加载性别数据和学科数据，并且选中
        $(function () {
            $('[name="gender"]').bootstrapSwitch({
                onText:"男",
                offText:"女",
                onColor:"success",
                offColor:"info",
                size:"small",
                onSwitchChange: function (event, state) {
                    if (state == true) {
                        $(this).val("1");
                    } else {
                        $(this).val("0")
                    }
                }
            })

            $.ajax({
                url:'teacher/teacherSelectedSub',
                type:'post',
                dataType:'json',
                data:{
                    teacherId:${param.teacher_id}
                },
                success:function(data){
                    $(data).each(function(index,value){
                        var option=$("<option value='"+value.subId+"'>"+value.subName+"</option>")
                        if(value.selected==true){
                            option.attr("selected",true);
                        }
                        $('#sub').append(option);

                    })
                }
            })

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
        })
    </script>
</head>
<body>
<div style="margin:10px;">
    <form class="well" id="form">
        <div class="form-group" style="display: none"><label></label>
            <input type="text" class="form-control" placeholder="" name="teacherId" value="${teacher.teacherId}">
        </div>
        <div class="form-group"><label>姓名</label>
            <input type="text" class="form-control" placeholder="请输入教师姓名..." name="name" value="${teacher.name}">
        </div>
        <div class="form-group">
            <label>学科</label>
            <select multiple class="form-control" id="sub"></select>
        </div>
        <div class="form-group"><label>年龄</label>
            <input type="text" class="form-control" placeholder="请输入文字..." name="age" value="${teacher.age}">
        </div>
        <div class="form-group">
            <label>性别</label>
            <div>
                <input name="gender" type="checkbox" data-size="small" <c:if test="${teacher.gender==1}">checked</c:if>>
            </div>
        </div>
        <div class="form-group"><label>手机</label>
            <input type="text" class="form-control" placeholder="请输入手机号..." name="tele" value="${teacher.tele}">
        </div>
        <div class="form-group"><label>邮箱</label>
            <input type="text" class="form-control" placeholder="请输入邮箱..." name="email" value="${teacher.email}">
        </div>
        <div class="form-group"><label>微信</label>
            <input type="text" class="form-control" placeholder="请输入微信号..." name="wxh" value="${teacher.wxh}">
        </div>
        <div class="form-group"><label>住址</label>
            <input type="text" class="form-control" placeholder="请输入联系住址..." value="${teacher.address}" name="address">
        </div>
        <div class="form-group"><label>备注</label>
            <textarea class="form-control" rows="3" name="memo">${teacher.memo}</textarea>
        </div>
        <button class="btn" onclick="save()">确认修改</button>
    </form>
</div>
</body>
</html>
