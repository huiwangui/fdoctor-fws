<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人糖尿病随访历史</title>
<head>
    <meta charset="utf-8">
    <title>个人糖尿病随访历史</title>
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
        </form>
        </blockquote>
		<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary layui-btn-small" id="detailButton"><i class="layui-icon">&#xe642;</i>随访详情</button>
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
                    url: '/FWS/diabetes/personalHistoryNext2',
                    type: 'GET',
                    pageSize: 15,
                    columns: [{
                        fieldName: 'ID',
                        field: 'ID',
                        hidden: true
                    },{
                        fieldName: '姓名',
                        field: 'PersonName'
                    },{
                        fieldName: '随访时间',
                        field: 'FollowUpDateStr'
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
                    },,{
                    	fieldName: '心理调整',
                        field: 'PsychologicalAdjustmentStr'
                    },{
                    	fieldName: '遵医行为',
                        field: 'ComplianceBehaviorStr'
                    },{
                    	fieldName: '服药',
                        field: 'MedicationComplianceStr'
                    },{
                    	fieldName: '低血糖',
                        field: 'LowBloodSugarReactionsStr'
                    },{
                    	fieldName: '随访结局',
                        field: 'FollowUpLiteRemarks'
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
                
                $('#detailButton').on('click', function () {
                    //获取选择的数据
                    btable.getSelections(function (obj) {
                    	//console.log(obj.elem[0].context.cells[2].innerHTML);
                    	var PersonID="${PersonID}";
                    	if(obj.count == 0){
                    		layer.msg('请选择要修改的随访记录',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		layer.open({
                         		  type: 2,
                         		  title: false,
                         		  id : Math.ceil(100),
                         		  area: ['900px', '600px'],
                         		  closeBtn: 1,
                         		  content: '/FWS/diabetes/detailFollowup?ID='+obj.ids[0]+'&PersonID='+PersonID
                          	});
                    	}
                    });

                });
                
                $(window).on('resize', function (e) {
                    var $that = $(this);
                    $('#content').height($that.height() - 92);
                }).resize();
                
            });
    		
    	}
    	//是否进入就查询
    	tableConfig();
    
    	//查询按钮声明点击事件，查询逻辑
            $('#selectButton').on('click', function(){
            	tableConfig();
            });	
  	  	
        function packParams(){
        	
        	
    		var param = {
    				PersonID:"${PersonID}"
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
</body>
</html>