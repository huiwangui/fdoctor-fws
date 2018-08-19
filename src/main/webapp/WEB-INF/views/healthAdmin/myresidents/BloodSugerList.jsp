<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的居民签约居民查询</title>
<head>
    <meta charset="utf-8">
    <title>签约居民记录查询</title>
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
         <div class="layui-inline">
	     日期
	      <div class="layui-input-inline">
	        <input type="text" name="date" id="date1" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
	      </div>
        </div>
		 
		 
		  <div class="layui-inline" >
			 <div class="layui-form-item"  style="margin-top: 20px;">  
				   <div class="layui-inline" >
						 <div class="layui-input-inline">
				    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
				    	 </div>
					</div>
			 </div>
		 </div>  
		  
		 
			 
			</form>
        </blockquote>
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
                    url: '/FWS/resident/getBloodSugerListByTime',
                    pageSize: 10,
                    columns: [{
                        fieldName: '日期',
                        field: 'timeStamp',
                        colRender : 'timeRender'
                    }, {
                        fieldName: '血糖值（mmol/L）',
                        field: 'bloodSuger',
                    }],
                    even: true,
                    //skin: 'row',
                    checkbox: false,
                    singleSelect: true,
                    paged: true,
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
        	console.log(Date.parse(new Date($("#date1").val())))
        	var params = {
        		personId : '${personId}',
        		qrtime: Date.parse(new Date($("#date1").val())),
 			   	}
        	return params;
        }
        
        function timeRender(data){
        	
        	var newDate = new Date();
        	newDate.setTime(data);
        	console.log(newDate.toJSON());// 2017年7月17日 
        	
        	return newDate.format('yyyy-MM-dd h:m:s')
        }
	 
	     
	     
   	     
    </script>
    
    <script>
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  
	  var start = {
		 min: '2010-01-01 00:00:00'
	    ,max: '2099-06-16 23:59:59'
	    ,istoday: false
	    ,choose: function(datas){
	      end.min = datas; //开始日选好后，重置结束日的最小日期
	      end.start = datas //将结束日的初始值设定为开始日
	    }
	  };
	  
	  var end = {
	     min: '2010-01-01 00:00:00'
	    ,max: '2099-06-16 23:59:59'
	    ,istoday: false
	    ,choose: function(datas){
	      start.max = datas; //结束日选好后，重置开始日的最大日期
	    }
	  };
	  
	  document.getElementById('date1').onclick = function(){
	    start.elem = this;
	    laydate(start);
	  }
	  
	});
	
	
	Date.prototype.format = function(format) {
	       var date = {
	              "M+": this.getMonth() + 1,
	              "d+": this.getDate(),
	              "h+": this.getHours(),
	              "m+": this.getMinutes(),
	              "s+": this.getSeconds(),
	              "q+": Math.floor((this.getMonth() + 3) / 3),
	              "S+": this.getMilliseconds()
	       };
	       if (/(y+)/i.test(format)) {
	              format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
	       }
	       for (var k in date) {
	              if (new RegExp("(" + k + ")").test(format)) {
	                     format = format.replace(RegExp.$1, RegExp.$1.length == 1
	                            ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
	              }
	       }
	       return format;
	}
</script>

</body>
</html>