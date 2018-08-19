<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../views/include/taglib.jsp"%>
<!DOCTYPE html>

<html>

<head>
<meta charset="utf-8">
<title>健康管理医生工作站</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">

<link rel="stylesheet" href="${fwsStatic}/plugins/layui/css/layui.css"
	media="all" />
<link rel="stylesheet" href="${fwsStatic}/css/global.css" media="all">
<link rel="stylesheet"
	href="${fwsStatic}/plugins/font-awesome/css/font-awesome.min.css">
<link rel="shortcut icon" type="image/x-icon"
	href="/FWS/statics/image/bitbug_favicon.ico" media="screen" />
</head>

<body>
	<input id="img_head_url" type="hidden" value="<%=imgHeadUrl%>">
	<div class="layui-layout layui-layout-admin"
		style="border-bottom: solid 5px #1aa094;">
		<div class="layui-header header header-demo" style="background: url('/FWS/statics/image/FWSbanner.png') left center no-repeat; background-size: cover;">
			<div class="layui-main">
				<div class="admin-login-box">
					<!-- <div class="admin-side-toggle">
						<i class="fa fa-bars" aria-hidden="true"></i>
					</div>
					<div class="admin-side-full">
						<i class="fa fa-life-bouy" aria-hidden="true"></i>
					</div> -->
				</div>
				
				<ul class="layui-nav admin-header-item" style="">
					<!-- <li class="layui-nav-item">
							<a href="javascript:;">清除缓存</a>
						</li> -->
					<!-- <li class="layui-nav-item">
							<a href="http://182.151.199.4:8104/BRHP/index.jsp" target="view_window">家庭医生工作站首页</a>
						</li> -->
					<div class="admin-side-toggle" style="left:-80px !important;">
						<i class="fa fa-bars" aria-hidden="true"></i>
					</div>
					<div class="admin-side-full" style="left:-30px !important;">
						<i class="fa fa-life-bouy" aria-hidden="true"></i>
					</div>
					<li class="layui-nav-item"><a href="javascript:;"
						class="admin-header-user"> <c:choose>
								<c:when test="${empty sessionScope.doc_session.img}">
									<img src="${fws}/statics/image/defaultImg.png" alt=""
										id="head_img" />
								</c:when>
								<c:otherwise>
									<img src="<%=imgHeadUrl%>${sessionScope.doc_session.img}"
										alt="" id="head_img" />
								</c:otherwise>
							</c:choose> <span id="userNameSpan">${sessionScope.doc_session.userName}</span>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:void(0)" onclick="showDoctorInfo()"><i
									class="layui-icon">&#xe614;</i>&nbsp;个人信息</a>
							</dd>
							<dd>
								<a href="javascript:void(0)" onclick="showTeamInfo()"><i
									class="layui-icon">&#xe613;</i>&nbsp;我的团队</a>
							</dd>
							<dd>
								<a href="javascript:void(0)" onclick="updatePassword()"><i
									class="fa fa-user-circle" aria-hidden="true"></i>&nbsp;修改密码</a>
							</dd>
							<dd>
								<a href="${fws}/logout"><i class="fa fa-sign-out"
									aria-hidden="true"></i>&nbsp;注销</a>
							</dd>
						</dl></li>
				</ul>
				
				<ul class="layui-nav admin-header-item-mobile">
					<li class="layui-nav-item"><a href="login.html"><i
							class="fa fa-sign-out" aria-hidden="true"></i> 注销</a></li>
				</ul>
			</div>
		</div>
		<div class="layui-side layui-bg-black" id="admin-side">
			<div class="layui-side-scroll" id="admin-navbar-side"
				lay-filter="side"></div>
		</div>
		<div class="layui-body"
			style="bottom: 0; border-left: solid 2px #1AA094;" id="admin-body">
			<div class="layui-tab admin-nav-card layui-tab-brief"
				lay-filter="admin-tab">
				<ul class="layui-tab-title">
					<li class="layui-this"><i class="fa fa-dashboard"
						aria-hidden="true"></i> <cite>控制面板</cite></li>
				</ul>
				<div class="layui-tab-content"
					style="min-height: 150px; padding: 5px 0 0 0;">
					<div class="layui-tab-item layui-show">
						 <iframe src="/FWS/mainPage"></iframe>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-footer footer footer-demo" id="admin-footer">
			<div class="layui-main">
				<p>
					2017 &copy; <a href="">亿阳信通</a> 健康管理医生工作站管理  version 1.0.0
				</p>
			</div>
		</div>
		<div class="site-tree-mobile layui-hide">
			<i class="layui-icon">&#xe602;</i>
		</div>
		<div class="site-mobile-shade"></div>

		<!--锁屏模板 start-->
		<script type="text/template" id="lock-temp">
				<div class="admin-header-lock" id="lock-box">
					<div class="admin-header-lock-img">
						<img src="http://182.151.199.4:8115/upload/img/default.jpg"/>
					</div>
					<div class="admin-header-lock-name" id="lockUserName">beginner</div>
					<input type="text" class="admin-header-lock-input" value="输入密码解锁.." name="lockPwd" id="lockPwd" />
					<button class="layui-btn layui-btn-small" id="unlock">解锁</button>
				</div>
			</script>
		<!--锁屏模板 end -->

		<script type="text/javascript"
			src="${fws}/statics/beginnerAdmin/plugins/layui/layui.js"></script>
		<script>
			var $;
			layui.use('layer', function() {
				$ = layui.jquery, layer = layui.layer;
				
			});
			
			//打开修改医生个人信息弹窗
			function showDoctorInfo() {
				layer.open({
					type : 2,
					area : [ '70%', '70%' ],
					fixed : false, //不固定
					maxmin : true,
					content : '${fws}/doctorInfoPage',
					title : '医生信息'
				});
			}
			
			//打开团队信息弹窗
			function showTeamInfo() {
				layer.open({
					type : 2,
					area : [ '50%', '70%' ],
					fixed : false, //不固定
					maxmin : true,
					content : '${fws}/teamInfoPage',
					title : '团队信息'
				});
			}
			
			//医生个人信息修改成功后改变头像地址
			function userInfoReset(src){
				$('#head_img').attr('src', src);
			}
			
			//修改密码
			function updatePassword(){
				layer.prompt({title: '请输入原始密码', formType: 1}, function(oldpass, index){
					layer.close(index);
					layer.prompt({title: '请输入新密码', formType: 1}, function(newpass, index){
						layer.close(index);
						layer.prompt({title: '确认新密码', formType: 1}, function(confirmPass, index){
							layer.close(index);
							if(newpass != confirmPass){
								layer.alert('确认密码输入有误！', {
									icon: 2
								})
							}else{
								$.ajax({
									type : 'POST',
									url : '${fws}/updatePassword',
									data : {
										password : oldpass,
										newPassword : newpass,
										userName : '${sessionScope.doc_session.userName}'
									},
									success : function(data) {
										//提示消息
										if(data.code == 200){
											layer.alert('修改密码成功，请重新登录！', {
												icon: 1
											});
											
											//跳转到登录页面
											setTimeout(function (){
												window.location.href = '${fws}/logout';
											}, 1500);
										}else{
											layer.alert(data.msg, {
												icon: 5
											})
										}
									},
									error : function(){
										layer.alert('修改密码失败！', {
											icon: 2
										})
									}
								});
							}
						});;
					});
				});
			}

			//var navs = eval('(' + '${ sessionScope.user_in_session.menuJson}' + ')');
			var userName = '${sessionScope.doctorInfo.userName}'
			console.log('${fws}')
			var navs = [
					{
						"title" : "签约管理",
						"icon" : "fa-cubes",
						"spread" : true,
						"children" : [ {
							"title" : "签约记录",
							"icon" : "&#xe641;",
							"href" : "${fws}/signAdmin/signRecord"
						}, {
							"title" : "去签约",
							"icon" : "&#xe63c;",
							"href" : "${fws}/signAdmin/goSign"
						}, {
							"title" : "解约记录",
							"icon" : "&#xe63c;",
							"href" : "${fws}/signAdmin/surrenderRecord"
						} ]
					},
					{
						"title" : "预约服务",
						"icon" : "&#xe606;",
						"spread" : false,
						"children" : [
								{
									"title" : "预约随访",
									"icon" : "fa-table",
									"href" : "${fws}/appointment/followPlan?userName="
											+ userName
								},
								{
									"title" : "预约免疫",
									"icon" : "fa-navicon",
									"href" : "${fws}/appointment/immunity?userName="
											+ userName
								},
								{
									"title" : "预约体检",
									"icon" : "&#xe62a;",
									"href" : "${fws}/appointment/examination?userName="
											+ userName
								} ]
					}, {
						"title" : "健康管理",
						"icon" : "&#xe62e;",
						"spread" : true,
						"children" : [ {
							"title" : "我的居民",
							"icon" : "&#xe613;",
							"href" : "${fws}/resident/golist"
						}, {
							"title": "健康评估",
							"icon": "&#xe630;",
							"href":"${fws}/physicleAssessment/goList"
						}, {
							"title": "群发关怀",
							"icon": "&#xe609;",
							"href":"${fws}/massCare/goIndex"
						}, {
							"title": "在线问诊",
							"icon": "&#xe63a;",
							"href":"${fws}/im/imPage"
						}]
					} ,
					{
						"title" : "公共卫生",
						"icon" : "&#xe62a;",
						"spread" : true,
						"children" : [
							{
								"title": "家庭档案",
								"icon": "&#xe63c;",
								"href":"${fws}/famliy/indexList"
							},
							{
								"title": "居民档案",
								"icon": "&#xe60a;",
								"href":"${fws}/famliy/healthRecord/healthIndex"	
							},{
								"title": "居民健康体检",
								"icon": "&#xe636;",
								"href":"${fws}/examination/examinationPage"
							},{
								"title": "老年人体检",
								"icon": "&#xe63f;",
								"href":"${fws}/oldExamination/examinationPage"
							},{
								"title": "糖尿病随访",
								"icon": "&#xe636;",
								"href":"${fws}/diabetes/toIndex"
							},{
								"title": "高血压随访",
								"icon": "&#xe62c;",
								"href":"${fws}/hypertension/toIndex"
							}]
					}];
		</script>
		<script src="${fws}/statics/beginnerAdmin/js/index.js"></script>
	</div>
</body>

</html>