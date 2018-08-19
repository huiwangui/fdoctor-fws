<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="fws" value="${pageContext.request.contextPath}"/>
<c:set var="fwsStatic" value="${pageContext.request.contextPath}/statics/beginnerAdmin"/>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>健康管理医生工作站</title>
    <link rel="stylesheet" href="${fwsStatic}/plugins/layui/css/layui.css">
    <link rel="stylesheet" href="${fwsStatic}/css/style.css">
    <link rel="stylesheet" href="/FWS/statics/css/work.css" />
    <link rel="icon" href="${fws}/statics/images/code.png">
    <link rel="stylesheet" href="/FWS/statics/css/login.css" />
</head>

<body onkeydown="keyLogin();">
		<!-- <div class="wrap">
			<div class="bg2"></div>
			<div class="loginUser">
				<div class="t">
					<img src="/FWS/statics/image/login/redWork.png" alt="" />
					<span class="span2">健康管理医生工作站</span>
				</div>
				<h3>登录</h3>
				<form class="userPass">
					<input type="text" name="account" id="account" value="" class="userName"/> <br />
					<input type="password" name="password" id="password" value="" class="password"/>
					<div class="fr ">
						<a type="button" id="loginButton" class="loginBtn2" lay-submit="" lay-filter="sub">登录</a>
					</div>
				</form>
			</div>
			<div class="msg_detail">
				<p>
					健康管理医生工作站是针对家庭医生服务所开发的一个资源整合、统一高效的医生工作平台。在签约医生团队和居民之间建立一套健康管理体系，使签约医生团队可以随时关注居民的身体健康，并最大化提升医生的工作效率。
				</p>
			</div>
		</div> -->
		
		
		<div class="header">
			<span></span>
			<img src="/FWS/statics/image/login/logo1.png" alt="" />
		</div>
				
		
		<div class="main1">
			<div class="login_box">
				<div class="title tc">
					<h4>用户登录</h4>
					<h5>LOGIN</h5>
				</div>
				<div class="content">
					<form action="">
						<div style="margin-top: 10%; " class="clearfix">
							<span class="left_icon1" style="height: 49px"></span>
							<input type="text" name="account" id="account" value="" placeholder="用户名" class="username"/>
						</div>
						<div class="clearfix">
							<span class="left_icon2" style="height: 49px"></span>
							<input type="password" name="password" id="password" value=""  placeholder="密码" class="password"/>
						</div>
					<!-- 	<div class="chk">
							<label >
								<input type="checkbox" name="" id="" value=""  />  记住密码
							</label>
						</div> -->
						<div style="margin-top:5%" >
							<a  class="login_btn" id="loginButton" lay-submit="" lay-filter="sub" style="cursor: pointer;">登录</a>
						</div>
						<!-- <div >
							<a href="javascript:;" class="forget_pws">忘记密码？</a>
						</div> -->
					</form>
				</div>
			</div>
		</div>
		
		<div class="bottom tc">
			<ul class="other_link">
				<li>
					<a href="/">版权声明</a>
				</li>
				<li>
					<a href="/">法律责任</a>
				</li>
				<li>
					<a href="/">隐私声明</a>
				</li>
				<li style="border-right: 1px solid #aaa;">
					<a href="/" >联系我们</a>
				</li>
			</ul>
			<p>
				地址：成都市成华区双庆路10号华润大厦7楼 邮编： 610000 Copyright@ 2017 - 2版权所有
			</p>
			<p>
				建议使用IE8及以上版本浏览器 川ICP备 09003078号
			</p>
		</div>
	</body>
	<script type="text/javascript">
		//这段是控制屏幕大小变化时候html的根字体大小 百分比形势
		(function (doc, win) {
		var docEl = doc.documentElement,
		resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
		recalc = function () {
		var clientWidth = docEl.clientWidth;
		if (!clientWidth) return;
		docEl.style.fontSize = 20 * (clientWidth / 3600) + 'px';
		};
		
		if (!doc.addEventListener) return;
		win.addEventListener(resizeEvt, recalc, false);
		doc.addEventListener('DOMContentLoaded', recalc, false);
		})(document, window);
	</script>
	<script type="text/javascript">
		//这段是控制屏幕大小变化时候html的根字体大小 百分比形势
		(function (doc, win) {
		var docEl = doc.documentElement,
		resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
		recalc = function () {
		var clientWidth = docEl.clientWidth;
		if (!clientWidth) return;
		docEl.style.fontSize = 20 * (clientWidth / 3600) + 'px';
		};
		
		if (!doc.addEventListener) return;
		win.addEventListener(resizeEvt, recalc, false);
		doc.addEventListener('DOMContentLoaded', recalc, false);
		})(document, window);
	</script>
<script src="${fws}/statics/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${fwsStatic}/plugins/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer'], function () {

        // 操作对象
        var form    = layui.form()
            ,layer  = layui.layer
            ,$      = layui.jquery;

        // 验证
        form.verify({
            account: function (value) {
                if (value == "") {
                    return "请输入用户名";
                }
            },
            password: function (value) {
                if (value == "") {
                    return "请输入密码";
                }
            }
        });

        // 提交监听
        form.on('submit(sub)', function (data) {
        	if( $('#account').val().trim()==''||$('#password').val().trim()==''){
        		layer.msg("账户密码不能为空")
        		return;
        	}else{
        	var data=data.field
        	console.log(data)
        	$.ajax({
        		scriptCharset: 'utf-8',
				type : 'POST',
				url : '/FWS/docLogin',
				data : {
					username : $('#account').val(),
					password : $('#password').val()
					
				},
				success : function(a) {
					if (a.code == 200) {
						layer.msg('登录成功，正在跳转到工作站');
						setTimeout(function(){
							location.href = "/FWS/indexPage";
						},200);
					} else {
						layer.msg(a.msg);
					}
				}
			});
          }
        }); 
       
        
    })
 function keyLogin(){ 
    if (event.keyCode==13)  //回车键的键值为13 
       document.getElementById("loginButton").click(); //调用登录按钮的登录事件 
    } 
</script>
</body>
</html>