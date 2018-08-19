<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>群发关怀</title>
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
		<style type="text/css">
			.left{
				float: left;width: 29%;border: 1px solid #ddd;
			}
			.right{
				margin-left:200px;border: 1px solid #ddd;box-sizing:border-box;padding:10px 10px 0 0;
			}
			.left .top h5{
				font-weight: 400;
			}
		</style>
	</head>
	<body>
		<div class="wrap">
				<!-- 	<ul>
						<li><a href="/">第一个选项</a></li>
						<li><a href="/">第一个选项</a></li>
						<li><a href="/">第一个选项</a></li>
						<li><a href="/">第一个选项</a></li>
						<li><a href="/">第一个选项</a></li>
					</ul> -->
					<div>
					<ul  style="position: fixed;
							    top: 0px;
							    bottom: 0;
							    left: 0;
							    right: 200px;
							    width: 200px;
							    z-index: 999;
							    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5);
							    background-color: #c2c2c2;
							    color: #c2c2c2;
							    overflow-x: hidden;">
						  <li  style="background-color: #fff;text-align:center;height:40px;">
						    <div class="layui-inline" style="text-align:center;">
						      <span lay-submit="" lay-filter="demo2"><a style="color: black;">模板列表</a></span>
						      <button class="layui-btn layui-btn-small"  lay-submit="" lay-filter="demo2" onclick="moudelList()">自定义模板</button>
						     </div>
						  </li>
						  <c:forEach items="${mlist}" var="item">
							  <li  style="text-align:center;">
							        <a style="width:200px" class="layui-btn layui-btn-primary" onclick="getsss(${item.id})" >${item.templateName}</a>
							  </li>
						  </c:forEach>
                     </ul>
                     </div>
                     <div class="right">
                     <form class="layui-form" action="">
	                      <div class="layui-form-item layui-form-text">
							    <label class="layui-form-label">关怀内容</label>
							    <div class="layui-input-block">
							      <textarea placeholder="请输入内容" class="layui-textarea" rows="12" id="copytext"></textarea>
							    </div>
	                      </div>
	                      
			             <div class="layui-form-item" pane="">
						    <label class="layui-form-label">关怀人群</label>
						    <div class="layui-input-block">
						      <c:forEach items="${labelids}" var="item">
								        <input type="checkbox" name="labeliId" value="${item.id}" lay-skin="primary" title="${item.labelName}" >
						     </c:forEach>
						    </div>
						  </div>
						  
						  <div class="layui-form-item" style="text-align:center;">
						    <button class="layui-btn" lay-submit="" lay-filter="demo2" type="button" id="send">选择并群发</button>
						  </div>
                        </form>
                
                     </div>
		</div>
		
	</body>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form()
  ,layer = layui.layer
})
</script>
<script type="text/javascript">
	var content='${mlistJson}'
	var resultOK= JSON.parse(content)
	$('#copytext').val(resultOK[0].templateContent)
	console.log(content)
	var labelIDs='';//标签ID
	function  getsss(id) {//获取模板内容
	   for (var i = 0; i< resultOK.length; i++) {
		if(resultOK[i].id==id){
			$('#copytext').val(resultOK[i].templateContent)
			break;
		}
		
	  } 
	}
	
	function jqchk(){ //jquery获取复选框值 
	   
		$('input[name="labeliId"]:checked').each(function(){ 
			labelIDs+=$(this).val()+","
		}); 
		if(labelIDs.length==0){
			layer.msg('你还没有选择人群！'); 
			return;
		}
	} 
	
	$('#send').on('click',function(){//群发消息
		if($('#copytext').val().trim()==''){
			layer.msg('你还没有填写任何内容！'); 
			return
		}
		jqchk();
		if(labelIDs.length==0||labelIDs==''){
			return;
		}
		$.ajax({
			
			type:'GET',
			url:'/FWS/massCare/sendMsgByDiseaseLabel',
			data:{
				templateContent:$('#copytext').val(),
				labelIDs:labelIDs.substring(0,labelIDs.length-1)
				
			},
			success:function(data){
				if(data.code==200){
					layer.msg('发送成功！'); 
				}else{
					layer.msg('发送失败！'); 
				}
			}
		})
		
		
		
	})
	
	
	function moudelList(){//自定义模板
		 
		 var index = layer.open({
			    type: 2
	   		    ,scrollbar: true
	   		    ,fixed: false //不固定
			   	,skin: 'layui-layer-rim' //加上边框
	   	        ,title :'自定义模板'
		   	    ,content: '${fws}/massCare/moudelList'
	   	        ,btnAlign: 'c' //按钮居中
	   	        ,shade: 0 //不显示遮罩
		   	    ,cancel: function(index, layero){ 
		   	       window.location.reload();
		   	     }    
	   	      });
	    layer.full(index)
  }
</script>
	
</html>
