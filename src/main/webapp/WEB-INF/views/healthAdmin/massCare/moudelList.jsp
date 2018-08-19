<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>模板列表</title>
		 <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/btable.css" />
     <link rel="stylesheet" href="/FWS/statics/css/person.css" />
    
    <script type="text/javascript" src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
	</head>
	<body>
	<form class="layui-form" action="">
	   
	     <div id="content" style="width: 100%;height: 500px;"></div>
	
	
	</form>
		
	</body>
<script type="text/javascript">
	  
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
                  url: '/FWS/massCare/getList',
                  pageSize: 10,
                  columns: [{
                      fieldName: '编号',
                      field: 'id',
                      hidden:	true
                  }, {
                      fieldName: '模板名称',
                      field: 'templateName'
                  }, {
                      fieldName: '默认标签',
                      field: 'defaultFlag',
                      colRender : 'defRender'
                  }, {
                      fieldName: '操作',
                      field: 'map',
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
  	

		     
		    
     
      function getParams(){
      	console.log('${sessionScope.doctorInfo.teamId}')
      	var params = {
      		docTeamId :'${sessionScope.doctorInfo.teamId}',
      		personName : $('#personName').val(),
      		status: $('#signStatus').val()
			   	}
      	return params;
      }
      
     function crRender(data){
    	 var data=eval(data)
    	 var str='';
    	 if(data.defaultFlag==0){
    	 str='<div class="layui-btn-group">'+
    		    '<button class="layui-btn layui-btn-small" type="button" onclick="addit()"><i class="layui-icon"></i></button>'+
    		    '<button class="layui-btn layui-btn-small" type="button" onclick="makeit()"><i class="layui-icon"></i></button>'+
    		   ' <button class="layui-btn layui-btn-small" type="button" onclick="delit('+data.id+')"><i class="layui-icon"></i></button>'+
    		 ' </div>'
    	 }else{
    		 str='<div class="layui-btn-group">'+
 		    '<button class="layui-btn layui-btn-small" type="button" onclick="addit()"><i class="layui-icon"></i></button>'+
 		    '<button class="layui-btn layui-btn-small" type="button" onclick="makeit()"><i class="layui-icon"></i></button>'+
 		 ' </div>'
    		 
    	 }
    	 return str
     }
     
     function defRender(data){
    	 if(data==1){
    		 return '是'
    	 }
    	 return '否'
     }
     
     function makeit(){//编辑自定义模板
		 
		 var index = layer.open({
			    type: 2
	   		    ,scrollbar: true
	   		    ,fixed: false //不固定
	   		    ,resize:false
	   		    ,area: ['500px', '300px']
			   	,skin: 'layui-layer-rim' //加上边框
	   	        ,title :'自定义模板'
		   	    ,content: '${fws}/massCare/makeMoudel'
	   	        ,btnAlign: 'c' //按钮居中
	   	        ,shade: 0 //不显示遮罩
	   	       
	   	      });
}


function addit(){//添加模板
	 
	 var index = layer.open({
		    type: 2
   		    ,scrollbar: true
   		    ,fixed: false //不固定
   		    ,resize:false
   		    ,area: ['500px', '300px']
		   	,skin: 'layui-layer-rim' //加上边框
   	        ,title :'自定义模板'
	   	    ,content: '${fws}/massCare/addMoudel'
   	        ,btnAlign: 'c' //按钮居中
   	        ,shade: 0 //不显示遮罩
   	       
   	      });
}

function delit(id){//删除自定义模板
	 console.log(id)
	 $.ajax({
		 type:'POST',
			url:'/FWS/massCare/deleteGroupMsgTemplate',
			data:{
				id:id,
				defaultFlag:0
			},
			success:function(data){
				if(data.code==200){
					layer.msg('删除成功！'); 
					tableConfig();
				//	window.parent.location.reload();
				}else{
					layer.msg('删除失败！'); 
				}
			}
		 
	 })
}


		

</script>
	
</html>
