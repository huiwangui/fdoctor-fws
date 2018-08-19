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
        
        <div class="layui-inline">
	      <label class="layui-form-label">随访日期</label>
	      <div class="layui-input-inline">
	        <input type="text" name="date" id="date1" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
	      </div>--
	      <div class="layui-input-inline">
	        <input type="text" name="date" id="date2" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
	      </div>
        </div>
    
			  
			   <div class="layui-form-item" align="left" style="margin-left: 0px;float:left" >
				    <label class="layui-form-label" style="width: 60px;" >状态</label>
				    <div class="layui-input-inline">
				      <select name="signStatus" lay-verify="" id="signStatus">
						  <option value="0">--请选择--</option>
						  <option value="1">已预约</option>
						  <option value="3">已完成</option>
						</select>     
				    </div>
			    </div>
			    
				
				<div class="layui-inline" style="width: 20%;" style="margin-left: 0px;float:left" >
			    <label class="layui-form-label" style="width: 30px;" ></label>
			    	 <div class="layui-input-inline">
			    	<button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
			    	</div>
			    </div>
			    
			    
                
                <div class="layui-form-item">
				    <div class="layui-input-block">
				        <button class="layui-btn" type="button" id="t1" >今日（${t1}）</button>
					    <button class="layui-btn layui-btn-normal" type="button" id="t2" >明日（${t2}）</button>
					    <button class="layui-btn layui-btn-warm" type="button" id="t7">本周（${t7}）</button>
				    </div>
				 </div>
			    <input  type="hidden"  id="htime" value=""/>
			   
			    
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
                    url: '/FWS/appointment/queryFollow',
                    pageSize: 10,
                    columns: [{
                        fieldName: '编号',
                        field: 'orderNumber',
                        hidden:	true
                    }, {
                        fieldName: '姓名',
                        field: 'patientName'
                    }, {
                        fieldName: '性别',
                        field: 'sex'
                    }, {
                        fieldName: '年龄',
                        field: 'age',
                        colRender : 'ageRender'
                    }, {
                        fieldName: '随访时间',
                        field: 'timestr'
                    }, {
                        fieldName: '随访项目',
                        field: 'fpName',
                    }, {
                        fieldName: '联系电话',
                        field: 'phone',
                    },{
                        fieldName: '状态',
                        field: 'orderStatus',
                        colRender : 'statusRender'
                    }, {
                        fieldName: '操作',
                        field: 'orderNumber',
                        colRender : 'crRender'
                    } ],
                    even: true,
                    //skin: 'row',
                    checkbox: false,
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
    	
      //时间选择点击事件，查询逻辑
        $("input[name='time']").on('click',function(){
        	console.log('time---')
        	$("#date1").val(''),
        	$("#date2").val('')
        	showTime();
        });
        function showTime(){
        	switch($("input[name='time']:checked").val()){
        	  case "1":$("#htime").val("1")
        	   break;
        	  case "2":$("#htime").val("2")
        	   break;
        	  case "7":$("#htime").val("7")
           	   break;
        	  default:$("#htime").val('')
        	   break;
        	 }
        	tableConfig();
        	
        }
        
       $("#t1").on('click',function(){
        	$("#date1").val('')
        	$("#date2").val('')
        	$("#htime").val("1")
        	tableConfig();
        	$("#htime").val("0")
        }) 
        $("#t2").on('click',function(){
        	$("#date1").val('')
        	$("#date2").val('')
        	$("#htime").val("2")
        	tableConfig();
        	$("#htime").val("0")
        }) 
        $("#t7").on('click',function(){
        	$("#date1").val('')
        	$("#date2").val('')
        	$("#htime").val("7")
        	tableConfig();
        	$("#htime").val("0")
        }) 
		     
		    
       
        function getParams(){
        	console.log('${sessionScope.doctorInfo.userName}')
        	var params = {
        		userName:'${sessionScope.doctorInfo.userName}',
        		//uid :'${sessionScope.doctorInfo.id}',
        		status: $('#signStatus').val(),
        		beginTime:$("#date1").val(),
        		endTime:$("#date2").val(),
        		time:$("#htime").val()
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
       
       
        function statusRender(data){
        	if(data == '1'){
        		return '已预约';
        	}else if(data == '3'){
        		return '已完成';
        	}else if(data == '2'){
        		return '已取消';
        	}else{
        		return data;
        	}
        }
        
        function crRender(data){
        		return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="goHand(\''+data+'\')" >详情</button>';
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
			   			sexStr='未知'
			   		  }
			   	      str+='<li style="border-bottom: 1px solid #007AFF">'+x[i].personName+'  &nbsp&nbsp&nbsp  '+sexStr+'&nbsp&nbsp&nbsp     '+x[i].age+'岁</br>'+x[i].customNumber+'</li>'
			   	  }; 
			      var tds = '<div><ui><li style="border-bottom: 1px solid #007AFF">住址：'+currentAddress+'</li>'+str+'</ui></div>';
			      
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
   function  goHand(orderNumber){
	   
	 var index = layer.open({
				    type: 2
		   		    ,scrollbar: true
		   		    ,fixed: false //固定
				   	,area: 'auto'
				   	, maxmin: true 
				   //	,skin: 'layui-layer-rim' //加上边框
		   	        ,title :'详情'
			   	    ,content: '${fws}/appointment/followDetail?orderNumber='+orderNumber
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
	 layer.full(index);  
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