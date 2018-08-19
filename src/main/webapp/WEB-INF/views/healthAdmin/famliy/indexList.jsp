<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>家庭档案列表</title>
<head>
    <meta charset="utf-8">
    <title>家庭档案列表</title>
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
        
		 
		 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-top: 18px">  
			  <label class="layui-form-label">关键字：</label>
				   <div class="layui-inline" style="width:10%;margin-left: 0px;float:left" >
						<div class="layui-input-inline">
							<input type="text" id="personName" name="personName" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
						</div>
						
				    	
					</div>
			 </div>
		 </div>    
		 
		 <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-top: 18px">  
			  <label class="layui-form-label">家庭编号：</label>
				   <div class="layui-inline" style="width:10%;margin-left: 0px;float:left" >
						<div class="layui-input-inline">
							<input type="text" id="familyCode" name="personName" lay-verify="required" placeholder="请输入家庭编号" autocomplete="off" class="layui-input">
						</div>
						
				    	
					</div>
			 </div>
		 </div>    
		 
		 	 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-left: 0px;margin-top: 18px">  
				   <div class="layui-inline" style="width:10%;margin-left: 0px;float:left" >
						 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
				    	 </div>
					</div>
			 </div>
		 </div>  
		 
		 <div class="layui-inline">
		      <label class="layui-form-label">是否空家庭</label>
		      <div class="layui-input-inline">
		        <select name="modules" lay-verify="required" lay-search="" id="IsEmpty">
		          <option value="">直接选择或搜索选择</option>
		          <option value="">否</option>
		          <option value="1">是</option>
		         
		        </select>
		      </div>
		    </div>
         </div>
		
			 
	</form>
        </blockquote>
        	<div class="layui-btn-group" style="margin-left:20px">
		    <button class="layui-btn"  type="button" id="add">增加</button>
		    <button class="layui-btn"  type="button" id="editFamily">编辑</button>
		    <button class="layui-btn"  type="button" id="deleteFamiy">删除</button>
		  </div>
        <div id="content" style="width: 100%;height: 500px;"></div>
    </div>

    <script>
    
    
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
                    url: '/FWS/famliy/queryList',
                    pageSize: 10,
                    columns: [{
                        fieldName: '编号',
                        field: 'FamilyID',
                        hidden:	true
                    }, {
                        fieldName: '户主姓名',
                        field: 'MasterName',
                        colRender : 'nameRender'
                    }, {
                        fieldName: '家庭编号',
                        field: 'FamilySN',
                    }, {
                        fieldName: '所在区划',
                        field: 'RegionFullName',
                       
                        
                    },],
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
                
                 //编辑家庭档案
	           	 $('#editFamily').on('click', function () {			 
	           			btable.getSelections(function (obj) {
	                          	if(obj.count == 0){
	                          		layer.msg('请选择要修改的数据',{icon: 7,id : Math.ceil(100)});
	                          		return
	                          	}else{	
	                        		   var	FAMILY_ID=obj.elem[0].context.cells[1].innerHTML
	                        		   var index= layer.open({
	                              			title : '编辑家庭档案',
	                              			id : Math.ceil(100),
	           							type: 2,
	           							area: ['70%', '80%'],
	           							fixed: false, //不固定
	           							maxmin: true,
	           							content: "/FWS/famliy/queryFamilyInfomation?FamilyId="+FAMILY_ID
	                              		});
	                        		   layer.full(index)
	                  	         }
	                  			 
	                  });
                 });    
                 
	           	  //删除家庭档案
				  $('#deleteFamiy').on('click', function() {
						btable.getSelections(function (obj) {
	                    	if(obj.count == 0){
	                    		layer.msg('请选择一条记录！',{icon: 7,id : Math.ceil(100)});
	                    	}else{
	                    		layer.msg('确认删除？', {
	                    			icon: 3,
	                    			time: 0, //不自动关闭,
	                    			btn: ['是', '否'],
	                    			yes: function(index){
	                    				/* layer.msg('该功能暂未开放，敬请等待！', {
	        								icon: 4
	        							});
	                    				return */
	                    				var	FAMILY_ID=obj.elem[0].context.cells[1].innerHTML
	                    				/* console.log("家庭档案ID"+FAMILY_ID)
	                    				console.log("家庭档案ID"+FAMILY_ID.length) */
	                    				$.ajax({
	                    					type:'get',
	                    					url:"/FWS/famliy/deleteFamilyDocument",
	                    					data:{ID:FAMILY_ID},
	                    					success:function(data){
	                    						/* console.log("家庭档案删除结果"+data.code)
	                    						console.log("家庭档案删除结果"+data.msg) */
	                    						 if(data.code==200){
	                    							layer.msg("删除成功",{icon:1})
	                    							tableConfig();
	                    						}else{
	                    							layer.msg("删除失败"+data.data) 
	                    						}
	                    						
	                    					}
	                    				})
	                    				
	                    			}
	                    		});
	                    	}
	                    });
					});
	           	  
	           	  
            });
    	}
    	
    	tableConfig();
    	
    	 function  nameRender(data){
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
        		masterName : $('#personName').val().trim(),
        		familyCode:$("#familyCode").val().trim(),
        		IsEmpty:$('#IsEmpty').val()
 			   	}
        	console.log(params)
        
        	return params;
        }
        
        
	//新增档案     
    $("#add").on('click',function(){
    	
    	var index = layer.open({
			    type: 2
	   		    ,scrollbar: true
	   		    ,area:['800px','400px']
			   	,skin: 'layui-layer-rim' //加上边框
	   	        ,title :'新增家庭'
		   	    ,content: '${fws}/famliy/addDoc'
	   	        	//,content: '${fws}/mobile/healthRecord/'
	   	        ,cancel: function(index, layero){ 
	   	          layer.close(index)
	   	          tableConfig();
	   	         }    
	   	       
	   	      });
		layer.full(index); 
    	
    })
    
  	
	
     
   	     
    </script>

   
  
</body>
</html>