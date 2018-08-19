<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评估详情</title>
<head>
    <meta charset="utf-8">
    <title>评估</title>
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
    
</head>

<body style=" background-color: gainsboro; box-sizing:border-box;padding:0 0 20px 15px">
	<div style="height: 30px; line-height: 30px;">
	<span>测量时间:</span>${crtime}
	</div>
	<div style="height: 30px; line-height: 30px;">
	<span>异常指标:</span>${detail.outlierData}
	</div>
	<div style="height: 30px; line-height: 30px; margin-bottom:20px">
	<span>备注说明:</span>${detail.remark}
	</div>
	<div>
	<span>关键字:</span><font style="color: blue">${keyWords}</font>
	</div>
	  
	<div  id="xyjs" class="layui-collapse" lay-accordion="" style="margin-bottom:20px">
	  <span style="line-height:30px; padding-left:20px; color:#08c">最近7次血压记录</span>
	  <div class="layui-colla-item">
	    <div class="layui-colla-content layui-show">
	       <div id="main" style="width: 500px;height:360px;" class="layui-inline" ></div>
	       <div id="main2" style="width: 500px;height:360px;" class="layui-inline" ></div>
	    </div>
	  </div>
	</div>
	
	<div id="xtjs" class="layui-collapse" lay-accordion="" style="margin-bottom:20px">
	  <span style="line-height:30px; padding-left:20px; color:#08c">最近7次血糖记录</span>
	  <div class="layui-colla-item">
	    <div class="layui-colla-content layui-show">
	        <div id="main3" style="width: 500px;height:360px;" class="layui-inline" ></div>
	    </div>
	  </div>
	</div>
	
	<div>
	<span>医生建议：</span>${detail.content }
	</div>
	<div><span>用药指导：</span>${detail.medicationGuide }
	</div>
<script>
layui.use(['element', 'layer'], function(){
  var element = layui.element();
  var layer = layui.layer;
  console.log('${crtime}')
  
  //监听折叠
  element.on('collapse(test)', function(data){
    layer.msg('展开状态：'+ data.show);
  });
});
</script>


   
   <script type="text/javascript">
	   var ycdata='${detail.outlierData}';
	   if(ycdata.indexOf("糖")!=-1){
		    $('#xyjs').hide()
		    $('#xtjs').show()
		    getBSJson();
		}
	   if(ycdata.indexOf("压")!=-1){
		   $('#xtjs').hide()
			   $('#xyjs').show()
			   getJson() 
	   }
	   
	   // 基于准备好的dom，初始化echarts实例
	    var myChartxt = echarts.init(document.getElementById('main3'));
	    var myChart2 = echarts.init(document.getElementById('main2'));
	    var myChart = echarts.init(document.getElementById('main'));
	  
       // 异步加载数据
       function getJson(){
    	   $.ajax({

    		   type: "GET",

    		   url: '${fws}/resident/getHypertensionListByTimeOnly?personId='+'${detail.personId}',

    		   dataType:"text",
    	   
    		   success: function(data){
    			   
    			   $data=$.parseJSON(data);
    			   console.log($data)
    			   var sbp=$data.Sbp
    			   var sbpre=sbp.reverse()
    			   
    			   var dbp=$data.Dbp
    			   var dbpre=dbp.reverse()
    			   option2 = {
    		    		    title: {
    		    		        text: '最近7次收缩压',
    		    		    },
    		    		    tooltip: {
    		    		        trigger: 'axis'
    		    		    },
    		    		    legend: {
    		    		        data:[]
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
    		    		        }
    		    		    
    		    		    ]
    		    		};
    			   
    			   option = {
   		    		    title: {
   		    		        text: '最近7次舒张压',
   		    		    },
   		    		    tooltip: {
   		    		        trigger: 'axis'
   		    		    },
   		    		    legend: {
   		    		        data:[]
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
   		    		            name:'舒张压',
   		    		            type:'line',
   		  	                    data: dbpre,
   		    		            markLine: {
   		    		            	data: [
   		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 60},
   		       		                    {name: 'Y 轴值为 100 的水平线', yAxis: 80}
   		       		                ]
   		    		            }
   		    		        }
   		    		    
   		    		    ]
   		    		};
    			   
    			   myChart2.setOption(option2);
    			   myChart.setOption(option);
    		   }
    		    	
    	   })
       }
       
     
       
        function getBSJson(){
    	   $.ajax({
    		   type: "GET",
    		   url: '${fws}/resident/getBloodSugerListByTimeOnly?personId='+'${detail.personId}',
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
    			   myChartxt.setOption(optionxt2);
    		   }
    		    	
    	   })
       }
       
       
      
    	 /*   if(keyword.indexOf("血糖")!=-1){
   		    $('#xyjs').hide()
   		    $('#xtjs').show()
   		    getBSJson();
   		}
   	   if(keyword.indexOf("血压")!=-1){
   		      $('#xtjs').hide()
 			   $('#xyjs').show()
 			   getJson() 
   	   } */
     

   </script>
  
   
  
</body>
</html>