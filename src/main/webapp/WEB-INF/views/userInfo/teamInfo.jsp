<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>团队信息</title>
<head>
<meta charset="utf-8">
<title>团队信息</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">

<link rel="stylesheet"
	href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css"
	media="all" />
<link rel="stylesheet"
	href="/FWS/statics/beginnerAdmin/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/btable.css" />
<link rel="stylesheet" href="/FWS/statics/css/global.css" />

<script type="text/javascript"
	src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>

</head>

<body>
	<fieldset class="layui-elem-field layui-field-title"
		style="margin-top: 5px; margin-left: 5px; margin-right: 5px">
		<legend>我的团队 </legend>
	</fieldset>
	<form class="layui-form" action="" id="dataForm">
		<c:forEach items="${teamInfo}" var="teamItem">
			<div class="layui-form-item">
				<div class="layui-inline" style="margin-left: 50px; width: 5%">
					<div class="layui-form-item" style="width: 100px; height: 100px">
						<div class="site-demo-upload">
							<c:choose>
								<c:when test="${empty teamItem.img}">
									<img src="${fws}/statics/image/defaultImg.png" alt=""
										id="head_img" />
								</c:when>
								<c:otherwise>
									<img src="<%=imgHeadUrl%>${teamItem.img}" alt="" id="head_img" />
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<div class="layui-inline" style="margin-left: 50px; width: 50%">
					<div class="layui-inline">
						${teamItem.docName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${teamItem.sex == '1'}">男</c:if>
						<c:if test="${teamItem.sex == '2'}">女</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${teamItem.docType == '1'}">医生</c:if>
						<c:if test="${teamItem.docType == '2'}">公卫医生</c:if>
						<c:if test="${teamItem.docType == '3'}">护士</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${teamItem.phoneNumber}
					</div>

					<div class="layui-form-item">${teamItem.orgName}</div>
					<div class="layui-form-item">简介：${teamItem.introduction}</div>
				</div>
			</div>
		</c:forEach>
	</form>

</body>
<script type="text/javascript">
	//初始化表单控件
	layui.use([ 'jquery', 'form', 'laydate', 'upload' ], function() {
		$ = layui.jquery;
		form = layui.form();
		var laydate = layui.laydate;
	});
</script>
</html>