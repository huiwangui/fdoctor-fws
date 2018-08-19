<%@page import="com.boco.common.utils.PropertiesUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>签约详情</title>
<head>
    <meta charset="utf-8">
    <title>签约处理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/btable.css" />
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

<form class="layui-form" action="">
  <div class="layui-form-item">

    <input value="${vo.id}" type="hidden" id="reqsignId">
    <c:if test="${vo.status=='1' }">
    <label  style="color:red;margin-left:20px" class="layui-form-label">待处理</label>
    </c:if>
    <c:if test="${vo.status=='2' }">
    <label  style="color:red;margin-left:20px" class="layui-form-label">已签约</label>
    </c:if>
    <c:if test="${vo.status=='3' }">
    <label  style="color:red;margin-left:20px" class="layui-form-label">已拒绝</label>
    </c:if>
  </div>
  <hr>
   <div class="layui-form-item">
   
    <label class="layui-form-label" style="width:100px;">签约服务包:</label>
    <div>
      <ul class="c1">
      <c:forEach items="${vo.packs}" var="pack" varStatus="status"> 
            <c:if test="${status.index==0}">  
             <li class="clearfix">
	    		 <label class="layui-form-label">${pack.packName}</label>
	    		 <input  name="price" type="hidden" value="${pack.packPrice}"/>
				  <c:if test="${pack.packType=='1'}">   
				    <label  style="color:red" class="layui-form-label">基础服务</label>
				  </c:if>
				  
				  <c:if test="${pack.packType=='2'}">   
				     <label  style="color:red" class="layui-form-label">增值服务</label>
				  </c:if>
	          </li>
	        </c:if> 
	         <c:if test="${status.index>0}">  
			     <li class="clearfix">
			        <label class="layui-form-label" style="width:100px;"></label>
			    	<label class="layui-form-label">${pack.packName}</label>
			    	<input  name="price" type="hidden" value="${pack.packPrice}"/>
			    	
					  <c:if test="${pack.packType=='1'}">   
					    <label  style="color:red" class="layui-form-label">基础服务</label>
					  </c:if>
					  
					  <c:if test="${pack.packType=='2'}">   
					     <label  style="color:red" class="layui-form-label">增值服务</label>
					  </c:if>
			    </li>
		     </c:if> 
	  </c:forEach>
	  </ul>
    </div>
  </div>
<hr>
  <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">签约时间:</label>
     <div class="layui-inline">
     <c:if test="${vo.status=='2' }">
      <label class="layui-form-label" style="width:170px;"><fmt:formatDate value="${vo.signTime}" pattern="yyyy-MM-dd"/></label>
        <label class="layui-form-label">至</label>
      <label class="layui-form-label" style="width:170px;"><fmt:formatDate value="${vo.dueTime}" pattern="yyyy-MM-dd"/></label>
    </c:if>
    
     <c:if test="${vo.status!='2' }">
      <label class="layui-form-label" style="width:170px;"><fmt:formatDate value="${vo.createTime}" pattern="yyyy-MM-dd"/></label>
      <label class="layui-form-label">至</label>
      <label class="layui-form-label" style="width:170px;"><fmt:formatDate value="${vo.dueTime}" pattern="yyyy-MM-dd"/></label>
    </c:if>
    </div>
  </div> 
  <hr>
  
  <div class="layui-form-item">
     <div class="layui-inline">
	    <label class="layui-form-label" style="width:100px;">医生团队:</label>
	    <label class="layui-form-label">${vo.docName}团队</label>
     </div><br>
    <div class="layui-inline">
	    <label class="layui-form-label" style="width:100px;"></label>
	    <span>${vo.docOrgName}</span>
     </div>
  </div>
  <hr>

  
  <div class="layui-form-item">
	   
	   <div class="layui-inline">
	     <label class="layui-form-label" style="width:100px;">个人信息:</label>
      	 <label class="layui-form-label">${vo.personName}</label>
   	  </div>
      <div class="layui-inline">
		<span >性别：&nbsp;&nbsp;${vo.sex}&nbsp;&nbsp; 年龄：   ${vo.age}岁 &nbsp;&nbsp;  身份证号：   ${vo.idCard}  &nbsp;&nbsp; 住址：${vo.currentAddress}</span><br>
	  </div>
  </div>    
 <hr>
 <c:if test="${vo.status=='1' }">
    <div class="layui-form-item">
			<label class="layui-form-label">医疗标签</label>
			<div class="layui-input-block" id="ylbq">
				<div class="ylbq">
				    <input type="hidden" name="personId" value="${vo.personId}">
					<input type="checkbox" name="bq" title="高血压" value="2">
					<input type="checkbox" name="bq" title="糖尿病" value="4">
					<input type="checkbox" name="bq" title="儿童" value="8">
					<input type="checkbox" name="bq" title="重性精神病" value="16">
					<input type="checkbox" name="bq" title="老年人" value="32">
					<input type="checkbox" name="bq" title="普通成人" value="64">
					<input type="checkbox" name="bq" title="孕产妇" value="128">
				</div>
			</div>
		</div>
 </c:if>
 
 <c:if test="${vo.status=='2' }">
  <div class="layui-form-item">
  	   <div class="layui-inline">
        <label class="layui-form-label" style="width:100px;">医疗标签：</label>
	   </div>
	   <div class="layui-inline">
	       <c:forEach items="${vo.labels}"  var="pl">
			    <c:if test="${pl.labelName=='高血压'&& pl.selectFlag=='0'}">
			      <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">高血压</button>
			    </c:if>
			    <c:if test="${pl.labelName=='高血压'&& pl.selectFlag=='1'}">
			      <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">高血压</button>
			    </c:if>
			     <c:if test="${pl.labelName=='糖尿病'&& pl.selectFlag=='1'}">
			      <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">糖尿病</button>
			    </c:if>
			    <c:if test="${pl.labelName=='糖尿病'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">糖尿病</button>
			    </c:if>
		    
		   
			    <c:if test="${pl.labelName=='儿童'&& pl.selectFlag=='1'}">
			        <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">儿童</button>
			    </c:if>
			    <c:if test="${pl.labelName=='儿童'&& pl.selectFlag=='0'}">
			        <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">儿童</button>
			    </c:if>
		    
		    
			    <c:if test="${pl.labelName=='重性精神病'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">重性精神病</button>
			    </c:if>
			     <c:if test="${pl.labelName=='重性精神病'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">重性精神病</button>
			    </c:if>
			    <c:if test="${pl.labelName=='老年人'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">老年人</button>
			    </c:if>
			     <c:if test="${pl.labelName=='老年人'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">老年人</button>
			    </c:if>
			    <c:if test="${pl.labelName=='普通成人'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">普通成人</button>
			    </c:if>
			     <c:if test="${pl.labelName=='普通成人'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">普通成人</button>
			    </c:if>
			    <c:if test="${pl.labelName=='孕产妇'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">孕产妇</button>
			    </c:if>
			     <c:if test="${pl.labelName=='孕产妇'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">孕产妇</button>
			    </c:if>
			    
			     <c:if test="${pl.labelName=='特困户'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">特困户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='特困户'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">特困户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='残疾人'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">残疾人</button>
			    </c:if>
			     <c:if test="${pl.labelName=='残疾人'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">残疾人</button>
			    </c:if>
			     <c:if test="${pl.labelName=='低保户'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">低保户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='低保户'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">低保户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='五保户'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">五保户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='五保户'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">五保户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='计生特户'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">计生特户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='计生特户'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">计生特户</button>
			    </c:if>
			     <c:if test="${pl.labelName=='结核病'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">结核病</button>
			    </c:if>
			     <c:if test="${pl.labelName=='结核病'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">结核病</button>
			    </c:if>
			     <c:if test="${pl.labelName=='流动人口'&& pl.selectFlag=='1'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal">流动人口</button>
			    </c:if>
			     <c:if test="${pl.labelName=='流动人口'&& pl.selectFlag=='0'}">
			       <button  type="button" class="layui-btn layui-btn-small layui-btn-normal layui-btn-disabled">流动人口</button>
			    </c:if>
		    </c:forEach>
		  </div>
     </div>
 </c:if>  
  
  </div> 
  
   <hr>
   
  <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">用户手持证件</label>
  </div>
  <hr>
  <c:if test="${vo.status=='1'}">
		  <hr>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="button" class="layui-btn" lay-submit="" lay-filter="demo1" id="ty">同意签约</button>
		      <button type="button"  style="margin-left:150px" class="layui-btn" id="cancle">拒绝签约</button>
		    </div>
		  </div>
	</c:if>
</form>
<script type="text/javascript">
layui.use(
		[ 'jquery', 'form' ],
		function() {
			$ = layui.jquery;
			form = layui.form();
	         console.log('${vo.signImg}')
			
			//同意签约
			$("#ty").on('click',function(){
				 var lableJson=[]
			   	   
		  	      //获取标签权值
		  	 	   $(".ylbq").each(function(i){
		  	 		      var map={}
		  	 		      var totalValue=0;
			  	 		  $(this).find('input:checkbox').each(function(){
			  	 			  var that=$(this);
			  	 			 if(that.is(':checked')) {
			  	 				var ckvalue=parseInt(that.val()); 
			  	 				totalValue+=ckvalue;
			  	 			
			  	 			}
			  	 		  });
		   			  if(totalValue===0){
		  					totalValue=1;
		  				}
		  	 		 
		  	 		  var personId=$(this).find('input[name="personId"]').val();
		  	 		  map['personId']=personId;
		  	 		  map['value']=totalValue;
		  	 		  lableJson.push(map)
		  	 		  console.log(map)
		  	 	   })
				alert(lableJson)
				layer.confirm('确认签约？', {icon: 3,id : Math.ceil(100)}, function(index){
				$.ajax({
					url:'/FWS/signAdmin/saveDoctorSign',
					type:'POST',
					data:{
						userName : '${sessionScope.doc_session.userName}',
						requestId:$('#reqsignId').val(),
						personId :'${vo.personId}',
	  	 				labelJson:JSON.stringify(lableJson)
					},
					success : function(data) {
							if(data.code == 200){
								var index = parent.layer.getFrameIndex(window.name);
								parent.layer.close(index);
								parent.layer.msg('签约处理成功！',{icon: 1});
								parent.tableConfig();
							}else{
								parent.layer.msg('确认签约操作失败！'+data.msg,{icon: 2});
							}
						}
				})
			  })
			})
		//拒绝签约
		$("#cancle").on('click',function(){
			var ss='${sessionScope.doc_session.userName}'
			layer.confirm('确认拒绝？', {icon: 3,id : Math.ceil(100)}, function(index){
			$.ajax({
				url:'/FWS/signAdmin/cancleSignRequestFWS',
				type:'POST',
				data:{
					userName: '${sessionScope.doc_session.userName}',
					requestId:$('#reqsignId').val()
				},
				success : function(data) {
						if(data.code == 200){
							var index = parent.layer.getFrameIndex(window.name);
							parent.layer.close(index);
							parent.layer.msg('操作成功,你已经拒绝签约！',{icon: 1});
							parent.tableConfig();
						}else{
							parent.layer.msg('拒绝操作失败！',{icon: 2});
						}
					}
			 })
		   })
	    })


});

</script>


</body>
</html>