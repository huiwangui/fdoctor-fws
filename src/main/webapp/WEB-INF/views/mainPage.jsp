<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../../views/include/taglib.jsp"%>
<!DOCTYPE>
<html>
<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="/FWS/statics/css/mainscreen/style.css"/>
		<link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="/FWS/statics/beginnerAdmin/css/main.css" />
		<link rel="stylesheet" href="/FWS/statics/css/bootstrap.min.css" />
		<link rel="stylesheet" href="/FWS/statics/css/mainPage.css" />
		<link rel="stylesheet" href="/FWS/statics/css/font/iconfont.css" media="all"/>
		<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="/FWS/statics/beginnerAdmin/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="/FWS/statics/js/echarts.common.min.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=QaBCa02gdr5G3klaXIV5HlRKquut3SpH"></script>
		<script type="text/javascript" src="/FWS/statics/js/bmap.js"></script>
        <script type="text/javascript" src="/FWS/statics/js/areaRestriction.min.js"></script>
	</head>

	
	<body>
		<div class="rightContent">
			<div class="section">
				<div class="box1">
					<div class="t">
						<img src="/FWS/statics/image/index/p1.png" alt="" />
						签约统计
					</div>
					<div class="c">
						<div class="records">
							<div class="week">
								<h5>本周</h5>
								<p> <span class="f16">${thisWeek }</span>人</p>
								<p><img src="/FWS/statics/image/index/up.png" alt="" style="position: relative;top: -2px;"/>${IncreatWeek }人</p>
							</div>
							<div class="month">
								<h5>本月</h5>
								<p> <span class="f16">${thisMonth}</span>人</p>
								<p><img src="/FWS/statics/image/index/up.png" alt=""  style="position: relative;top: -2px;"/>${IncreatMonth }人</p>
							</div>
						</div>
						<div class="chart1">
							<div id="main" style="width: 380px;height:210px;" class="layui-inline" ></div>
						</div>
					</div>
				</div>
				<div class="box2">
					<div class="t">
						<img src="/FWS/statics/image/index/p2.png" alt="" />
						居民分类统计
					</div>
					<div class="c">
						<div class="category_left">
							<div class="shortSec">
								<div class="name">${lableList[0].labelName}</div>
								<div class="num">${lableList[0].personCount}人</div>
							</div>
							<div class="shortSec">
								<div class="name">${lableList[1].labelName}</div>
								<div class="num">${lableList[1].personCount}人</div>
							</div>
							<div class="shortSec">
								<div class="name">${lableList[5].labelName}</div>
								<div class="num">${lableList[5].personCount}人</div>
							</div>
						</div>
						<div class="category_right">
							<ul class="diease_lists">
							<c:forEach items="${lableList}" var="item">
							  <c:if test="${item.labelName!='高血压' and item.labelName!='老年人' and item.labelName!='糖尿病'}">
								<li class="item">
									<span class="fl">${item.labelName}</span>
									<span class="fr">${item.personCount}人</span>
								</li>
							</c:if>
							</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="box3">
					<div class="t">
						<img src="/FWS/statics/image/index/p3.png" alt="" style="position: relative;top: -2px;"/>
						异常统计
					</div>
					<div class="c">
					 <div class="layui-inline">
					  <div id="mainBP" style="width: 260px;height:180px;"></div>
					 </div>
					 <div class="layui-inline">
					  <div id="mainBS" style="width: 260px;height:180px;"></div>
					 </div>
					 
			         <div class="layui-inline">
					  <div id="mainJM" style="width: 500px;height:180px;"></div>
					 </div>
					  
					</div>
				</div>
			</div>
			<div class="section">
				<div class="box4">
					<div class="t">
						<img src="/FWS/statics/image/index/p4.png" alt="" />
						随访体检统计
					</div>
					<div class="c">
					
					 <div id="mainSF" style="width: 600px;height:280px;"></div>
					</div>
				</div>
				<div class="box5">
					<div class="t">
						<img src="/FWS/statics/image/index/p5.png" alt="" />
						签约家庭覆盖情况
					</div>
					<div class="c">
					   <div id="container" style="width: 430px;height:280px;"></div>
					</div>
				</div>
			</div>
		</div>
	</body>
	
<script type="text/javascript">
	   // 基于准备好的dom，初始化echarts实例
	    var myChart = echarts.init(document.getElementById('main'));
	    var myChart_BP = echarts.init(document.getElementById('mainBP'));
	    var myChart_BS = echarts.init(document.getElementById('mainBS'));
	    var myChart_JM = echarts.init(document.getElementById('mainJM'));
	    var myChart_SF = echarts.init(document.getElementById('mainSF'));
	    
       // 最近7天签约趋势
	   option = {
   		    title: {
   		        text: '最近7天签约趋势',
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
   		            name:'签约总数',
   		            type:'line',
 	                    data: ['${sevenList[0]}','${sevenList[1]}','${sevenList[2]}','${sevenList[3]}','${sevenList[4]}','${sevenList[5]}','${sevenList[6]}']
   		        }
   		    
   		    ]
   		};
	   function getJson(){
    	   $.ajax({
    		   type: "GET",
    		   url: '${fws}/getBpbs',
    		   dataType:"text",
    		   success: function(data){
    			   $data=$.parseJSON(data);
    			       optionBS= {
						    tooltip: {
						        trigger: 'item',
						        formatter: "{a} <br/>{b}: {c} ({d}%)"
						    },
						    legend: {
						        orient: 'vertical',
						        x: 'left',
						        data:['高血糖','正常血糖','低血糖']
						    },
						    series: [
						        {
						            name:'访问来源',
						            type:'pie',
						            radius: ['50%', '70%'],
						            avoidLabelOverlap: false,
						            label: {
						                normal: {
						                    show: false,
						                    position: 'center'
						                },
						                emphasis: {
						                    show: true,
						                    textStyle: {
						                        fontSize: '30',
						                        fontWeight: 'bold'
						                    }
						                }
						            },
						            labelLine: {
						                normal: {
						                    show: false
						                }
						            },
						            data:[
						                {value:$data.highBsCount, name:'高血糖'},
						                {value:$data.normalBsCount, name:'正常血糖'},
						                {value:$data.lowBsCount, name:'低血糖'},
						            ]
						        }
						    ]
						};
    			    myChart_BS.setOption(optionBS);//血糖统计
    			    
    			    
					   optionBP= {
							    tooltip: {
							        trigger: 'item',
							        formatter: "{a} <br/>{b}: {c} ({d}%)"
							    },
							    legend: {
							        orient: 'vertical',
							        x: 'left',
							        data:['高血压','正常血压','低血压']
							    },
							    series: [
							        {
							            name:'访问来源',
							            type:'pie',
							            radius: ['50%', '70%'],
							            avoidLabelOverlap: false,
							            label: {
							                normal: {
							                    show: false,
							                    position: 'center'
							                },
							                emphasis: {
							                    show: true,
							                    textStyle: {
							                        fontSize: '30',
							                        fontWeight: 'bold'
							                    }
							                }
							            },
							            labelLine: {
							                normal: {
							                    show: false
							                }
							            },
							            data:[
							                {value:$data.highBpCount, name:'高血压'},
							                {value:$data.normalBpCount, name:'正常血压'},
							                {value:$data.lowBpCount, name:'低血压'},
							            ]
							        }
							    ]
							};
    			    myChart_BP.setOption(optionBP);//血压统计
    			    
    			   

    		   }
    	   });
	   }
     
 			   
	     myChart.setOption(option);
	     getJson()
    	//柱状图 居民统计
    	
    	var nameList='${nameList}'
        var countList='${countList}'
	    optionJM = {
	    color: ['#3398DB'],
	    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data: $.parseJSON(nameList),
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'直接访问',
		            type:'bar',
		            barWidth: '60%',
		            data:$.parseJSON(countList)
		        }
		    ]
		};
	     myChart_JM.setOption(optionJM);//血压统计
	     
	     //随访统计
	     optionSF = {
	    		    title: {
	    		        text: '近7日随访',
	    		       
	    		    },
	    		    tooltip: {
	    		        trigger: 'axis'
	    		    },
	    		    legend: {
	    		        data:['高血压','糖尿病','儿童随访','老年人体检','成人体检']
	    		    },
	    		   
	    		    xAxis:  {
	    		        type: 'category',
	    		        boundaryGap: false,
	    		        data: ['一','二','三','四','五','六','七']
	    		    },
	    		    yAxis: {
	    		        type: 'value',
	    		        
	    		    },
	    		    series: [
	    		        {
	    		            name:'高血压',
	    		            type:'line',
	    		            data:[11, 101, 105, 13, 12, 103, 100],
	    		           
	    		            
	    		        },
	    		        {
	    		            name:'糖尿病',
	    		            type:'line',
	    		            data:[51, 70, 20, 50, 133, 211, 100],
	    		            
	    		           
	    		        },
	    		        {
	    		            name:'儿童随访',
	    		            type:'line',
	    		            data:[19, 20, 20, 50, 13, 52, 100],
	    		            
	    		           
	    		        },
	    		        {
	    		            name:'老年人体检',
	    		            type:'line',
	    		            data:[110, 11, 15, 130, 12, 13, 70],
	    		           
	    		            
	    		        },
	    		        {
	    		            name:'成人体检',
	    		            type:'line',
	    		            data:[101, 110, 15, 103, 102, 13, 10],
	    		           
	    		            
	    		        }
	    		       
	    		    ]
	    		};
	     
	     myChart_SF.setOption(optionSF);//血压统计
	     
	     
	     //地图
	 // var myChart_MAP = echarts.init(document.getElementById('mainMAP'));
		
	
	

		// 获取百度地图实例，使用百度地图自带的控件
   /*      var bmap = myChart_MAP.getModel().getComponent('bmap').getBMap();
        bmap.addControl(new BMap.MapTypeControl());
        bmap.setMapType(BMAP_SATELLITE_MAP);

        map.centerAndZoom(new BMap.Point(104.9, 31.55), 12);
        map.setCurrentCity("游仙区"); */
        
        
      //  myChart_MAP.setOption(optionMAP);
	               
	   
   </script>


<script type="text/javascript">
	
</script>



<script type="text/javascript">
var bmapChart = echarts.init(document.getElementById('container'));

var option = {
	
	bmap: {
      	center: [104.9, 31.55], // 中心位置坐标
      	zoom: 5, // 地图缩放比例
      	roam: true, // 开启用户缩放
      	mapStyle: {  // 百度地图自定义样式
	    		styleJson: [
	    			{
                            'featureType': 'water',
                            'elementType': 'all',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'land',
                            'elementType': 'geometry',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'highway',
                            'elementType': 'all',
                            'stylers': {
                                'visibility': 'on'
                            }
                        }, {
                            'featureType': 'arterial',
                            'elementType': 'geometry.fill',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'arterial',
                            'elementType': 'geometry.stroke',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'local',
                            'elementType': 'geometry',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'railway',
                            'elementType': 'geometry.fill',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'railway',
                            'elementType': 'geometry.stroke',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'subway',
                            'elementType': 'geometry',
                            'stylers': {
                                'lightness': -70
                            }
                        }, {
                            'featureType': 'building',
                            'elementType': 'geometry.fill',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'all',
                            'elementType': 'labels.text.fill',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'all',
                            'elementType': 'labels.text.stroke',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'building',
                            'elementType': 'geometry',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'green',
                            'elementType': 'geometry',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'boundary',
                            'elementType': 'all',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'manmade',
                            'elementType': 'all',
                            'stylers': {
                            }
                        }, {
                            'featureType': 'label',
                            'elementType': 'all',
                            'stylers': {
                                'visibility': 'on'
                            }
                        }
         	
           
              ,{//不显示点信息
    	          "featureType": "poi",
    	          "elementType": "all",
    	          "stylers": {
    	              "color": "#ffffff",
    	              "visibility": "off"
    	          }
    	      }
	    		]
	    	}
  	}
}

bmapChart.setOption(option);
	var bmap= bmapChart.getModel().getComponent('bmap').getBMap();

	bmap.enableScrollWheelZoom(); // 允许滚动
	
	//map.disableDragging();//禁止拖动
    //map.disableDoubleClickZoom();//禁止双击缩放
	var blist = [];
	var districtLoading = 0;
	
	function getBoundary() {   
	
	  	
	  addDistrict("绵阳市游仙区");
	 
	
	}
	
	/**
	* 添加行政区划
	* @param {} districtName 行政区划名
	* @returns  无返回值
	*/
	function addDistrict(districtName) {
	  //使用计数器来控制加载过程
	  districtLoading++;
	  var bdary = new BMap.Boundary();
	  bdary.get(districtName, function (rs) {       //获取行政区域
	      var count = rs.boundaries.length; //行政区域的点有多少个
	      if (count === 0) {
	          alert('未能获取当前输入行政区域');
	          return;
	      }
	      for (var i = 0; i < count; i++) {
	          blist.push({ points: rs.boundaries[i], name: districtName });
	      };
	      //加载完成区域点后计数器-1
	      districtLoading--;
	      if (districtLoading == 0) {
	          //全加载完成后画端点
	          drawBoundary();
	      }
	  });
	}
	
	
	/**
	* 各种鼠标事件绑定
	*/
 	function click(evt) {
	  //alert(evt.target.name);
	}
	
	function mouseover(evt) {
	  evt.target.label.setZIndex(99);
	  evt.target.label.setPosition(evt.point);
	  evt.target.label.show();
	}
	
	function mousemove(evt) {
	  evt.target.label.setPosition(evt.point);
	}
	
	function mouseout(evt) {
	  evt.target.label.hide();
	}
	
	function drawBoundary() {
	  //包含所有区域的点数组
	  var pointArray = [];
	
	  /*画遮蔽层的相关方法
	  *思路: 首先在中国地图最外画一圈，圈住理论上所有的中国领土，然后再将每个闭合区域合并进来，并全部连到西北角。
	  *      这样就做出了一个经过多次西北角的闭合多边形*/
	  //定义中国东南西北端点，作为第一层
	  var pNW = { lat: 59.0, lng: 73.0 }
	  var pNE = { lat: 59.0, lng: 136.0 }
	  var pSE = { lat: 3.0, lng: 136.0 }
	  var pSW = { lat: 3.0, lng: 73.0 }
	  //向数组中添加一次闭合多边形，并将西北角再加一次作为之后画闭合区域的起点
	  var pArray = [];
	  pArray.push(pNW);
	  pArray.push(pSW);
	  pArray.push(pSE);
	  pArray.push(pNE);
	  pArray.push(pNW);
	  //循环添加各闭合区域
	  for (var i = 0; i < blist.length; i++) {
	      //添加显示用标签层
	      var label = new BMap.Label(blist[i].name, { offset: new BMap.Size(20, -10) });
	      label.hide();
	      bmap.addOverlay(label);
	
	      //添加多边形层并显示
	      var ply = new BMap.Polygon(blist[i].points, { strokeWeight: 5, strokeColor: "#FF0000", fillOpacity: 0.01, fillColor: " #FFFFFF" }); //建立多边形覆盖物
	      ply.name = blist[i].name;
	      ply.label = label;
	     // ply.addEventListener("click", click);
	      ply.addEventListener("mouseover", mouseover);
	      ply.addEventListener("mouseout", mouseout);
	      ply.addEventListener("mousemove", mousemove);
	      bmap.addOverlay(ply);
	
	      //添加名称标签层
	      var centerlabel = new BMap.Label(blist[i].name, { offset: new BMap.Size(0, 0) });
	      centerlabel.setPosition(ply.getBounds().getCenter());
	      bmap.addOverlay(centerlabel);
	
	      //将点增加到视野范围内
	      var path = ply.getPath();
	      pointArray = pointArray.concat(path);
	      //将闭合区域加到遮蔽层上，每次添加完后要再加一次西北角作为下次添加的起点和最后一次的终点
	      pArray = pArray.concat(path);
	      pArray.push(pArray[0]);
	  }
	
	  //限定显示区域，需要引用api库
	  var boundply = new BMap.Polygon(pointArray);
	  BMapLib.AreaRestriction.setBounds(bmap, boundply.getBounds());
	  bmap.setViewport(pointArray);    //调整视野 
	
	  //添加遮蔽层
	  var plyall = new BMap.Polygon(pArray, { strokeOpacity: 0.0000001, strokeColor: "#000000", strokeWeight: 0.00001, fillColor: "#ffffff", fillOpacity: 0.9 }); //建立多边形覆盖物
	  bmap.addOverlay(plyall);
	}
	
 	setTimeout(function () {
	  getBoundary();
	  getHospitals();
	}, 100);
	
	
	
	 var hospitals = [];
     var loadIndex = 0;
     var okPoint={};
	
	 //地址解析
    function geocAddr(data,item) {
        var geoc = new BMap.Geocoder();
        geoc.getPoint(item.address, function(point) {
            if (point) {
                item.point = [point.lng,point.lat];
                bmap.addOverlay(new BMap.Marker(point));
               // bmap.addOverlay(myCompOverlay);
               // console.log("解析OK!"+item.point);
            } else {
               // console.log("您选择地址没有解析到结果!");
            }
            loadIndex++;
            console.log(loadIndex)
            if(loadIndex === data.length ){
            	// getBoundary();
			}
        }, "绵阳市游仙区");
    }

	//获取所有机构并解析地址
	function getHospitals(){
		$.ajax({
			url:"/FWS/getHospitalList",
			success:function(data){
	            $.each(data,function(i,item){
	                geocAddr(data,item);
	            });
	            hospitals = data;
	           // console.log(hospitals)
	        }
	    });
	}
	
	
	// 复杂的自定义覆盖物
  /*   function ComplexCustomOverlay(point, text, mouseoverText){
      this._point = point;
      this._text = text;
      this._overText = mouseoverText;
    }
    ComplexCustomOverlay.prototype = new BMap.Overlay();
    ComplexCustomOverlay.prototype.initialize = function(map){
      this._map = map;
      var div = this._div = document.createElement("div");
      div.style.position = "absolute";
      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
      div.style.backgroundColor = "#EE5D5B";
      div.style.border = "1px solid #BC3B3A";
      div.style.color = "white";
      div.style.height = "18px";
      div.style.padding = "2px";
      div.style.lineHeight = "18px";
      div.style.whiteSpace = "nowrap";
      div.style.MozUserSelect = "none";
      div.style.fontSize = "12px"
      var span = this._span = document.createElement("span");
      div.appendChild(span);
      span.appendChild(document.createTextNode(this._text));      
      var that = this;
 
      var arrow = this._arrow = document.createElement("div");
      arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
      arrow.style.position = "absolute";
      arrow.style.width = "11px";
      arrow.style.height = "10px";
      arrow.style.top = "22px";
      arrow.style.left = "10px";
      arrow.style.overflow = "hidden";
      div.appendChild(arrow);
      
      div.onmouseover = function(){
        this.style.backgroundColor = "#6BADCA";
        this.style.borderColor = "#0000ff";
        this.getElementsByTagName("span")[0].innerHTML = that._overText;
        arrow.style.backgroundPosition = "0px -20px";
      }
 
      div.onmouseout = function(){
        this.style.backgroundColor = "#EE5D5B";
        this.style.borderColor = "#BC3B3A";
        this.getElementsByTagName("span")[0].innerHTML = that._text;
        arrow.style.backgroundPosition = "0px 0px";
      }
 
      bmap.getPanes().labelPane.appendChild(div);
       
      return div;
    }
    ComplexCustomOverlay.prototype.draw = function(){
      var map = this._map;
      var pixel = map.pointToOverlayPixel(this._point);
      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
      this._div.style.top  = pixel.y - 30 + "px";
    }
    var txt = "银湖海岸城", mouseoverTxt = txt + " " + parseInt(Math.random() * 1000,10) + "套" ;
         
    var myCompOverlay = new ComplexCustomOverlay(new BMap.Point(116.407845,39.914101), "银湖海岸城",mouseoverTxt); */
 
    
</script>




	
</html>