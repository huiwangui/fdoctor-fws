<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>标签管理</title>
<head>
    <meta charset="utf-8">
    <title>标签管理</title>
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
 
<table class="layui-table" lay-skin="line">
  <colgroup>
    <col width="150">
    <col width="150">
    <col width="200">
    <col>
  </colgroup>
  <thead>
    <tr>
      <th>标签名称</th>
      <th>人数</th>
      <th>操作</th>
    </tr> 
  </thead>
  <tbody   id="addTr">
   <c:forEach items="${lableList}" var="item">
  
    <tr>
      <td>${item.labelName}</td>
      <td>${item.personCount}</td>
      <c:if test="${item.defaultFlag=='1'}">
      <td>----</td>
      </c:if>
      <c:if test="${item.defaultFlag=='0'}">
      <td><input  class="ids"  type="hidden" value="${item.id}"/><a  class="deletetr" style="color:blue;">删除</a></td>
      </c:if>
    </tr>
     </c:forEach>
     
  </tbody>
</table>   
     <label class="layui-form-label"></label>
    <div class="layui-input-inline">
      <input type="text"  id="labelName" name="labelname" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>
     <button  type="button" class="layui-btn layui-btn-normal"  id="add">添加标签</button>
     
     
     
 <script type="text/javascript">
 layui.use(['jquery', 'form','layer'], function() {
     $ = layui.jquery;
     form = layui.form();
     $form = $('form');
     
     
    $("#add").on('click',function(){
    	var labelname=$('#labelName').val().trim()
    	if(labelname==''||labelname==null){
    		return;
    	}
    	
    	var body={}
    	body['labelName']=$('#labelName').val()
    	body['labelId']='0'
    	body['defaultFlag']='0'
    	body['personIdList']=[]
    	body['teamId']='${sessionScope.doctorInfo.teamId}'
    	console.log(body)
    	 $.ajax({
    		url:'${fws}/resident/editLabel',
    		type : 'POST',
			async: false,
			data : {
				dataJson : JSON.stringify(body)
				
			}
			    
			,
			success : function(data) {
				if(data.code == 200){
  					layer.msg('添加成功！',{icon: 1});
  					var id=data.data
  					addtoTable(id)//添加到表格
  					$('#labelName').val('')
  				}else{
  					layer.msg('添加失败！',{icon: 2});
  				}
			}
    	}) 
    	
    })
    
    
    function  addtoTable(id){
    	console.log(id)
    	var labelName=$('#labelName').val()
    	var  str=''
    	str=' <tr>'+
    	'       <td>'+labelName+'</td>'+
    	'       <td>0</td>'+
    	'       <td> <input  class="ids"  type="hidden" value="'+id+'"/><a  class="deletetr"  style="color:blue;">删除</a></td>'+
    	'       </tr>';
    	
    	$("#addTr").append(str)
    }
    
    
    //事件委托
    $(document).on('click', '.deletetr', function(){
    	var that=$(this)
    	var  id=$(this).siblings().parent().find('.ids').val()
    	console.log("ididididididi")
    	console.log(id)
    	$.ajax({
    		url:'${fws}/resident/delLabel',
    		type : 'POST',
			async: false,
			data : {
				labelId :id
			},
			success : function(data) {
				if(data.code == 200){
					var tr=that.parent().parent();
			  		tr.remove();
  					layer.msg('删除成功！',{icon: 1});
  				}else{
  					layer.msg('删除失败！',{icon: 2});
  				}
			}
    	}) 
  		
	})
    
     
 })
     
    </script>
</body>
</html>