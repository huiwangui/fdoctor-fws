<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的居民签约居民查询</title>
<head>
    <meta charset="utf-8">
    <title>签约居民记录查询</title>
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
      
		  
        <div class="layui-inline">
	      <label class="layui-form-label">日期</label>
	      <div class="layui-input-inline">
	        <input type="text" name="date" id="date1" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
	      </div>--
	      <div class="layui-input-inline">
	        <input type="text" name="date" id="date2" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
	      </div>
        </div>
    
		  
		 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
						 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
				    	 </div>
					</div>
			 </div>
		  </div>  
		  
		    <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
						 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButtonzhou" type="button">本周</button>
				    	 </div>
					</div>
			 </div>
		  </div>  
		  
		    <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
						 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButtonyue" type="button">本月</button>
				    	 </div>
					</div>
			 </div>
		  </div>  
			 
		
		 
		 
			 
			</form>
        </blockquote>
        <div id="content" style="width: 100%;height: 500px;"></div>
    </div>

    <script>
    
    var zy='zy'
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
                url: '/FWS/resident/getAllUserReportByDoc',
                pageSize: 10,
                columns: [ {
                    fieldName: '上传者',
                    field: 'upName',
                    colRender : 'personNameRender'
                   
                }, {
                    fieldName: '上传日期',
                    field: 'uptimeStr',
                    
                },{
                    fieldName: '描述',
                    field: 'reportDescription',
                    
                },{
                    fieldName: '操作',
                    field: 'tid',
                    colRender : 'crRender'
                }],
                even: true,
                //skin: 'row',
                checkbox: false,
                singleSelect: true,
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
    	zy='zy'
    	tableConfig();
    });
    $('#selectButtonzhou').on('click', function(){
    	zy='1'
    	tableConfig();
    });
    
    $('#selectButtonyue').on('click', function(){
    	zy='30'
    	tableConfig();
    });
    
    
    
    
    function getParams(){
    	var params = {
    		personId:'${personId}',
    		date1:$("#date1").val().trim(),
    		date2:$("#date2").val().trim(),
    		zy:zy
			   	}
    	return params;
    }
   
    function crRender(data){
    	
    	return '<a onclick="getDetail(\''+data+'\')">详情</a>'
    	
    }
    
  function personNameRender(data){
    	console.log(data)
	  if(data=='null'||data==''||data==undefined){
			return '上传者未知'
		} else if(data=="null"||typeof (data)=="undefined"||data==null){
			'上传者未知'
	  }else{
		return data
	  }
    	
    }
    
    
    function getDetail(id){
 	   
   	 layer.open({
   		    type: 2
     			,area: ['560px', '430px']
     	        ,title :'报告详情'
   	   	    ,content: '${fws}/resident/getDetail?tid='+id
   	   	     
   		});		
   	   
   	   
   	   
      } 
    </script>
    
  
   
    <script>
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  
	  var start = {
	    min: '2010-01-01 00:00:00'
	    ,max: '2099-06-16 23:59:59'
	    ,istoday: false
	    ,choose: function(datas){
	      end.min = datas; //开始日选好后，重置结束日的最小日期
	      end.start = datas //将结束日的初始值设定为开始日
	    }
	  };
	  
	  var end = {
		 min: '2010-01-01 00:00:00'
	    ,max: '2099-06-16 23:59:59'
	    ,istoday: false
	    ,choose: function(datas){
	      start.max = datas; //结束日选好后，重置开始日的最大日期
	    }
	  };
	  
	  document.getElementById('date1').onclick = function(){
	    start.elem = this;
	    laydate(start);
	  }
	  document.getElementById('date2').onclick = function(){
	    end.elem = this
	    laydate(end);
	  }
	  
	});
</script>
</body>
</html>