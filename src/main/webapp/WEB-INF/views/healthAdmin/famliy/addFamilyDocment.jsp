<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>家庭档案</title>
		<link rel="stylesheet" href="/FWS/statics/ztree/css/demo.css" />
	    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" type="text/css" href="/FWS/statics/css/main.css">
		<link rel="stylesheet" href="/FWS/statics/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>	
		<script type="text/javascript" src="/FWS/statics/ztree/js/jquery.ztree.core.js"></script>
		<script type="text/javascript" src="/FWS/statics/ztree/js//jquery.ztree.excheck.js"></script>
		<style type="text/css">
			body{
				background: #f0f3f8;
			}
		</style>
		
        <SCRIPT type="text/javascript">
				var setting = {
					/* check: {
						enable: true,
						chkStyle: "radio",
						radioType: "all"
					}, */
					view: {
						dblClickExpand: false
					},
					data: {
						simpleData: {
							enable: true
						}
					},
					callback: {
						onClick: zTreeOnClick,
						//onCheck: onCheck
					},
					async: {
						enable: true,
						type: "get",
						url: "/FWS/famliy/getChildrenRegions?parentCode=",
						autoParam: ["id=parentCode","name","level"],
					},
				};
		
				var zNodes =[
					
				 ];
		
				function filter(treeId, parentNode, childNodes) {
					if (!childNodes) return null;
					for (var i=0, l=childNodes.length; i<l; i++) {
						childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
					}
					return childNodes;
				}
				function onClick(e, treeId, treeNode) {
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					zTree.checkNode(treeNode, !treeNode.checked, null, true);
					return false;
				}
		
				function onCheck(e, treeId, treeNode) {
					var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
					nodes = zTree.getCheckedNodes(true),
					v = "";
					for (var i=0, l=nodes.length; i<l; i++) {
						v += nodes[i].name + ",";
					}
					if (v.length > 0 ) v = v.substring(0, v.length-1);
					var cityObj = $("#FamilyAddress");
					cityObj.attr("value", v);
				}
		
				function showMenu() {
					var cityObj = $("#FamilyAddress");
					var cityOffset = $("#FamilyAddress").offset();
					$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		
					$("body").bind("mousedown", onBodyDown);
				}
				function hideMenu() {
					$("#menuContent").fadeOut("fast");
					$("body").unbind("mousedown", onBodyDown);
				}
				function onBodyDown(event) {
					if (!(event.target.id == "menuBtn" || event.target.id == "FamilyAddress" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
						hideMenu();
					}
				}
				//获取子节点，所有父节点的name的拼接字符串
				function getFilePath(treeObj){
					if(treeObj==null)return "";
					var filename = treeObj.name;
					var pNode = treeObj.getParentNode();
					if(pNode!=null){
					filename = getFilePath(pNode) +">"+ filename;
					}
					return filename;
				}
				
				function zTreeOnClick(event, treeId, treeNode) {
					  //  alert(treeNode.tId + ", " + treeNode.name);
					    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
					    var sNodes = treeObj.getSelectedNodes();
					    if (sNodes.length > 0) {
					    	var nodes = sNodes[0].getPath();
					    	var str="";
					    	var regionID="";
							for (var i=0, l=nodes.length; i<l; i++) {
								str=str+nodes[i].name
								regionID=nodes[i].regionID
								if(nodes[i].id.length==14){
							    	$('#FamilyAddress').val(str);
							    	$('#RegionID').val(regionID);
							    	$('#RegionCode').val(nodes[i].id);
							    	hideMenu()
									}
							}
							
					    }
					};

		
				$(document).ready(function(){
					$.fn.zTree.init($("#treeDemo"), setting);
				});
	</SCRIPT>
	<script type="text/javascript">
		$.fn.serializeObject = function() {  
		    var o = {};  
		    var a = this.serializeArray();  
		    $.each(a, function() {  
		        if (o[this.name]) {  
		            if (!o[this.name].push) {  
		                o[this.name] = [ o[this.name] ];  
		            }  
		            o[this.name].push(this.value || '');  
		        } else {  
		            o[this.name] = this.value || '';  
		        }  
		    });  
		    return o;  
		}  
</script>
	</head>
	<body>
		
		<div class="main">
			<div class="table_familyedit ">
			<form id="myform">
				<table>
					<tr>
						<td class="tr f16">家庭编号：</td>
						<td><div id="family_code_1"></div></td>
						 
					</tr>
					<tr>
						<td class="tr f16">自定编号：</td>
						<td colspan="3">
							<input type="text" name="CustomNumber" id="CustomNumber" value="" class="input_b"/>
						</td>
					</tr>
					<!-- <tr>
						<td class="tr f16">所属区划：</td>
						<td class="bluecolor"><input type="text" name="RegionName" id="RegionName" value="" class="input_b"/></td>
					</tr> -->
					<tr>
						<td class="tr f16">户主：</td>
						<td>
							<input type="text" name="MasterName" id="MasterName" value="" class="input_b" disabled="" placeholder="建立成员时确定户主"/> 
							</select>
						</td>
						<td class="tr f16">
							<span class="redcolor">*</span>家庭人口数：
						</td>
						<td class="">
							<input type="number"  min="1" name="MemberCount" id="MemberCount" value="" class="w20 input_b"/>,
							现住
							<input type="number"  min="0" name="CurrentCount" id="CurrentCount" value="" class="w20 input_b"/>人
						</td>
					</tr>
					<tr>
						<td class="tr f16">家庭位置：</td>
						<td>
							<select name="Position" id="Position" class="">
								<option value="未知">未知</option>
								<option value="集居">集居</option>
								<option value="孤居">孤居</option>
							</select>
						</td>
						<td class="tr f16">住房面积：</td>
						<td>
							<input type="number" name="HouseArea" id="HouseArea" value=""  class="w40 input_b"/>
							平方
						</td>
					</tr>
					<tr>
						<td class="tr">残疾人数：</td>
						<td>
							<input type="number" name="DisabilityCount"  min="0" id="DisabilityCount" value="" class="input_b w40"/>
						</td>
						<td class="tr">月平均收入：</td>
						<td>
							<input type="number" oninput="if(value.length>9)value=value.slice(0,9)" max="99999999" min="0" name="MontyAverageIncome" id="MontyAverageIncome" value="" class="input_b"/> 元
						</td>
					</tr>
					<tr>
						<td class="tr f16">距卫生站：</td>
						<td>
							<input type="number" name="Tohealthstation" id="Tohealthstation" value="" class="input_b"/> km
						</td>
					</tr>
					<tr>
						<td class="tr f16">住房类型:</td>
						<td>
							<select id="HouseType" name="HouseType">
								<option value="0">未知</option>
								<option value="1">平房</option>
								<option value="2">楼房</option>
								<option value="3">四合院</option>
								<option value="4">高层电梯公寓</option>
							</select>
						</td>
						<td class="tr f16">厕所类型</td>
						<td>
							<select id="ToiletType" name="ToiletType">
								<option value="0">未知</option>
								<option value="1">马桶</option>
								<option value="2">蹲厕</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="tr f16">使用燃料:</td>
						<td>
							<select id="FuelType" name="FuelType">
								<option value="0">未知</option>
								<option value="1">天然气</option>
								<option value="2">煤气罐</option> 
								<option value="3">蜂窝煤</option>
								<option value="4">木材</option>
							</select>
						</td>
						<td class="tr f16">有无冰箱:</td>
						<td>
							<select id="HaveIcebox" name="HaveIcebox">
								<option value="1">有</option>
								<option value="2">无</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="tr f16">引用水源:</td>
						<td>
							<select id="WaterType" name="WaterType">
								<option value="0">未知</option>
								<option value="1">自来水</option>
								<option value="2">井水</option> 
							</select>
						</td>
						<td class="tr f16">救助人群:</td>
						<td>
							<select id="SalCro" name="SalCro">
								<option value="0">请选择</option>
								<option value="1">军烈属</option>
								<option value="2">五保户</option> 
								<option value="3">残疾人</option>
								<option value="4">特困户</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="tr f16">
							<span class="redcolor">*</span>
							家庭地址：
						</td>
						<td colspan="3">
							<input type="text" name="FamilyAddress" id="FamilyAddress" value="" class="input_b" style="width: 400px;" onclick="showMenu()"/> 
							
						</td>
					</tr>
					<tr>
						<td class="tr f16">家庭电话：</td>
						<td colspan="3">
							<input type="text" name="FamilyTel" id="FamilyTel" value="" class="input_b"/>
							 <input  style="display: none" id="RegionID" name="RegionID" />
							 <input  style="display: none" id="RegionCode" name="RegionCode" />
							
						</td>
					</tr>
				</table>
			</form>
				<div class="operation tc">			 
					 <button class="layui-btn layui-btn-primary layui-btn-radius" type="button" id="save">保存档案</button>
                     <button class="layui-btn layui-btn-primary layui-btn-radius" type="button" id="addNewPersonDoc">新建居民</button>	 
				</div>
				<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
					<ul id="treeDemo" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>
				</div>
				 <input name="FamilyID" style="display: none" id="FamilyID" value="" />
			</div>
	
		</div>

	</body>
	
	<script type="text/javascript" src="/FWS/statics/layer/layer.js"></script>
	<script type="text/javascript">
		//保存
		$('#save').on('click',function(){
			console.log( $("#myform").serializeObject())
			var validFlag=1;
			if($('#FamilyAddress').val()==null||$('#FamilyAddress').val()==''){
				validFlag==0
				layer.msg("地址必填",{icon: 3,id : Math.ceil(100)})
				return
			}
			if($('#RegionID').val()==null||$('#RegionID').val()==''){
				validFlag==0
				layer.msg("地址必选择到组",{icon: 3,id : Math.ceil(100)})
				return
			}
			if($('#MemberCount').val()==null||$('#MemberCount').val()==''){
				validFlag==0
				layer.msg("家庭人口数必填！",{icon: 3,id : Math.ceil(100)})
				return
			}
			if(validFlag==1){
				$.ajax({
					url:'/FWS/famliy/addFamilyRecord',
					type:'POST',
					contentType: "application/json",
				    data:JSON.stringify($("#myform").serializeObject()),
					success:function(data){
						if(data.code==200){
							$('#FamilyID').val(data.data.ID)
							layer.msg("保存成功，请新建居民！",{icon: 7,id : Math.ceil(100)})
							$('#save').hide();
						}else{
							layer.msg("保存失败："+data.msg,{icon: 5,id : Math.ceil(100)})
						}
					}
					
					
				})
				
			}else{
				layer.msg("保存失败")
				return
			}
		})
	
		
		 //新建居民     
	    $("#addNewPersonDoc").on('click',function(){
	    	if($('#FamilyID').val()==""||$('#FamilyID').val()==null){
	    		layer.msg("请先新建家庭！！！！",{icon: 7,id : Math.ceil(100)})
	    		return
	    	}
	    	window.location.href="/FWS/famliy/addPersonDocment?"+"FamilyID="+$('#FamilyID').val()
	    	
	    })
		
		
	</script>
</html>
