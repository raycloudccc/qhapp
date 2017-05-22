
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
        iconCls:'icon-save',
        url:path+"/menu/listmenus?parent_id=0",
        onBeforeExpand:function(node){
            $('#ttmenu').tree('options').url=path+"/menu/listmenus?parent_id="+node.id;
            return true;
        },
        onClick:function(node){
            $(this).tree('toggle', node.target);
            //如果获得的url为#，则表示该目录下有分目录，反之则获取url加载
            if(node.url!="#" && node.url!=""){
                checknode(node.id);
            }

        }
    });
});
function checknode(menuid){
    $.ajax({
        type: "POST",
        url: path+"/menu/getUrlData",
        data: {
            menu_id:menuid
        },
        dataType: "text",
        beforeSend: function(XMLHttpRequest){
            $("<div class=\"datagrid-mask\" style=\"display:block\"></div>").css({width:"100%",height:"100%"}).appendTo($(document.body));
            return true;
        },
        //如果返回数据为空，页面加载空，有则直接加载返回的url内容
        success: function(responseData, textStatus){
            if(/^(null|undefined|#)$/.test(responseData)){
                document.getElementById("mframe").src="";
            } else {
                document.getElementById("mframe").src=path+"/"+responseData;
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