<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>糖尿病随访</title>
<head>
    <meta charset="utf-8">
    <title>糖尿病随访</title>
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

<body style=" background-color: gainsboro;">

    <div style="margin:0px; background-color: white;">
        <blockquote class="layui-elem-quote">
        <form class="layui-form" action="">
        	<input type="hidden" id="regionCode" name="regionCode" value="${regionCode}">
        	<div class="" align="left" style="margin:10px 0">
			  	<div class="layui-inline"  >
				  	<label class="layui-form-label" style="text-align:left;"> 随访日期：</label>
				  	
					<div class="layui-input-inline">
						<input type="text" name="StartFollowupDate"
							id="StartFollowupDate" lay-verify="date" placeholder=""
							autocomplete="off" class="layui-input"
							onclick="layui.laydate({elem: this})">
					</div>
					<span style="">--</span>
					<div class="layui-input-inline">
						<input type="text" name="EndFollowupDate"
							id="EndFollowupDate" lay-verify="date" placeholder=""
							autocomplete="off" class="layui-input"
							onclick="layui.laydate({elem: this})">
					</div>
			  	</div>
			  	
			  	<div class="layui-inline" >
			    <label class="layui-form-label" > 是否随访：</label>
					<div class="layui-input-inline" style="width: 115px;">
						<select name="IsFollowup" id="IsFollowup" lay-verify="" >
							<option value="0" selected="true">否</option>
							<option value="1" >是</option>
						</select>	
					</div>     
			    </div>
			    </div>
			    
			 	<div class="layui-inline" >
					<div class="layui-input-inline" style="width: 115px;">
						<select name="KeyValueType" id="KeyValueType" lay-verify="">
							<option value="1" selected="true">姓名或拼音</option>
							<option value="2">身份证</option>
							<option value="3">档案号</option>
						</select>
					</div>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" name="KeyValue" id="KeyValue" value="" class="layui-input"/>
					</div>
				</div>
				
				<div class="layui-inline" >
				<label class="layui-form-label"  >随访方式：</label>
				<div class="layui-input-inline" style="width: 115px;">
					<select name="FollowupType" id="FollowupType" lay-verify="">
						<option value="1">门诊</option>
						<option value="2">家庭</option>
						<option value="4">电话</option>
						<option value="-1" selected="true">全部</option>
					</select>
					</div>
				</div>
				
				<div class="layui-inline" >
				<label class="layui-form-label"  >是否完善：</label>
				<div class="layui-input-inline" style="width: 115px;">
					<select name="Perfect" id="Perfect" lay-verify=""> 
						<option value="0" selected="true">是</option>
						<option value="1" >否</option>
					</select>
				</div>
				</div>
				
			    
			    <div class="layui-inline" >
			    	 <div class="layui-input-inline">
			    	<button class="layui-btn layui-btn-radius" style="width: 150px;margin-left: 50px;" id="selectButton" type="button">查询</button>
			    	</div>
			    </div>
			    
			 </div>
			</form>
        </blockquote>
		<div class="layui-btn-group" style="margin-left:20px;">
		<button class="layui-btn layui-btn-primary layui-btn-small" id="addButton"><i class="layui-icon">&#xe654;</i>新增随访</button>
		 <button class="layui-btn layui-btn-primary layui-btn-small" id="updateButton"><i class="layui-icon">&#xe642;</i>编辑随访</button>
		 <button class="layui-btn layui-btn-primary layui-btn-small" id="deleteButton"><i class="layui-icon">&#xe640;</i>删除</button>
		 <button class="layui-btn layui-btn-primary layui-btn-small" id="curveButton"><i class="layui-icon">&#xe64a;</i>随访曲线</button>
		</div>
        <div id="content" style="width: 100%;height: 500px;"></div>
    </div>

    <script>

    
    
    	function tableConfig(){
    		layui.config({
                base: '/FWS/statics/beginnerAdmin/js/'
            }).use(['btable','layer'], function () {
                var layer = layui.layer;
                
                var btable = layui.btable(),
                    $ = layui.jquery;
                
                //layer.config({
                	//id : Math.ceil(100)	//防止重复弹窗
                //});
                btable.set({
                    elem: '#content',
                    url: '/FWS/diabetes/followupList',
                    type: 'GET',
                    pageSize: 15,
                    columns: [{
                        fieldName: 'ID',
                        field: 'ID',
                        hidden: true
                    },{
                        fieldName: 'PersonID',
                        field: 'PersonID',
                        hidden: true
                    },{
                        fieldName: '姓名',
                        field: 'PersonName'
                    },{
                        fieldName: '随访时间',
                        field: 'FollowUpDateStr'
                    },{
                        fieldName: '方式',
                        field: 'WayUpStr'
                    },{
                        fieldName: '症状',
                        field: 'SymptomLiteStr'
                    },{
                        fieldName: '收缩压',
                        field: 'Sbp',
                        colRender : 'typeRenderA'
                    },{
                        fieldName: '舒张压',
                        field: 'Dbp',
                        colRender : 'typeRenderA'
                    },{
                        fieldName: '空腹血糖(mmol/L)',
                        field: 'FastingBloodGlucose',
                        colRender : 'typeRenderA'
                    },{
                    	fieldName: '食量(g)',
                        field: 'Staple',
                        colRender : 'typeRenderA'
                    },{
                    	fieldName: '心理调整',
                        field: 'PsychologicalAdjustmentStr'
                    },{
                    	fieldName: '遵医行为',
                        field: 'ComplianceBehaviorStr'
                    },{
                    	fieldName: '服药',
                        field: 'MedicationComplianceStr'
                    },{
                    	fieldName: '药物反应',
                        field: 'AdverseDrugReactionsStr'
                    },{
                    	fieldName: '低血糖',
                        field: 'LowBloodSugarReactionsStr'
                    },{
                    	fieldName: '随访结局',
                        field: 'FollowUpLiteRemarks'
                    },{
                    	fieldName: '随访分类',
                        field: 'FuClassificationStr'
                    },{
                    	fieldName: '随访医生',
                        field: 'DoctorName'
                    },{
                    	fieldName: '是否完善',
                        field: 'Perfect',
                        colRender : 'typeRenderB'
                    }],
                    even: true,
                    //skin: 'row',
                    checkbox: true,
                    field: 'ID',
                    paged: true,
                    singleSelect: true,
                    params : packParams(),
                });
                btable.render();
                
                $('#updateButton').on('click', function () {
                    //获取选择的数据
                    btable.getSelections(function (obj) {                   
                    	if(obj.count == 0){
                    		layer.msg('请选择要修改的随访记录',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		var PersonID=obj.elem[0].context.cells[2].innerHTML;
                    		layer.open({
                         		  type: 2,
                         		  title: false,
                         		  id : Math.ceil(100),
                         		  area: ['900px', '600px'],
                         		  closeBtn: 1,
                         		  content: '/FWS/diabetes/updateFollowup?ID='+obj.ids[0]+'&PersonID='+PersonID
                          	});
                    	}
                    });

                });
                
                
                $('#deleteButton').on('click', function () {
                    //获取选择的数据
                    btable.getSelections(function (obj) {                 
                    	if(obj.count == 0){
                    		layer.msg('请选择一条的随访记录',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    	  	var PersonID=obj.elem[0].context.cells[2].innerHTML;
                    		layer.open({
                         		  type: 2,
                         		  title: false,
                         		  id : Math.ceil(100),
                         		  area: ['600px', '400px'],
                         		  closeBtn: 1,
                         		  content: '/FWS/diabetes/toDelete?&PersonID='+PersonID
                          	});
                    	}
                    });

                });
                
                
                $('#addButton').on('click', function () {
                	 //获取选择的数据
                    btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择要新增随访的人员选择一条随访记录',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		var PersonID=obj.elem[0].context.cells[2].innerHTML;
                    		layer.open({
                         		  type: 2,
                         		  title: false,
                         		  id : Math.ceil(100),
                         		  area: ['900px', '600px'],
                         		  closeBtn: 1,
                         		  content: '/FWS/diabetes/saveFollowup?ID='+obj.ids[0]+'&PersonID='+PersonID
                          	});
                    	}
                    });
                });
                
                $('#curveButton').on('click', function () {
                	//获取选择的数据
                    btable.getSelections(function (obj) {                  
                    	if(obj.count == 0){
                    		layer.msg('请根据居民选择一条对应的随访数据',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		var PersonID=obj.elem[0].context.cells[2].innerHTML;
                    		layer.open({
                         		  type: 2,
                         		  title: false,
                         		  id : Math.ceil(100),
                         		  area: ['900px', '500px'],
                         		  closeBtn: 1,
                         		  content: '/FWS/diabetes/diabetesCurve?PersonID='+PersonID
                          	});
                    	}
                    })
                });
                
                

               $(window).on('resize', function (e) {
                    var $that = $(this);
                    $('#content').height($that.height() - 92);
                }).resize();
                
            });
    		
    	
    		
    		
    	}
    	//是否进入就查询
    	//tableConfig();
    
    	//查询按钮声明点击事件，查询逻辑
            $('#selectButton').on('click', function(){
            	tableConfig();
            });	
  	  	
        function packParams(){
        	
        	
    		var param = {
    			KeyValueType: $('select[name=KeyValueType]').val(),
  	   		    KeyValue: $('#KeyValue').val(),
  	   		   	StartFollowupDate: $('#StartFollowupDate').val(),
  	   		    EndFollowupDate:$('#EndFollowupDate').val(),
  	   		    IsFollowup: $('select[name=IsFollowup]').val(),
  	   		    FollowupType: $('select[name=FollowupType]').val(),
  	   		    Perfect: $('select[name=Perfect]').val(),
  			    RegionCode:$('#regionCode').val(),
    		}
    		return param;
    	}
        
        layui.use('form', function(){
        	  var form = layui.form();
        });
        function typeRenderA(data){
        	if(data == null){
        		return '';
        	}else{
        		return data;
        	}
        }
        function typeRenderB(data){
        	if(data == '1'){
        		return '完善';
        	}else{
        		return '不完善';
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