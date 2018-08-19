<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>高血压删除列表</title>
<head>
<meta charset="utf-8">
<title>高血压删除列表</title>
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
			选择高血压随访记录删除
		</blockquote>
		<div class="layui-btn-group">
		  <button class="layui-btn layui-btn-primary layui-btn-small" id="deletebutton">
		    <i class="layui-icon">&#xe640;</i>删除选中随访
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
					url : '/FWS/hypertension/queryFollowUpHistory',
					type: 'GET',
					pageSize : 6,
					columns : [ {
						fieldName : '随访编号',
						field : 'ID',
						hidden : true
					},  {
						fieldName : '姓名',
						field : 'PersonName'
					}, {
						fieldName : '随访时间',
						field : 'FollowUpDateStr'
					} , {
						fieldName : '随访医生',
						field : 'DoctorName'
					} ],
					even : true,
					//skin: 'row',
					checkbox : true,
					singleSelect : true,
					field : 'ID',
					paged : true,
					params : getParams(),
				});
				btable.render();

				$(window).on('resize', function(e) {
					var $that = $(this);
					$('#content').height($that.height() - 92);
				}).resize();
				
				
				//新增体检
				$('#deletebutton').on('click', function() {
					btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择一条记录！',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		layer.msg('确认删除？', {
                    			icon: 3,
                    			time: 0, //不自动关闭,
                    			btn: ['是', '否'],
                    			yes: function(index){
                    				$.ajax({
                    				    type: 'POST',
                    				    url: '/FWS/hypertension/deleteHypertension' ,
                    				    data: {
                    				    	ID: obj.ids[0]
                    				    } ,
                    				    success: function(data){
                    				    	if(data.code == '200'){
                    				    		tableConfig();
                    				    		layer.msg('删除成功！', {
                    								icon: 1
                    							});
                    				    	}else{
                    							layer.msg('删除失败！', {
                    								icon: 2
                    							});
                    				    	}
                    				    }
                    				});
                    			}
                    		});
                    	}
                    });
				});
			});
		}

		tableConfig();

		function getParams() {
			//获取所有参数
			var params = {
				PersonID : '${PersonID}'
			}
			
			return params;
		}
		
		
 }) 

	</script>
</body>
</html>