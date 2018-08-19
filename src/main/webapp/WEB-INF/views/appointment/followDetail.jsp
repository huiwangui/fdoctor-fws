
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>签约详情</title>
<head>
    <meta charset="utf-8">
    <title>签约处理</title>
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
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>随访详情</legend>
</fieldset>  
 
<table class="layui-table" lay-even="" lay-skin="nob">
  <colgroup>
    <col width="150">
    <col width="150">
    <col width="200">
    <col>
  </colgroup>
  <thead>
    <tr>
      <th></th>
      <th></th>
    </tr> 
  </thead>
  <tbody>
    <tr>
      <td>订单编号</td>
      <td>${ovo.orderNumber}</td>
    </tr>
    <tr>
      <td>订单时间</td>
      <td>${ovo.createTimeStr}</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>随访单位</td>
      <td>${ovo.hospitalName}</td>
    </tr>
    <tr>
      <td>随访地址</td>
      <td>${ovo.hospitalAddress}</td>
    </tr>
    <tr>
      <td>随访项目</td>
      <td>${ovo.projectName}</td>
    </tr>
    <tr>
      <td>随访时间</td>
      <td>${ovo.timestr}</td>
    </tr>
    <tr>
      <td>随访人</td>
      <td>${ovo.patientName}  &nbsp;&nbsp;${ovo.sex}&nbsp;&nbsp;${ovo.age}岁</td>
    </tr>
    <tr>
      <td>联系电话</td>
      <td>${ovo.phone}</td>
    </tr>
    <tr>
      <td>家庭住址</td>
      <td>${ovo.personAddress}</td>
    </tr>
  </tbody>
</table> 
         
</body>
</html>