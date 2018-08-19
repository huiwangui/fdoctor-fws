
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

<script type="text/javascript"
	src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
</head>
<body>

	<form class="layui-form" action="">
		<div class="layui-form-item" pane="">
			<label class="layui-form-label">签约服务包</label><br> <br>
			<div class="layui-input-block">
				<c:forEach items="${packs}" var="pack" varStatus="status">
					<div class="layui-inline">
						<div style="float: left">
							<input type="checkbox" name="packval" lay-skin="primary"
								title="${pack.packName}" value="${pack.packValue}">
						</div>
						<label class="layui-form-label" style="color: red; width: 120px">金额：¥${pack.packPrice}/年</label>

						<c:if test="${pack.packType=='1'}">
							<label style="color: red" class="layui-form-label">基础服务</label>
						</c:if>
						<c:if test="${pack.packType=='2'}">
							<label style="color: red" class="layui-form-label">增值服务</label>
						</c:if>
					</div>
					<br>
				</c:forEach>
			</div>
		</div>

		<hr>
		<div class="layui-form-item" pane="">
			<label class="layui-form-label">签约年限</label>
			<div class="layui-input-block">
				<input type="radio" name="term" value="1" title="一年"> <input
					type="radio" name="term" value="2" title="两年" checked=""> <input
					type="radio" name="term" value="3" title="三年">
			</div>
		</div>
		<hr>

		<hr>
		<hr>
		<hr>
		<span style="margin-left: 40px;">${vo.personName}<a
			style="color: red;"></a> &nbsp;&nbsp;${vo.sex}&nbsp;&nbsp; ${vo.age}岁
			&nbsp;&nbsp; 身份证号： ${vo.idCard}
		</span><br>
		<div class="layui-form-item">
			<label class="layui-form-label">医疗标签</label>
			<div class="layui-input-block" id="ylbq">
				<div class="ylbq">
					<input type="hidden" name="personId" value="${vo.personId}">
					<input type="checkbox" name="bq" title="高血压" value="2"> <input
						type="checkbox" name="bq" title="糖尿病" value="4"> <input
						type="checkbox" name="bq" title="儿童" value="8"> <input
						type="checkbox" name="bq" title="重性精神病" value="16"> <input
						type="checkbox" name="bq" title="老年人" value="32"> <input
						type="checkbox" name="bq" title="普通成人" value="64"> <input
						type="checkbox" name="bq" title="孕产妇" value="128">
				</div>
			</div>
		</div>

		<input type="button" onclick="myFunction()" value="验证医疗标签"
			style="margin-left: 40px;" />
		<hr>
		<hr>







	</form>

	<fieldset class="layui-elem-field layui-field-title"
		style="margin-top: 50px;">
		<legend>用户手持证件上传</legend>
	</fieldset>

	<div class="site-demo-upload">
		<input type="hidden" id="imgUrl"> <img id="LAY_demo_upload"
			src="/FWS/statics/beginnerAdmin/images/0.jpg">
		<div class="site-demo-upbar" style="margin-top: 5px">
			<input type="file" name="file" lay-type="file"
				class="layui-upload-file" id="file">
		</div>
	</div>

	<hr>
	<br>
	<br>
	<br>
	<br>
	<div class="layui-form-item">
		<div class="layui-input-block" style="margin-left: 0 !important;">
			<button type="button" class="layui-btn layui-btn-normal"
				id="saveButton">确认签约</button>
		</div>
	</div>
	<div style="color: red;">备注：确认签约后不能再次签约！</div>
	<script src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"
		charset="utf-8"></script>
	<script type="text/javascript">
		function myFunction() {
			var lableValue = parseInt("${labelValue}");
			var list = new Array();
			var j = 0;
			for (var i = 10; i > 0; i--) {
				if (lableValue >= Math.pow(2, i)) {
					list[j] = Math.pow(2, i);
					lableValue = lableValue % Math.pow(2, i);
					j++;
				}
			}

			var result = "";
			var checkbox = document.all('bq');
			if (checkbox.length == undefined) {//一个选项时
				if (checkbox.checked)
					result = result + checkbox.title + "、";
			} else {
				for (var i = 0; i < checkbox.length; i++) {//多个选项时
					if (checkbox[i].checked)
						result = result + checkbox[i].title + "、";
				}
			}
			result = result.replace("普通成人、", "");

			for (var i = 0; i < list.length; i++) {
				switch (list[i]) {
				case 2:
					result = result.replace("高血压、", "");
					break;
				case 4:
					result = result.replace("糖尿病、", "");
					break;
				case 8:
					result = result.replace("儿童、", "");
					break;
				case 16:
					result = result.replace("重性精神病、", "");
					break;
				case 32:
					result = result.replace("老年人、", "");
					break;
				case 128:
					result = result.replace("孕产妇、", "");
					break;
				default:
					break;
				}
			}
			if ("" != result) {
				result = result.substring(0, result.length - 1);
			}

			if ("" == result) {
				alert("通过！可以签约");
				return true;
			} else {
				alert("对不起，您不能为此人选择“" + result
						+ "”标签，请先在基卫系统建档，在此之前，请选择无或者其它标签。");
				return false;
			}
		}

		//初始化表单控件
		layui
				.use(
						[ 'jquery', 'form', 'upload' ],
						function() {
							$ = layui.jquery;
							form = layui.form();

							layui
									.use(
											'upload',
											function() {
												layui
														.upload({
															url : '/FWS/signAdmin/uploadUserSignByDocFWS',
															elem : '#file' //指定原始元素，默认直接查找class="layui-upload-file"
															,
															method : 'post' //上传接口的http类型
															,
															type : 'images',
															success : function(
																	res) {
																console
																		.log('上传成功')
																console
																		.log(res)
																$(
																		'#LAY_demo_upload')
																		.attr(
																				'src',
																				res.data.src);
																$('#imgUrl')
																		.val(
																				res.data.src);
															}
														});
											});

							//"{'userName':'医生登录用户名','familyId':'签约家庭ID','img':'图片file对象','servicePackValue':'所选服务包权值','endDate':'签约有效期截止时间戳','agreementNum':'签约协议号','labelJson':'人员和标签对应json'}")
							//封装签约参数

							$('#saveButton')
									.on(
											'click',
											function() {
												if (!myFunction()) {
													return;
												}
												var lableJson = []

												//获取标签权值
												$(".ylbq")
														.each(
																function(i) {
																	var map = {}
																	var totalValue = 0;
																	$(this)
																			.find(
																					'input:checkbox')
																			.each(
																					function() {
																						var that = $(this);
																						if (that
																								.is(':checked')) {
																							var ckvalue = parseInt(that
																									.val());
																							totalValue += ckvalue;

																						}
																					});
																	if (totalValue === 0) {
																		totalValue = 1;
																	}

																	var personId = $(
																			this)
																			.find(
																					'input[name="personId"]')
																			.val();
																	map['personId'] = personId;
																	map['value'] = totalValue;
																	lableJson
																			.push(map)
																	console
																			.log(map)
																})

												console.log(lableJson)
												//获取服务包权值
												var sum = 0;

												$(
														"input[name='packval']:checked")
														.each(
																function() {
																	sum += parseInt($(
																			this)
																			.val());
																});

												console.log(sum)
												if (sum == 0 || sum == null) {
													layer.msg("请选择服务包！")
												}

												var img = $('#imgUrl').val();
												if (img == '' || img == null) {
													layer.msg("上传手持证件照！")
													return;
												}
												layer
														.confirm(
																'确认保存？',
																{
																	icon : 3
																},
																function(index) {
																	$
																			.ajax({
																				type : 'POST',
																				url : '/FWS/signAdmin/saveDoctorSign',
																				data : {
																					userName : '${sessionScope.doc_session.userName}',
																					personId : '${vo.personId}',
																					img : $(
																							'#imgUrl')
																							.val(),
																					servicePackValue : sum,
																					term : $(
																							"input[name='term']:checked")
																							.val(),
																					labelJson : JSON
																							.stringify(lableJson)
																				},
																				success : function(
																						data) {
																					if (data.code == 200) {
																						layer
																								.msg(
																										'保存成功！',
																										{
																											icon : 1
																										});
																						parent
																								.tableConfig();
																						//   var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
																						//  parent.layer.close(index);
																					} else {
																						layer
																								.msg(
																										'保存失败：'
																												+ data.msg,
																										{
																											icon : 2
																										});
																					}
																				},
																				error : function(
																						data) {
																					console
																							.log("ERROR")
																				}
																			});
																});
											});

						});
	</script>
</body>
</html>