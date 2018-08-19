<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预约记录查询</title>
<head>
    <meta charset="utf-8">
    <title>预约记录查询</title>
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
			    <label class="layui-form-label" style="width: 30px;" ></label>
			    	 <div class="layui-input-inline">
			    	<button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
			    	</div>
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
                
                //layer.config({
                	//id : Math.ceil(100)	//防止重复弹窗
                //});

                btable.set({
                    elem: '#content',
                    url: '/FWS/signAdmin/getNotSignMasterforwork',
                    pageSize: 10,
                    columns: [{
                        fieldName: '编号',
                        field: 'personId',
                        hidden:	true
                    }, {
                        fieldName: '姓名',
                        field: 'personName'
                    }, {
                        fieldName: '性别',
                        field: 'sex'
                    }, {
                        fieldName: '年龄',
                        field: 'age',
                        colRender : 'ageRender'
                    }, {
                        fieldName: '住址',
                        field: 'currentAddress',
                        colRender : 'adrRender'
                    },{
                        fieldName: '操作',
                        field: 'personId',
                        colRender : 'crRender'
                    }],
                    even: true,
                    //skin: 'row',
                    checkbox: false,
                    field: 'familyId',
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
        		personName : $('#personName').val(),
        		status: $('#signStatus').val()
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
        
        function familyNumRender(data){
        	var num=data.length
	        var _data = JSON.stringify(data).replace(/\"/g,"'");  
            return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="subfram('+_data+')" >'+num+'名家庭成员'+'</button>';
        }
        
        function crRender(data){
           console.log(data)
        	return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="goHand(\''+data+'\')" >签约</button>';
        
        }
        
        
	     function  subfram(x){
		    layui.use('layer', function(){ //独立版的layer无需执行这一句
		   		  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
		   		  var str='';
		   		
			   	  for (var i = 0; i <x.length; i++) {
			   		  var currentAddress=x[0].currentAddress;
			   		  var sexStr='';
			   		  if(x[i].sex==1){
			   			sexStr='男'
			   		  }else if(x[i].sex==2){
			   			sexStr='女'  
			   		  }else{
			   			  sexStr='';
			   		  }
			   	      str+='<li style="border-bottom: 1px solid #007AFF">'+x[i].personName+'  &nbsp&nbsp&nbsp  '+sexStr+'&nbsp&nbsp&nbsp     '+x[i].age+'岁</br>'+x[i].customNumber+'</li>'
			   	  }; 
			      var tds = '<div><ul><li style="border-bottom: 1px solid #007AFF">住址：'+currentAddress+'</li>'+str+'</ul></div>';
			      
		   		  layer.open({
		   		    scrollbar: true
		   		    ,fixed: true //不固定
				   	,area: ['450px', '360px']
				   	,skin: 'layui-layer-rim' //加上边框
		   	        ,title :'家庭成员'
			   	    ,content: tds
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
	   		  
	   		});
	     } 
        
	     
	     
    </script>
    
    <script type="text/javascript">
		   function  goHand(data){
			 var index = layer.open({
				    type: 2
		   		    ,scrollbar: true
		   		    ,fixed: true //不固定
				   	,area: 'auto'
				   	, maxmin: true 
				   	,skin: 'layui-layer-rim' //加上边框
		   	        ,title :'签约'
			   	    ,content: '${fws}/signAdmin/contractHandlingByDoc?personId='+data
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
			 layer.full(index);  
		   }
    </script>
 
</body>
</html>