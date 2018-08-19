<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>解约记录查询</title>
<head>
    <meta charset="utf-8">
    <title>解约记录查询</title>
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
    
				<div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
					<label class="layui-form-label">关键字</label>
					<div class="layui-input-inline">
						<input type="text" id="personName" name="personName" lay-verify="required"
							placeholder="请输入姓名" autocomplete="off" class="layui-input">
					</div>
				</div>
				
				
			    
			    <div class="layui-inline" style="width: 20%;" style="margin-left: 0px;float:left" >
			    <div class="layui-form-item" align="left" style="margin-left: 0px;float:left" >
				    <div class="layui-input-inline">
				      <select name="surrenderStatus" lay-verify="" id="surrenderStatus">
						  <option value="">-请选择-</option>
						  <option value="1">审核中</option>
						  <option value="2">已拒绝</option>
						  <option value="3">已解约</option>
						</select>     
				    </div>
			    </div>
			  </div>
			  
			  <div class="layui-inline" style="width: 20%;" style="margin-left: 0px;float:left" >
			    <label class="layui-form-label" style="width: 30px;" ></label>
			    	 <div class="layui-input-inline">
			    	<button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
			    	</div>
			    </div>
			  
			</form>
        </blockquote>
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
                
                btable.set({
                    elem: '#content',
                    url: '/FWS/signAdmin/querySurrenderInfo',
                    pageSize: 10,
                    columns: [{
                        fieldName: '编号',
                        field: 'personId',
                        hidden:	true
                    }, {
                        fieldName: '姓名',
                        field: 'personName',
                        colRender : 'personNameRender'
                    }, {
                        fieldName: '性别',
                        field: 'sex',
                        colRender : 'sexRender'
                    }, {
                        fieldName: '年龄',
                        field: 'age',
                        colRender : 'ageRender'
                    }, {
                        fieldName: '住址',
                        field: 'currentAddress',
                        colRender : 'adrRender'
                    },  {
                        fieldName: '状态',
                        field: 'status',
                        colRender : 'statusRender'
                    }, {
                        fieldName: '操作',
                        field: 'surrenderMap',
                        colRender : 'crRender'
                    } ],
                    even: true,
                    //skin: 'row',
                    checkbox: true,
                    field: 'id',
                    paged: true,
                    params : getParams(),
                });
                btable.render();

                $(window).on('resize', function (e) {
                    var $that = $(this);
                    $('#content').height($that.height() - 92);
                }).resize();
                
            });
    	}
    	
    	tableConfig();
    
    	//查询按钮声明点击事件，查询逻辑
        $('#selectButton').on('click', function(){
        	tableConfig();
        });
    	
  
		     
		    
       
        function getParams(){
        	console.log('${sessionScope.doctorInfo.teamId}')
        	var params = {
        		docTeamId :'${sessionScope.doctorInfo.teamId}',
        		personName : $('#personName').val().trim(),
        		status: $('#surrenderStatus').val()
 			   	}
        	return params;
        }
        
        function ageRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        
        function personNameRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        
        function adrRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        
        function sexRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        
        function statusRender(data){
        	if(data == '1'){
        		return '审核中';
        	}else if(data == '2'){
        		return '已拒绝';
        	}else if(data == '3'){
        		return '已解约';
        	}else{
        		return data;
        	}
        }
        
        function crRender(data){
        	var map=eval(data);
        	var status= map.status
        	var id=map.id
        	console.log(status)
        	if(status == '1'){
        		return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="goHand('+id+','+status+')" >详情</button>';
        	}else if(status == '2'){
        		return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="goHand('+id+','+status+')" >详情</button>';
        	}else if(status == '3'){
        		return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="surrenderDetail('+id+','+status+')" >详情</button>';
        	}else{
        		return '';
        	} 
        }
	     
	     
    </script>
   <script type="text/javascript">
   function  goHand(id,status){
	 var index = layer.open({
				    type: 2
		   		    ,scrollbar: true
		   		    ,fixed: true //不固定
				   	,area: 'auto'
				   	, maxmin: true 
				   	,skin: 'layui-layer-rim' //加上边框
		   	        ,title :'解约详情'
			   	    ,content: '${fws}/signAdmin/surrenderHandling?id='+id+'&status='+status
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
	 layer.full(index);  
   }
   
   function  surrenderDetail(id,status){
		 var index = layer.open({
					    type: 2
			   		    ,scrollbar: true
			   		    ,fixed: true //不固定
					   	,area: 'auto'
					   	, maxmin: true 
					   	,skin: 'layui-layer-rim' //加上边框
			   	        ,title :'解约详情'
				   	    ,content: '${fws}/signAdmin/surrenderDetail?id='+id+'&status='+status
			   	        ,btnAlign: 'c' //按钮居中
			   	        ,shade: 0 //不显示遮罩
			   	       
			   	      });
		 layer.full(index);  
	   }
   </script>
</body>
</html>