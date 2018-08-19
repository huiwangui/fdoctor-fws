<%@page import="com.boco.common.utils.PropertiesUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报告信息</title>
<head>
    <meta charset="utf-8">
    <title>报告信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/btable.css" />
    
    <script type="text/javascript" src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
    <% String webServerIp=PropertiesUtils.getValue("ftp_web_server_ip"); %>  
</head>

<body style=" background-color: gainsboro;">
 
   <div>
    <span>上传检查检验报告照片</span>
   <div id="img"></div>
   </div>
   <br>
     <div>
      <span>报告描述</span>
      <span>${userReportVo.reportDescription}</span>
     </div>
	   <br>
    <div>
     <span>报告拍片日期</span>
     <span>${time}</span>
    </div>
  <script language="javascript"> 
	str ='${userReportVo.img}'; 
	var strs= new Array();  
	strs=str.split(",");
	var ip='<%=webServerIp%>';
	var imgs=''
	for (i=0;i<strs.length ;i++ ) 
	{ 
	imgs+='<img alt="" src="'+ip+'/'+strs[i]+'">';
	console.log(imgs)
	} 
    $('#img').append(imgs)
</script>    
    
</body>
</html>