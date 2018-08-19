<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>自定义模板</title>
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
	    <label class="layui-form-label">关怀对象</label>
	    <div class="layui-input-block">
	      <select id="guanhuai" name="interest" lay-filter="aihao">
	        <option value=""></option>
	        <c:forEach items="${mlist}" var="item">
	        <option value="${item.id }">${item.templateName }</option>
	        </c:forEach>
	      </select>
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
<script>

	  

</script>
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form()
	  ,layer = layui.layer
	  
	    var content='${mlistJson}'
		var resultOK= JSON.parse(content)
		var labelIDs=null;//标签ID
	    var templateName='';//标签名称
	    var defaultFlag='';
	
	
		form.on('select(aihao)', function(data){
		  for (var i = 0; i< resultOK.length; i++) {
				if(resultOK[i].id==data.value){
					labelIDs=data.value
					templateName=resultOK[i].templateName
					defaultFlag=resultOK[i].defaultFlag
					$('#copytext').val(resultOK[i].templateContent)//得到被选中的值
					break;
				}
		  } 
		})


		$('#save').on('click',function(){//保存点击事件
			
			if($('#guanhuai').val()==''){
				layer.msg("没选择任何关怀对象！")
				return
			}
			if($('#copytext').val().length>300){
				layer.msg("内容过多，请填写300字符以内！")
				return
			}
			var data={
					templateContent:$('#copytext').val(),
					id:labelIDs,
					templateName:templateName,
					defaultFlag:defaultFlag
					
				   };
				
			$.ajax({
				type:'POST',
				url:'/FWS/massCare/editGroupMsgTemplate',
				//data:JSON.stringify(data), 
				data:data,
				success:function(data){
					if(data.code==200){
						layer.msg('保存发送成功！'); 
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
