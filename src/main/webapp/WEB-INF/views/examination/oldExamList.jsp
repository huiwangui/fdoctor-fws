<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>老年人体检列表</title>
<head>
<meta charset="utf-8">
<title>老年人体检列表</title>
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
					<label class="layui-form-label" style="text-align:left">体检日期</label>
					<div class="layui-input-inline">
						<input type="text" name="start_follow_up_date"
							id="start_follow_up_date" lay-verify="date" placeholder=""
							autocomplete="off" class="layui-input"
							onclick="layui.laydate({elem: this})">
					</div>
					--
					<div class="layui-input-inline">
						<input type="text" name="end_follow_up_date"
							id="end_follow_up_date" lay-verify="date" placeholder=""
							autocomplete="off" class="layui-input"
							onclick="layui.laydate({elem: this})">
					</div>

					<div id="layui-form-item" style="margin-top: 10px">
						<div class="layui-input-inline">
							<select id="key_value_type">
								<option value="1">姓名或拼音</option>
								<option value="2">身份证号</option>
								<option value="3">档案号</option>
							</select>
						</div>
						：
						<div class="layui-input-inline">
							<input type="text" id="key_value" class="layui-input">
						</div>
					</div>
				</div>



				<div class="layui-inline">
					
					<div class="layui-form-item" style="margin-top: 10px">
						<label class="layui-form-label">是否完善：</label>
						<div class="layui-input-inline">
							<select id="is_perfect">
								<option value="-1">请选择</option>
								<option value="0">是</option>
								<option value="1">否</option>
							</select>
						</div>
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




			</form>
		</blockquote>
 		<div class="layui-btn-group" style="margin-left:20px;"> 
 			<button class="layui-btn layui-btn-primary layui-btn-small" id="add_button"><i class="layui-icon">&#xe654;</i>新增随访</button>
		    <button class="layui-btn layui-btn-primary layui-btn-small" id="update_button"><i class="layui-icon">&#xe642;</i>编辑随访</button>
		    <button class="layui-btn layui-btn-primary layui-btn-small" id="delete_button"><i class="layui-icon">&#xe640;</i>删除</button>
 			
		 <!--  <button class="layui-btn layui-btn-primary layui-btn-small" id="add_button">
		    <i class="layui-icon">&#xe654;</i>
		  </button>
		  <button class="layui-btn layui-btn-primary layui-btn-small" id="update_button">
		    <i class="layui-icon">&#xe642;</i>
		  </button>
		  <button class="layui-btn layui-btn-primary layui-btn-small" id="delete_button">
		    <i class="layui-icon">&#xe640;</i>
		  </button> -->
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

			form.on('select(isperson)', function(data) {
				//当选择‘慢病患者’时，显示慢病种类下拉框
				if(data.value == '4'){
					$('#type_div').attr('style','margin-top: 10px');
				}else{
					$('#type').val('0');
					$('#type_div').attr('style','margin-top: 10px;visibility: hidden');
					form.render('select');
				}
			});
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
					url : '/FWS/oldExamination/getOldExamList',
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
						fieldName : '性别',
						field : 'GENDER'
					}, {
						fieldName : '体检年龄',
						field : 'AGE'
					}, {
						fieldName : '身份证号',
						field : 'CARD_ID',
					}, {
						fieldName : '联系电话',
						field : 'TELPHONE',
						colRender : 'nullRender'
					}, {
						fieldName : '体检日期',
						field : 'FOLLOW_UP_DATE'
					}, {
						fieldName : '是否完善',
						field : 'PERFECT',
						colRender : 'perfectRender'
					}],
					even : true,
					//skin: 'row',
					checkbox : true,
					singleSelect : true,
					field : 'OLDPEOPLEID',
					paged : true,
					params : getParams(),
				});
				btable.render();

				$(window).on('resize', function(e) {
					var $that = $(this);
					$('#content').height($that.height() - 92);
				}).resize();
				
				//修改按钮
				$('#update_button').on('click', function() {
					btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择要修改的数据',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		if(obj.elem[0].context.cells[7].innerHTML == '-'){
                    			layer.msg('该居民暂无体检信息！', {
        							icon: 7,
        							id : Math.ceil(100)
        						});
                    			return;
                    		}
                    		
                    		var url = '/FWS/examination/updateExaminationPage?personId=' + obj.elem[0].context.cells[2].innerHTML + '&examId=' + 
                    				obj.elem[0].context.cells[1].innerHTML + '&examDate=' + obj.elem[0].context.cells[8].innerHTML;
                    		layer.open({
                    			title : '修改体检',
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
				
				//新增体检
				$('#add_button').on('click', function() {
					btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择一位居民！',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		layer.open({
                    			title : '新增体检',
                    			id : Math.ceil(100),
								type: 2,
								area: ['70%', '80%'],
								fixed: false, //不固定
								maxmin: true,
								content: '/FWS/examination/toAddExamination?personId=' + obj.elem[0].context.cells[2].innerHTML
                    		});
                    	}
                    });
				});
				
				//删除体检
				$('#delete_button').on('click', function() {
					btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择一条记录！',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		layer.msg('确认删除？', {
                    			icon: 3,
                    			time: 0, //不自动关闭,
                    			btn: ['是', '否'],
                    			yes: function(index){
                    				layer.close(index);
                    				var loadIndex = layer.load(1); //加载层
                    				$.ajax({
                    				    type: 'POST',
                    				    url: '/FWS/examination/deleteExamination' ,
                    				    data: {
                    				    	examId : obj.elem[0].context.cells[1].innerHTML
                    				    } ,
                    				    success: function(data){
                    				    	layer.close(loadIndex);
                    				    	if(data.code == '200'){
                    				    		tableConfig();
                    				    		layer.msg('删除成功！', {
                    								icon: 1
                    							});
                    				    	}else{
                    							layer.msg('删除失败：' + data.msg, {
                    								icon: 2
                    							});
                    				    	}
                    				    },
                    				    error : function(){
                    				    	layer.close(loadIndex);
                    				    	layer.msg('删除失败！', {
                								icon: 2
                							});
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

		//查询按钮声明点击事件，查询逻辑
		$('#selectButton').on('click', function() {
			tableConfig();
		});
		
		function getParams() {
			//获取所有参数
			var params = {
				FollowUpDateS : $('#start_follow_up_date').val(),
				FollowUpDateE : $('#end_follow_up_date').val(),
				KeyValueType : $('#key_value_type').val(),
				KeyValue : $('#key_value').val(),
				IsPerfect : ($('#is_perfect').val() != '-1') ? $('#is_perfect').val() : null 
			}
			//将参数转化为字符串
			var strParam = {
				paramJson : JSON.stringify(params)
			}
			return strParam;
		}
		
		function nullRender(data){
			if(data == 'null' || data == null){
				return '-';
			}else{
				return data;
			}
		}
		
		function perfectRender(data){
			if(data == 0){
				return '否';
			}else if(data == 1){
				return '是';
			}else{
				return '-';
			}
		}

	</script>

	<script>
		layui.use('laydate', function() {
			var laydate = layui.laydate;

			var start = {
				min : '2010-01-01 00:00:00',
				max : '2099-06-16 23:59:59',
				istoday : false,
				choose : function(datas) {
					end.min = datas; //开始日选好后，重置结束日的最小日期
					end.start = datas //将结束日的初始值设定为开始日
				}
			};

			var end = {
				min : '2010-01-01 00:00:00',
				max : '2099-06-16 23:59:59',
				istoday : false,
				choose : function(datas) {
					start.max = datas; //结束日选好后，重置开始日的最大日期
				}
			};
		});
	</script>
</body>
</html>