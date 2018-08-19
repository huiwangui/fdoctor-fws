<%@page import="com.boco.common.utils.PropertiesUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>解约详情</title>
<head>
    <meta charset="utf-8">
    <title>解约详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/surrenderpage.css" />
    <script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
   
    <style type="text/css">
     .c1 li{
     
      display:block
     }
     
     .clearfix:after {
  content: ".";
  display: block;
  height: 0;
  clear: both;
  visibility: hidden; }
     
    </style>
    
     <% String webServerIp=PropertiesUtils.getValue("ftp_web_server_ip"); %>  
</head>

<body>
	  
  	<div class="layui-row clearfix" style="border: 1px solid #ddd;">
			<div class="layui-col-xs6  residence_info">
				<div class="t">
					居民信息
				</div>
				<div class="c">
					<div class="item"><label for="">姓名：</label> ${vo.personName} </div>
					<div class="item"><label for="">性别：</label> ${vo.sex}</div>
					<div class="item"><label for="">证件号：</label> ${vo.idCard}</div>
					<div class="item"><label for="">电话号码：</label> ${vo.residentMobile}</div>
					<div class="item_last">
						<label for="">手持证件照：</label> 
						<img src="<%=webServerIp%>/${vo.signImg}" alt="" />
					</div>
					
				</div>
			</div>
			<div class="layui-col-xs6 selected_service_pack">
				<div class="t">
					已选服务包
				</div>
				<table class="layui-table" style="margin: 10px; width: 95%;">
				<c:forEach items="${vo.packs}" var="pack" varStatus="status">
			    <tr>
			    	<td>
			    		${pack.packName}<span class="color_red">
			    		<c:if test="${pack.packType=='1'}">基础服务 </c:if>
			    		<c:if test="${pack.packType=='2'}">增值服务 </c:if>
			    		</span>
			    	</td>
			    	<td>${vo.term}年</td>
			    	<td><span class="color_red">${pack.packPrice}&yen;</span></td>
			    </tr>
				</c:forEach>
			    <tr>
			    	<td>
			    	</td>
			    	<td>
			    	</td>
			    	<td>
			    		合计：<span class="color_red">${vo.serviceTotalPrice}&yen;</span>
			    	</td>
			    </tr>
				</table>
			</div>
		</div>
  
  <form class="layui-form" action="">
	<div class="layui-form-item" pane="">
			<label class="layui-form-label" style="width:100px;">解约原因：</label>
			<div class="layui-input-block" style="margin-top:20px;">
				 <c:forEach items="${vo.reasonPacks}" var="reason" varStatus="status"> 
				  <div class="layui-inline" style="width:200px；">
				  <div style="float:left">
				  	<c:if test="${reason.reasonValue!=8}">
				  	<label class="">${reason.reason}</label></c:if>
				  <c:if test="${reason.reasonValue==8}">
				  	<label class="">${vo.reasonOther}</label>
				  </c:if>
				  </div> 
				  </div>
				 <br>
				</c:forEach>
		    </div>
	</div>
	
		<hr>
		<div class="layui-form-item">
			<c:if test="${vo.status=='3'}">
			<label class="layui-form-label" style="width:100px;">解约时间：</label>
			<div class="layui-input-block">
				<label class="layui-form-label">${vo.auditTimeStr}</label>
			</div>
			</c:if>
			<c:if test="${vo.status!='3'}">
			<label class="layui-form-label" style="width:100px;">申请时间：</label>
			<div class="layui-input-block">
				<label class="layui-form-label">${vo.requestTimeStr}</label>
			</div>
			</c:if>
		</div>
		<c:if test="${vo.status!='1'}">
		<div class="layui-form-item">
			<label class="layui-form-label">审核意见：</label>
			<div class="layui-input-block">
				<label class="layui-form-label">${vo.auditRemark}"</label>
			</div>
		</div>	
		</c:if>	
 </form>
    <hr>	
	<c:if test="${vo.status=='1'}">
    <div class="layui-form-item">
	    <div class="layui-input-block" style="">
	       <button  type="button" class="layui-btn layui-btn-normal" id="deleteButton" >取消申请</button>
	    </div>
    </div>
    </c:if>
    <c:if test="${vo.status=='2'}">
    <div class="layui-form-item">
	    <div class="layui-input-block" >
	    <input  id="signId" type="hidden" value="${vo.signId}"/>
	       <button  type="button" class="layui-btn layui-btn-normal" id="editButton" >编辑</button>
	       <button  type="button" class="layui-btn layui-btn-normal" id="cancelButton" >取消</button>
	    </div>
	    <div class="layui-input-block" style="margin-left:0 !important;">
	       
	    </div>
    </div>
    </c:if>
 
</body>

<script type="text/javascript"> 
layui.use('form', function(){
	  var form = layui.form;
	  
	  $('#saveButton').on('click', function(){
		  
		//获取原因权值
  	 	 var sum=0; 	     
 	     $("input[name='reasonval']:checked").each(function(){
 	    	sum+=parseInt($(this).val()); 
 	     }); 
 	     console.log(sum)
 	     if(sum==0||sum==null){
    	 layer.msg("请选择解约原因！")
	     }
 	     
 	     var doctorPhone= $('#doctorPhone').val();
 	 	 if(doctorPhone==''||doctorPhone==null){
	    	 layer.msg("请输入医生电话！")
	    	 return;
	     }
 	 	 var personPhone= $('#personPhone').val();
	 	 if(personPhone==''||personPhone==null){
	    	 layer.msg("请输入居民电话！")
	    	 return;
	     }
 	    
	 	layer.confirm('确认解约？', {icon: 3}, function(index){
  	 	    $.ajax({
  	 			type : 'POST',
  	 			url : '/FWS/signAdmin/doctorSurrender',
  	 			data : {
  	 				docTeamId : '${vo.docTeamId}',
  	 				personId :'${vo.personId}',
  	 				reasonValue : sum,
  	 				reasonOther: $('#otherReason').val(), //选中其他原因复选框后出现输入框
  	 				doctorPhone : $('#doctorPhone').val(),
  	 				personPhone : $('#personPhone').val()
  	 			},
  	 			success : function(data) {
  		 			if(data.code == 200){
  		 				layer.msg('解约成功！',{icon: 1});
  		 				parent.tableConfig();
  		 		   	    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		 			    parent.layer.close(index);
  	 				}else{
  	 					layer.msg('解约失败：'+data.msg,{icon: 2});
  	 				}
  	 			},
  	 			error : function(data) {
  	 				console.log("ERROR")
  	 			}
  	 		});  
	    });
	  });
	  
	  $('#deleteButton').on('click', function(){
		  
		 	layer.confirm('确认取消？', {icon: 3}, function(index){
	  	 	    $.ajax({
	  	 			type : 'POST',
	  	 			url : '/FWS/signAdmin/cancleSurrenderRequest',
	  	 			data : {
	  	 				docTeamId : '${vo.docTeamId}',
	  	 				requestId : '${vo.id}'
	  	 			},
	  	 			success : function(data) {
	  		 			if(data.code == 200){
	  		 				layer.msg('取消成功！',{icon: 1});
	  		 				parent.tableConfig();
	  		 		   	    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			 			    parent.layer.close(index);
	  	 				}else{
	  	 					layer.msg('取消失败：'+data.msg,{icon: 2});
	  	 				}
	  	 			},
	  	 			error : function(data) {
	  	 				console.log("ERROR")
	  	 			}
	  	 		});  
		    });
		  });
	  
	  $('#editButton').on('click', function(){  		 	
		  var index = layer.open({
			    type: 2
	   		    ,scrollbar: true
	   		    ,fixed: true //不固定
			   	,area: 'auto'
			   	, maxmin: true 
			   	,skin: 'layui-layer-rim' //加上边框
	   	        ,title :'解约详情'
		   	    ,content: '${fws}/signAdmin/goSurrender?id='+$('#signId').val()+'&status=2'//status=2表示是已拒绝的再次编辑
	   	        ,btnAlign: 'c' //按钮居中
	   	        ,shade: 0 //不显示遮罩
	   	       
	   	      });
		layer.full(index);  
		
	 });
	  
	 $('#cancelButton').on('click', function(){  		 	
		  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		  parent.layer.close(index); 
	 });
	 
});

</script>
</html>