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
            <div class="layui-form-item" align="left" style="margin-left: 0px">
			  <div class="layui-inline" style="width: 30%;">
			    
			    <div class="layui-input-inline">
			      <select lay-verify="" id="mySelect" lay-filter="mySelect">
					  <option value="">选择标签以展示</option>
					  <option value="">全部</option>
				      	<c:forEach items="${lableList}" var="item">
				      		<option value="${item.id}">${item.labelName}(${item.personCount})</option>
				      	</c:forEach>
					</select>     
			    </div>
			  
			  </div>
		 </div>
		 </div>
		 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
						<div class="layui-input-inline">
							<input type="text" id="personName" name="personName" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
						</div>
						
				    	
					</div>
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
			 
		 <div class="layui-inline" style="width: 30%;">
			  <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
						
				    	 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="addlabel" type="button">标签管理</button>
				    	 </div>
					</div>
			 </div>  
		 </div>   
		 
		 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px">  
				   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
						  <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="addButton" type="button">新增成员</button>
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
	     
	     //form.on('select(mySelect)', function(data) {
	     //	 tableConfig()
		 //})
		  $('#addButton').on('click',function(){
			window.location.href="${fws}/resident/addPersonView";  
			  
		  })
		 
         $('#addlabel').on('click',function(){
        	 layer.open({
        		  type: 2,
        		  title:'标签管理',
        		  area: ['500px', '330px'],
        		  fixed: false, //不固定
        		  maxmin: true,
        		  content: '${fws}/resident/toLabel',
        		  cancel: function(index, layero){ 
        			 window.location.reload();
        			}    
        		});
        	 
         })
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
                    url: '/FWS/resident/queryresident',
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
                        field: 'sex',
                        colRender : 'sexRender'
                    }, {
                        fieldName: '年龄',
                        field: 'age',
                        colRender : 'ageRender'
                        
                        
                    },{
                        fieldName: '出生日期',
                        field: 'birthDay',
                        colRender : 'birthDayRender'
                    }, {
                        fieldName: '联系电话',
                        field: 'phoneNumber',
                        colRender : 'telRender'
                    },  {
                        fieldName: '操作',
                        field: 'personId',
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
        		labelId:$("#mySelect").val()
 			   	}
        	console.log(params)
        	return params;
        }
        
        function ageRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null||data==''){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        
        function birthDayRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null||data==''){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        function telRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null||data==''){
        		return '未知'
        	}
        	else{
        		return data;
        	}
        }
        
        function sexRender(data){
        	if(data=="null"||typeof (data)=="undefined"){
        		return '未知'
        	}else if(data==undefined||data==null||data==''){
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
        		return '待确认';
        	}else if(data == '2'){
        		return '已签约';
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
              if($("#mySelect").val()==''){
            	  var html = '<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick=\"goHand(\''+data+'\')\" >居民信息</button>'+'<button data-method="offset" data-type="auto" style="width:125px" class="layui-btn layui-btn-normal" onclick=\"goHandgw(\''+data+'\')\" >居民档案</button>'
                  return html;
              } 
        	 var html = '<input type="button" value="居民信息"  onclick=\"goHand(\''+data+'\')\" class="layui-btn layui-btn-mini" /> ' +
        	 '<input type="button" value="档案信息"  onclick=\"goHandgw(\''+data+'\')\" class="layui-btn layui-btn-mini" /> ' +
             '<input type="button" value="删除"  onclick=\"del(\''+data+'\')\" class="layui-btn layui-btn-mini layui-btn-danger" />';
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
	     
	     
	     var  labelJson='${lableListJson}'
	     
	     
   	     
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
		   	        ,title :'居民详情'
			   	    ,content: '${fws}/resident/personInfo?personId='+data
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
	 layer.full(index); 
   }
   
   function  goHandgw(data){
	var index = layer.open({
				    type: 2
		   		    ,scrollbar: true
		   		    ,fixed: true //不固定
				   	,area: 'auto'
				   	, maxmin: true 
				   	,skin: 'layui-layer-rim' //加上边框
		   	        ,title :'居民详情'
			   	    ,content: '${fws}/resident/docmentInfo?personId='+data
		   	        ,btnAlign: 'c' //按钮居中
		   	        ,shade: 0 //不显示遮罩
		   	       
		   	      });
	layer.full(index); 
	}
   
   
   function  del(data){
       //询问框
       layer.confirm('确认删除？', {icon: 3,id : Math.ceil(100)}, function(index) {
    	   
    	   $.ajax({
       		url:'${fws}/resident/changeSelectStatus',
       		type : 'POST',
   			async: false,
   			data : {
   				labelId :$("#mySelect").val(),
   				personId:data
   			},
   			success : function(data) {
   				if(data.code == 200){
   					tableConfig()
     					layer.msg('删除成功！',{icon: 1});
     				}else{
     					layer.msg('删除失败！',{icon: 2});
     				}
   			}
          }) 
    	   
       });
}
   
 
   </script>
</body>
</html>