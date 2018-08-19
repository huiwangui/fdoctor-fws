<%@ page import="com.boco.common.utils.PropertiesUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的居民详细信息</title>
<head>
    <meta charset="utf-8">
    <title>我的居民详细信息</title>
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
    <script type="text/javascript" src="/FWS/statics/js/echarts.common.min.js"></script>
     <script type="text/javascript" src="/FWS/statics/jquery-easyui-1.5.2/jquery.easyui.min.js"/>
    <link href="/FWS/statics/jquery-easyui-1.5.2/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/FWS/statics/jquery-easyui-1.5.2/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/FWS/statics/jquery-easyui-1.5.2/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <% String webIP=PropertiesUtils.getValue("ftp_web_server_ip"); %>
    
</head>
<style>
	h5{
	font-size:14px;
	}
</style>
<body style=" background-color: gainsboro;">
    <div class="head" >
			<a href="/" style="padding:10px 80px 0 20px;">我的居民</a>
		</div>
		<div class="person_msg clearfix">
			<div class="l">
				<div class="pic">
					<img src="<%=webIP %>/${vo.personInfo.img}" alt="" />
				</div>
				<div class="p_brief">
					<div class="name">
						${vo.personInfo.personName}
					</div>
					<div class="">
						<span>${vo.personInfo.sex}</span>
						<span>${vo.personInfo.age}岁</span>
						<span>${vo.personInfo.nation}</span>
					</div>
				</div>
			</div>
			
			<div class="r" >
				<div class="h_chose">
				
				<c:forEach  items="${vo.labelList}" var="item" >
					<c:if test="${item.selectFlag==1}">
					  <a href="javascript:;" style="color:red;">${item.labelName}</a>
					</c:if>
					
					<c:if test="${item.selectFlag==0}">
				      <a href="javascript:;">${item.labelName}</a>
				     </c:if>
			   </c:forEach>
					
				</div>
				<div class="clear"></div>
				<div class="">
					<table>
						<tr>
							<td>身份证号：</td>
							<td>${vo.personInfo.idCard}</td>
							<td>健康档案编码：</td>
							<td>${vo.personInfo.personCode}</td>
							<td>手机号码：</td>
							<td>${vo.personInfo.phoneNumber}</td>
						</tr>
						<tr>
							<td>身高：</td>
							<td>${vo.personInfo.height}</td>
							<td>体重：</td>
							<td>${vo.personInfo.weight}</td>
							<td>婚姻状况：</td>
							<c:if test="${vo.personInfo.marryStatus==1}">
						       <td>未婚</td>
						    </c:if>
						    <c:if test="${vo.personInfo.marryStatus==2}">
						       <td>已婚</td>
						    </c:if>
						    <c:if test="${vo.personInfo.marryStatus==3}">
						       <td>丧偶</td>
						    </c:if>
						    <c:if test="${vo.personInfo.marryStatus==4}">
						       <td>离婚</td>
						    </c:if>
						    <c:if test="${vo.personInfo.marryStatus==5}">
						       <td>未说明的婚姻状况</td>
						    </c:if>
						     <c:if test="${vo.personInfo.marryStatus eq ''}">
						       <td></td>
						    </c:if>
						</tr>
						<tr>
							<td>医疗费用支付方式：</td>
						     <c:if test="${vo.personInfo.paymentWaystring==1}">
						       <td>成长职工基本医疗保险</td>
						     </c:if>
						      <c:if test="${vo.personInfo.paymentWaystring==2}">
						       <td>城镇居民基本医疗保险</td>
						     </c:if>
						      <c:if test="${vo.personInfo.paymentWaystring==4}">
						       <td>新型农村合作医疗</td>
						     </c:if>
						      <c:if test="${vo.personInfo.paymentWaystring==8}">
						       <td>商业医疗保险</td>
						     </c:if>
						      <c:if test="${vo.personInfo.paymentWaystring==16}">
						       <td>全公费</td>
						     </c:if>
						     <c:if test="${vo.personInfo.paymentWaystring==32}">
						       <td>全自费</td>
						     </c:if>
						     <c:if test="${vo.personInfo.paymentWaystring==64}">
						       <td>其它</td>
						     </c:if>
							<td>家庭住址：</td>
							<td>${vo.personInfo.phoneNumber}</td>
							<td><a onclick="subfram()" class="aaa">家庭成员</a></td>
							<td></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		
	












   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend></legend>
</fieldset>
<div class="layui-collapse" lay-accordion="">
  <div class="layui-colla-item">
    <h5 class="layui-colla-title">血压     <a onclick="getList()" style="color:#08c;">血压记录></a></h5>
    <div class="layui-colla-content layui-show">
       <div id="main" style="width: 500px;height:360px;" class="layui-inline" ></div>
       <div id="main2" style="width: 500px;height:360px;" class="layui-inline" ></div>
    </div>
  </div>
  
 <div class="layui-colla-item">
    <h5 class="layui-colla-title">血糖     <a onclick="getXTList()" style="color:#08c";>血糖记录></a></h5>
    <div class="layui-colla-content layui-show">
       <div id="mainxt" style="width: 500px;height:360px;" class="layui-inline" ></div>
       <div id="mainxt2" style="width: 500px;height:360px;" class="layui-inline" ></div>
    </div>
  </div>
  
  <div class="layui-colla-item">
    <h5 class="layui-colla-title">签约服务包信息</h5>
    
    <div class="layui-colla-content">
    <div >
    <input  type="hidden"  id="pp"/>
    <c:forEach  items="${packs}" var="item">
       <span>
        <button  type="button" class="layui-btn layui-btn-small"  onclick="getPackById('${item.id}')">${item.packName}</button>
       </span>
     </c:forEach>
      </div>
         	<div id="content" style="width: 100%; height: 100%;"></div>
			
		
    </div>
  </div>
 
</div>
	<!-- 随访管理 -->
<!-- 	<div>
		<div>
			<span>随访管理</span>
		    <button  type="button" class="layui-btn layui-btn-small"  onclick="getgxy()">高血压</button>
		    <button  type="button" class="layui-btn layui-btn-small"  onclick="gettnb()">糖尿病</button>
		</div>
		
		<div id="contentgxy" style="width: 100%; height: 100%;"></div>
		
		<div id="contenttnb" style="width: 100%; height: 100%;"></div>
	
	</div> -->
	
	<!-- 检查报告 -->
	<div style="box-sizing:border-box; padding:0 0 20px 0">
		<div style="padding:10px 0 0 15px">
			<span>检查检验报告</span>
		    <button  type="button" class="layui-btn layui-btn-small"  onclick="UploadReport()">上传</button>
		</div>
				
	   <table class="layui-table" lay-skin="line">
		  <colgroup>
		    <col width="150">
		    <col width="150">
		    <col width="200">
		    <col>
		  </colgroup>
		  <thead>
		    <tr>
		     
		      <th>上传者</th>
		      <th>上传时间</th>
		       <th>报告描述</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody id="trdiv">
			    <tr>
			      <td></td>
			      <td></td>
			      <td></td>
			      <td></td>
			    </tr>
		  </tbody>
		</table>   
		
	<button style="margin:0 0 0 15px" type="button" class="layui-btn layui-btn-small"  onclick="moreReport()">更多</button>
	</div>

<script>
console.log('${voJson}')
layui.use(['element', 'layer'], function(){
  var element = layui.element();
  var layer = layui.layer;
  
 
  //监听折叠
  element.on('collapse(test)', function(data){
    layer.msg('展开状态：'+ data.show);
  });
});
</script>


   
   <script type="text/javascript">
	   // 基于准备好的dom，初始化echarts实例
	   var myChart = echarts.init(document.getElementById('main'));
	   var myChart2 = echarts.init(document.getElementById('main2'));
	   var myChartxt = echarts.init(document.getElementById('mainxt'));
	   var myChartxt2 = echarts.init(document.getElementById('mainxt2'));
	   
	   
	   //血糖占比
	   $.ajax({

		   type: "GET",

		   url: '${fws}/resident/getBloodSugerNum?personId='+'${vo.personInfo.personId}',

		   dataType:"text",

		    success: function(data){
		        data=$.parseJSON(data);
		       var chart;

		    $(document).ready(function() {
			   myChartxt.setOption({
					   title : {
					        text: '血糖占比分析',
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        orient: 'vertical',
					        left: 'left',
					        data: ['偏低','偏高','正常']
					    },
					    series : [
					        {
					            name: '访问来源',
					            type: 'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            data:[
					                {value:data.low, name:'偏低'},
					                {value:data.high, name:'偏高'},
					                {value:data.nor, name:'正常'}
					            ],
					            itemStyle: {
					                emphasis: {
					                    shadowBlur: 10,
					                    shadowOffsetX: 0,
					                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					                }
					            }
					        }
					    ]
				});

		     })
		   }
		 })
		
	   
				   // 指定图表的配置项和数据
				  option = {
				    title : {
				        text: '血压占比分析',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient: 'vertical',
				        left: 'left',
				        data: ['偏低','偏高','正常']
				    },
				    series : [
				        {
				            name: '访问来源',
				            type: 'pie',
				            radius : '55%',
				            center: ['50%', '60%'],
				            data:[
				                {value:'${lowCount}', name:'偏低'},
				                {value:'${highCount}', name:'偏高'},
				                {value:'${normalCount}', name:'正常'}
				            ],
				            itemStyle: {
				                emphasis: {
				                    shadowBlur: 10,
				                    shadowOffsetX: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				  };
	   
      

       
       // 使用刚指定的配置项和数据显示图表。
       myChart.setOption(option);
       // 异步加载数据
       function getJson(){
    	   
    	   $.ajax({

    		   type: "GET",

    		   url: '${fws}/resident/getHypertensionListByTimeOnly?personId='+'${vo.personInfo.personId}',

    		   dataType:"text",
    	   
    		   success: function(data){
    			   $data=$.parseJSON(data);
    			   var sbp=$data.Sbp
    			   var sbpre=sbp.reverse()
    			   
    			   var dbp=$data.Dbp
    			   var dbpre=dbp.reverse()
    			   option2 = {
    		    		    title: {
    		    		        text: '最近7次血压',
    		    		    },
    		    		    tooltip: {
    		    		        trigger: 'axis'
    		    		    },
    		    		    legend: {
    		    		        data:['收缩压','舒张压']
    		    		    },
    		    		    toolbox: {
    		    		        show: true,
    		    		       
    		    		    },
    		    		    xAxis:  {
    		    		        type: 'category',
    		    		        boundaryGap: false,
    		    		        data: ['一','二','三','四','五','六','七']
    		    		    },
    		    		    yAxis: {
    		    		        type: 'value',
    		    		        axisLabel: {
    		    		            formatter: '{value} '
    		    		        }
    		    		    },
    		    		    series: [
    		    		        {
    		    		            name:'收缩压',
    		    		            type:'line',
    		  	                    data: sbpre,
    		    		            markLine: {
    		    		            	data: [
    		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 100},
    		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 120}
    		       		                ]
    		    		            }
    		    		        },
    		    		        {
    		    		            name:'舒张压',
    		    		            type:'line',
    		    		            data: dbpre,
    		    		            markLine: {
    		    		            	data: [
    		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 80},
    		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 60}
    		       		                ]
    		    		            }
    		    		           
    		    		        }
    		    		    ]
    		    		};
    			   myChart2.setOption(option2);
    		   }
    		    	
    	   })
       }
       
       
 function getBSJson(){
    	   $.ajax({
    		   type: "GET",
    		   url: '${fws}/resident/getBloodSugerListByTimeOnly?personId='+'${vo.personInfo.personId}',
    		   dataType:"text",
    		   success: function(data){
    			   $dataxt=$.parseJSON(data);
    			   optionxt2 = {
    		    		    title: {
    		    		        text: '最近7次血糖',
    		    		    },
    		    		    tooltip: {
    		    		        trigger: 'axis'
    		    		    },
    		    		    legend: {
    		    		        data:['血糖']
    		    		    },
    		    		    toolbox: {
    		    		        show: true,
    		    		       
    		    		    },
    		    		    xAxis:  {
    		    		        type: 'category',
    		    		        boundaryGap: false,
    		    		        data: ['一','二','三','四','五','六','七']
    		    		    },
    		    		    yAxis: {
    		    		        type: 'value',
    		    		        axisLabel: {
    		    		            formatter: '{value} '
    		    		        }
    		    		    },
    		    		    series: [
    		    		        {
    		    		            name:'血糖',
    		    		            type:'line',
    		  	                    data: $dataxt.reverse(),
    		    		            markLine: {
    		    		            	data: [
    		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 100},
    		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 120}
    		       		                ]
    		    		            }
    		    		        },
    		    		       
    		    		    ]
    		    		};
    			   myChartxt2.setOption(optionxt2);
    		   }
    		    	
    	   })
       }
    	   
		 getJson()    	   
		 getBSJson()    
       function getList(){
		  event.stopPropagation();
    	  var index = layer.open({
			    type: 2
	   			,area: ['560px', '430px']
	   	        ,title :'近7次血压记录'
		   	    ,content: '${fws}/resident/getHypertensionList?personId='+'${vo.personInfo.personId}'
		   	    ,cancel: function(index, layero){ 
		   	    	getJson()
    			}    
    		});		
       }
       
       function getXTList(){
    	   event.stopPropagation();
    	   var index = layer.open({
			    type: 2
	   			,area: ['560px', '430px']
	   	        ,title :'近7次血糖记录'
		   	    ,content: '${fws}/resident/getBloodList?personId='+'${vo.personInfo.personId}'
		   	    ,cancel: function(index, layero){ 
		   	    	getBSJson()
    			}    
    		});		
        }
       
     
       
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
                   url: '/FWS/resident/getServicePackDetail',
                   pageSize: 10,
                   columns: [ {
                       fieldName: '服务项目',
                       field: 'serviceName'
                   }, {
                       fieldName: '频次',
                       field: 'frequency',
                       colRender : 'frequencyRender'
                   }, {
                       fieldName: '服务内容',
                       field: 'serviceDetails',
                       
                   } ],
                   even: true,
                   //skin: 'row',
                   checkbox: false,
                   singleSelect: true,
                   field: 'id',
                   paged: false,
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
       		packId:packid
			   	}
       	return params;
       }
       
       function frequencyRender (data){
       	if(data == '-1'){
       		return '不限';
       	}else{
       		return data;
       	}
       }
       
     var  packid='${packs[0].id}';
     function  getPackById(id){
    	 packid=id;
    	 tableConfig()
       }
     

   </script>
   <script type="text/javascript">

   $.ajax({
		url:'/FWS/resident/getAllUserReportByDoc',
		type : 'GET',
		async: false,
		data : {
			personId :'${personId}',
			date1:'',
			date2:'',
			zy:'zy',
			pageSize:10,
			pageIndex:1
		},
		success : function(data) {
		console.log(456)
		var data=data.list
		console.log(data)
				 var str='';
				for(var i=0;i<data.length;i++){
					var name=data[i].personName
					if(name=='null'||name==''){
						name=data[i].docName
					}
					if(data=="null"||typeof (name)=="undefined"||name==null){
						name=data[i].docName
					}
				str+='     <tr>'+
				'		      <td>'+name+'</td>'+
				'		      <td>'+data[i].uptimeStr+'</td>'+
				'  <td>'+data[i].reportDescription+'</td>'+
				'		      <td><a onclick="getDetail('+data[i].tid+')">详情</a></td>'+
				'		    </tr>';
				}
				$('#trdiv').append(str) 
				
		}
	}) 
   
   function getDetail(id){
	   
	 layer.open({
		    type: 2
  			,area: ['560px', '430px']
  	        ,title :'报告详情'
	   	    ,content: '${fws}/resident/getDetail?tid='+id
	   	     
		});		
	   
	   
	   
   } 
   
  function moreReport(){
	   var indexs=layer.open({
		    type: 2
 			,area: ['560px', '430px']
 	        ,title :''
	   	    ,content: '${fws}/resident/getMoreReport?personId='+'${personId}'
	   	     
		});	
	   layer.full(indexs);
	   
   } 
  
  //上传报告
  function UploadReport(){
	  
	  var indexsup=layer.open({
		    type: 2
	        ,title :'上传报告'
	   	    ,content: '${fws}/resident/upReport?personId='+'${personId}'
	   	     
		});	
	   layer.full(indexsup);
  }
   
  
  
  function  subfram(){
	 var x='${familyMember}'
	 x=JSON.parse(x)
	    layui.use('layer', function(){ 
	   		  var $ = layui.jquery, 
	   		  layer = layui.layer; //独立版的layer无需执行这一句
	   		  var str='';
	   		  
		   	  for (var i = 0; i <x.length; i++) {
		   		  var currentAddress=x[0].currentAddress;
		   		  var sexStr='';
		   		  if(x[i].sex==1){
		   			sexStr='男'
		   		  }else{
		   			sexStr='女'  
		   		  }
		   		var huzhu='<li style="border-bottom: 1px solid #007AFF">'+x[0].personName+'  &nbsp&nbsp&nbsp  '+sexStr+'&nbsp&nbsp&nbsp     '+x[0].age+'岁<a style="color:red;">（户主）</a></br>'+x[0].customNumber+'</li>'
		   		if(i>0){
			   	    str+='<li style="border-bottom: 1px solid #007AFF">'+x[i].personName+'  &nbsp&nbsp&nbsp  '+sexStr+'&nbsp&nbsp&nbsp     '+x[i].age+'岁</br>'+x[i].customNumber+'</li>'

		   		}
		   	  }; 
		   	  var hs=huzhu+str
		      var tds = '<div><ui><li style="border-bottom: 1px solid #007AFF">住址：'+currentAddress+'</li>'+hs+'</ui></div>';
		      
	   		  layer.open({
	   		    scrollbar: true
	   		    ,fixed: true //不固定
			   	,area: ['450px', '360px']
			   	,skin: 'layui-layer-rim' //加上边框
	   	        ,title :'家庭成员'
		   	    ,content: tds
	   	        ,btnAlign: 'c' //按钮居中
	   	        ,shade: 0 //不显示遮罩
	   	       
	   	      });
 		  
 		});
   } 
   
   </script>
  
   
  
</body>
</html>