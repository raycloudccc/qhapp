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
        $(function () {
            $('form').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    subName: {
                        message: '学科验证失败',
                        validators: {
                            notEmpty: {
                                message: '学科不可为空'
                            },
                            regexp: {
                                regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9_]{1,20}$/,
                                message: '请输入长度为1-20的中英文或者数字'
                            }

                        }
                    }
                }
            });
        });

            function addSubject() {
                $('#form').data('bootstrapValidator').validate();
                var flag = $('#form').data("bootstrapValidator").isValid();
                if (flag == false) {
                    return;
                }
                $.ajax({
                    url:'subject/addSubject',
                    type:'post',
                    data:$('form').serialize(),
                    dataType:'text',
                    success:function(result){
                        if(result=='true'){
                            closeModal();
                            mframe.reload();
                            //清空所有验证
                            $('#form').data('bootstrapValidator').resetForm();
                            //清空表单数据
                            $('#form')[0].reset();
                        }else if(result=='clash'){
                            parent.tip('操作提示','该学科已经存在',400);
                        }else{
                            parent.tip('操作提示','添加失败',400);
                        }
                    }
                })
            }
    </script>
</head>
<body>
<form class="well" id="form">
    <div class="form-group">
        <label>学科</label>
        <input type="text" class="form-control" placeholder="请输入学科名" name="subName">
    </div>
    <button class="btn" onclick="addSubject()">确认添加</button>
</form>
</body>
</html>