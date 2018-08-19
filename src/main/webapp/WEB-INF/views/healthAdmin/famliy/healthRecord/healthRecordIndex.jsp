<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>居民档案</title>
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/btable.css" />
    <script type="text/javascript" src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>

</head>
<body>
	
		
		<!--********************表单开始**************************-->
<form class="layui-form" action="" style="margin-top:20px">
<div class="layui-form-item">
	<div class="layui-inline">
      <label class="layui-form-label">居民状态</label>
      <div class="layui-input-inline">
        <select name="IsStatus"  id="IsStatus" lay-verify="required" lay-search="">
            <option value="">直接选择或搜索选择</option>
	        <option value="0">活动</option>
			<option value="1">迁出 </option>
			<option value="2">死亡</option>
			<option value="99">已删除</option>
			<option value="3">其他</option>
        </select>
      </div>
    </div>
    
    <div class="layui-inline">
      <label class="layui-form-label">性别：</label>
      <div class="layui-input-inline">
       <select name="Gender" id="Gender">
			<option value="">请选择 </option>
			<option value="">全部</option>
			<option value="1">男</option>
			<option value="2">女 </option>
		</select>
      </div>
    </div>
 
  <div class="layui-inline">
      <div class="layui-input-inline">
       <select name="KeyCode" id="KeyCode">
			<option value="1">姓名或拼音</option>
			<option value="2">身份证</option>
			<option value="3">档案号</option>
			<option value="4">自定义编码</option>
			<option value="5">联系电话</option>
		</select>
      </div>
      
     
    <div class="layui-input-inline">
      <input type="text" name="KeyValue" id="KeyValue"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>
 </div>
			
				
	<div class="layui-inline" >
			<button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
	 </div>  
	 
	<div>
		  <div class="layui-btn-group" style="margin-left:20px;margin-top:20px;">
			   <button class="layui-btn layui-btn-primary layui-btn-small" type="button" id="editPeople"><i class="layui-icon">&#xe642;</i>编辑居民档案</button>
			   <button class="layui-btn layui-btn-primary layui-btn-small"  type="button" id="editFamily"><i class="layui-icon">&#xe642;</i>编辑家庭档案</button>
<!-- 			   <button class="layui-btn layui-btn-primary layui-btn-small" type="button" id="personInfo"><i class="layui-icon">&#xe642;</i>居民档案浏览</button> -->
			    <button class="layui-btn layui-btn-primary layui-btn-small" type="button" id="delperson"><i class="layui-icon">&#xe642;</i>删除居民档案</button>
		  </div>
	 </div>	
 <div id="content" style="width: 100%;height: 500px;"></div>
</form>
		<!--********************表单结束**************************-->
	
</body>

<script type="text/javascript">
 

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
                url: '/FWS/famliy/index',
                pageSize: 10,
                columns: [{
                    fieldName: '编号',
                    field: 'ID',
                    hidden:	true
                }, {
                    fieldName: '家庭ID',
                    field: 'FAMILY_ID',
                    hidden:	true
                },{
                    fieldName: '姓名',
                    field: 'NAME'
                }, {
                    fieldName: '管理病种',
                    field: 'TJ',
                    colRender : 'tjRender'
                }, {
                    fieldName: '性别',
                    field: 'GENDER',
                },
                {
                    fieldName: '年龄',
                    field: 'AGE',
                },{
                    fieldName: '联系电话',
                    field: 'TELPHONE',
                    colRender : 'telRender'
                },{
                    fieldName: '状态',
                    field: 'HRSTATUS',
                },
                {
                    fieldName: '是否完善',
                    field: 'SOPHISTICATION',
                },
                {
                    fieldName: '最后体检时间',
                    field: 'LASTTIME',
                    colRender : 'timeRender'
                },
                {
                    fieldName: '最近体检是否完善',
                    field: 'HMPERFECT',
                },],
                even: true,
                //skin: 'row',
                checkbox: true,
                singleSelect: true,
                field: 'ID',
                paged: true,
                params : getParams(),
            });
            btable.render();
           
            $(window).on('resize', function (e) {
                var $that = $(this);
                $('#content').height($that.height() - 92);
            }).resize(); 
            
            
           
            
          //编辑居民档案
       	 $('#editPeople').on('click', function () {		
       		
       		 btable.getSelections(function (obj) {
               	if(obj.count == 0){
               		layer.msg('请选择要修改的数据',{icon: 7,id : Math.ceil(100)});
               		return
               	}else{	
             		    var	ID =obj.elem[0].context.cells[1].innerHTML
             		    var	FAMILY_ID=obj.elem[0].context.cells[2].innerHTML
             		    layer.open({
               			title : '编辑居民档案',
               			id : Math.ceil(100),
							type: 2,
							area: ['70%', '80%'],
							fixed: false, //不固定
							maxmin: true,
							content: "/FWS/famliy/queryPeopleInfomation?ID="+ID+"&FamilyId="+FAMILY_ID
               		});
       	         }
       			 
                 });
            });
          
		      //编辑家庭档案
			 $('#editFamily').on('click', function () {			 
					btable.getSelections(function (obj) {
		               	if(obj.count == 0){
		               		layer.msg('请选择要修改的数据',{icon: 7,id : Math.ceil(100)});
		               		return
		               	}else{	
		             		    var	ID =obj.elem[0].context.cells[1].innerHTML
		             		    var	FAMILY_ID=obj.elem[0].context.cells[2].innerHTML
		             		    layer.open({
	                    			title : '编辑家庭档案',
	                    			id : Math.ceil(100),
									type: 2,
									area: ['70%', '80%'],
									fixed: false, //不固定
									maxmin: true,
									content: "/FWS/famliy/queryFamilyInfomation?ID="+ID+"&FamilyId="+FAMILY_ID
	                    		});
		             		    
		       	         }
		       			 
		             });
					
		     });
		     //点击居民档案浏览
		      $('#personInfo').on('click', function () {			 
				    btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择一位居民！',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    		layer.open({
                    			title : '居民档案浏览',
                    			id : Math.ceil(100),
								type: 2,
								area: ['70%', '80%'],
								fixed: false, //不固定
								maxmin: true,
								content: "/FWS/famliy/personRecordbrowse?personId="+obj.ids[0]
                    		});
                    	}
                    });
				
					
		     });
		    //居民档案删除
		      $('#delperson').on('click', function () {			 
				    btable.getSelections(function (obj) {
                    	if(obj.count == 0){
                    		layer.msg('请选择一位居民！',{icon: 7,id : Math.ceil(100)});
                    	}else{
                    	/* 	layer.open({
                    			title : '居民档案浏览',
                    			id : Math.ceil(100),
								type: 2,
								area: ['70%', '80%'],
								fixed: false, //不固定
								maxmin: true,
								content: "/FWS/famliy/deletePersonRecord?personId="+obj.ids[0]
                    		}); */
                    		/* $.ajax({
            					type:'POST',
            					url:"/FWS/famliy/deletePersonRecord",
            					data:JSON.stringify({personId:obj.ids[0]}),
            					success:function(data){
            						if(data.code==200){
            							layer.msg("删除成功",{icon:1})
            							tableConfig();
            						}
            						layer.msg("删除失败"+data.data)
            					}
            				}) */
                    		$.post("/FWS/famliy/deletePersonRecord",{personId:obj.ids[0]},function(result){
                    			if(result.code==200){
        							layer.msg("删除成功",{icon:1})
        							tableConfig();
        						}else{layer.msg("删除失败"+result.msg)}
        						
                    		});
                    	}
                    });
				
					
		     });
          
          
        });
	}
	
	//tableConfig();
	
	
	 function  tjRender(data){
     	if(data==null||data==""||data=="null"){
     		return "-"
     	}else{
     		return data
     	}
     }
     
     function  timeRender(data){
     	if(data==null||data==""||data=="null"){
     		return "-"
     	}else{
     		return data
     	}
     }
     
     function  telRender(data){
     	if(data==null||data==""||data=="null"){
     		return "-"
     	}else{
     		return data
     	}
     }

	//查询按钮声明点击事件，查询逻辑
    $('#selectButton').on('click', function(){
    	tableConfig();
    });
   
    function getParams(){
    	
    	var params = {
    			  IsStatus:document.getElementById("IsStatus").value,
	          	  Gender:document.getElementById("Gender").value,
	          	  KeyCode: document.getElementById("KeyCode").value,
	          	  KeyValue: $("#KeyValue").val(),				          
			   	}
    	console.log(params)
    
    	return params;
    }
	
    
    
		
	
</script>
</html>
