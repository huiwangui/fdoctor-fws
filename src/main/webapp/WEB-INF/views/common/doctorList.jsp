<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医生</title>
<head>
<meta charset="utf-8">
<title>医生</title>
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

<body style="background-color: gainsboro;">
	<div style="margin: 0px; background-color: white;">

		<blockquote class="layui-elem-quote">
			<form class="layui-form" action="">
				<div class="layui-inline">

					<label class="layui-form-label">医生姓名</label>
					<div class="layui-input-inline">
						<input type="text"  class="layui-input" id="doctor_name"/>
					</div>
				</div>

				<div class="layui-inline">
					<div class="layui-form-item" style="margin-top: 20px">
						<div class="layui-inline"
							style="width: 10%; margin-left: 0px; float: left">
							<div class="layui-input-inline">
								<button class="layui-btn layui-btn-radius" style="width: 100%"
									id="selectButton" type="button">查询</button>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-inline">
					<div class="layui-form-item" style="margin-top: 20px">
						<div class="layui-inline"
							style="width: 10%; margin-left: 0px; float: left">
							<div class="layui-input-inline">
								<button class="layui-btn layui-btn-radius" style="width: 100%"
									id="choose_button" type="button">确认选择</button>
							</div>
						</div>
					</div>
				</div>




			</form>
		</blockquote>
		<div id="content" style="width: 100%; height: 500px;"></div>
	</div>

	<script>
		layui.use([ 'layer', 'jquery', 'form' ], function() {
			var layer = layui.layer;
			$ = layui.jquery;
			layerTips = parent.layer === undefined ? layui.layer
					: parent.layer, //获取父窗口的layer对象
			form = layui.form();
			
			$form = $('form');

		})
		
		function tableConfig() {
			
			layui.config({
				base : '/FWS/statics/beginnerAdmin/js/'
			}).use([ 'btable', 'layer' ], function() {
				var layer = layui.layer;
				var btable = layui.btable(), $ = layui.jquery;
				//layer.config({
					//id : Math.ceil(100)	//防止重复弹窗
				//});
			
				btable.set({
					elem : '#content',
					url : '/FWS/common/getDoctorList',
					pageSize : 10,
					columns : [ {
						fieldName : '编号',
						field : 'id',
						hidden : true
					}, {
						fieldName : '医生姓名',
						field : 'docName'
					}, {
						fieldName : '所属机构',
						field : 'orgName',
						colRender : 'nullRender'
					}],
					even : true,
					//skin: 'row',
					checkbox : true,
					singleSelect : true,
					field : 'ID',
					paged : true,
					params : {
						doctorName : $('#doctor_name').val()
					},
				});
				btable.render();

				$(window).on('resize', function(e) {
					var $that = $(this);
					$('#content').height($that.height() - 92);
				}).resize();
				
				
				$('#choose_button').on('click', function(){
					btable.getSelections(function (obj) {
		            	if(obj.count == 0){
		            		layer.msg('请选择一条数据！',{icon: 7,id : Math.ceil(100)});
		            	}else{
		            		parent.$('#' + '${idContainerId}').val(obj.elem[0].context.cells[1].innerHTML);
		            		parent.$('#' + '${nameContainerId}').text(obj.elem[0].context.cells[2].innerHTML);
		            		
		            		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		            		parent.layer.close(index); //再执行关闭   
		            	}
		            });
				});
				
			});
		}

		tableConfig();

		//查询按钮声明点击事件，查询逻辑
		$('#selectButton').on('click', function() {
			tableConfig();
		});
		
		function nullRender(data){
			if(data == 'null' || data == null){
				return '-';
			}else{
				return data;
			}
		}
		

	</script>
</body>
</html>