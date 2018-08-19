<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人资料</title>
<head>
<meta charset="utf-8">
<title>个人资料</title>
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
	<input id="img_head_url" type="hidden" value="<%=imgHeadUrl%>">
	<fieldset class="layui-elem-field layui-field-title"
		style="margin-top: 5px; margin-left: 5px; margin-right: 5px">
		<legend>个人信息 </legend>
	</fieldset>
	<input type="hidden" id="webServerIp" value="<%=imgHeadUrl%>">
	<form class="layui-form" action="" id="dataForm">
		<div class="layui-form-item">
			<div class="layui-inline" style="width: 60%">
				<div class="layui-form-item">
					<label class="layui-form-label">医生姓名</label>
					<div class="layui-input-block">
						<span></span> <input name="name" class="layui-input" type="text"
							id="name" value="${sessionScope.doc_session.docName}"
							disabled="disabled">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">所属医院</label>
					<div class="layui-input-block">
						<input name="name" class="layui-input" type="text" id="name"
							value="${sessionScope.doc_session.orgName}" disabled="disabled">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">所属科室</label>
					<div class="layui-input-block">
						<input name="name" class="layui-input" type="text" id="name"
							value="${sessionScope.doc_session.deptName}" disabled="disabled">
					</div>
				</div>
				
				<input type="hidden" id="update_mobile_flag_hidden">

				<div class="layui-inline" style="width: 40%">
					<div class="layui-form-item">
						<label class="layui-form-label">手机号码</label>
						<div class="layui-input-block">
							<input name="label" class="layui-input" type="text"
								id="phone_number" value="${sessionScope.doctorInfo.phoneNumber}"
								width="50%" disabled="disabled">
						</div>
					</div>
				</div>

				<div class="layui-inline" style="width: 30%"
					id="before_update_mobile_div">
					<div class="layui-form-item">
						<button class="layui-btn layui-btn-primary" type="button"
							id="update_mobile_button">修改手机号</button>
					</div>
				</div>
				<div class="layui-inline" style="width: 15%; display: none;"
					id="after_update_mobile_div">
					<div class="layui-form-item">
						<button class="layui-btn layui-btn-primary" type="button"
							id="send_sms">发送验证码</button>
					</div>
				</div>
				
				<div class="layui-inline" style="width: 15%; display: none;"
					id="cancel_update_mobile_div">
					<div class="layui-form-item">
						<button class="layui-btn layui-btn-primary" type="button"
							id="cancle_update_mobile_button">取消修改</button>
					</div>
				</div>
					
				<div class="layui-form-item" style="display: none" id="sms_code_div">
					<label class="layui-form-label">验证码</label>
					<div class="layui-input-block">
						<input name="name" class="layui-input" type="text" id="sms_code">
					</div>
				</div>

			</div>
			<div class="layui-inline" style="margin-left: 50px; width: 30%">
				<div class="layui-form-item" style="width: 230px; height: 230px">
					<div class="site-demo-upload">
						<input type="hidden" id="img_url"
							value="${sessionScope.doc_session.img}"> <img
							id="LAY_demo_upload"
							src="<%=imgHeadUrl%>${sessionScope.doc_session.img}" width="100%"
							height="100%">
						<div class="site-demo-upbar">
							<input name="file" class="layui-upload-file" id="img" type="file">
						</div>
					</div>
				</div>

			</div>
			<div class="layui-form-item" style="width: 90%">
				<label class="layui-form-label">擅长领域</label>
				<div class="layui-input-block">
					<input name="specialty" class="layui-input" type="text"
						id="specialty" value="${sessionScope.doctorInfo.specialty}">
				</div>
			</div>
			<div class="layui-form-item" style="width: 90%">
				<label class="layui-form-label">医生简介</label>
				<div class="layui-input-block">
					<textarea placeholder="请输入内容" class="layui-textarea"
						id="introduction">${sessionScope.doctorInfo.introduction}</textarea>
				</div>
			</div>
		</div>

		<hr>

		<div align="center">
			<button
				class="layui-btn layui-btn-big layui-btn-primary layui-btn-radius"
				type="button" id="save_button">
				<i class="layui-icon">&#xe618;</i>确认保存
			</button>
		</div>
	</form>


	<div id="menuContent" class="menuContent"
		style="display: none; position: absolute;">
		<ul id="deptTree" class="ztree"></ul>
	</div>

</body>
<script type="text/javascript">
	$('#update_mobile_flag_hidden').val(false);

	//初始化表单控件
	layui.use([ 'jquery', 'form', 'laydate', 'upload' ], function() {
		$ = layui.jquery;
		form = layui.form();
		var laydate = layui.laydate;

		layui.upload({
			url : '${fws}/common/imgUpload',
			elem : '#img' //指定原始元素，默认直接查找class="layui-upload-file"
			,
			method : 'post' //上传接口的http类型
			,
			success : function(res) {
				LAY_demo_upload.src = $('#webServerIp').val() + res.data;
				$('#img_url').val(res.data);
			}
		});

		//修改手机号点击事件
		$("#update_mobile_button").on(
				'click',
				function() {
					//清空电话号码框，并设置为可以填写
					$('#phone_number').val('');
					$('#phone_number').removeAttr('disabled');
					//显示验证码div
					$('#sms_code_div').attr('style', '');
					$('#phone_number').attr('placeholder', '请输入新手机号');
					//隐藏修改手机号按钮
					$('#before_update_mobile_div').attr('style',
							'width: 30%; display: none;');
					//显示发送验证码   和取消修改按钮
					$('#after_update_mobile_div').attr('style', 'width: 15%;');
					$('#cancel_update_mobile_div').attr('style', 'width: 15%;');
					
					//修改电话标识置为true，后台修改时需进行验证码判断
					$('#update_mobile_flag_hidden').val(true);
		});

		
		//取消修改手机号点击事件
		$("#cancle_update_mobile_button").on(
				'click',
				function() {
					//电话号码输入框重新设置值为session中的值
					$('#phone_number').val('${sessionScope.doctorInfo.phoneNumber}');
					$('#phone_number').attr('disabled', 'disabled');
					//显示验证码div
					$('#sms_code_div').attr('style', 'display: none;');
					//隐藏修改手机号按钮
					$('#before_update_mobile_div').attr('style',
							'width: 30%;');
					//显示发送验证码   和取消修改按钮
					$('#after_update_mobile_div').attr('style', 'display: none;');
					$('#cancel_update_mobile_div').attr('style', 'display: none;');
					
					//修改电话标识置为false，后台修改时不需要进行验证码判断
					$('#update_mobile_flag_hidden').val(false);
		});

		
		//发送验证码
		$('#send_sms').on('click', function() {
			if ($("#phone_number").val() == null || $("#phone_number").val() == '') {
				layer.tips('请输入手机号', '#phone_number', {
					time : 3000,
					tipsMore : true
				});
				return;
			} else {
				var reg = /^1[3|4|5|7|8]\d{9}$/;
				if (!reg.test($("#phone_number").val())) {
					layer.tips('请输入正确的手机号', '#phone_number', {
						time : 3000,
						tipsMore : true
					});
					return;
				}
			}
			$.ajax({
				type : 'GET',
				url : '${fws}/common/sendSmsCode',
				async: false,
				data : {
					mobile : $("#phone_number").val()
				},
				success : function(data) {
					//计时120秒内不能重新发送
					var count = 120;
					var countdown = setInterval(CountDown, 1000);

					$("#send_sms").attr("class", "layui-btn layui-btn-disabled");
					$("#send_sms").attr("disabled", "disabled");

					$("#send_sms").text("剩余(" + count + "s)");

					function CountDown() {
						$("#send_sms").text("剩余(" + (count - 1) + "s)");
						if (count == 1) {
							$("#send_sms").attr('class', "layui-btn layui-btn-primary");
							$("#send_sms").attr("disabled", "false");
							$("#send_sms").text("发送验证码");

							window.clearInterval(countdown);
						}
						count--;
					}
				}
			});
		});
		
		//修改保存按钮
		$('#save_button').on('click', function(){
			
			if($('#update_mobile_flag_hidden').val() && ($('#sms_code').val == null || $('#sms_code').val == '')){
				layer.msg('请输入验证码！');
				return;
			}
			
			$.ajax({
				type : 'POST',
				url : '${fws}/updateDoctorUser',
				async: false,
				data : {
					phoneNumber : $("#phone_number").val(),
					img : $("#img_url").val(),
					specialty : $("#specialty").val(),
					introduction : $("#introduction").val(),
					smsCode : $('#sms_code').val(),
 					mobileFlag : $('#update_mobile_flag_hidden').val(),
					userName : '${sessionScope.doc_session.userName}',
					id : '${sessionScope.doc_session.doctorId}'
				},
				success : function(data) {
					if(data.code == '200'){
						parent.layer.msg('保存成功！');
						parent.userInfoReset($('#img_head_url').val() + $("#img_url").val());
						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index); //再执行关闭
						
					}else{
						layer.msg(data.msg);
					}
				},
				error : function(data){
					layer.msg('保存失败！');
				}
			});
		})
	});
</script>
</html>