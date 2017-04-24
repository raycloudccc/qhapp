<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${xtname}</title>
    <%String path = request.getContextPath();%>
    <link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
    <script type="text/javascript" src="../easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jquery.form.js"></script>
    <script type="text/javascript" src="../view/js/begin.js"></script>
    <style type="text/css">

        .logostr{
            font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
            font-size: 20px;
            color: #fff;
            font-weight:bold;
            padding-left:3px;
        }

        .home_icon{
            background:url('../images/brkp_type.gif') no-repeat;
        }

        .mylin{
            text-decoration:none;
            color:#fff;
        }

        td,div {
            font-size: 12px;
        }

        form {
            margin: 0px;
            padding: 0px;
        }

        input {
            font-size: 12px;
        }

        textarea {
            font-size: 12px;
        }
        .treeHeader {
            font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #336699;
        }
        div,li,ul{
            font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
            font-size: 12px;
            /*color: #336699;*/
        }


        .table .td{
            background:#eee;
            text-align:center;
            font-size:10px;
            line-height:16px;
            padding:0;
        }

        .table .td.box{
            background:#fafafa;
            width:90px;
            height:22px;
        }

        .itemTable td{
            background:#eee;
            text-align:center;
            font-size:10px;
            line-height:16px;
        }
        .itemTable td.box{
            background:#fafafa;
            width:90px;
            height:22px;
        }

        .scDragTab table{
            background:#666;
            width:100%;
        }
        .scDragTab td{
            background:#eee;
            color:#444;
            text-align:center;
            padding:2px;
            height:20px;
        }
        .scDragTab td{
            background:#E0ECFF;
        }
        .scDragTab td.courseDrop{
            background:#fafafa;
            width:110px;
        }
        .scDragTab td.over{
            background:#FBEC88;
        }

    </style>
    <script type="text/javascript">
        var path = '<%=path%>';
        <c:if test="${dictionary.hasCmd}">
        function viewCmd() {
            openWithWin('数据上报','cmd-main.cyc','',800,400);
        }
        </c:if>
    </script>
</head>
<body style="padding:0px;margin:0px;" class="easyui-layout">
<div data-options="region:'north'" style="overflow:hidden;border:0px;height:40px;padding-top:8px;background:#003366">
    <span class="logostr">${xtname}</span>
    <div style="float:right;font-size:12px;color:#fff;width:250px;text-align:right;padding:4px 8px 0px 0px">
        <c:if test="${dictionary.hasCmd}">
            <span><a href="javascript:void(0)" onclick="viewCmd()"  class="mylin">数据上报</a></span><span> | </span>
        </c:if>
        <span><a href="javascript:void(0)" onclick="editPwdWin()" title="修改密码" class="mylin">${username}</a></span>
        <span> | </span><span><a href="javascript:void(0)" onclick="openNewWin()" title="打开新界面" class="mylin">打开新界面</a></span>
        <span> | </span><span><a href="sys-logout.cyc" title="退出" class="mylin">退出</a></span>
    </div>
</div>

<div data-options="region:'west',split:true" style="padding:3px;margin:0px;width:240px">
    <div style="height:16px;padding-left:10px;padding-top:2px" class="home_icon">
        <div class="treeHeader" style="margin-left:9px"><span>系统导航</span></div>
        <ul id="ttmenu" class="easyui-tree" style="color:#336699;"></ul>
    </div>
</div>
<div data-options="region:'center'" style="background:#fff;border-top:0px;overflow:hidden">
    <iframe id="mframe" name="mframe" width="100%" height="100%" frameborder="0" style="border:none" src="about:blank"></iframe>
</div>
<div data-options="closed:true,modal:true" id="w" class="easyui-window" title="My Window" style="width:750px;height:400px;padding:5px">
    <div data-options="fit:true" class="easyui-layout">
        <div data-options="region:'center'" id="popWin" style="padding:10px;background:#fff;border:1px solid #ccc">
        </div>
    </div>
</div>
<div id="loadding" style="display:none"><img alt="" src="../images/panel_loading.gif"/></div>
</body>
</html>