<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${xtname}</title>
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>
    <style type="text/css">

        .logostr{
            font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
            font-size: 20px;
            color: #fff;
            font-weight:bold;
            padding-left:3px;
        }

        .home_icon{
            background:url('images/brkp_type.gif') no-repeat;
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

        function openWithWin(tit,url,param,w,h){
            $('#w').window({
                title: tit,
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                shadow: false,
                closed: false,
                width:w,
                height:h
            });
            getReloadURL(url,param,"popWin");
        }

        function closeWindow(){
            $('#w').window('close');
        }

        function getReloadURL(urlstr,param,pane){
            showLoading(pane);
            $.ajaxSetup({cache:false});
            $.ajax({
                type: "POST",
                url: urlstr,
                data: param,
                dataType: "text",
                beforeSend: function(XMLHttpRequest){
                    //beforeLoading();
                    return true;
                },
                success: function(responseData, textStatus){
                    $("#"+pane).html(responseData);
                    //document.getElementById(pane).innerHTML=responseData;
                    $.parser.parse('#w');
                },
                complete: function(XMLHttpRequest, textStatus){
                    //hideLoading();
                },
                error: function(){
                    //errorLoading();
                }
            });
        }

        function showLoading(pane){
            document.getElementById(pane).innerHTML=document.getElementById("loadding").innerHTML;
        }

        $(document).ready(function(){
            $('#ttmenu').tree({
                animate:true,
                lines:true,
                url:"menu/listmenus",
                onBeforeExpand:function(node){
                    $('#ttmenu').tree('options').url="main-loadmenus.cyc?parentid="+node.id;
                    return true;
                },
                onClick:function(node){
                    $(this).tree('toggle', node.target);
                    //checknode(node.id);
                    if(node.attributes.url!="#" && node.attributes.url!=""){
                        checknode(node.id);
                    }
                }
            });
            <c:if test="${dictionary.hasCmd}">
            viewCmd();
            </c:if>
        });
        function checknode(menuid){
            $.ajax({
                type: "POST",
                url: "main-urldata.cyc?menuid="+menuid,
                data: "",
                dataType: "text",
                beforeSend: function(XMLHttpRequest){
                    $("<div class=\"datagrid-mask\" style=\"display:block\"></div>").css({width:"100%",height:"100%"}).appendTo($(document.body));
                    return true;
                },
                success: function(responseData, textStatus){
                    if(/^(null|undefined|#)$/.test(responseData)){
                        document.getElementById("mframe").src="";
                    } else {
                        document.getElementById("mframe").src=responseData;
                    }
                },
                complete: function(XMLHttpRequest, textStatus){
                    $(document.body).children("div.datagrid-mask").remove();
                },
                error: function(){
                    document.getElementById("mframe").src="";
                }
            });
        }
        function editPwdWin(){
            openWithWin('修改密码','main-toeditpwd.cyc','',340,200);
        }
        function savePwdWin(){
            var res = $('#login_users_form').form('validate');
            if(res){
                var pwd = $('#password').val();
                var repwd = $('#repassword').val();
                if(pwd != repwd){
                    alert("两次新密码输入不一致");
                    $('#repassword').focus();
                    return false;
                }
                var param = $('#login_users_form').serialize();
                $.post("main-savepwd.cyc",param,function(data){
                    if(data=='true'){
                        alert("操作成功");
                        closeWindow();
                    }else if(data=='false'){
                        alert("操作失败");
                    }else if(data=='password-not-equals'){
                        alert("操作失败\n原密码不正确");
                    }
                },"text");
            }
        }
        function openNewWin(){
            window.top.open("main-index.cyc", "");
        }

        window.setInterval(function(){keepSession();}, 1000*60*5);

        function keepSession(){
            $.ajaxSetup({cache:false});
            var parma="n="+Math.random();
            $.ajax({
                type: "POST",
                url: "session-keep.cyc",
                data: parma,
                dataType: "text",
                beforeSend: function(XMLHttpRequest){
                    //alert("url="+parma);
                    return true;
                },
                success: function(responseData, textStatus){
                    //alert(responseData);
                },
                complete: function(XMLHttpRequest, textStatus){
                    //hideLoading();
                },
                error: function(){
                    //errorLoading();
                }
            });
        }
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
<div id="loadding" style="display:none"><img alt="" src="images/panel_loading.gif"/></div>
</body>
</html>