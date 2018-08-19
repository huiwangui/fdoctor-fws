<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评估列表</title>
<head>
    <meta charset="utf-8">
    <title>评估列表</title>
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
			 <div class="layui-form-item" align="left" style="margin-top: 14px;float:left" >
				    <label class="layui-form-label" style="width: 50px;" >状态</label>
				    <div class="layui-input-inline">
				      <select name="signStatus" lay-verify="" id="signStatus">
						  <option value="0">全部</option>
						  <option value="1">待评估</option>
						  <option value="2">已完成</option>
						</select>     
				    </div>
			    </div>
		 </div>
		 
		 
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
			 <div class="layui-form-item"  style="margin-top: 18px">  
			  <label class="layui-form-label">关键字：</label>
				   <div class="layui-inline" style="width:10%;margin-left: 0px;float:left" >
						<div class="layui-input-inline">
							<input type="text" id="personName" name="personName" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
						</div>
						
				    	
					</div>
			 </div>
		 </div>    
		 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:10%;margin-left: 0px;float:left" >
						 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
				    	 </div>
					</div>
			 </div>
		 </div>  
			 
		 
		 
		 
			 
			</form>
        </blockquote>
        <div id="content" style="width: 100%;height: 500px;"></div>
    </div>

    <script>
    
    
    layui.use(['layer','jquery', 'form'], function() { 
    	var layer = layui.layer;
	     $ = layui.jquery;
	     layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
	     form = layui.form();
	     $form = $('form');
	     
    })
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
                    url: '/FWS/physicleAssessment/indexList',
                    pageSize: 10,
                    columns: [{
                        fieldName: '编号',
                        field: 'id',
                        hidden:	true
                    }, {
                        fieldName: '姓名',
                        field: 'personName'
                    }, {
                        fieldName: '性别',
                        field: 'sex',
                    }, {
                        fieldName: '年龄',
                        field: 'age',
                        colRender : 'ageRender'
                        
                    },{
                        fieldName: '异常数据',
                        field: 'outlierData',
                    }, {
                        fieldName: '录入时间',
                        field: 'createTime',
                        colRender : 'createTimeRender'
                    }, {
                        fieldName: '状态',
                        field: 'status',
                        colRender : 'statusRender'
                    } ,{
                        fieldName: '操作',
                        field: 'sid',
                        colRender : 'crRender'
                    } ],
                    even: true,
                    //skin: 'row',
                    checkbox: true,
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
        	tableConfig();
        });
       
        function getParams(){
        	console.log('${sessionScope.doctorInfo.teamId}')
        	var params = {
        		personName : $('#personName').val().trim(),
        		status:$("#signStatus").val(),
        		beginTime:$("#date1").val(),
        		endTime:$("#date2").val(),
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
        
        function createTimeRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null){
        		return '未知'
        	}
        	else{
        		var unixTimestamp = new Date(data) ;
        		unixTimestamp.toLocaleString();
        		return unixTimestamp.toLocaleString();
        	}
        }
        
        function sexRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null){
        		return '未知'
        	}
        	else{
        		if(data=='1'){
        			return '男'
        		}else if(data=='2'){
        			return '女'
        		}else{
        			return data;
        		}
        	}
        }
        
        function statusRender(data){
        	if(data == '1'){
        		return '待评估';
        	}else if(data == '2'){
        		return '已完成';
        	}else if(data == '3'){
        		return '已拒绝';
        	}else{
        		return data;
        	}
        }
         function familyNumRender(data){
           var familyNumData=eval(data)
           var num=familyNumData.length
	       var _data = JSON.stringify(data).replace(/\"/g,"'");  
           return '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick="subfram('+_data+')" >'+num+'名家庭成员'+'</button>';
          
        } 
        
        function crRender(data){
        	 var crData=eval(data)
              if(crData.status=='1'){
            	  var html = '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick=\"goHand(\''+crData.id+'\')\" >去评估</button>'
                  return html;
              } else{
            	  var html = '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick=\"godetail(\''+crData.id+'\')\" >查看详情</button>'
                  return html;
              }
             return html;
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
			   		  }else{
			   			sexStr='女'  
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
   function  goHand(data){
	          console.log("id="+data)
	  var index = layer.open({
				    type: 2
		   		    ,scrollbar: true
		   		    ,fixed: true //不固定
				   	,skin: 'layui-layer-rim' //加上边框
		   	        ,title :'评估'
			   	    ,content: '${fws}/physicleAssessment/hand?id='+data
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
	 layer.full(index); 
   }
   
   
   function  godetail(data){
       console.log("id="+data)
var index = layer.open({
			    type: 2
	   		    ,scrollbar: true
	   		    ,fixed: true //不固定
			   	,skin: 'layui-layer-rim' //加上边框
	   	        ,title :'评估详情'
		   	    ,content: '${fws}/physicleAssessment/detail?id='+data
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