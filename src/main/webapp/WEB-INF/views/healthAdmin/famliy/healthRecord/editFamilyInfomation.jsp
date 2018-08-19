<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>家庭档案</title>
		<link rel="stylesheet" type="text/css" href="/FWS/statics/css/main.css">
	    <link rel="stylesheet" href="/FWS/statics/beginnerAdmin/plugins/layui/css/layui.css" media="all" />
		
		<style type="text/css">
			body{
				background: #f0f3f8;
			}
		</style>
	</head>
	<body>
		
		<div class="main">
			<div class="table_familyedit ">
				<table>
					<tr>
						<td class="tr f16">家庭编号：</td>
						<td><div id="family_code_1"></div></td>
						 
					</tr>
					<tr>
						<td class="tr f16">自定编号：</td>
						<td colspan="3">
							<input type="text" name="CustomNumber" id="CustomNumber" value="${data.CustomNumber }" class="input_b"/>
						</td>
					</tr>
					<tr>
						<td class="tr f16">所属区划：</td>
						<td class="bluecolor"><input type="text" name="RegionName" id="RegionName" value="${data.RegionName }" class="input_b"/></td>
					</tr>
					<tr>
						<td class="tr f16">户主：</td>
						<td>
							<input type="text" name="MasterName" id="MasterName" value="${data.MasterName }" class="input_b" disabled=""/> 
							<button type="button" id="createMaster">另立户主</button>
							<select name="" id="cmaster" class="" hidden="" >
						 
							</select>
						</td>
						<td class="tr f16">
							<span class="redcolor">*</span>家庭人口数：
						</td>
						<td class="">
							<input type="number" name="MemberCount" id="MemberCount" value="${data.MemberCount }" class="w20 input_b"/>,
							现住
							<input type="number" name="CurrentCount" id="CurrentCount" value="${data.CurrentCount }" class="w20 input_b"/>人
						</td>
					</tr>
					<tr>
						<td class="tr f16">家庭位置：</td>
						<td>
							<select name="" id="Position" class="">
								<option value="未知">未知</option>
								<option value="集居">集居</option>
								<option value="孤居">孤居</option>
							</select>
						</td>
						<td class="tr f16">住房面积：</td>
						<td>
							<input type="number" name="HouseArea" id="HouseArea" value="${data.HouseArea }"  class="w40 input_b"/>
							平方
						</td>
					</tr>
					<tr>
						<td class="tr">残疾人数：</td>
						<td>
							<input type="number" name="DisabilityCount" id="DisabilityCount" value="${data.DisabilityCount }" class="input_b w40"/>
						</td>
						<td class="tr">月人均收入：</td>
						<td>
							<input type="number" name="yearIncome" id="yearIncome" value="${data.MontyAverageIncome}" class="input_b"/> 元
						</td>
					</tr>
					<tr>
						<td class="tr f16">距卫生站：</td>
						<td>
							<input type="number" name="Tohealthstation" id="Tohealthstation" value="${data.Tohealthstation }" class="input_b"/> km
						</td>
					</tr>
					<tr>
						<td class="tr f16">住房类型:</td>
						<td>
							<select id="HouseType" name="">
								<option value="0">未知</option>
								<option value="1">平房</option>
								<option value="2">楼房</option>
								<option value="3">四合院</option>
								<option value="4">高层电梯公寓</option>
							</select>
						</td>
						<td class="tr f16">厕所类型</td>
						<td>
							<select id="ToiletType" name="">
								<option value="0">未知</option>
								<option value="1">马桶</option>
								<option value="2">蹲厕</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="tr f16">使用燃料:</td>
						<td>
							<select id="FuelType" name="">
								<option value="0">未知</option>
								<option value="1">天然气</option>
								<option value="2">煤气罐</option> 
								<option value="3">蜂窝煤</option>
								<option value="4">木材</option>
							</select>
						</td>
						<td class="tr f16">有无冰箱:</td>
						<td>
							<select id="HaveIcebox" name="">
								<option value="true">有</option>
								<option value="false">无</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="tr f16">引用水源:</td>
						<td>
							<select id="WaterType" name="">
								<option value="0">未知</option>
								<option value="1">自来水</option>
								<option value="2">井水</option> 
							</select>
						</td>
						<td class="tr f16">救助人群:</td>
						<td>
							<select id="Salcro" name="">
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
							<input type="text" name="FamilyAddress" id="FamilyAddress" value="${data.FamilyAddress }" class="input_b" style="width: 400px;"/> 
							<a id="changeFamily">使用当前组</a>
						</td>
					</tr>
					<tr>
						<td class="tr f16">家庭电话：</td>
						<td colspan="3">
							<input type="text" name="FamilyTel" id="FamilyTel" value="${data.FamilyTel }" class="input_b"/>
						</td>
					</tr>
				</table>
				<div class="operation tc">			 
					<button class="layui-btn layui-btn-small layui-btn-normal" id="save"><i class="layui-icon">&#xe616;</i> 保存</button>
					<button class="layui-btn layui-btn-small layui-btn-normal" id="addNewPersonDoc"><i class="layui-icon">&#xe654;</i> 添加居民</button>
					<%-- <c:if test="${not empty ID}">
					<button class="layui-btn layui-btn-small layui-btn-normal" id="addNewPersonDoc"><i class="layui-icon">&#xe654;</i> 添加居民</button>
					</c:if> --%>
				</div>
			</div>
	
		</div>

	</body>
	<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>	
	<script type="text/javascript" src="/FWS/statics/layer/layer.js"></script>
	<script type="text/javascript">
		$(function(){
			//家庭编号回显
			$("#family_code_1").html("");
			var CodeList = "${data.FamilyCode}";
			for(var i=1;i<=18;i++){
				var v="";
				if(i<=CodeList.length){
					v=CodeList.substr(i-1,1);
				}
				$("#family_code_1").append("<div class='codeCon' id='pCode_'" + i + " style='color:Gray'>" + v + "</div>");//"<div class='codeCon' id='pCode_'" + i + " style='color:Gray'>" + v + "</div>"
				/* if (i % 6 == 0 && i + 1 <= 18){
					$("#family_code_1").append("<div style='float:left;padding:4px;'>-</div>");//"<div style='float:left;padding:4px;'>-</div>"
				} */
					
			}
			//点击另立户主
			$("#createMaster").on('click',function(){
		
				var familyList ='${flist}';
				var flist=JSON.parse(familyList);  
				if(flist.length!=0){
					$("#cmaster").removeAttr("hidden");
					for(var i=0;i<flist.length;i++){
					var option ='<option>'+flist[i].Name+'</option>';
					$("#cmaster").append(option)
				    }
				}else{
					layer.msg("该家庭还没有其他家庭成员！")
				}
			})
			//点击使用当前组
			$("#changeFamily").on('click',function(){
				$("#FamilyAddress").val("${data.RegionName }")
			})
			//家庭位置回显
			$("#Position").val("${data.Position }")
			//住房类型回显
			$("#HouseType").val("${data.HouseType }")
			//厕所类型回显
		    $("#ToiletType").val("${data.ToiletType }")
			//使用燃料回显
			$("#FuelType").val("${data.FuelType }")
			//有无冰箱回显					
			$("#HaveIcebox").val("${data.HaveIcebox }")
			//引用水源回显
			$("#WaterType").val("${data.WaterType }")
			//救助人群
			$("#Salcro").val("${data.Salcro }")
			
			
			
			
			//保存
			$("#save").on('click',function(){
				var saveParam = {};
				saveParam.ProductCode = "${ProductCode}"
				var FamilyList = [];
				var param={};
				param["ID"] ="${data.ID}";
				param["CustomNumber"] =$("#CustomNumber").val();
				
				/* param["RegionName"] =$("#RegionName").val(); */
				
				param["MasterName"] =$("#MasterName").val(); 
				if($("#cmaster").val()!=null&&$("#cmaster").val()!=""){
					param["MasterName"] =$("#cmaster").val(); 
				}
				
				param["MemberCount"] =$("#MemberCount").val();
				param["CurrentCount"] =$("#CurrentCount").val();
				param["Position"] =$("#Position").val();
				
				param["HouseArea"] =$("#HouseArea").val();
				param["DisabilityCount"] =$("#DisabilityCount").val();
				param["MontyAverageIncome"] =$("#yearIncome").val();
				
				
				param["Tohealthstation"] =$("#Tohealthstation").val();
				param["Tohospitals"] =$("#Tohospitals").val();
				param["HouseType"] =$("#HouseType").val();
				param["ToiletType"] =$("#ToiletType").val();
				param["FuelType"] =$("#FuelType").val();
				param["HaveIcebox"] =$("#HaveIcebox").val();
				param["WaterType"] =$("#WaterType").val();
				param["Salcro"] =$("#Salcro").val();
				param["RegionID"] ="${data.RegionID }";
				
				param["FamilyAddress"] =$("#FamilyAddress").val();
				param["FamilyTel"] =$("#FamilyTel").val();
				 
				FamilyList.push(param) 
				saveParam.FamilyList=FamilyList;
				
				layer.msg('确认保存？', {
        			icon: 3,
        			time: 0, //不自动关闭,
        			btn: ['是', '否'],
        			yes: function(index){
        				$.ajax({
    					    type: 'POST',
    					    url: '/FWS/famliy/updateFamilyInfomation',
    					    data: {
    					    	saveParam : JSON.stringify(saveParam),
    					    } ,
    					    success: function(data){
    					    	if(data.code == '200'){
    					    		layer.msg('保存成功！', {icon: 1});
    					    		
    					    	}else{
    					    		layer.msg('保存失败！'+data.msg, {icon: 5});
    					    	}
    					    }
    					});
        			}
        		});
			 
			   })
			   

				 //新建居民     
			    $("#addNewPersonDoc").on('click',function(){
			    	layer.open({
            			title : '编辑家庭档案',
            			id : Math.ceil(100),
						type: 2,
						area: ['70%', '80%'],
						fixed: false, //不固定
						maxmin: true,
						//content: "/FWS/famliy/addPeopleInfomation?FamilyId="+'${FamilyId}'
						content: "/FWS/famliy/addPersonDocment?FamilyID="+'${FamilyId}'
            		});
			    	
			    })
				
		})
		
		
	</script>
</html>
