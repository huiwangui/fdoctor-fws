<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>体检列表</title>
<head>
<meta charset="utf-8">
<title>体检列表</title>
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
			个人体检列表
		</blockquote>
		<div class="layui-btn-group">
		  <button class="layui-btn layui-btn-primary layui-btn-small" id="detail_button">
		    <i class="layui-icon">&#xe60a;</i>
		    查看详情
		  </button>
		</div>
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
					url : '/FWS/examination/getPersonExamList',
					pageSize : 10,
					columns : [ {
						fieldName : '编号',
						field : 'OLDPEOPLEID',
						hidden : true
					}, {
						fieldName : '居民ID',
						field : 'PERSONID',
						hidden : true
					}, {
						fieldName : '姓名',
						field : 'NAME'
					}, {
						fieldName : '体检年龄',
						field : 'AGE'
					}, {
						fieldName : '性别',
						field : 'GENDER'
					}, {
						fieldName : '体检日期',
						field : 'FOLLOW_UP_DATE'
					} , {
						fieldName : '医生',
						field : 'DOCTOR_NAME',
						colRender : 'nullRender'
					} ],
					even : true,
					//skin: 'row',
					checkbox : true,
					singleSelect : true,
					field : 'OLDPEOPLEID',
					paged : true,
					params : {
						personId : '${personId}'
					},
				});
				btable.render();

				$(window).on('resize', function(e) {
					var $that = $(this);
					$('#content').height($that.height() - 92);
				}).resize();
				
				//详情按钮
				$('#detail_button').on('click', function() {
					btable.getSelections(function (obj) {
						console.log(obj);
                    	if(obj.count == 0){
                    		layer.msg('请选择要查看的数据',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		var url = '/FWS/examination/examDetailPage?examId=' + obj.ids[0] + '&personId=' + obj.elem[0].context.cells[2].innerHTML;
                    		layer.open({
                    			title : '体检详情',
                    			id : Math.ceil(100),
								type: 2,
								area: ['70%', '80%'],
								fixed: false, //不固定
								maxmin: true,
								content: url
                    		});
                    		
                    	}
                    });
				});
			});
		}

		tableConfig();
		
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