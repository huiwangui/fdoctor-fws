<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>居民档案</title>
<link rel="stylesheet" href="/FWS/statics/ztree/css/demo.css" />
<link rel="stylesheet" href="/FWS/statics/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/FWS/statics/css/main.css">
<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" href="/FWS/statics/layui/css/layui.css"
	media="all" />
<script type="text/javascript" src="/FWS/statics/layui/layui.js"></script>
<script type="text/javascript" src="/FWS/statics/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/FWS/statics/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="/FWS/statics/ztree/js//jquery.ztree.excheck.js"></script>


</head>
<body>
	<div class="main">
		<div class="Edit_navbar ">
			<ul>
				<li><a href="javascript:void(0)" class="active_li">封面 <span>(必填)</span>
				</a></li>
				<li><a href="javascript:void(0)">基本信息 <span>(必填)</span>
				</a></li>
				<!-- <li>
						<a href="javascript:void(0)">扩展信息 <span>(选填)</span> </a>
					</li>
					<li>
						<a href="javascript:void(0)">体检 <span></span> </a>
					</li> 
					<li>
						<a href="javascript:void(0)">档案信息卡 <span></span> </a>
					</li> -->
				<li><a id="save" href="javascript:void(0)">保存</a></li>
			</ul>
		</div>
		<!------------------------------------封面---------------------------->
		<div class="content_div">
			<div class="personNumber">
			<!-- 	<table>
					<tr>
						<td class="tr">个人编号：</td>
						<td><div name="person_code_1"></div></td>

					</tr>
				</table> -->
			</div>

			<h1 class="tc">居民健康档案</h1>
			<table class="health_table1">
				<!-- <tr>
					<td class="tr">自定编号：</td>
					<td><input type="text" name="CustomNumber" id="CustomNumber"
						value="" class="borderb" /></td>
				</tr> -->
				<tr>
					<td class="tr"><span style="color:red;">*</span>姓 名：</td>
					<td><input type="text" name="Name" id="Name" value=""
						onkeyup='$("#tab2_name").text($("#Name").val())' class="borderb" /></td>
				</tr>
				<tr>
					<td class="tr">身份证号：</td>
					<td><input type="text" name="CardID" id="CardID" value=""
						class="borderb" /> <!-- <input type="button" name="" id="" value="验证身份证" class=""/> -->
						<a href="javascript:void(0)" class="sibtn_small"
						onclick="validCard()">验证身份证</a> 
					<!-- 	<label> 
					      <input type="radio" name="idCard" id="idCard_1" /> 无
					    </label> 
					    <label>
					     <input type="radio" name="idCard" id="idCard_2" />不详</label> -->
					 </td>
				</tr>
				<tr>
					<td class="tr">现 住 址：</td>
					<td><input type="text" name="CurrentAddress"
						id="CurrentAddress" value="" class="borderb" /> <!-- <input type="button" name="" id="masterAdd" value="当前户主地址" class="sibtn_small"/> 
							<input type="button" name="" id="currentAdd" value="使用当前组" class=""/>  -->
						<a href="javascript:void(0)" class="sibtn_small" id="masterAdd"
						onclick="addAddress()">当前户主地址</a> <a href="javascript:void(0)"
						class="sibtn_small" id="masterAdd" onclick="CurrentAddress()">使用当前组</a>
					</td>
				</tr>
				<tr>
					<td class="tr">户籍地址：</td>
						<td>
							<input type="text" name="ResidenceAddress" id="ResidenceAddress" value="${data.ResidenceAddress }"  class="borderb" style="width:200px" onclick="showMenu()"/> 
						    <span> 贫困人口：
						    <select id="IsPoor" name="">
								<option value="2">是</option>
								<option value="1">否</option>
			                 </select>
					    </span>
					</td>
					
					
					
						
				</tr>
				<!-- <tr>
					<td class="tr">本人电话：</td>
					<td>
					<input type="text" name="PersonTel"  value=""  class="borderb" disabled="disabled"/>
							<label>
								<input type="radio" name="p_phone" id="ptelephone1" value="" /> 无
							</label>
							<label>
								<input type="radio" name="p_phone" id="ptelephone2" value="" /> 不详
							</label> 
					<span> 贫困人口： <select id="IsPoor" name="">
								<option value="2">是</option>
								<option value="1">否</option>
						</select>
					</span>
					</td>
				</tr> -->
				<tr>
					<td class="tr">乡镇(街道)名称：</td>
					<td><input type="text" name="xiangzhen" id="xiangzhen"
						 value="" class="borderb" /></td>
				</tr>
				<tr>
					<td class="tr">村(居)委会名称</td>
					<td><input type="text" name="cun" id="cun" value="" 
						class="borderb" /></td>
				</tr>
				<tr>
					<td class="tr"><span class="redcolor">*</span>与户主关系：</td>
					<td><select id="HouseholderRelationship" name="">
						<c:if test="${empty MasterName}">
							<option value="1">本人</option>
						</c:if>
							
							<option value="2">配偶</option>
							<option value="3">子</option>
							<option value="4">女婿</option>
							<option value="5">女</option>
							<option value="6">儿媳</option>
							<option value="7">父亲</option>
							<option value="8">母亲</option>
							<option value="9">孙子</option>
							<option value="10">孙女</option>
							<option value="11">外孙子</option>
							<option value="12">外孙女</option>
							<option value="13">爷爷</option>
							<option value="14">奶奶</option>
							<option value="15">外公</option>
							<option value="16">外婆</option>
							<option value="17">兄弟姐妹</option>
							<option value="18">孙媳妇或外孙媳妇</option>
							<option value="19">孙女婿或外孙女婿</option>
							<option value="20">曾孙子或外曾孙子</option>
							<option value="21">曾孙女或外曾孙女</option>
							<option value="22">公公</option>
							<option value="23">婆婆</option>
							<option value="24">岳父</option>
							<option value="25">岳母</option>
							<option value="26">其他</option>
							<option value="27">不详</option>
					</select> <span class="redcolor">*</span>户口类型： <input type="hidden"
						name="ResType" id="ResType" /> <label> <input
							type="radio" name="resname" id="agriculture1" value="1" /> 农业
					</label> <label> <input type="radio" name="resname"
							id="agriculture2" value="2" />非 农业
					</label> <label> <input type="checkbox" name="IsFlowing"
							id="IsFlowing" value="1" /> 流动人口
					</label></td>
				</tr>

				<c:if test="${Jiandang != jiandang }">
					<tr>
						<td class="tr">建档单位：</td>
						<td><input type="text" name="BuildOrgName" id="BuildOrgName"
							value="${data.BuildOrgName }" readOnly="readOnly" class="borderb" />
						</td>
					</tr>
					<tr>
						<td class="tr">建档人：</td>
						<td><a href="javascript:void(0)"><input type="text"
								name="BuildEmployeeName" id="BuildEmployeeName"
								value="${data.BuildEmployeeName }" class="borderb" /></a></td>
					</tr>
					<tr>
						<td class="tr">责任医生或者护士</td>
						<td><a href="javascript:void(0)"><input type="text"
								name="ResponsibilityDoctor" id="ResponsibilityDoctor"
								value="${data.ResponsibilityDoctor }" class="borderb" /> </a></td>
					</tr>
					<tr>
						<td class="tr">建档日期：</td>
						<td><input type="date" name="BuildDate" id="BuildDate"
							value="${data.BuildDate }" class="borderb" /></td>
					</tr>
				</c:if>
			</table>
		</div>
		<!------------------------------------基本信息---------------------------->
		<div class="content_div" hidden="">
			<h1>基本信息</h1>
			<div class="clearfix">
				<div class="fl">
					姓名：<span id="tab2_name"></span>
				</div>
				<div class="fr">
					个人编号：<span></span>
				</div>
			</div>
			<table border="1">
				<tr>
					<td>性别</td>
					<td colspan="3" id="GenderCodeTd"><a onClick="Gendering(this)"
						value="0" class="option">0 未知的性别 </a> <a onClick="Gendering(this)"
						value="1" class="option">1 男性 </a> <a onClick="Gendering(this)"
						value="2" class="option">2 女性 </a> <a onClick="Gendering(this)"
						value="9" class="option">9 未说明的性别 </a> <span class="fr"><input
							type="number" name="GenderCode" id="GenderCode" value=""
							class="w20" /> </span></td>
					<td>出生日期</td>
					<td><input type="date" name="BirthDay" id="BirthDay" value=""
						class="borderb" /></td>
				</tr>
				<tr>
					<td>身份证号</td>
					<td colspan="3"><input type="text" name="CardID"
						id="tab_CardID" value="" disabled="disabled" class="borderb" /></td>
					<td>工作单位</td>
					<td colspan="3"><input type="text" name="WorkOrgName"
						id="WorkOrgName" value="" class="borderb" /></td>
				</tr>
				<tr>
					<td>本人电话</td>
					<td><input type="text" name="PersonTel" id="PersonTel"
						value="" class="borderb" />手机或固话</td>
					<td>联系人姓名</td>
					<td><input type="text" name="ContactPerson" id="ContactPerson"
						value="" class="borderb" /></td>
					<td>联系人电话</td>
					<td><input type="text" name="ContactTel" id="ContactTel"
						value="" class="borderb" /> 手机或固话</td>
				</tr>
				<tr>
					<td>常住类型</td>
					<td colspan="3"><c:choose>
							<c:when test="${data.huKouInd eq 1 }">
								<a onClick="HukouInding(this)" value="1"
									class="option bluecolor">1 户籍 </a>
								<a onClick="HukouInding(this)" value="2" class="option">2
									非户籍 </a>
								<span class="fr"><input type="number" name="HukouInd"
									id="HukouInd" value="" class="w20" /> </span>
							</c:when>
							<c:when test="${data.huKouInd eq 2 }">
								<a onClick="HukouInding(this)" value="1" class="option">1 户籍
								</a>
								<a onClick="HukouInding(this)" value="2"
									class="option bluecolor">2 非户籍 </a>
								<span class="fr"><input type="number" name="HukouInd"
									id="HukouInd" value="" class="w20" /> </span>
							</c:when>
							<c:otherwise>
								<a onClick="HukouInding(this)" value="1" class="option">1 户籍
								</a>
								<a onClick="HukouInding(this)" value="2" class="option">2
									非户籍 </a>
								<span class="fr"><input type="number" name="HukouInd"
									id="HukouInd" value="" class="w20" /> </span>
							</c:otherwise>
						</c:choose></td>
					<td>民族</td>
					<td><input type="hidden" id="NationCodeInput" value="">
						<select name="NationCode" id="NationCode" value="">
							<option title="汉族" value="01">汉族</option>
							<option title="蒙古族" value="02">蒙古族</option>
							<option title="回族" value="03">回族</option>
							<option title="藏族" value="04">藏族</option>
							<option title="维吾尔族" value="05">维吾尔族</option>
							<option title="苗族" value="06">苗族</option>
							<option title="彝族" value="07">彝族</option>
							<option title="壮族" value="08">壮族</option>
							<option title="布依族" value="09">布依族</option>
							<option title="朝鲜族" value="10">朝鲜族</option>
							<option title="满族" value="11">满族</option>
							<option title="侗族" value="12">侗族</option>
							<option title="瑶族" value="13">瑶族</option>
							<option title="白族" value="14">白族</option>
							<option title="土家族" value="15">土家族</option>
							<option title="哈尼族" value="16">哈尼族</option>
							<option title="哈萨克族" value="17">哈萨克族</option>
							<option title="傣族" value="18">傣族</option>
							<option title="黎族" value="19">黎族</option>
							<option title="傈僳族" value="20">傈僳族</option>
							<option title="佤族" value="21">佤族</option>
							<option title="畲族" value="22">畲族</option>
							<option title="高山族" value="23">高山族</option>
							<option title="拉祜族" value="24">拉祜族</option>
							<option title="水族" value="25">水族</option>
							<option title="东乡族" value="26">东乡族</option>
							<option title="纳西族" value="27">纳西族</option>
							<option title="景颇族" value="28">景颇族</option>
							<option title="柯尔克孜族" value="29">柯尔克孜族</option>
							<option title="土族" value="30">土族</option>
							<option title="达斡尔族" value="31">达斡尔族</option>
							<option title="仫佬族" value="32">仫佬族</option>
							<option title="羌族" value="33">羌族</option>
							<option title="布朗族" value="34">布朗族</option>
							<option title="撒拉族" value="35">撒拉族</option>
							<option title="毛南族" value="36">毛南族</option>
							<option title="仡佬族" value="37">仡佬族</option>
							<option title="锡伯族" value="38">锡伯族</option>
							<option title="阿昌族" value="39">阿昌族</option>
							<option title="普米族" value="40">普米族</option>
							<option title="塔吉克族" value="41">塔吉克族</option>
							<option title="怒族" value="42">怒族</option>
							<option title="乌孜别克族" value="43">乌孜别克族</option>
							<option title="俄罗斯族" value="44">俄罗斯族</option>
							<option title="鄂温克族" value="45">鄂温克族</option>
							<option title="德昂族" value="46">德昂族</option>
							<option title="保安族" value="47">保安族</option>
							<option title="裕固族" value="48">裕固族</option>
							<option title="京族" value="49">京族</option>
							<option title="塔塔尔族" value="50">塔塔尔族</option>
							<option title="独龙族" value="51">独龙族</option>
							<option title="鄂伦春族" value="52">鄂伦春族</option>
							<option title="赫哲族" value="53">赫哲族</option>
							<option title="门巴族" value="54">门巴族</option>
							<option title="珞巴族" value="55">珞巴族</option>
							<option title="基诺族" value="56">基诺族</option>
							<option title="外国血统" value="98">外国血统</option>
							<option title="其他 " value="99">其他</option>

					</select></td>
				</tr>
				<tr>
					<td>血型</td>
					<td colspan="5"><span id="BloodTypeTd"> <a value="1"
							onClick="BloodTypeing(this)" class="option">1 A型 </a> <a
							value="2" onClick="BloodTypeing(this)" class="option">2 B型 </a> <a
							value="3" onClick="BloodTypeing(this)" class="option">3 O型 </a> <a
							value="4" onClick="BloodTypeing(this)" class="option">4 AB型 </a>
							<a value="5" onClick="BloodTypeing(this)" class="option">5 不详
						</a>
					</span> /RH阴性： <span id="RhBloodTd"> <a value="1"
							onClick="RhBlooding(this)" class="option">1 否 </a> <a value="2"
							onClick="RhBlooding(this)" class="option">2 是 </a> <a value="3"
							onClick="RhBlooding(this)" class="option">3 不详 </a>
					</span> <span class="fr"> <input type="number" name="BloodType"
							id="BloodType" value="${data.BloodType}" class="w20" />/<input
							type="number" name="RhBlood" id="RhBlood"
							value="${data.RhBlood }" class="w20" /></span></td>
				</tr>
				<tr>
					<td>文化程度</td>
					<td colspan="5" id="EducationCodeTd"><a value="1"
						onClick="EducationCodeing(this)" class="option">1 文盲或半文盲 </a> <a
						value="2" onClick="EducationCodeing(this)" class="option">2 小学
					</a> <a value="3" onClick="EducationCodeing(this)" class="option">3
							初中 </a> <a value="4" onClick="EducationCodeing(this)" class="option">4
							高中/技校/中专 </a> <a value="5" onClick="EducationCodeing(this)"
						class="option">5 大学专科及以上 </a> <a value="6"
						onClick="EducationCodeing(this)" class="option">6 不详 </a> <span
						class="fr"> <input type="number" name="EducationCode"
							id="EducationCode" value="${data.educationCode}" class="w20" /></span></td>
				</tr>
				<tr>
					<td>职业</td>
					<td colspan="5" id="JobCodeTd"><a value="1"
						onClick="JobCodeing(this)" class="option">1
							国家机关、党群组织、企业、事业单位负责人 </a> <a value="2" onClick="JobCodeing(this)"
						class="option">2 专业技术人员 </a> <a value="3"
						onClick="JobCodeing(this)" class="option">3 办事人员和有关人员 </a> <a
						value="4" onClick="JobCodeing(this)" class="option">4 商业、服务业人员
					</a> <a value="5" onClick="JobCodeing(this)" class="option">5
							农、林、牧、渔、水利业生产人员 </a> <a value="6" onClick="JobCodeing(this)"
						class="option">6 生产、运输设备操作人员及有关人员 </a> <a value="7"
						onClick="JobCodeing(this)" class="option">7 军人 </a> <a value="8"
						onClick="JobCodeing(this)" class="option">8 不便分类的其他从业人员 </a> <select
						id="JobOther" name="JobOther">
							<!-- 这里还有待处理 -->
							<option value="1">学龄前</option>
							<option value="2">学生</option>
							<option value="3">农民</option>
					</select> <span class="fr"> <input type="text" name="JobCode"
							id="JobCode" value="" class="w20" /></span></td>
				</tr>
				<tr>
					<td>婚姻状况</td>
					<td colspan="5" id="MarryStatusTd"><a value="1"
						onClick="MarryStatusing(this)" class="option">1 未婚 </a> <a
						value="2" onClick="MarryStatusing(this)" class="option">2 已婚 </a>
						<a value="3" onClick="MarryStatusing(this)" class="option">3
							丧偶 </a> <a value="4" onClick="MarryStatusing(this)" class="option">4
							离婚 </a> <a value="5" onClick="MarryStatusing(this)" class="option">5
							未说明的婚姻情况 </a> <span class="fr"> <input type="number"
							name="MarryStatus" id="MarryStatus" value="" class="w20" /></span></td>
				</tr>
				<tr>
					<td>医疗费用支付方式</td>
					<td colspan="5" id="PaymentWayTd"><a href="javascript:void(0)"
						id="1" value="1" class="optionMore">1 城镇职工基本医疗保险 </a> <a
						href="javascript:void(0)" id="2" value="2" class="optionMore">2
							城镇居民基本医疗保险 </a> <a href="javascript:void(0)" id="3" value="4"
						class="optionMore">3 新型农村合作医疗 </a> <a href="javascript:void(0)"
						id="4" value="8" class="optionMore">4 贫困救助 </a> <a
						href="javascript:void(0)" id="5" value="16" class="optionMore">5
							商业医疗保险 </a> <a href="javascript:void(0)" id="6" value="32"
						class="optionMore">6 全公费 </a> <a href="javascript:void(0)" id="7"
						value="64" class="Noption">7 全自费 </a> <a href="javascript:void(0)"
						id="8" value="128" class="optionMore">8 其他 </a> <input type="text"
						name="OtherPaymentWaystring" id="OtherPaymentWaystring" value=""
						class="borderb" /></span> <input type="hidden" name="Payment"
						id="PaymentWayAll" value="" class="w20" /> <span class="fr"
						id="payFr"> <!-- 	<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">1</span>				 
							  	<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">2</span>
							  	<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">3</span>
							  	<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">4</span>				 
							  	<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">5</span>
							  	<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">6</span>
								<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">7</span>
								<span style="width: 16px;height: 16px;display: inline-block;text-align: center;line-height: 16px;border: 1px solid #333;">8</span> -->

							<!-- <input type="number" name="Payment" id="Payment" value="" class="w20"/>  -->
							<!-- <input type="number" name="PaymentWay2" id="PaymentWay2" value="" class="w20"/>
								<input type="number" name="PaymentWay3" id="PaymentWay3" value="" class="w20"/> 
								<input type="number" name="PaymentWay4" id="PaymentWay4" value="" class="w20"/> 
								<input type="number" name="PaymentWay5" id="PaymentWay5" value="" class="w20"/> 
								<input type="number" name="PaymentWay6" id="PaymentWay6" value="" class="w20"/> 
								<input type="number" name="PaymentWay7" id="PaymentWay7" value="" class="w20"/> 
								<input type="number" name="PaymentWay8" id="PaymentWay8" value="" class="w20"/>  -->
					</span></td>
				</tr>
				<tr>
					<td>药物过敏</td>
					<td colspan="5" id="DrugAllergyHistoryingTd"><a value="1"
						id="1" class="Noption">1 无 </a> <a value="2" id="2"
						class="optionMore">2 青霉素 </a> <a value="4" id="3"
						class="optionMore">3 磺胺 </a> <a value="8" id="4"
						class="optionMore">4 链霉素 </a> <a value="16" id="5"
						class="optionMore">5 其他 </a> <input type="text"
						name="OtherDrugAllergyHistory" id="OtherDrugAllergyHistory"
						value="${data.otherDrugAllergyHistory }" class="borderb" /> <!-- <span class="fr">						 
								<input type="number" name="DrugAllergyHistory1" id="DrugAllergyHistory1" value="" class="w20"/> 
								<input type="number" name="DrugAllergyHistory2" id="DrugAllergyHistory2" value="" class="w20"/> 
								<input type="number" name="DrugAllergyHistory3" id="DrugAllergyHistory3" value="" class="w20"/> 
								<input type="number" name="DrugAllergyHistory4" id="DrugAllergyHistory4" value="" class="w20"/> 
								<input type="number" name="DrugAllergyHistory5" id="DrugAllergyHistory5" value="" class="w20"/> 
							</span> --></td>
				</tr>
				<tr>
					<td>暴露史</td>
					<td colspan="5" id="ExposureHistoryTd"><a value="1" id="1"
						class="Noption">1 无 </a> <a value="2" id="2" class="optionMore">2
							化学品 </a> <a value="4" id="3" class="optionMore">3 毒物 </a> <a
						value="8" id="4" class="optionMore">4 射线 </a> <!-- <span class="fr">						 
								<input type="number" name="ExposureHistory1" id="ExposureHistory1" value="" class="w20"/> 
								<input type="number" name="ExposureHistory2" id="ExposureHistory2" value="" class="w20"/> 
								<input type="number" name="ExposureHistory3" id="ExposureHistory3" value="" class="w20"/> 
								<input type="number" name="ExposureHistory4" id="ExposureHistory4" value="" class="w20"/> 
  
							</span> --></td>
				</tr>
				<tr>
					<td rowspan="4" class="jiwangshi">既往史</td>
					<td rowspan="">疾病</td>
					<td colspan="4" class="diseases_td" id="diseasesTd"><span
						class="Noption chosed">1 无</span> <span class="optionMore ">2
							高血压</span> <span class="optionMore">3 糖尿病</span> <span
						class="optionMore">4 冠心病</span> <span class="optionMore">5
							慢性阻塞性肺疾病</span> <span class="optionMore">6 恶性肿瘤</span> <span
						class="optionMore">7 脑卒中</span> <span class="optionMore">8
							重性精神疾病</span> <span class="optionMore">9 结核病</span> <span
						class="optionMore">10 肝炎</span> <span class="optionMore">11
							其它法定传染病</span> <span class="optionMore">12 职业病</span> <span
						class="optionMore">13 其它 </span>


						<div class="diseaseBox">
							<span class="box1"> <span class="codeCon1 chosed">2</span>
								<span>确诊时间 <input name="" id="highBloodPressure" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">3</span>
								<span>确诊时间 <input name="" id="diabetes" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">4</span>
								<span>确诊时间 <input name="" id="coronaryHeartdDisease"
									value="" class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">5</span>
								<span>确诊时间 <input name=""
									id="chronicObstructivePulmonaryDisease" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">6</span>
								<span>确诊时间 <input name="" id="cancer" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">7</span>
								<span>确诊时间 <input name="" id="stroke" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">8</span>
								<span>确诊时间 <input name="" id="severeMentalIllness"
									value="" class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">9</span>
								<span>确诊时间 <input name="" id="tuberculosis" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">10</span>
								<span>确诊时间 <input name="" id="hepatitis" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">11</span>
								<span>确诊时间 <input name="" id="notifiableDisease" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span> <span class="box1"> <span class="codeCon1 chosed">12</span>
								<span>确诊时间 <input name="" id="industrialDisease" value=""
									class="borderb" onClick="WdatePicker()" /></span>
							</span>
							<div class="box1">
								<span>其它疾病13.1</span> <input type="text" name=""
									id="DiseaseOther" value="" class="borderb" /> <span>确诊时间</span>
								<input name="" id="DiseaseOtherDate" value="" class="borderb"
									onClick="WdatePicker()" /> <a href="javascript:void(0)"
									class="add_other_disase">+</a>
							</div>


						</div></td>
				</tr>

				<tr>
					<td>手术</td>
					<td><span class="option no_illness chosed" id="sshas1">1
							无</span> <span class="option has_illness" id="sshas2">2 有</span></td>
					<td colspan="3" id="operation" class="add_illness_td">
						<div class="add_illness" hidden="">
							名称： <input type="text" name="" id="" value="" class="borderb" />
							时间： <input name="" id="" value="" class="borderb"
								onClick="WdatePicker()" /> <a href="javascript:void(0)"
								class="add" id="addss">+</a>
						</div>
					</td>
				</tr>
				<tr>
					<td>外伤</td>
					<td><span class="option no_illness chosed" id="wshas1">1
							无</span> <span class="option has_illness" id="wshas2">2 有</span></td>
					<td colspan="3" id="trauma" class="add_illness_td">
						<div class="add_illness" hidden="">
							名称： <input type="text" name="" id="" value="" class="borderb" />
							时间： <input name="" id="" value="" class="borderb"
								onClick="WdatePicker()" /> <a href="javascript:void(0)"
								class="add">+</a>
						</div>
					</td>
				</tr>
				<tr>
					<td>输血</td>
					<td><span class="option no_illness chosed" id="sxhas1">1
							无</span> <span class="option has_illness" id="sxhas2">2 有</span></td>
					<td colspan="3" id="transfusion" class="add_illness_td">
						<div class="add_illness" hidden="">
							名称： <input type="text" name="" id="" value="" class="borderb" />
							时间： <input name="" id="" value="" class="borderb"
								onClick="WdatePicker()" /> <a href="javascript:void(0)"
								class="add">+</a>
						</div>
					</td>
				</tr>
				<tr>
					<td rowspan="2">家族史</td>
					<td colspan="5" class="family_disase_td"><span
						class="option1 chosed" style="cursor: pointer;">1 父亲</span> <input
						type="number" name="f1" id="f1" value="" class="w20 fn0"
						disabled="disabled" /> <input type="number" name="f2" id="f2"
						value="" class="w20 fn0" disabled="disabled" /> <input
						type="number" name="f3" id="f3" value="" class="w20 fn0"
						disabled="disabled" /> <input type="number" name="f4" id="f4"
						value="" class="w20 fn0" disabled="disabled" /> <input
						type="number" name="f5" id="f5" value="" class="w20 fn0"
						disabled="disabled" /> <input type="number" name="f6" id="f6"
						value="" class="w20 fn0" disabled="disabled" /> <input
						type="number" name="f7" id="f7" value="" class="w20 fn0"
						disabled="disabled" /> <input type="number" name="f8" id="f8"
						value="" class="w20 fn0" disabled="disabled" /> <input
						type="number" name="f9" id="f9" value="" class="w20 fn0"
						disabled="disabled" /> <input type="number" name="f10" id="f10"
						value="" class="w20 fn0" disabled="disabled" /> <input
						type="number" name="f11" id="f11" value="" class="w20 fn0"
						disabled="disabled" /> <input type="number" name="f12" id="f12"
						value="" class="w20 fn0" disabled="disabled" /> <input type="text"
						name="" id="f_0" value="" class="borderb fn0" disabled="disabled" />
						<br> <span class="option2" style="cursor: pointer;">2
							母亲</span> <input type="number" name="m1" id="m1" value=""
						class="w20 fn1" disabled="disabled" /> <input type="number"
						name="m2" id="m2" value="" class="w20 fn1" disabled="disabled" />
						<input type="number" name="m3" id="m3" value="" class="w20 fn1"
						disabled="disabled" /> <input type="number" name="m4" id="m4"
						value="" class="w20 fn1" disabled="disabled" /> <input
						type="number" name="m5" id="m5" value="" class="w20 fn1"
						disabled="disabled" /> <input type="number" name="m6" id="m6"
						value="" class="w20 fn1" disabled="disabled" /> <input
						type="number" name="m7" id="m7" value="" class="w20 fn1"
						disabled="disabled" /> <input type="number" name="m8" id="m8"
						value="" class="w20 fn1" disabled="disabled" /> <input
						type="number" name="f9" id="m9" value="" class="w20 fn1"
						disabled="disabled" /> <input type="number" name="m10" id="m10"
						value="" class="w20 fn1" disabled="disabled" /> <input
						type="number" name="m11" id="m11" value="" class="w20 fn1"
						disabled="disabled" /> <input type="number" name="m12" id="m12"
						value="" class="w20 fn1" disabled="disabled" /> <input type="text"
						name="" id="f_1" value="" class="borderb fn1" disabled="disabled" />
						<br> <span class="option3" style="cursor: pointer;">3
							兄弟姐妹</span> <input type="number" name="b1" id="b1" value=""
						class="w20 fn2" disabled="disabled" /> <input type="number"
						name="b2" id="b2" value="" class="w20 fn2" disabled="disabled" />
						<input type="number" name="b3" id="b3" value="" class="w20 fn2"
						disabled="disabled" /> <input type="number" name="b4" id="b4"
						value="" class="w20 fn2" disabled="disabled" /> <input
						type="number" name="b5" id="b5" value="" class="w20 fn2"
						disabled="disabled" /> <input type="number" name="b6" id="b6"
						value="" class="w20 fn2" disabled="disabled" /> <input
						type="number" name="b7" id="b7" value="" class="w20 fn2"
						disabled="disabled" /> <input type="number" name="b8" id="b8"
						value="" class="w20 fn2" disabled="disabled" /> <input
						type="number" name="b9" id="b9" value="" class="w20 fn2"
						disabled="disabled" /> <input type="number" name="b10" id="b10"
						value="" class="w20 fn2" disabled="disabled" /> <input
						type="number" name="b11" id="b11" value="" class="w20 fn2"
						disabled="disabled" /> <input type="number" name="b12" id="b12"
						value="" class="w20 fn2" disabled="disabled" /> <input type="text"
						name="" id="f_2" value="" class="borderb fn2" disabled="disabled" />
						<br> <span class="option4" style="cursor: pointer;">4
							子女</span> <input type="number" name="s1" id="s1" value=""
						class="w20 fn3" disabled="disabled" /> <input type="number"
						name="s2" id="s2" value="" class="w20 fn3" disabled="disabled" />
						<input type="number" name="s3" id="s3" value="" class="w20 fn3"
						disabled="disabled" /> <input type="number" name="s4" id="s4"
						value="" class="w20 fn3" disabled="disabled" /> <input
						type="number" name="s5" id="s5" value="" class="w20 fn3"
						disabled="disabled" /> <input type="number" name="s6" id="s6"
						value="" class="w20 fn3" disabled="disabled" /> <input
						type="number" name="s7" id="s7" value="" class="w20 fn3"
						disabled="disabled" /> <input type="number" name="s8" id="s8"
						value="" class="w20 fn3" disabled="disabled" /> <input
						type="number" name="s9" id="s9" value="" class="w20 fn3"
						disabled="disabled" /> <input type="number" name="s10" id="s10"
						value="" class="w20 fn3" disabled="disabled" /> <input
						type="number" name="s11" id="s11" value="" class="w20 fn3"
						disabled="disabled" /> <input type="number" name="s12" id="s12"
						value="" class="w20 fn3" disabled="disabled" /> <input type="text"
						name="" id="f_3" value="" class="borderb fn3" disabled="disabled" />

					</td>
				</tr>
				<tr>
					<td colspan="5" class="family_disase_conent"><a
						onClick="fillness(this)" href="javascript:void(0)" id="father1"
						value="1" class="Noption">1 无</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father2" value="2"
						class="optionMore">2 高血压 </a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father3" value="4"
						class="optionMore">3 糖尿病</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father4" value="8"
						class="optionMore">4 冠心病 </a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father5" value="16"
						class="optionMore">5 慢性阻塞性肺疾病 </a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father6" value="32"
						class="optionMore">6 恶性肿瘤 </a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father7" value="64"
						class="optionMore">7 脑卒中</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father8" value="128"
						class="optionMore">8四肢发麻</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father9" value="256"
						class="optionMore">9 结核病</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father10" value="512"
						class="optionMore">10 肝炎</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father11" value="1024"
						class="optionMore">11 先天畸形</a> <a onClick="fillness(this)"
						href="javascript:void(0)" id="father12" value="2048"
						class="optionMore">12 其它</a></td>
					<td colspan="5" hidden class="family_disase_conent"><a
						onClick="millness(this)" href="javascript:void(0)" id="mather1"
						value="1" class="Noption">1 无</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather2" value="2"
						class="optionMore">2 高血压 </a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather3" value="4"
						class="optionMore">3 糖尿病</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather4" value="8"
						class="optionMore">4 冠心病 </a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather5" value="16"
						class="optionMore">5 慢性阻塞性肺疾病 </a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather6" value="32"
						class="optionMore">6 恶性肿瘤 </a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather7" value="64"
						class="optionMore">7 脑卒中</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather8" value="128"
						class="optionMore">8四肢发麻</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather9" value="256"
						class="optionMore">9 结核病</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather10" value="512"
						class="optionMore">10 肝炎</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather11" value="1024"
						class="optionMore">11 先天畸形</a> <a onClick="millness(this)"
						href="javascript:void(0)" id="mather12" value="2048"
						class="optionMore">12 其它</a></td>
					<td colspan="5" hidden class="family_disase_conent"><a
						onClick="billness(this)" href="javascript:void(0)" id="brather1"
						value="1" class="Noption">1 无</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather2" value="2"
						class="optionMore">2 高血压 </a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather3" value="4"
						class="optionMore">3 糖尿病</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather4" value="8"
						class="optionMore">4 冠心病 </a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather5" value="16"
						class="optionMore">5 慢性阻塞性肺疾病 </a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather6" value="32"
						class="optionMore">6 恶性肿瘤 </a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather7" value="64"
						class="optionMore">7 脑卒中</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather8" value="128"
						class="optionMore">8四肢发麻</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather9" value="256"
						class="optionMore">9 结核病</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather10" value="512"
						class="optionMore">10 肝炎</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather11" value="1024"
						class="optionMore">11 先天畸形</a> <a onClick="billness(this)"
						href="javascript:void(0)" id="brather12" value="2048"
						class="optionMore">12 其它</a></td>
					<td colspan="5" hidden class="family_disase_conent"><a
						onClick="sillness(this)" href="javascript:void(0)" id="son1"
						value="1" class="Noption">1 无</a> <a onClick="sillness(this)"
						href="javascript:void(0)" id="son2" value="2" class="optionMore">2
							高血压 </a> <a onClick="sillness(this)" href="javascript:void(0)"
						id="son3" value="4" class="optionMore">3 糖尿病</a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son4"
						value="8" class="optionMore">4 冠心病 </a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son5"
						value="16" class="optionMore">5 慢性阻塞性肺疾病 </a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son6"
						value="32" class="optionMore">6 恶性肿瘤 </a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son7"
						value="64" class="optionMore">7 脑卒中</a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son8"
						value="128" class="optionMore">8四肢发麻</a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son9"
						value="256" class="optionMore">9 结核病</a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son10"
						value="512" class="optionMore">10 肝炎</a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son11"
						value="1024" class="optionMore">11 先天畸形</a> <a
						onClick="sillness(this)" href="javascript:void(0)" id="son12"
						value="2048" class="optionMore">12 其它</a></td>
				</tr>
				<tr>
					<td>遗传病史</td>
					<td class="ycb"><span class="N1" id="ycbswu">1 无</span> <span
						class="N2" id="ycbs2">2 有</span></td>
					<td colspan="4" id="inheritance" class="ycb_content_td">
						<div class="box2" hidden="">
							名称： <input type="text" name="" id="" value="" class="borderb" />
							时间： <input name="" id="" value="" class="borderb"
								onClick="WdatePicker()" /> <a href="javascript:void(0)"
								class="add_box2">+</a>
						</div>
					</td>
				</tr>
				<tr>
					<td>残疾情况</td>
					<td colspan="5" id="DisabilityingTd"><a id="1" value="1"
						class="Noption">1 无残疾 </a> <a id="2" value="2" class="optionMore">2
							视力残疾 </a> <a id="3" value="4" class="optionMore">3 听力残疾 </a> <a
						id="4" value="8" class="optionMore">4 言语残疾 </a> <a id="5"
						value="16" class="optionMore">5 肢体残疾 </a> <a id="6" value="32"
						class="optionMore">6 智力残疾 </a> <a id="7" value="64"
						class="optionMore">7 精神残疾 </a> <a id="8" value="128"
						class="optionMore">8 其它残疾 </a> <input type="text"
						name="OtherDisability" id="OtherDisability"
						value="${data.otherDisability }" /> <span> 残疾证：<input
							type="text" name="DisabilityNumber" id="DisabilityNumber"
							value="${data.disabilityNumber }" class="borderb" />
					</span> <span class="fr"> <!-- <input type="number" name="Disability1" id="Disability1" value="" class="w20"/> 
								<input type="number" name="Disability2" id="Disability2" value="" class="w20"/> 
								<input type="number" name="Disability3" id="Disability3" value="" class="w20"/> 
								<input type="number" name="Disability4" id="Disability4" value="" class="w20"/> 
								<input type="number" name="Disability5" id="Disability5" value="" class="w20"/> 
								<input type="number" name="Disability6" id="Disability6" value="" class="w20"/> 
								<input type="number" name="Disability7" id="Disability7" value="" class="w20"/> 
								<input type="number" name="Disability8" id="Disability8" value="" class="w20"/> 
  -->

					</span></td>
				</tr>
				<tr>
					<td rowspan="5">生活环境</td>
					<td>厨房排风设施</td>
					<td colspan="4" id="KitchenExhaustTd">
						<a onClick="KitchenExhausting(this)" id="1" value="1" class="option">1无 </a> 
						<a onClick="KitchenExhausting(this)" id="2" value="2" class="option">2 油烟机 </a> 
						<a onClick="KitchenExhausting(this)" id="3" value="4" class="option">3 换气扇 </a>
					    <a onClick="KitchenExhausting(this)" id="4" value="8" class="option">4 烟囱 </a> 
					    <span class="fr"><input type="number" name="KitchenExhaust" id="KitchenExhaust"
							  value="${data.kitchenExhaust}" disabled="disabled" class="w20"/ >
						</span>
					</td>
				</tr>
				<tr>
					<td>燃料类型</td>
					<td colspan="4" id="FuelTypeTd">
						 <a onClick="FuelTypeing(this)" id="1" value="1" class="option">1 液化气 </a>
						 <a onClick="FuelTypeing(this)" id="2" value="2" class="option">2煤 </a> 
						 <a onClick="FuelTypeing(this)" id="3" value="4" class="option">3天然气 </a>
						 <a onClick="FuelTypeing(this)" id="4" value="8"class="option">4 沼气 </a>
						 <a onClick="FuelTypeing(this)" id="5" value="16" class="option">5 柴火 </a>
						 <a onClick="FuelTypeing(this)"id="6" value="32" class="option">6 其他 </a>
					     <span class="fr">
					       <input type="number" name="FuelType" id="FuelType" value="${data.fuelType}" class="w20" disabled="disabled" />
                          </span>
                     </td>
				</tr>
				<tr>
					<td>饮水</td>
					<td colspan="4" id="DrinkingwaterTd"><a
						onClick="Drinkingwatering(this)" id="1" value="1" class="option">1
							自来水 </a> <a onClick="Drinkingwatering(this)" id="2" value="2"
						class="option">2 经净化过滤的水 </a> <a onClick="Drinkingwatering(this)"
						id="3" value="4" class="option">3 井水 </a> <a
						onClick="Drinkingwatering(this)" id="4" value="8" class="option">4
							河湖水 </a> <a onClick="Drinkingwatering(this)" id="5" value="16"
						class="option">5 塘水 </a> <a onClick="Drinkingwatering(this)"
						id="6" value="32" class="option">6 其他 </a> <span class="fr"><input
							type="number" name="Drinkingwater" id="Drinkingwater"
							value="${data.drinkingwater }" disabled="disabled" class="w20" />
					</span></td>
				</tr>
				<tr>
					<td>厕所</td>
					<td colspan="4" id="ToiletTd"><a onClick="Toileting(this)"
						id="1" value="1" class="option">1 卫生厕所 </a> <a
						onClick="Toileting(this)" id="2" value="2" class="option">2
							一格或二格粪池式 </a> <a onClick="Toileting(this)" id="3" value="4"
						class="option">3 马桶 </a> <a onClick="Toileting(this)" id="4"
						value="8" class="option">4 露天粪坑 </a> <a onClick="Toileting(this)"
						id="5" value="16" class="option">5 简易棚厕 </a> <span class="fr"><input
							type="number" name="Toilet" id="Toilet" value="${data.toilet }"
							disabled="disabled" class="w20" /> </span></td>
				</tr>
				<tr>
					<td>禽兽栏</td>
					<td colspan="4" id="LivestockColumnTd"><a
						onClick="LivestockColumning(this)" id="1" value="1" class="option">1
							单设 </a> <a onClick="LivestockColumning(this)" id="2" value="2"
						class="option">2 室内 </a> <a onClick="LivestockColumning(this)"
						id="3" value="4" class="option">3 室外 </a> <span class="fr"><input
							type="number" name="LivestockColumn" id="LivestockColumn"
							value="${data.livestockColumn }" disabled="disabled" class="w20" />
					</span></td>
				</tr>
			</table>
		</div>
		<!------------------------------------个人扩展信息---------------------------->
		<div class="content_div1" hidden="">
			<h1 class="tc">个人扩展信息</h1>
			<div class="pMsg_box clearfix">
				<div class="pic">
					<div class="thumbnails">
						<img src="${data.Photo}" alt="" id="imgPerson" />
					</div>

					<p>尺寸(cm):113*137</p>
					<p class="tc mt10">
						<!-- <input type="file" name="file" class="layui-upload-file" id="test"> -->
					</p>
				</div>
				<div class="msg_table">
					<table cellspacing="5">
						<tr>
							<td>经济类型：</td>
							<td><select name="IncomeType" id="IncomeType">
									<option value="0">无</option>
									<option value="1">低保</option>
									<option value="2">五保</option>
									<option value="3">优抚</option>
							</select></td>
							<td>参加工作时间：</td>
							<td><input type="date" name="WorkDate" id="WorkDate"
								value="${WorkDate }" class="borderb" /></td>
						</tr>
						<tr>
							<td>备注信息：</td>
							<td colspan="3"><textarea name="Remark" id="Remark" rows=""
									cols=""></textarea></td>
						</tr>
						<tr>
							<td>状态：</td>
							<td><select name="HrStatus" id="HrStatus">
									<option value="0">正常</option>
									<option value="1">迁出</option>
									<option value="2">是我</option>
									<option value="99">已删除</option>
									<option value="3">其他</option>
							</select></td>
							<td>状态变更日期：</td>
							<td><input type="date" name="HrStatusDate" id="HrStatusDate"
								value="${HrStatusDate }" class="borderb" /></td>
						</tr>
						<tr>
							<td>状态变更说明：</td>
							<td colspan="3"><textarea name="HrStatusRemark"
									id="HrStatusRemark" rows="" cols=""> </textarea></td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="content_div1" hidden="">体检的</div>
		<!------------------------------------档案信息卡---------------------------->
		<div class="content_div1" hidden="">
			<h1 class="tc">居民健康档案信息卡</h1>
			<p class="tc mt20">(正面)</p>
			<div class="msg_card_table">
				<table border="1">
					<tr>
						<td>姓名</td>
						<td>${data.Name }</td>
						<td>性别</td>
						<td>${Gender }</td>
						<td>出生日期</td>
						<td>${BirthDay }</td>
					</tr>
					<tr>
						<td colspan="2">健康档案编号</td>
						<td colspan="4">
							<div name="person_code_1">${data.PersonCode}</div>
						</td>
					</tr>
					<tr>
						<td>血型</td>
						<td colspan="2" id="BloodTypeingTd"><label> <input
								type="radio" name="BloodTypeing" id="1"
								<c:if test="${data.BloodType==1}">checked="checked"</c:if> />A
						</label> <label> <input type="radio" name="BloodTypeing" id="2"
								<c:if test="${data.BloodType==2}">checked="checked"</c:if> />B
						</label> <label> <input type="radio" name="BloodTypeing" id="3"
								<c:if test="${data.BloodType==3}">checked="checked"</c:if> />O
						</label> <label> <input type="radio" name="BloodTypeing" id="4"
								<c:if test="${data.BloodType==4}">checked="checked"</c:if> />AB
						</label> <label> <input type="radio" name="BloodTypeing" id="5"
								<c:if test="${data.BloodType==5}">checked="checked"</c:if> />不详
						</label></td>
						<td>RH阴性</td>
						<td colspan="2" id="RhBloodingTd"><label> <input
								type="radio" name="RhBlooding" id="1"
								<c:if test="${data.RhBlood==1}">checked="checked"</c:if> />否
						</label> <label> <input type="radio" name="RhBlooding" id="2"
								<c:if test="${data.RhBlood==2}">checked="checked"</c:if> />是
						</label> <label> <input type="radio" name="RhBlooding" id="3"
								<c:if test="${data.RhBlood==3}">checked="checked"</c:if> />不详
						</label></td>
					</tr>
					<tr>
						<td colspan="6">慢性病患者：${cmData }</td>
					</tr>
					<tr>
						<td colspan="6">过敏史：${DrugAllergyHistorystr }</td>
					</tr>
				</table>

				<p class="tc mt20">(反面)</p>
				<table border="1">
					<tr>
						<td>户籍地址</td>
						<td>${data.ResidenceAddress }</td>
						<td>家庭电话</td>
						<td>未知</td>
					</tr>
					<tr>
						<td>联系人姓名</td>
						<td>${data.ContactPerson }</td>
						<td>联系人电话</td>
						<td>${data.ContactTel }</td>
					</tr>
					<tr>
						<td>建档机构名称</td>
						<td>${data.BuildOrgName }</td>
						<td>责任医生</td>
						<td>${data.ResponsibilityDoctor }</td>
					</tr>
					<tr>
						<td colspan="4">其他说明： 无</td>
					</tr>
				</table>

			</div>
		</div>
		
	     	<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
					<ul id="treeDemo" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>
			</div>

             <input  style="display: none" id="RegionID" name="RegionID" />
			 <input  style="display: none" id="RegionCode" name="RegionCode" />
	</div>
	
	 <SCRIPT type="text/javascript">
		var setting = {
			
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
			var cityObj = $("#ResidenceAddress");
			cityObj.attr("value", v);
		}

		function showMenu() {
			var cityObj = $("#ResidenceAddress");
			var cityOffset = $("#ResidenceAddress").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "ResidenceAddress" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
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
					    	$('#ResidenceAddress').val(str);
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

	</script>
	
	<script type="text/javascript">
		//厨房排风设施
		function KitchenExhausting(tr){
			var id=tr.getAttribute('id');
			$("#KitchenExhaust").val(id);
		} 
		//燃料类型
		function FuelTypeing(tr){
			var id=tr.getAttribute('id');
			$("#FuelType").val(id);
		} 
		//饮水
		function Drinkingwatering(tr){
			var id=tr.getAttribute('id');
			$("#Drinkingwater").val(id)
		} 
		//厕所
		function Toileting(tr){
			var id=tr.getAttribute('id');
			$("#Toilet").val(id);
		} 
		//禽畜栏
		function LivestockColumning(tr){
			var id=tr.getAttribute('id');
			$("#LivestockColumn").val(id);
		} 
	  
		//性别
		function Gendering(tr){
			var value=tr.getAttribute('value');
			$("#GenderCode").val(value)
		}
		//常住类型
		function HukouInding(tr){
			var value=tr.getAttribute('value');
			$("#HukouInd").val(value)
		}
	 	//血型处理 
		function BloodTypeing(tr){
			var value=tr.getAttribute('value');
			$("#BloodType").val(value)
		}
		//RH阴性
		function RhBlooding(tr){
			var value=tr.getAttribute('value');
			$("#RhBlood").val(value)
		}
		
		//文化程度回显
		function EducationCodeing(tr){
			var value=tr.getAttribute('value');
			$("#EducationCode").val(value)
		}
		//职业
		function JobCodeing(tr){
			var value=tr.getAttribute('value');
			if(value==8){
				$("#JobCode").val(8)
				
			}else{
			$("#JobCode").val(value)
			}
			
		} 
		//婚姻状况
		function MarryStatusing(tr){
			var value=tr.getAttribute('value');
			$("#MarryStatus").val(value)
		} 
		
		
	  //获取2的幂次方值	
	  function getBlueIds(sss){
			var blueId=0;//初始化症状的值
			sss.each(function(i){
				var id = Math.pow(2, i);
				if($(this).hasClass('bluecolor')){
					if(i==0){
						blueId=1
						//return
					}else{
						blueId=blueId+id;
					}
				}
			});
			return blueId;
		}
	  // 2的幂次方回显
	  function getBlueColor(sss,str){
			sss.each(function(i){
			 var id = String(Math.pow(2, i));
			 if(str.indexOf(id) > -1){
			    sss.eq(i).toggleClass('bluecolor');
			  }
			});
		}
	  // 2的幂次方回显方式2
	  function getBlueColorOderbyOne(sss,str){
			 sss.eq(str-1).toggleClass('bluecolor');
			
	  }
	  // 2的幂次方回显input回显
	  function getBlueColorWithObj(sss,str,obj){
			sss.each(function(i){
			 var id = String(Math.pow(2, i));
			 if(str.indexOf(id) > -1){
			    sss.eq(i).toggleClass('bluecolor');
			    obj.eq(i).val(i+1);
			  }
			});
	  }
		
		
		
		
		
		//家族史
		//父亲
		function fillness(tr){		 
			if($(tr).hasClass('bluecolor')){//有颜色则是执行了取消操作
				//获取当前元素的索引位置
			    var index=$(tr).parent().find('a').index($(tr))
			    if(index==0){
			    	 $('.fn0').eq(index).val("1")
			    	 $('#f_0').val('')
			    	 $('#f_0').attr("disabled",true); 
			    }else{
			    	if(index==11){
			    		$('#f_0').val('')
			    		$('#f_0').attr("disabled",true); 
			    		 $('.fn0').eq(index).val("")
			    	}else{
			    	 $('.fn0').eq(index).val("")
			    	}
			    }
			}else{//没有颜色
				var index=$(tr).parent().find('a').index($(tr))
				if(index==0){
				 $('.fn0').val("")
			     $('.fn0').eq(index).val(index+1)
			     $('#f_0').val('')
			     $('#f_0').attr("disabled",true); 
				}else{
				  if(index==11){
					  $('.fn0').eq(index).val(index+1)
					  $('.fn0').eq(0).val("")
					  $('#f_0').attr("disabled",false); 
				  }else{
					  $('.fn0').eq(index).val(index+1)
					  $('.fn0').eq(0).val("")
				  }
				}
			}
			
		}
		 
		//母亲
		function millness(tr){		 
			if($(tr).hasClass('bluecolor')){//有颜色则是执行了取消操作
				//获取当前元素的索引位置
			    var index=$(tr).parent().find('a').index($(tr))
			    if(index==0){
			    	 $('.fn1').eq(index).val("1")
			    	 $('#f_1').val('')
			    	 $('#f_1').attr("disabled",true); 
			    }else{
			    	if(index==11){
			    		$('#f_1').val('')
			    		$('#f_1').attr("disabled",true); 
			    		 $('.fn1').eq(index).val("")
			    	}else{
			    	 $('.fn1').eq(index).val("")
			    	}
			    }
			}else{
				var index=$(tr).parent().find('a').index($(tr))
				if(index==0){
				 $('.fn1').val("")
			     $('.fn1').eq(index).val(index+1)
			     $('#f_1').val('')
			     $('#f_1').attr("disabled",true); 
				}else{
				  if(index==11){
					  $('.fn1').eq(index).val(index+1)
					    $('.fn1').eq(0).val("")
					  $('#f_1').attr("disabled",false); 
				  }else{
					  $('.fn1').eq(index).val(index+1)
					  $('.fn1').eq(0).val("")
				  }
				}
			}
	   }
		//兄弟姐妹
		function billness(tr){		 
			if($(tr).hasClass('bluecolor')){//有颜色则是执行了取消操作
				//获取当前元素的索引位置
			    var index=$(tr).parent().find('a').index($(tr))
			    if(index==0){
			    	 $('.fn2').eq(index).val("1")
			    	 $('#f_2').val('')
			    	 $('#f_2').attr("disabled",true); 
			    }else{
			    	if(index==11){
			    		$('#f_2').val('')
			    		$('#f_2').attr("disabled",true); 
			    		$('.fn2').eq(index).val("")
			    	}else{
			    	 $('.fn2').eq(index).val("")
			    	}
			    }
			}else{
				var index=$(tr).parent().find('a').index($(tr))
				if(index==0){
			     $('.fn2').val("")
			     $('.fn2').eq(index).val(index+1)
			     $('#f_2').val('')
			     $('#f_2').attr("disabled",true); 
				}else{
				  if(index==11){
					  $('.fn2').eq(index).val(index+1)
					  $('.fn2').eq(0).val("")
					  $('#f_2').attr("disabled",false); 
				  }else{
					  $('.fn2').eq(index).val(index+1)
					  $('.fn2').eq(0).val("")
				  }
				}
			}
		}
		//子女
		function sillness(tr){
			if($(tr).hasClass('bluecolor')){//有颜色则是执行了取消操作
				//获取当前元素的索引位置
			    var index=$(tr).parent().find('a').index($(tr))
			    if(index==0){
			    	 $('.fn3').eq(index).val("1")
			    	 $('#f_3').val('')
			    	 $('#f_3').attr("disabled",true); 
			    }else{
			    	if(index==11){
			    		$('#f_3').val('')
			    		$('#f_3').attr("disabled",true); 
			    		$('.fn3').eq(index).val("")
			    	}else{
			    	 $('.fn3').eq(index).val("")
			    	}
			    }
			}else{
				var index=$(tr).parent().find('a').index($(tr))
				if(index==0){
			     $('.fn3').val("")
			     $('.fn3').eq(index).val(index+1)
			     $('#f_3').val('')
			     $('#f_3').attr("disabled",true); 
				}else{
				  if(index==11){
					  $('.fn3').eq(index).val(index+1)
					   $('.fn3').eq(0).val("")
					  $('#f_3').attr("disabled",false); 
				  }else{
					  $('.fn3').eq(index).val(index+1)
					  $('.fn3').eq(0).val("")
				  }
				}
			}
			
		}
		
		layui.use('layer', function(){
			  var layer = layui.layer;
			  
			  $("#save").on("click",function(){
					
					var saveParam = {};
					var Person = {};//居民基本信息
					var FamilyHistoryList = [];//家庭既往史
					var PersonHistoryList = [];//个人既往史
					var CmDataList = [];//个人疾病既往史
					//封面
					Person["ID"]="${data.ID}";
					Person["RegionID"]=$('#RegionID').val() ;        //区划ID    必需
					Person["RegionCode"]=$('#RegionCode').val();//区划编码    必需
					//if('${data.RegionCode}'==''){Person["RegionCode"]="${RegionCode}"}
					Person["FamilyID"]="${data.FamilyID}";
					if('${data.FamilyID}'==''){
						Person["FamilyID"]='${FamilyID}'
						}//家庭ID    必需
					Person["CustomNumber"]=$("#CustomNumber").val();//自定义编码
					Person["Name"]=$("#Name").val();//姓名
					Person["CardID"]=$("#CardID").val();//身份证号 使用基本信息中
					Person["CurrentAddress"]=$("#CurrentAddress").val();//现住址
					Person["ResidenceAddress"]=$("#ResidenceAddress").val();//户籍地址
					Person["PersonTel"]=$("#PersonTel").val();//本人电话
					Person["IsPoor"]=$("#IsPoor").val();//贫困人口
					Person["xiangzhen"]=$("#xiangzhen").val();//贫困人口
					Person["cun"]=$("#cun").val();//贫困人口
					Person["HouseholderRelationship"]=$("#HouseholderRelationship").val();//与户主关系
					Person["ResType"]= $("input[name='resname']:checked").val(); //获取被选中Radio的Value值//户口类型
					if($("input[name='IsFlowing']:checked").val()){
						Person["IsFlowing"]=$("input[name='IsFlowing']:checked").val();//流动人口
					}else{
						Person["IsFlowing"]=0;
					};
					Person["BuildEmployeeName"]=$("#BuildEmployeeName").val();//建档人
					Person["ResponsibilityDoctor"]=$("#ResponsibilityDoctor").val();//责任医生
					Person["BuildDate"]=$("#BuildDate").val();//建档日期			 
					//基本信息
					Person["GenderCode"]=$("#GenderCode").val();//性别
					Person["BirthDay"]=$("#BirthDay").val(); //出生日期
					
					Person["WorkOrgName"]=$("#WorkOrgName").val();//工作单位
					
					Person["ContactPerson"]=$("#ContactPerson").val();//联系人姓名
					/* Person["ContacetTel"]=$("#ContactTel").val();//联系人电话 */   
					Person["ContactTel"]=$("#ContactTel").val();//联系人电话   
					Person["HukouFlag"]=$("#HukouInd").val();//常住类型
					Person["HukouInd"]=$("#HukouInd").val();//常住类型
					Person["NationCode"]=$("#NationCode option:selected").val();//民族
					Person["BloodType"]=$("#BloodType").val();//血型
					Person["RhBlood"]=$("#RhBlood").val();//RH阴性
					Person["EducationCode"]=$("#EducationCode").val();//文化程度
					Person["JobCode"]=$("#JobCode").val();//职业
					Person["OtherJobCode"]=$("#JobOther").val()//职业其他
					Person["MarryStatusCode"]=$("#MarryStatus").val();//婚姻状况
					Person["MarryStatus"]=$("#MarryStatus").val();//婚姻状况
					Person["PaymentWaystring"]=getBlueIds($('#PaymentWayTd a'));//医疗费用支付方式
					Person["OtherPaymentWaystring"]=$("#OtherPaymentWaystring").val();//医疗费用其他
					Person["DrugAllergyHistory"]=getBlueIds($('#DrugAllergyHistoryingTd a'));//药物过敏史
					Person["OtherDrugAllergyHistory"]=$("#OtherDrugAllergyHistory").val();//其他药物过敏史
					
					Person["ExposureHistory"]=getBlueIds($('#ExposureHistoryTd a'));//暴露史
					var CmDataList =[];
					//当确诊时间有值就将其保存
					//高血压
					if($('#diseasesTd span').eq(1).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="52A0328740914BCE86ED10A4D2521816";
						CmData.DiagnosisDate=$("#highBloodPressure").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(2).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="7AA0AFF1DDA040F18510513DE3753547";
						CmData.DiagnosisDate=$("#diabetes").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(3).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="708DE71884C645D0AEF802E06C6B4B12";
						CmData.DiagnosisDate=$("#coronaryHeartdDisease").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(4).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="C2B2CB0803EC46A684A00AE350A34251";
						CmData.DiagnosisDate=$("#chronicObstructivePulmonaryDisease").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(5).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="E63F8CF300D44FECBD6FF96B9FCAF39C";
						CmData.DiagnosisDate=$("#cancer").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(6).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="37A51584E2EF43D09CEF1CE8D69BDEB8";
						CmData.DiagnosisDate=$("#stroke").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(7).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="FC6FF7E27F064D9C98DCD5C83E70F119";
						CmData.DiagnosisDate=$("#severeMentalIllness").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(8).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="52A0328740914BCE86ED10A4D2521814";
						CmData.DiagnosisDate=$("#tuberculosis").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(9).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="AB9E834EDC1B4FE68CD41C94767AFD9A";
						CmData.DiagnosisDate=$("#hepatitis").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(10).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="DE414310BBCA47299208FD524D3B617A";
						CmData.DiagnosisDate==$("#notifiableDisease").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(11).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="930FAEAF1DA34246A2CBDDA86EE480CD";
						CmData.DiagnosisDate=$("#industrialDisease").val();
						CmDataList.push(CmData)
					}
					if($('#diseasesTd span').eq(12).hasClass('bluecolor')){
						var CmData ={};
						CmData.DiseaseKindID="9D9B81363B3C4A699ECB77AFF805D411";
						CmData.DiagnosisDate=$("#DiseaseOtherDate").val();
						CmData.Remark=$("#DiseaseOther").val();
						CmDataList.push(CmData)
					} 
					//获取值
					/* $('#diseaseTd a').each(function(i){
						if($(this).hasClass('bluecolor')){
							alert($('#diseaseTd a').eq(i).val())
						}
						
					}) */
					//手术处理
				   var PersonHistoryList =[]
				   if($("#sshas2").hasClass('bluecolor')){ 
					   var operationName  = $("#operation input[name='name1']");
		               var operationtime = $("#operation input[name='time']");
					   if(operationtime.length>0){
						   for(var i=0;i<operationtime.length;i++){
						    	var operation ={};
						    	operation.RecordType="1";
						    	var value=operationName[i].value;
						    	if(value!=null&&value!=""){
						    		operation.Name=operationName[i].value;
							    	operation.OccurrenceDate=operationtime[i].value
							    	PersonHistoryList.push(operation);
						    	}
						   }
						   var operation ={};
						    operation.RecordType="1";
						    operation.Name=$("#operation input").eq(0).val();
					    	operation.OccurrenceDate=$("#operation input").eq(1).val()
					    	PersonHistoryList.push(operation);
					   }else{
						    var operation ={};
						    operation.RecordType="1";
						    operation.Name=$("#operation input").eq(0).val();
					    	operation.OccurrenceDate=$("#operation input").eq(1).val()
					    	PersonHistoryList.push(operation);
					   }
					   
				   }
				   //外伤处理
				   if($("#wshas2").hasClass('bluecolor')){
					   var traumaName  = $("#trauma input[name='name1']");
		               var traumatime = $("#trauma input[name='time']");
					   if(traumatime.length>0){
						   for(var i=0;i<traumatime.length;i++){
						    	var trauma ={};
						    	trauma.RecordType="2";
						    	var value=traumaName[i].value;
						    	if(value!=null&&value!=""){
						    		trauma.Name=traumaName[i].value;
							    	trauma.OccurrenceDate=traumatime[i].value;
							    	PersonHistoryList.push(trauma)	
						    	}
						    	
						   }
						    var trauma ={};
						    trauma.RecordType="2";
						    trauma.Name=$("#trauma input").eq(0).val();
						    trauma.OccurrenceDate=$("#trauma input").eq(1).val()
					    	PersonHistoryList.push(trauma); 
					   }else{
						    var trauma ={};
						    trauma.RecordType="2";
						    trauma.Name=$("#trauma input").eq(0).val();
						    trauma.OccurrenceDate=$("#trauma input").eq(1).val()
					    	PersonHistoryList.push(trauma);
					   }
				   }
				   //输血处理
				   if($("#sxhas2").hasClass('bluecolor')){
					   var transfusionName  = $("#transfusion input[name='name1']");
		               var transfusiontime = $("#transfusion input[name='time']");
					   if(transfusiontime.length>0){
						   for(var i=0;i<transfusiontime.length;i++){
						    	var transfusion ={};
						    	transfusion.RecordType="3";
						    	var value=transfusionName[i].value;
						    	if(value!=null&&value!=""){
						    		transfusion.Name=transfusionName[i].value;
							    	transfusion.OccurrenceDate=transfusiontime[i].value;
							    	PersonHistoryList.push(transfusion);
						    	}
						    	
						   }
						    var transfusion ={};
						    transfusion.RecordType="3";
						    transfusion.Name=$("#transfusion input").eq(0).val();
						    transfusion.OccurrenceDate=$("#transfusion input").eq(1).val()
					    	PersonHistoryList.push(transfusion);
					   }else{
						    var transfusion ={};
						    transfusion.RecordType="3";
						    transfusion.Name=$("#transfusion input").eq(0).val();
						    transfusion.OccurrenceDate=$("#transfusion input").eq(1).val()
					    	PersonHistoryList.push(transfusion);
					   }
				   }
				   //遗传病史处理
				   if($("#ycbs2").hasClass('bluecolor')){
					   var inheritanceName  = $("#inheritance input[name='name1']");
		               var inheritancetime = $("#inheritance input[name='time']");
					   if(inheritancetime.length>0){
						   for(var i=0;i<inheritancetime.length;i++){
						    	var inheritance ={};
						    	inheritance.RecordType="4";
						    	var value=inheritanceName[i].value;
						    	if(value!=null&&value!=""){
						    		inheritance.Name=inheritanceName[i].value;
							    	inheritance.OccurrenceDate=inheritancetime[i].value;
							    	PersonHistoryList.push(inheritance);
						    	}
						    
						   }
						    var inheritance ={};
						    inheritance.RecordType="4";
						    inheritance.Name=$("#inheritance input").eq(0).val();
						    inheritance.OccurrenceDate=$("#inheritance input").eq(1).val()
					    	PersonHistoryList.push(inheritance);
				       }else{
						    var inheritance ={};
						    inheritance.RecordType="4";
						    inheritance.Name=$("#inheritance input").eq(0).val();
						    inheritance.OccurrenceDate=$("#inheritance input").eq(1).val()
					    	PersonHistoryList.push(inheritance);
					   }
				   }
				   //家族史处理
				   var FamilyHistoryList = [];
					//保存父亲数据
					var father ={}
					father.RelationshipType="1";
					father.Disease=getBlueIds($('.family_disase_conent').eq(0).find('a'));
					father.Remark=$("#f_0").val();
					FamilyHistoryList.push(father)
					//保存母亲数据
					var mather ={}
					mather.RelationshipType="2";
					mather.Disease=getBlueIds($('.family_disase_conent').eq(1).find('a'));
					mather.Remark=$("#f_1").val();
					FamilyHistoryList.push(mather)
					//保存兄弟姐妹数据
					var brother ={}
					brother.RelationshipType="3";
					brother.Disease=getBlueIds($('.family_disase_conent').eq(2).find('a'));
					brother.Remark=$("#f_2").val();
					FamilyHistoryList.push(brother)
					//保存子女数据
					var srother ={}
					srother.RelationshipType="4";
					srother.Disease=getBlueIds($('.family_disase_conent').eq(3).find('a'));
					srother.Remark=$("#f_3").val();
					FamilyHistoryList.push(srother)
					//残疾情况处理 
					Person["Disability"] =getBlueIds($('#DisabilityingTd a'));
					Person["OtherDisability"] =$("#OtherDisability").val();
					Person["DisabilityNumber"] =$("#DisabilityNumber").val();
					//Person["KitchenExhaust"] =$("#KitchenExhaust").val();
					var KitchenExhaust =$("#KitchenExhaust").val();
					var KitchenExhaustSum =0;
					if(KitchenExhaust==1){
						KitchenExhaustSum=1;
					}else if(KitchenExhaust==2){
						KitchenExhaustSum=2;
					}else if(KitchenExhaust==3){
						KitchenExhaustSum=4;
					}else if(KitchenExhaust==4){
						KitchenExhaustSum=8;
					}
					Person["KitchenExhaust"]=KitchenExhaustSum;
					//Person["FuelType"] =$("#FuelType").val();
					var FuelType =$("#FuelType").val();
					var FuelTypeSum=0;
					if(FuelType==1){
						 FuelTypeSum=1;
					}else if(FuelType==2){
						FuelTypeSum=2;
					}else if(FuelType==3){
						FuelTypeSum=4;
					}else if(FuelType==4){
						FuelTypeSum=8;
					}else if(FuelType==5){
						FuelTypeSum=16;
					}else if(FuelType==6){
						FuelTypeSum=32;
					}
					 Person["FuelType"] =FuelTypeSum;
					//Person["Drinkingwater"] =$("#Drinkingwater").val();
				    var Drinkingwater = $("#Drinkingwater").val()
				    var DrinkingwaterSum=0;
					if(Drinkingwater==1){
						DrinkingwaterSum=1;
					}else if(Drinkingwater==2){
						DrinkingwaterSum=2;
					}else if(Drinkingwater==3){
						DrinkingwaterSum=4;
					}else if(Drinkingwater==4){
						DrinkingwaterSum=8;
					}else if(Drinkingwater==5){
						DrinkingwaterSum=16;
					}else if(Drinkingwater==6){
						DrinkingwaterSum=32;
					}
					Person["Drinkingwater"]=DrinkingwaterSum;
					//Person["Toilet"] =$("#Toilet").val();
					var Toilet=$("#Toilet").val();
					var ToiletSum=0;
					if(Toilet==1){
						ToiletSum=1;
					}else if(Toilet==2){
						ToiletSum=2;
					}else if(Toilet==3){
						ToiletSum=4;
					}else if(Toilet==4){
						ToiletSum=8;
					}else if(Toilet==5){
						ToiletSum=16;
					}
					Person["Toilet"]=ToiletSum;
					//Person["LivestockColumn"] =$("#LivestockColumn").val();
					var LivestockColumn = $("#LivestockColumn").val();
					var LivestockColumnSum=0;
					if(LivestockColumn==1){
						LivestockColumnSum=1;
					}else if(LivestockColumn==2){
						LivestockColumnSum=2;
					}else if(LivestockColumn==3){
						LivestockColumnSum=4;
					}
					Person["LivestockColumn"]=LivestockColumnSum;
					//扩展信息
					Person["IncomeType"] =$("#IncomeType").val();
					Person["WorkDate"] =$("#WorkDate").val();
			        Person["Remark"] =$("#Remark").val();
					
					Person["HrStatus"] =$("#HrStatus").val();
					Person["HrStatusDate"] =$("#HrStatusDate").val();
					Person["HrStatusRemark"] =$("#HrStatusRemark").val();
					 
	       
					
					
					saveParam["Person"]=Person;
					saveParam["FamilyHistoryList"]=FamilyHistoryList;
					saveParam["PersonHistoryList"]=PersonHistoryList;
					saveParam["CmDataList"]=CmDataList;
					if($("#Name").val().trim()==""){
						layer.msg("姓名不能为空",{icon: 2})
						return;
					}
					/* if(!validCard()){
						layer.msg("身份证号码验证错误！",{icon: 2})
						return;
					} */
					layer.msg('确认保存？', {
	      			icon: 3,
	      			time: 0, //不自动关闭,
	      			btn: ['是', '否'],
	      			yes: function(index){
	      				//console.log('保存--')
	      				//console.log('${isNewPerson}')
	      				//console.log(JSON.stringify(saveParam))
	      				$.ajax({
	  					    type: 'POST',
	  					    url: '/FWS/famliy/updateResidentHealthRecord',
	  					    data: {
							    	saveParam : JSON.stringify(saveParam),
							    	isSave:'${isNewPerson}'
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
				
			 
		});       
				
				
			//点击添加 手术，外伤，输血
			$('.no_illness').on('click',function(){
				$(this).addClass('chosed').siblings().removeClass('chosed')
				$(this).parent().siblings('.add_illness_td').find('.add_illness').hide();
			})
			$('.has_illness').on('click',function(){
				$(this).addClass('chosed').siblings().removeClass('chosed')
				$(this).parent().siblings('.add_illness_td').find('.add_illness').show();
			})
			
			//点击添加 手术，外伤，输血
			$(".add_illness .add").on('click',function(){
				var add_div='<div class="add_illness">'+
						'	名称： <input type="text" name="name1" id="" value="" class="borderb"/> 时间： <input type="date" name="time" id="" value="" class="borderb"/>  '+
						'	<a href="javascript:void(0)" class="delete" onclick="delete_this(this)">X</a>'+
						'</div>';
				$(this).parents('.add_illness_td').append(add_div);
			});  
		
			
			//点击删除;
			
			function delete_this(x){
				$(x).parent().remove();
			};
			
			//点击添加疾病的确诊时间;让他们显示
				$('.diseases_td .optionMore').on('click',function(){
				// 点击增加删除样式;
					$('.diseases_td .Noption').removeClass('chosed');
					//$(this).toggleClass('chosed')
					var index=$(this).index();
					$('.box1').eq(index-1).toggle();
					
				});
				
				$('.diseases_td .Noption').on('click',function(){
					$('.diseases_td .optionMore').removeClass('chosed');
					$(this).addClass('chosed');
					$('.box1').hide();
				})
				
				
				//其他疾病的添加与删除
				var idx=1
				function other_delete(x){
					$(x).parent().remove();
					idx--;
					
				}
				$('.add_other_disase').on('click',function(){
					idx++;
					var other_disase='<div class=""  style="margin: 5px;">'+
									'	<span>其它疾病13. '+idx+'</span>'+
									'	<input type="text" name="" id="" value="" class="borderb"/>'+
									'	<span>确诊时间</span>'+
									'	<input  name="" id="" value="" class="borderb" add_other_disase/>'+
									'	<a href="javascript:void(0)" onclick="other_delete(this)">X</a>'+
									'</div>';
					$(this).parents('.diseaseBox').append(other_disase);
				});
										
				
				
				//家族史疾病;
				
				$('.family_disase_td .option1').on('click',function(){
					$(this).addClass('chosed').siblings().removeClass('chosed');
					$(".family_disase_conent").eq(0).show().siblings().hide();
				});
				$('.family_disase_td .option2').on('click',function(){
					$(this).addClass('chosed').siblings().removeClass('chosed');
					$(".family_disase_conent").eq(1).show().siblings().hide();
				});
				$('.family_disase_td .option3').on('click',function(){
					$(this).addClass('chosed').siblings().removeClass('chosed');
					$(".family_disase_conent").eq(2).show().siblings().hide();
				});
				$('.family_disase_td .option4').on('click',function(){
					$(this).addClass('chosed').siblings().removeClass('chosed');
					$(".family_disase_conent").eq(3).show().siblings().hide();
				});
				
				 //遗传病;
				 $(".ycb .N2").on('click',function(){
					$(this).addClass("bluecolor").siblings('.N1').removeClass('bluecolor');
					$('.box2').show();
				});
				
				$(".ycb .N1").on('click',function(){
					 $(this).addClass('bluecolor').siblings('.N2').removeClass('bluecolor')
					$('.box2').hide();
				});					
				
				
				var add_box2='<div class="box2">'+
							'	名称： <input type="text" name="name1" id="" value="" class="borderb"/> 时间： <input  name="time" id="" value="" class="borderb" onClick="WdatePicker()"/>  '+
							'	<a href="javascript:void(0)" onclick="delete_this(this)">X</a>'+
							'</div>';
							
				$(".add_box2").on('click',function(){
					$('.ycb_content_td').append(add_box2);
				});
				
				//多选加样式  
				$(".optionMore").on('click',function(){
					$(this).toggleClass("bluecolor");
					$(this).siblings('.Noption').removeClass('bluecolor')
				});
				// 多选全取消 加样式
				$(".Noption").on('click',function(){
					$(this).addClass('bluecolor').siblings('.optionMore').removeClass('bluecolor')
				})
			
				
				//单选加样式
				$(".option").on('click',function(){
					if($(this).hasClass('bluecolor')){
						$(this).removeClass('bluecolor')
					}else{
					   $(this).addClass('bluecolor').siblings('.option').removeClass('bluecolor');
					}
				})
				
				
				function isCardNo(value)  
				{  
					 var arrExp = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];//加权因子 
					  var arrValid = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2];//校验码 
					  if(/^\d{17}\d|x$/i.test(value)){  
					    var sum = 0, idx; 
					    for(var i = 0; i < value.length - 1; i++){ 
					      // 对前17位数字与权值乘积求和 
					      sum += parseInt(value.substr(i, 1), 10) * arrExp[i]; 
					    } 
					    // 计算模（固定算法） 
					    idx = sum % 11; 
					    // 检验第18为是否与校验码相等 
					    return arrValid[idx] == value.substr(17, 1).toUpperCase(); 
					  }else{ 
						  
					       return  false;  
					  } 
				    
				}  
			
				function validCard(){
					var cardid=isCardNo($("#CardID").val())
					if(!cardid){
					  layer.msg("身份证输入不合法");  
						return false;
					}else{
						 layer.msg("身份证验证成功");  
						 return true;
					}
				}
				
				function CurrentAddress(){
					$('#CurrentAddress').val('${data.CurrentAddress}')
				}
				function addAddress(){//户主地址
					$('#CurrentAddress').val('${add}')
				}
				function ResidenceAddress(){
					$('#ResidenceAddress').val('${data.ResidenceAddress}')
				}
				function NationCodeView(){//民族回显
					$("#NationCode").find("option[value='${NationCode}']").attr("selected",true); 
				}
				function EducationCodeTd(){//文化水平
					$("#EducationCodeTd").find("a").each(function(i){
						var value=$("#EducationCode").val()
						if(value==i+1){
					      $(this).addClass('bluecolor')
					     } 
					})
				}
				function BloodTypeTd(){//血型
					$("#BloodTypeTd").find("a").each(function(i){
						var value=$("#BloodType").val()
						if(value==i+1){
							
					      $(this).addClass('bluecolor')
					     } 
					})
				}
				function RhBloodTd(){//RH
					$("#RhBloodTd").find("a").each(function(i){
						var value=$("#RhBlood").val()
						if(value==i+1){
							
					      $(this).addClass('bluecolor')
					     } 
					})
				}
				
				
				//婚姻状况id="MarryStatusTd"
				function MarryStatusTd(){//RH
					$("#MarryStatusTd").find("a").each(function(i){
						var value=$("#MarryStatus").val()
						if(value==i+1){
							
					      $(this).addClass('bluecolor')
					     } 
					})
				}
	</script>
	
</body>


<script type="text/javascript">
	$(function(){
		//console.log('=========================================================')
		//console.log('${dataJson}')
		//console.log('=========================================================')
		$(".content_div").eq(0).show().siblings('.content_div').hide();
		//内容选项卡；
		$(".Edit_navbar li a").on("click",function(){
			var index= $(this).parent().index();
			$(".Edit_navbar li a").removeClass("active_li");
			$(this).addClass('active_li');
			$(".content_div").eq(index).show().siblings('.content_div').hide();
			return false;
		});
		
		
		
		

    });
	
	
	
	</script>

</html>
