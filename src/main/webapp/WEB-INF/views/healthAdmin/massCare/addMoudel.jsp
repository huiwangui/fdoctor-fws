<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>新增模板</title>
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
	   
	     <div class="layui-form-item">
		    <label class="layui-form-label">模板名称<span style="color:red;">*</span></label>
		    <div class="layui-input-block">
		      <input type="text" name="tname" id="templateName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
		    </div>
		 </div>
	    
	     <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">关怀内容</label>
		    <div class="layui-input-block">
		      <textarea placeholder="请输入内容"  id="copytext" class="layui-textarea"></textarea>
		    </div>
         </div>
         
         <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		      <button class="layui-btn" lay-submit="" lay-filter="demo1" id="save" type="button">保存</button>
		    </div>
		  </div>
  </div>
	
	
	
	
	</form>
		
	</body>
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form()
	  ,layer = layui.layer
	  
	


		$('#save').on('click',function(){//保存点击事件
			
			if($('#templateName').val().trim()==''){
				layer.msg("请填入模板名称！")
				return
			}
			var data={
					templateContent:$('#copytext').val(),
					id:0,
					templateName:$('#templateName').val(),
					defaultFlag:0
					
				   };
				
			$.ajax({
				type:'POST',
				url:'/FWS/massCare/editGroupMsgTemplate',
				//data:JSON.stringify(data), 
				data:data,
				success:function(data){
					if(data.code==200){
						layer.msg('保存成功！'); 
						 window.parent.location.reload();
                         var index = parent.layer.getFrameIndex(window.name);
                         parent.layer.close(index);
					}else{
						layer.msg('保存失败！'); 
					}
				}
			})
			
		})
})	
</script>
	
</html>
