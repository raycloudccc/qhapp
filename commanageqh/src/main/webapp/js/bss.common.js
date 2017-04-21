function GoEnterPage() {
    var e = jQuery.Event("keydown");
    e.keyCode = 13;
    $("input.pagination-num").trigger(e);
}

function gridSearch(formid,tabid,url){
	var json = $("#"+formid).form2json();
	$('#'+tabid).datagrid('getPager').pagination('loading');
	var pageSize=$('#'+tabid).datagrid('getPager').pagination('options').pageSize;
	var pageNumber=$('#'+tabid).datagrid('getPager').pagination('options').pageNumber;
	var pp="pageNo="+pageNumber+"&pageSize="+pageSize;
	$('#'+tabid).datagrid('options').url=url+"?"+pp;
	$('#'+tabid).datagrid('options').queryParams=json;
	$("#"+tabid).datagrid('reload');
	$('#'+tabid).datagrid('getPager').pagination('loaded');
}

$.fn.form2json = function(){
    var serializedParams = this.serialize();
    serializedParams=decodeURIComponent(serializedParams,true);
    //return serializedParams;
    var obj = paramString2obj(serializedParams);
    return obj;
    //return JSON.stringify(obj);
};

function paramString2obj(serializedParams) {
	var obj={};
    function evalThem (str) {
        var attributeName = str.split("=")[0];
        var attributeValue = str.split("=")[1];
        if(!attributeValue){
            return ;
        }
         
        var array = attributeName.split(".");
        for (var i = 1; i < array.length; i++) {
            var tmpArray = Array();
            tmpArray.push("obj");
            for (var j = 0; j < i; j++) {
                tmpArray.push(array[j]);
            };
            var evalString = tmpArray.join(".");
            // alert(evalString);
            if(!eval(evalString)){
                eval(evalString+"={};");                
            }
        };
     
        eval("obj."+attributeName+"='"+attributeValue+"';");
         
    };
 
    var properties = serializedParams.split("&");
    for (var i = 0; i < properties.length; i++) {
        evalThem(properties[i]);
    };
 
    return obj;
}

function jumpUrl(url){
	document.location.href=url;
}

function getURL(urlstr,param,pane){
	//showLoading(pane);
	$.ajaxSetup({cache:false});
	$.ajax({
			type: "post",
			url: urlstr,
			data:param,
			beforeSend: function(XMLHttpRequest){
				//
			},
			success: function(responseData, textStatus){
				document.getElementById(pane).innerHTML=responseData;
				$.parser.parse('#'+pane);
			},
			complete: function(XMLHttpRequest, textStatus){
				//HideLoading();
			},
			error: function(){
				//请求出错处理
			}
	});
}

function commonFunction(){
	var cycle=new Object;
	cycle.getFormData=function(formId){
		var params = jQuery("#"+formId).serialize()+"&_random_n="+Math.random();
		//params = decodeURIComponent(params,true); 
		//alert(params);
		return params;
	};
	return cycle;
}
var cycle=commonFunction();

$.fn.datebox.defaults.formatter = function(v) {
	if (v instanceof Date) {
		var y = v.getFullYear();
		var m = v.getMonth() + 1;
		if (m < 10) {
			m = "0" + m;
		}
		var d = v.getDate();
		if (d < 10) {
			d = "0" + d;
		}
		var h = v.getHours();
		if (h < 10) {
			h = "0" + h;
		}
		var i = v.getMinutes();
		if (i < 10) {
			i = "0" + i;
		}
		var s = v.getSeconds();
		var ms = v.getMilliseconds();
		if (ms > 0)
			return y + '-' + m + '-' + d + ' ' + h + ':' + i + ':' + s + '.'+ ms;
		if (h > 0 || i > 0 || s > 0)
			return y + '-' + m + '-' + d + ' ' + h + ':' + i + ':' + s;
		return y + '-' + m + '-' + d;
	}
	return '';
};

function submitForm(frmid){
	var rtstr= $('#'+frmid).form('validate');
	if(rtstr){
		$('#'+frmid).submit();
	}
}

function jump(url){
	window.location.href=url;
	//document.location.href=url;
}