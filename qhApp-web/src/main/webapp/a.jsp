<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="width:100%;height:100%">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${xtname}</title>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-switch.min.css">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-select.min.css">
    <script type="text/javascript" src="plugs/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap-treeview.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap-switch.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap-select.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/i18n/defaults-*.min.js"></script>--%>
    <%--<script type="text/javascript" src="bootstrap/js/i18n/defaults-*.js"></script>--%>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: 'menu/listmenus',
                type: 'post',
                dataType: 'json',
                success: function (tree) {
//                    $('#tree').treeview({data: tree});
                    $('#tree').treeview({
                        data: tree,
                        enableLinks: false,
                        levels: 5,
                        onNodeSelected: function (event, data) {
                            var url = data.href;
                            if ('#' != url) {
                                $('#mframe').attr('src', url);
                            }
                        }
                    });
                }
            });
        })

        //打开一个模态图，远程加载页面，宽度可限定，高度自适应
        function openWithWin(url, wid) {
            $('#wid').css("width", wid + 'px')
            $("#myModal").modal({
                remote: url
            });
        }
        //在每次隐藏模态框的同时清空所有数据
        $(function () {
            $('#myModal').on('hide.bs.modal', function () {
                $(this).removeData("bs.modal")
            })

            $('#tip').on('hide.bs.modal', function () {
                $(this).removeData("bs.modal")
            })
        });


        //远程加载页面的模态图的隐藏方法，直接调用
        function closeModal() {
            $('#myModal').modal('hide');
        }


        function clearData() {
            $('#myModal').destroy();
        }

        //        用于提示框，如添加成功等信息
        function tip(title, context, wid) {
            $('#myModalLabel').html(title);
            $('.modal-body').html(context);
            $('#tip_wid').css("width", wid);
            $('#tip').modal('show')
        }

    </script>
</head>
<body style="padding:0px;margin:0px;width:100%;height:100%">
<div style="border:1px solid #ffab3f;width:100%;height:30px"></div>
<div style="width:100%;height:100%;border:1px solid #00ee00;position:fixed;top:30px">
    <div style="float:left;width:250px;height:100%;border:1px solid #ffab3f">
        <div id="tree"></div>
    </div>
    <div style="height:100%;margin-left:250px">
        <iframe id="mframe" name="mframe" width="100%" height="100%" frameborder="0" style="border:none"
                src="about:blank"></iframe>
    </div>
</div>

<%--模态图--该块用于加载远程页面--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" id="wid">
        <div class="modal-content">
        </div>
    </div>
</div>


<%--提示框--%>
<div class="modal fade" id="tip" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" id="tip_wid">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    x
                </button>
                <h4 class="modal-title" id="myModalLabel">
                </h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>