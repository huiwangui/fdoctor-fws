<%@page import="com.boco.common.utils.PropertiesUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>解约申请</title>
<head>
    <meta charset="utf-8">
    <title>解约申请</title>
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
					<div class="item"><label for="">电话号码：</label> ${vo.phoneNumber}</div>
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
		
		<div style="color:red;" style="margin-left:40px">一旦解约，已付款服务包不会退费！请如实告知居民！与居民商量</div>
		
		<!--解约原因-->
		<form action="" class="layui-form">
		<div class="layui-row termination_reason">
			<div class="t">
				解约原因
			</div>
			<div class="layui-col-xs6 left_chk">
				<form action="" class="layui-form">
					<c:forEach items="${reasonPacks}" var="reason" varStatus="status"> 
					<c:if test="${reason.reasonValue !='8'}">
					<div class="layui-form-item">
						 <input  type="checkbox" name="reasonval"  title="${reason.reason}" value="${reason.reasonValue}">
					</div>
					</c:if>
					</c:forEach>
					
					<div class="layui-form-item" onclick="othercheck()">
						<input  type="checkbox" id="othercheck" name="reasonval" title="其他理由" value="8">
					</div>
				</form>
			</div>
			<div class="layui-col-xs6 right_fillin">
				<textarea id="otherReason"  style="display:none;" placeholder="请输入其他原因" name="" rows="" cols="" class="layui-textarea"></textarea>
			</div>
		</div>
		
		<!--确认解约-->
		<div class="layui-row confirm_termination">
			<div class="t">
				确认解约
			</div>
			
				<div class="layui-form-item">
					<label for="" class="layui-form-label">医生手机号</label>
					<div class="layui-input-block">
				      <input type="text" name="title" id="doctorPhone" value="${doctorPhone}" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label for="" class="layui-form-label">居民手机号</label>
					<div class="layui-input-block">
				      <input type="text" name="title" id="personPhone"required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					 <div class="color_red"  style="margin:0 25px;">请留下正确的手机号码，以确保通过审核</div>
				</div>
				<div class="layui-form-item">
					 <div class="layui-input-block">
				      <button  type="button" class="layui-btn layui-btn-normal" id="saveButton" >确认提交</button>
				    </div>
				</div>	
		</div>
		</form>
	

 
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
	  
	});

</script>
<script>
	function othercheck(){
		 var ischeck=$('#othercheck').is(':checked');
	     if(ischeck){
	    	 $('#otherReason').show();
	     }else{
	    	 $('#otherReason').hide();
	     }
	}
</script>
</html>