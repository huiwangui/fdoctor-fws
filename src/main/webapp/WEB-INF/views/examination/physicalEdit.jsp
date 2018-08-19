<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>体检修改</title>

<link rel="stylesheet" type="text/css"
	href="/FWS/statics/css/main.css">
<link rel="stylesheet" type="text/css"
	href="/FWS/statics/css/easyui.css">
<!--引入CSS样式-->

<link rel="stylesheet" type="text/css"
	href="/FWS/statics/css/icon.css">
<!--Icon引入-->

<script type="text/javascript"
	src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript"
	src="/FWS/statics/js/jquery.easyui.min.js"></script>
<link rel="stylesheet" href="/FWS/statics/layui/css/layui.css" />
<script type="text/javascript" src="/FWS/statics/layui/layui.js"></script>
<script type="text/javascript"
	src="/FWS/statics/My97DatePicker/WdatePicker.js"></script>
<!--  <style type="text/css">
  .delete_drug:nth-child(1){
  	display:none;
  }
  </style> -->
</head>

<body>
	<div class="main">
		<input type="hidden" id="exam_id">
		
		<div class="clear"></div>
		<div class="mt10 mb10">
			历次体检 &nbsp;<select id="HealthDateList">
				<option value="">请选择</option>
				<c:forEach items="${listMtIdAndExamDate}" var="data">
					<option value="${data.MtId}" examdate="${data.ExamDate}">${data.ExamDate}
					</option>
				</c:forEach>
			</select>
<!-- 			<a id="report" href="javascript:void(0)"  style="margin-left: 5px;"> <span class="circular">+</span> 体检报告 -->
<!-- 			</a> -->
		</div>

		<div class="personMsg">
			<table>
				<tr>
					<td>上次体检时间</td>
					<td>${beforeExamInfo.ExamDate}</td>
					<td>体重</td>
					<td>${beforeExamInfo.Weight}</td>
					<td>身高</td>
					<td>${beforeExamInfo.Height}</td>
					<td>体质指数</td>
					<td>${beforeExamInfo.Bmi}</td>
				</tr>
				<tr>
					<td>腰围</td>
					<td>${beforeExamInfo.Waistline}</td>
					<td>体温</td>
					<td>${beforeExamInfo.BodyTemperature}</td>
					<td>脉率</td>
					<td>${beforeExamInfo.PulseRate}</td>
					<td>呼吸频率</td>
					<td>${beforeExamInfo.RespiratoryRate}</td>
				</tr>
				<tr>
					<td>左侧血压</td>
					<td>${beforeExamInfo.LeftSbp}/${beforeExamInfo.LeftDbp}</td>
					<td>右侧血压</td>
					<td>${beforeExamInfo.RightSbp}/${beforeExamInfo.RightDbp}</td>

				</tr>
			</table>
		</div>

		<div class="table3_hdinfo">
			<font color="red">${personInfoMsg}</font>
			<table>
				<tr>
					<td>姓名</td>
					<td>${personInfo.personName}</td>
					<td>性别</td>
					<c:choose>
						<c:when test="${personInfo.sex == 1}">
							<td>男</td>
						</c:when>
						<c:when test="${personInfo.sex == 2}">
							
						</c:when>
						<c:otherwise>
							<td>未知</td>
						</c:otherwise>
					</c:choose>
					<td>体检年龄</td>
					<td>${ExamAge}</td>
					<td>编号</td>
					<td>${personInfo.personCode}</td>
				</tr>
			</table>
		</div>


		<div class="table3">
			<table id="datable" border="1" class="tab_content">
				<tr>
					<td>体检日期</td>
					<td colspan="2"><input name="rExamDate" id="rExamDate" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})" type="date" value=""></input></td>
					<td>责任医生</td>
					<td colspan="2" id="choose_doctor" style="cursor: pointer;"><input type="hidden" name="DoctorID" value=""><span id="DoctorName"></span></td>
				</tr>
				<tr class="bgf1">
					<td class="bold">内容</td>
					<td colspan="5" class="bold">体检项目</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="5">
						<div id="symptomDiv">
							<span class="Noption">1无症状</span> <span class="optionMore">2头痛</span>
							<span class="optionMore">3头晕</span> <span class="optionMore">4心悸</span>
							<span class="optionMore">5胸闷</span> <span class="optionMore">6胸痛</span>
							<span class="optionMore">7慢性咳嗽</span> <span class="optionMore">8咳痰</span>
							<span class="optionMore">9呼吸困难</span> <span class="optionMore">10多饮</span>
							<span class="optionMore">11多尿</span> <span class="optionMore">12体重下降</span>
							<span class="optionMore">13乏力</span> <span class="optionMore">14关节肿痛</span>
							<span class="optionMore">15视力模糊</span> <span class="optionMore">16手脚麻木</span>
							<span class="optionMore">17尿急</span> <span class="optionMore">18尿痛</span>
							<span class="optionMore">19便秘</span> <span class="optionMore">20腹泻</span>
							<span class="optionMore">21恶心呕吐</span> <span class="optionMore">22烟花</span>
							<span class="optionMore">23耳鸣</span> <span class="optionMore">24乳房胀痛</span>
							<span class="optionMore">25其他<input type="text"
								name="SymptomOther" id="SymptomOther" value="" other-field="Symptom" class="borderb" /></span>
						</div>
					</td>
				</tr>

				<form id="bodyForm">
					<tr>
						<td rowspan="9">一<br />般<br />状<br />态
						</td>
						<td>体温</td>
						<td><input type="number" name="BodyTemperature"
							id="BodyTemperature" value="" class="borderb w40" /> ℃</td>
						<td>脉率 <span class="bluecolor" id="help1">?</span></td>
						<td><input type="number"  name="PulseRate" id="PulseRate"
							value="" class="borderb w40" />次/分钟</td>
						<td>/</td>
					</tr>
					<tr>
						<td rowspan="2">呼吸频率<a href="file:///C:/" class="bluecolor" id="help2">?</a></td>
						<td rowspan="2"><input type="number" name="RespiratoryRate"
							id="RespiratoryRate" value="" class="borderb w40" />次/分钟</td>
						<td rowspan="2">血压 <span class="bluecolor id="help3">?</span></td>
						<td>左侧</td>
						<td><input type="number" name="LeftSbp" id="LeftSbp" value=""
							class="borderb w20" />/ <input type="number" name="LeftDbp"
							id="LeftDbp" value="" class="borderb w20" /> mmHg</td>
					</tr>
					<tr>
						<td>右侧</td>
						<td><input type="number" name="RightSbp" id="RightSbp"
							value="" class="borderb w20" />/ <input type="number"
							name="RightDbp" id="RightDbp" value="" class="borderb w20" />
							mmHg</td>
					</tr>
					<tr>
						<td>身高</td>
						<td><input type="number" min="0.0" step="0.1" name="Height" id="Height" value=""
							class="borderb w40" />cm</td>
						<td>体重</td>
						<td><input type="number" min="0.0" step="0.1" name="Weight" id="Weight" value=""
							class="borderb w40" />kg</td>
						<td>/</td>
					</tr>
					<tr>
						<td>腰围</td>
						<td><input type="number" min="0.0" step="0.1" name="Waistline" id="Waistline"
							value="" class="borderb w40" />cm</td>
						<td>体质指数(BMI) <span class="bluecolor" id="help4">?</span></td>
						<td><input type="number" name="Bmi" id="Bmi" min="0.0" step="0.01" value=""
							class="borderb w40" />kg/m²</td>
						<td>/</td>
					</tr>
				</form>
				<tr>
					<td>老年人健康状态自我评估 <span class="redcolor">*</span></td>
					<td colspan="4" id="Health"><span class="option">1满意</span> <span
						class="option">2基本满意</span> <span class="option">3说不清楚</span> <span
						class="option">4不太满意</span> <span class="option">5不满意</span></td>
				</tr>
				<tr>
					<td>老年人生活自理能力自我评估 <span class="redcolor">*</span></td>
					<td colspan="4" id="LifeSkills"><span class="option">1可自理(0～3分)</span>
						<span class="option">2轻度依赖(4～8分)</span> <span class="option">3中度依赖(9～18分)</span>
						<span class="option">4不能自理(≥19分)</span> <span class="option">总分
							<input type="number" name="LifeSkillsScore" 
							value="" class="w40 borderb" />
					</span></td>
				</tr>
				<tr>
					<td>老年人认知功能<span class="redcolor" >*</span> <a href="file:///C:/" class="bluecolor" id="help5">?</a></td>
					<td colspan="4" id="CognitiveFunction"><span class="option">1粗筛阴性</span>
						<span class="option" id="xuanzhe">2粗阳性，简易智力状态检查</span> <span class="option">总分
							<input type="number" name="CognitiveFunctionScore" id="CognitiveFunctionScore"
							 value="" class="w40 borderb" />
					</span></td>
				</tr>
				<tr>
					<td>老年人情感状态  <span class="redcolor" >*</span> <a href="file:///C:/" class="bluecolor" id="help6">?</a></td>
					<td colspan="4" id="EmotionalState"><span class="option">1粗筛阴性</span>
						<span class="option" id="xuanzhe2">2粗阳性，老年人抑郁评分检查</span> <span class="option">总分
							<input type="number" name="EmotionalStateScore" id="EmotionalStateScore" value=""
							class="w40 borderb" />
					</span></td>
				</tr>
				<form id="LifeStyleForm">
					<tr>
						<td rowspan="17">生<br />活<br />方<br />式
						</td>
						<td rowspan="3">体育锻炼<a href="file:///C:/" class="bluecolor" id="help7">?</a></td>
						<td>锻炼频率</td>
						<td id="ExerciseFrequency" colspan="3"><span class="option">1每天</span> <span
							class="option">2每周一次以上</span> <span class="option">3偶尔</span> <span
							class="option">4不锻炼</span></td>
					</tr>
					<tr>
						<td>每次锻炼时间</td>
						<td><input type="number" name="EachExerciseTime"
							id="EachExerciseTime" value="" class="borderb w40" />分钟</td>
						<td>坚持锻炼时间</td>
						<td><input type="number" name="ExerciseTime"
							id="ExerciseTime" value="" class="borderb w40" />年</td>
					</tr>
					<tr>
						<td>锻炼方式</td>
						<td colspan="4"><input type="text" name="ExerciseMethod"
							id="ExerciseMethod" value="" class="borderb"
							style="width: 200px;" /></td>
					</tr>

					<tr>
						<td>饮食习惯</td>
						<td colspan="5">
							<div id="DietDiv">
								<span class="option">1荤素均衡</span> <span class="option">2荤食为主</span>
								<span class="option">3素食为主</span> <span class="option">4嗜盐</span>
								<span class="option">4嗜油</span> <span class="option">6嗜糖</span>
							</div>
						</td>
					</tr>
					<tr>
						<td rowspan="3">吸烟情况 <a href="file:///C:/" class="bluecolor" id="help8">?</a>
						</td>
						<td>吸烟状况</td>
						<td colspan="3">
							<div id="SmokingStatus">
								<span class="option">1从不吸烟</span> <span class="option">2已戒烟</span>
								<span class="option">3吸烟</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>日吸烟量</td>
						<td colspan="3">平均 <input type="number" name="Smoking"
							id="Smoking" value="" class="borderb w40" />只
						</td>
					</tr>
					<tr>
						<td>开始吸烟年龄</td>
						<td colspan="3"><span class=""> <input type="number"
								name="SmokingAge" id="SmokingAge" value="" class="borderb w40" />岁
						</span> <span class="seat"></span> <span class=""> 戒烟年龄 <input
								type="number" name="AgeQuit" id="AgeQuit" value=""
								class="borderb w40" />岁
						</span></td>
					</tr>

					<tr>
						<td rowspan="5">饮酒情况<a href="file:///C:/" class="bluecolor" id="help9">?</a></td>
						<td>饮酒频率</td>
						<td colspan="3" id="DrinkingFrequencyDiv"><span
							class="option">1从不</span> <span class="option">2偶尔</span> <span
							class="option">3经常</span> <span class="option">4每天</span></td>
					</tr>
					<tr>
						<td>日饮酒量</td>
						<td colspan="3">平均 <input type="number"
							name="DailyAlcoholIntake" id="DailyAlcoholIntake" value=""
							class="borderb w40" />两
						</td>
					</tr>
					<tr>
						<td>是否戒酒</td>
						<td colspan="3" id="AlcoholDiv"><span class="option">1未戒酒</span>
							<span class="option">2已戒酒</span> 戒酒年龄 <input type="number"
							name="AlcoholAge" id="AlcoholAge" value="" class="borderb w20" />岁

						</td>
					</tr>
					<tr>
						<td>开始饮酒年龄</td>
						<td colspan="1"><input type="number"
							name="AgeStartedDrinking" id="AgeStartedDrinking" value=""
							class="borderb w20" />岁</td>
						<td>近一年是否醉酒</td>
						<td id="IsDrunkLastYearOp"><span class="option">1是</span> <span
							class="option">2否</span></td>
					</tr>
					<tr>
						<td>饮酒种类</td>
						<td colspan="3">
							<div id="AlcoholTypeDiv">
								<span class="option">1白酒</span> <span class="option">2啤酒</span>
								<span class="option">3红酒</span> <span class="option">4黄酒</span>
								<span class="option">5其他</span>
							</div>
						</td>
					</tr>
				</form>

			</table>


			<table class="tab_content" border="1" hidden="">
				<form id="OePostion">
					<tr>
						<td class="" rowspan="7">生<br>活<br>方<br>式
						</td>
						<td rowspan="7">职业病危害因素接触史<a href="file:///C:/" class="bluecolor" id="help10">?</a></td>
						<td colspan="4">
							<div id="IsOeDiv">
								<span class="option">1无</span> <span class="option">2有</span>
								(工种 <input type="text" name="Occupation" id="Occupation"
									value="" class="borderb" />从业时间 <input type="number"
									name="WorkingTime" id="WorkingTime" value=""
									class="w20 borderb" />年 )
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="5">毒物种类</td>
					</tr>

					<tr id="tr0" class="row-poison">
						<td colspan="1">粉尘 <input type="text" name="PoisonName" id=""
							value="" class="borderb" />
						</td>
						<td colspan="3">防护措施 <span class="option">1无</span> <span
							class="option">2有</span> <input type="text"
							name="ProtectionMeasures" id="" value="" class="w20 borderb" />
						</td>
					</tr>
					<tr id="tr1" class="row-poison">
						<td colspan="1">放射性物质 <input type="text" name="PoisonName"
							id="" value="" class="borderb" />
						</td>
						<td colspan="3">防护措施 <span class="option">1是</span> <span
							class="option">2否</span> <input type="text"
							name="ProtectionMeasures" id="" value="" class="w20 borderb" />
						</td>
					</tr>

					<tr id="tr2" class="row-poison">
						<td colspan="1">物理因素 <input type="text" name="PoisonName"
							id="" value="" class="borderb" />
						</td>
						<td colspan="3">防护措施 <span class="option">1是</span> <span
							class="option">2否</span> <input type="text"
							name="ProtectionMeasures" id="" value="" class="w20 borderb" />
						</td>
					</tr>

					<tr id="tr3" class="row-poison">
						<td>化学因素 <input type="text" name="PoisonName" id="" value=""
							class="borderb" />
						</td>
						<td colspan="3">防护措施 <span class="option">1是</span> <span
							class="option">2否</span> <input type="text"
							name="ProtectionMeasures" id="" value="" class="w20 borderb" />
						</td>
					</tr>

					<tr id="tr4" class="row-poison">
						<td>其他 <input type="text" name="PoisonName" id="" value=""
							class="borderb" />
						</td>
						<td colspan="3">防护措施 <span class="option">1是</span> <span
							class="option">2否</span> <input type="text"
							name="ProtectionMeasures" id="" value="" class="w20 borderb" />
						</td>
					</tr>
				</form>
				<form id="OrganForm">
					<tr>
						<td rowspan="6">脏<br />器<br />功<br />能
						</td>
						<td rowspan="3">口腔</td>
						<td>口唇</td>
						<td colspan="3" id="Lips-option"><span class="option">1红润</span>
							<span class="option">2苍白</span> <span class="option">3发绀</span> <span
							class="option">4皲裂</span> <span class="option">5疱疹</span></td>
					</tr>
					<tr>
						<td>齿列</td>
						<td colspan="3" id="Dentition"><span class="option">1正常</span>
							<span class="option">2缺齿</span> <span class="option">3龋齿</span> <span
							class="option">4义齿(假牙)</span></td>
					</tr>
					<tr>
						<td>咽部</td>
						<td colspan="3" id="Throat"><span class="option">1</span> <span
							class="option">2</span> <span class="option">3</span> <span
							class="option">4</span> <span class="option">5</span> <span
							class="option">6</span> <span class="option">7</span> <span
							class="option">8</span></td>
					</tr>
					<tr>
						<td>视力 <a href="file:///C:/" class="bluecolor" id="help11">?</a></td>
						<td colspan="4">左眼 <input type="number" name="LeftEye" id=""
							value="" class="borderb w40" /> 右眼 <input type="number"
							name="RightEye" id="" value="" class="borderb w40" /> (矫正视力： 左眼 <input
							type="number" name="LeftEyeVc" id="" value="" class="borderb w40" />
							右眼 <input type="number" name="RightEyeVc" id="" value=""
							class="borderb w40" /> )
						</td>
					</tr>
					<tr>
						<td>听力   <a href="file:///C:/" class="bluecolor" id="help12">?</a></td>
						<td colspan="4" id="Hearing"><span class="option">1听见</span>
							<span class="option">2听不清或无法听见</span></td>
					</tr>
					<tr>
						<td>运动能力<a href="file:///C:/" class="bluecolor" id="help13">?</a></td>
						<td colspan="4" id="MotorFunction"><span class="option">1可顺利完成</span>
							<span class="option">2无法独立完成气质任何一个动作</span></td>
					</tr>
					<tr>
						<td rowspan="4">脏<br />器<br />功<br />能
						</td>
						<td>眼底 <span class="redcolor">*</span></td>
						<td colspan="4" id="Fundus"><span class="option">1正常</span> <span
							class="option">2异常<input type="text" name="FundusReason"
								id="FundusReason" value="" class="borderb w40" /></span></td>
					</tr>
					<tr id="Skin">
						<td>皮肤</td>
						<td colspan="4"><span class="option">1正常</span> <span
							class="option">2潮红</span> <span class="option">3苍白</span> <span
							class="option">4发绀</span> <span class="option">5染黄</span> <span
							class="option">6色素沉着</span> <span class="option">7其他<input
								type="text" name="" id="" other-field="Skin" value="" class="borderb" /></span></td>
					</tr>
					<tr id="Sclera">
						<td>巩膜</td>
						<td colspan="4"><span class="option">1正常</span> <span
							class="option">2染黄</span> <span class="option">3充血</span> <span
							class="option">4其他<input type="text" name="" id=""
								value="" class="borderb" other-field="Sclera"/></span></td>
					</tr>
					<tr id="LymphNodes">
						<td>淋巴结</td>
						<td colspan="4"><span class="option">1未触及</span> <span
							class="option">2锁骨上</span> <span class="option">3腋窝</span> <span
							class="option">4其他<input type="text" name="" id=""
								value="" class="borderb" other-field="LymphNodes"/></span></td>
					</tr>
					<tr>
						<td rowspan="20">查<br />体
						</td>
						<td rowspan="3">肺</td>
						<td>桶状胸：</td>
						<td colspan="3" id="BarrelChest"><span class="option">1否</span>
							<span class="option">2是</span></td>
					</tr>
					<tr id="BreathSounds">
						<td>呼吸音：</td>
						<td colspan="3"><span class="option">1正常</span> <span
							class="option"> 2异常 <input type="text"
								name="BreathSoundsReason" id="BreathSoundsReason" value=""
								class="borderb" />
						</span></td>
					</tr>
					<tr id="Rale">
						<td>罗音：</td>
						<td colspan="3"><span class="option">1无</span> <span
							class="option">2干罗音</span> <span class="option">3湿罗音</span> <span
							class="option">4其他<input type="text" name="" id=""
								value="" class="borderb" other-field="Rale"/></span></td>
					</tr>
					<tr>
						<td rowspan="2">心脏</td>
						<td>心律</td>
						<td id="Rhythm" colspan="3"><span class="option">1齐</span> <span
							class="option">2不齐</span> <span class="option">3绝对不齐</span></td>
					</tr>
					<tr>
						<td>杂音：</td>
						<td colspan="3" id="HeartMurmur"><span class="option">1无</span>
							<span class="option">2有<input type="text"
								name="HeartMurmurReason" id="HeartMurmurReason" value=""
								class=" borderb" />
						</span>
						</td>
					</tr>
					<tr>
						<td rowspan="5">腹部</td>
						<td>压痛：</td>
						<td colspan="3" id="AbdominalTenderness"><span class="option">1无</span>
							<span class="option">2有 <input type="text"
								name="AbdominalTendernessReason" id="AbdominalTendernessReason"
								value="" class="borderb" />
						</span></td>
					</tr>
					<tr>
						<td>包块：</td>
						<td colspan="3" id="AbdominalMass"><span class="option">1无</span>
							<span class="option">2有 <input type="text"
								name="AbdominalMassReason" id="AbdominalMassReason" value=""
								class="borderb" />
						</span></td>
					</tr>
					<tr>
						<td>肝大：</td>
						<td colspan="3" id="TheAbdomenLiver"><span class="option">1无</span>
							<span class="option">2有 <input type="text"
								name="TheAbdomenLiverReason" id="TheAbdomenLiverReason" value=""
								class="borderb" />
						</span></td>
					</tr>
					<tr>
						<td>脾大：</td>
						<td colspan="3" id="Splenomegaly"><span class="option">1无</span>
							<span class="option">2有 <input type="text"
								name="SplenomegalyReason" id="SplenomegalyReason" value=""
								class="borderb" />
						</span></td>
					</tr>
					<tr>
						<td>移动性浊音：</td>
						<td colspan="3" id="ShiftingDullness"><span class="option">1无</span>
							<span class="option">2有 <input type="text"
								name="ShiftingDullnessReason" id="ShiftingDullnessReason"
								value="" class="borderb" />
						</span></td>
					</tr>
					<tr>
						<td>下肢水肿</td>
						<td colspan="4" id="LowerExtremityEdema"><span class="option">1无</span>
							<span class="option">2单侧</span> <span class="option">3双侧不对称</span>
							<span class="option">4双侧对称</span></td>
					</tr>
					<tr>
						<td>足背动脉搏动 <a href="file:///C:/" class="bluecolor" id="help14">?</a></td>
						<td colspan="4" id="DorsalisPedisArteryPulse"><span
							class="option">1未触及</span> <span class="option">2触及双侧对称</span> <span
							class="option">3触及左侧弱或消失</span> <span class="option">4触及右侧弱或消失</span>
						</td>
					</tr>
					<tr>
						<td>肛门指诊 <span class="redcolor">*</span></td>
						<td colspan="4" id="Dre"><span class="option">1未及异常</span> <span
							class="option">2触痛</span> <span class="option">3包块</span> <span
							class="option">4前列腺异常</span> <span class="option">5其他 <input
								type="text" name="" other-field="Dre" id="" value="" class="borderb" />
						</span>
						</td>
					</tr>
					<tr>
						<td>乳腺 <span class="redcolor">*</span> <a href="file:///C:/" class="bluecolor" id="help15">?</a></td>
						<td colspan="4" id="Breast"><span class="option">1未及异常</span>
							<span class="option">2触痛</span> <span class="option">3包块</span> <span
							class="option">4前列腺异常</span> <span class="option">5其他 <input
								type="text" name="" other-field="Breast" id="" value="" class="borderb" />
						</span>
						</td>
					</tr>
				</form>
				<tr>
					<td rowspan="5">妇科 <span class="redcolor">*</span></td>
					<td>外阴 <span class="bluecolor">?</span></td>
					<td colspan="3" id="Vulva"><span class="option">1未见异常</span> <span
						class="option">2异常 <input type="text" name="VulvaReason"
							id="VulvaReason" value="" class="borderb" />
					</span></td>
				</tr>
				<tr>
					<td>阴道 <span class="bluecolor">?</span></td>
					<td colspan="3" id="Vaginal"><span class="option">1未见异常</span>
						<span class="option">2异常 <input type="text" name="VaginalReason"
							id="VaginalReason" value="" class="borderb" />
					</span></td>
				</tr>
				<tr>
					<td>宫颈 <span class="bluecolor">?</span></td>
					<td colspan="3" id="Cervix"><span class="option">1未见异常</span>
						<span class="option">2异常 <input type="text" name="CervixReason"
							id="CervixReason" value="" class="borderb" />
					</span></td>
				</tr>
				<tr>
					<td>宫体 <span class="bluecolor">?</span></td>
					<td colspan="3" id="Palace"><span class="option">1未见异常</span>
						<span class="option">2异常 <input type="text" name="PalaceReason"
							id="PalaceReason" value="" class="borderb" />
					</span></td>
				</tr>
				<tr>
					<td>附件 <span class="bluecolor">?</span></td>
					<td colspan="3" id="UterineAdnexa"><span class="option">1未见异常</span>
						<span class="option">2异常 <input type="text" name="UterineAdnexaReason"
							id="UterineAdnexaReason" value="" class="borderb" />
					</span></td>
				</tr>
				<tr>
					<td>其他 <span class="redcolor">*</span></td>
					<td colspan="4"><input type="text" name="" id="womenOther" value=""
						class="borderb" /></td>
				</tr>


			</table>


			<table class="tab_content" border="1" hidden="">
				<form id="Labor">
					<tr>
						<td rowspan="21">辅<br />助<br />检<br />查
						</td>
						<td rowspan="2">血常规<span class="redcolor">*</span></td>
						<td colspan="1">血红蛋白<span class="bluecolor">?</span> <input
							type="number" name="Hemoglobin" placeholder="请输入" value=""
							class="borderb w40" />mol/L
						</td>
						<td colspan="1">白细胞<span class="bluecolor">?</span> <input
							type="number" name="Leukocyte" placeholder="请输入" value=""
							class="borderb w40" />X10 <sup>9</sup>/L
						</td>
						<td colspan="1">血小板 <span class="bluecolor">?</span> <input
							type="number" name="Platelet" placeholder="请输入" value=""
							class="borderb w40" />
						</td>
						<td>/</td>
					</tr>
					<tr>
						<td colspan="4">其他 <input type="text" name="OtherBlood" id=""
							value="" class="borderb"/>
						</td>
					</tr>
					<tr class="Urines">
						<td rowspan="3">尿常规 <span class="redcolor">*</span><a href="file:///C:/" class="bluecolor" id="help24">?</a></td>
						<td colspan="1">尿蛋白(PRO) <select name="UrineProtein"
							class="borderb">
								<option value="">+++++</option>
								<option value="">++++</option>
								<option value="">+++</option>
								<option value="">++</option>
						</select>
						</td>
						<td colspan="1">尿糖(GLU) <select name="Urine" class="borderb">
								<option value="">+++++</option>
								<option value="">++++</option>
								<option value="">+++</option>
								<option value="">++</option>
						</select>
						</td>
						<td colspan="1">尿酮体(GLU) <select name="Ketone"
							class="borderb">
								<option value="">+++++</option>
								<option value="">++++</option>
								<option value="">+++</option>
								<option value="">++</option>
						</select>
						</td>
						<td colspan="1">尿潜血(BLO) <select name="OccultBloodInUrine"
							class="borderb">
								<option value="">+++++</option>
								<option value="">++++</option>
								<option value="">+++</option>
								<option value="">++</option>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="4">其他 <input type="text" name="OtherUrine" id=""
							value="" class="borderb" />
						</td>
					</tr>
					<tr>
						<td>空腹血糖(FPG) <span class="redcolor">*</span><a href="file:///C:/" class="bluecolor" id="help25">?</a></td>
						<td><input type="number" name="FastingBloodGlucose"
							placeholder="请输入" value="" class="borderb w40" />mmol/L</td>
						<td>随机血糖</td>
						<td><input type="number" name="RandomBloodGlucose" id=""
							value="" class="borderb w40" />mmol/L</td>
					</tr>
					<tr>
						<td>心电图<span class="redcolor">*</span></td>
						<td colspan="4" id="Ecg"><span class="option">1正常</span> <span
							class="option">2异常 <input type="text" name=""
								id="EcgReason" value="" class="borderb" />
						</span>
						</td>
					</tr>
					<tr>
						<td>尿微量白蛋白(U-MA)<span class="redcolor">*</span></td>
						<td colspan="4"><input type="number" name="UrinaryAlbumin"
							placeholder="请输入" value="" class="borderb w40" />mg/dL</td>
					</tr>
					<tr>
						<td>大便潜血(FOB)<span class="redcolor">*</span></td>
						<td colspan="4" id="FecalOccultBlood"><span class="option">1阴性</span>
							<span class="option">2阳性</span></td>
					</tr>
					<tr>
						<td>糖化血红蛋白(HbA1c)<span class="redcolor">*</span></span><a href="file:///C:/" class="bluecolor" id="help26">?</a></td>
						<td colspan="4"><input type="number"
							name="GlycatedHemoglobin" id="" value="" class="w40" />%</td>
					</tr>
					<tr>
						<td>乙型肝炎表面抗原(HBsAg)<span class="redcolor">*</span></span></td>
						<td colspan="4" id="HepatitisBSurfaceAntigen"><span
							class="option">1阴性</span> <span class="option">2阳性</span></td>
					</tr>
					<tr>
						<td rowspan="3">肝功能<span class="redcolor">*</span></td>
						<td colspan="2">血清谷丙转氨酶(ALT) <span class="bluecolor" id="help27">?</span>
							<input type="number" name="SerumAla" placeholder="请输入" value=""
							class="borderb w40" />U/L
						</td>
						<td colspan="2">血清谷草转氨酶(AST) <span class="bluecolor" id="help28">?</span>
							<input type="number" name="SerumAa" placeholder="请输入" value=""
							class="borderb w40" />U/L
						</td>
					</tr>
					<tr>
						<td colspan="2">白蛋白(ALB) <input type="number" name="Albumin"
							placeholder="请输入" value="" class="borderb w40" />g/L
						</td>
						<td colspan="2">总胆红素(TBIL) <span class="bluecolor" id="help29">?</span> <input
							type="number" name="TotalBilirubin" placeholder="请输入" value=""
							class="borderb w40" />μ mol/L
						</td>
					</tr>
					<tr>
						<td colspan="2">结合胆红素(SDB) <input type="number"
							name="Bilirubin" placeholder="请输入" value="" class="borderb w40" />μ
							mol/L
						</td>
						<td colspan="2">/</td>
					</tr>
					<tr>
						<td rowspan="2">肾功能<span class="redcolor">*</span> <span
							class="bluecolor" id="30">?</span></td>
						<td colspan="2">血清肌酐(SCR) <span class="bluecolor" id="31" >?</span> <input
							type="number" name="SerumCreatinine" placeholder="请输入" value=""
							class="borderb w40" />μ mol/L
						</td>
						<td colspan="2">血尿素氮 <span class="bluecolor" id="32">?</span> <input
							type="number" name="Bun" placeholder="请输入" value=""
							class="borderb w40" />mmol/L
						</td>
					</tr>
					<tr>
						<td colspan="2">血钾浓度(K+) <input type="number"
							name="PotassiumConcentration" id="" value="" class="borderb w40" />mmol/L
						</td>
						<td colspan="2">血钠浓度(Na+) <input type="number"
							name="SodiumConcentration" id="" value="" class="borderb w40" />mmol/L
						</td>
					</tr>
					<tr>
						<td rowspan="2">血脂</td>
						<td colspan="2">总胆固醇(TC) <span class="bluecolor" id="33">?</span> <input
							type="number" name="TotalCholesterol" placeholder="请输入" value=""
							class="borderb w40" />mmol/L
						</td>
						<td colspan="2">甘油三酯(TG) <span class="bluecolor" id="34">?</span> <input
							type="number" name="Triglycerides" placeholder="请输入" value=""
							class="borderb w40" />mmol/L
						</td>
					</tr>
					<tr>
						<td colspan="2">血清低密度脂蛋白胆固醇(LDL-C) <input type="number"
							name="LdlCholesterol" placeholder="请输入" value=""
							class="borderb w40" />mmol/L
						</td>
						<td colspan="2">血清高密度脂蛋白胆固醇(HDL-C) <input type="number"
							name="HdlCholesterol" id="" value="" class="borderb w40" />mmol/L
						</td>
					</tr>
					<tr>
						<td>胸部X线片<span class="redcolor">*</span></td>
						<td colspan="4" id="ChestXRay"><span class="option">1正常</span>
							<span class="option"> 2异常 <input type="text" name=""
								id="ChestXRayReason" value="" class="borderb" />
						</span>
						</td>
					</tr>
					<tr>
						<td>B 超<span class="redcolor">*</span></td>
						<td colspan="4" id="BUltrasonicWave"><span class="option">1正常</span>
							<span class="option"> 2异常 <input type="text" name=""
								id="BUltrasonicWaveReason" value="" class="borderb" />
						</span>
						</td>
					</tr>
					<tr>
						<td>宫颈涂片<span class="redcolor">*</span></td>
						<td colspan="4" id="CervicalSmear"><span class="option">1正常</span>
							<span class="option"> 2异常 <input type="text" name=""
								id="CervicalSmearReason" value="" class="borderb" />
						</span>
						</td>
					</tr>
					<tr>
						<td>其他<span class="redcolor">*</span><span class="bluecolor" id="help35">?</span></td>
						<td colspan="4"><input type="text" name="OtherLaboratory"
							id="" value="" class="borderb" /></td>
					</tr>
				</form>
				<form id="ChsCons">
					<tr>
						<td rowspan="9">中<br />医<br />体<br />质<br />辨<br />识<br />
						<span class="redcolor">*</span>
						</td>
						<td>平和质</td>
						<td colspan="4" id="ModerateQuality"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>气虚质</td>
						<td colspan="4" id="QualityDeficiency"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>阳虚质</td>
						<td colspan="4" id="YangQuality"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>阴虚质</td id="YinQuality">
						<td colspan="4"><span class="option">1是</span> <span
							class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>痰湿质</td>
						<td colspan="4" id="Phlegm"><span class="option">1是</span> <span
							class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>湿热质</td>
						<td colspan="4" id="DampHeat"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>血瘀质</td>
						<td colspan="4" id="BloodQuality"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>气郁质</td>
						<td colspan="4" id="QiQuality"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
					<tr>
						<td>特秉质</td>
						<td colspan="4" id="TeBingQuality"><span class="option">1是</span>
							<span class="option">2倾向是</span></td>
					</tr>
				</form>

			</table>

			<table class="tab_content" border="1" hidden="">
				<form>
					<tr>
						<td rowspan="7">现<br />存<br />主<br />要<br />健<br />康<br />问<br />题
						</td>
						<td>脑血管疾病</td>
						<td colspan="4" id="Cerebrovascular"><span class="option">1未发现</span>
							<span class="option">2缺血性卒中</span> <span class="option">3脑出血</span>
							<span class="option">4蛛网膜下腔出血</span> <span class="option">5短暂性脑缺血发作</span>
							<span class="option"> 6其他 <input type="text" name="" id=""
								value="" class="borderb" other-field="Cerebrovascular"/>
						</span></td>
					</tr>
					<tr>
						<td>肾脏疾病</td>
						<td colspan="4" id="Kidney"><span class="option">1未发现</span>
							<span class="option">2糖尿病肾病</span> <span class="option">3肾功能衰竭</span>
							<span class="option">4急性肾炎</span> <span class="option">5慢性肾炎</span>
							<span class="option"> 6其他 <input type="text" name="" id=""
								value="" class="borderb" other-field="Kidney"/>
						</span></td>
					</tr>
					<tr>
						<td>心脏疾病</td>
						<td colspan="4" id="Heart"><span class="option">1未发现</span> <span
							class="option">2心肌梗死</span> <span class="option">3心绞痛</span> <span
							class="option">4冠状动脉血运重建</span> <span class="option">5充血性心力衰竭</span>
							<span class="option">6心前区疼痛</span> <span class="option">
								7其他 <input type="text" name="" id="" value="" class="borderb" other-field="Heart"/>
						</span></td>
					<tr>
						<td>血管疾病</td>
						<td colspan="4" id="Vascular"><span class="option">1未发现</span>
							<span class="option">2夹层动脉瘤</span> <span class="option">3动脉闭塞性疾病</span>
							<span class="option"> 4其他 <input type="text" name="" id=""
								value="" class="borderb" other-field="Vascular"/>
						</span></td>
					</tr>
					<tr>
						<td>眼部疾病</td>
						<td colspan="4" id="Eyes"><span class="option">1未发现</span> <span
							class="option">2视网膜出血或渗出</span> <span class="option">3视乳头水肿</span>7
							<span class="option">4白内障</span> <span class="option"> 5其他
								<input type="text" name="" id="" value="" class="borderb"  other-field="Eyes"/>
						</span></td>
					</tr>
					<tr>
						<td>神经系统疾病</td>
						<td colspan="5" id="Nervoussystems"><span class="option">1未发现</span>
							<span class="option">2有 <input type="text" name="" id=""
								value="" class="borderb" other-field="Nervoussystems"/>
						</span></td>
					</tr>
					<tr>
						<td>其他系统疾病</td>
						<td colspan="5" id="Others"><span class="option">1未发现</span>
							<span class="option">2有 <input type="text" name="" id=""
								value="" class="borderb"  other-field="Others"/>
						</span></td>
					</tr>
				</form>

				<tr id="hosp_title_tr">
					<td rowspan="4" class="inHospital_situation">住<br />院<br />治<br />疗<br />情<br />况
					</td>
					<td rowspan="2" class="inHospital_history">住院史</td>
					<td>入/出院日期</td>
					<td>原因</td>
					<td>医疗机构名称</td>
					<td>病案号 <a href="javascript:void(0)" class="add_drug">+</a></td>
				</tr>

				<tr class="add_drugTr">
					<td><input type="date" name="InDate" data-json-key="hosList" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"
						data-json-by="HistoryType:1" id="" value="" class="borderb" />/ <input
						type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="OutDate" data-json-key="hosList"
						data-json-by="HistoryType:1" id="" value="" class="borderb" /></td>
					<td><input type="text" name="Reason" id=""
						data-json-key="hosList" data-json-by="HistoryType:1" value=""
						class="borderb" /></td>
					<td><input type="text" name="OrgName" id=""
						data-json-key="hosList" data-json-by="HistoryType:1" value=""
						class="borderb" /></td>
					<td><input type="text" name="MedicalRecordNumber"
						data-json-key="hosList" data-json-by="HistoryType:1" id=""
						value="" class="borderb" /> <a href="javascript:void(0)"
						class="delete_drug">X</a></td>
				</tr>


				<tr id="bed_title_tr">
					<td rowspan="2" class="inBed">家庭病床史</td>
					<td>建/撤床日期</td>
					<td>原因</td>
					<td>医疗机构名称</td>
					<td>病案号<a href="javascript:void(0)" class="add_bed">+</a></td>
				</tr>
				<tr class="inBed_tr">
					<td><input type="date" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="InDate" id=""
						data-json-key="hosList" data-json-by="HistoryType:2" value=""
						class="borderb" />/ <input type="date" name="OutDate" id="" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"
						data-json-key="hosList" data-json-by="HistoryType:2" value=""
						class="borderb" /></td>
					<td><input type="text" name="Reason" id=""
						data-json-key="hosList" data-json-by="HistoryType:2" value=""
						class="borderb" /></td>
					<td><input type="text" name="OrgName" id=""
						data-json-key="hosList" data-json-by="HistoryType:2" value=""
						class="borderb" /></td>
					<td><input type="text" name="MedicalRecordNumber" id=""
						data-json-key="hosList" data-json-by="HistoryType:2" value=""
						class="borderb" /> <a href="javascript:void(0)" class="delete_bed">X</a>
					</td>
				</tr>

				<form>
					<tr>
						<td rowspan="2" class="drug_situation">主要用药情况</td>
						<td>药物名称</td>
						<td>用法</td>
						<td>用量</td>
						<td>用药时间</td>
						<td>服药依从性<a href="javascript:void(0)" class="add_drug2">+</a>
							<br />

						</td>
					</tr>
					<tr class="drug_situation_tr">
						<td><input type="text" name="DrugName" id="" value=""
							class="borderb" /></td>
						<td><input type="text" name="Usage" id="" value=""
							class="borderb" /></td>
						<td><input type="text" name="Amount" id="" value=""
							class="borderb" /></td>
						<td><input type="text" name="MedicationTime" id="" value=""
							class="borderb w40" /> <select name="MedicationUnit" class="MedicationUnit">
								<option value="1">天</option>
								<option value="2">月</option>
								<option value="3">年</option>
						</select></td>
						<td class="MedicationCompliance"><span class="option">1规律</span>
							<span class="option">2间断</span> <span class="option">3不服药</span>
							<a href="javascript:void(0)" class="delete_drug2"
							onclick="delete_drug2(this)">X</a></td>
					</tr>
				</form>
				<form>
					<tr>
						<td rowspan="2" class="inoculation">非免疫 规划预防接种史</td>
						<td>名称</td>
						<td>接种日期</td>
						<td colspan="3">接种机构 <a href="javascript:void(0)"
							class="add_inoculation">+</a></td>
					</tr>
					<tr id="vaccList" class="inoculation_tr">
						<td><input type="text" name="VaccineName" id="" value=""
							class="borderb" /></td>
						<td><input type="date" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="VaccDate" id="" value=""
							class="borderb" /></td>
						<td colspan="3"><input type="text" name="VaccOrgName" id=""
							value="" class="borderb" /> <a href="javascript:void(0)"
							class="delete_inoculation">X</a></td>
					</tr>
				</form>
				<tr>
					<td rowspan="2" class="health_assess">健康评价</td>
					<td colspan="5" id="Assessment"><span class="option">1体检无异常</span>
						<span class="option">2有异常</span></td>
				</tr>
				<tr>
					<td colspan="5" class="health_assess_tr">结果： <input
						type="text" name="AssessmentAbnormal" id="" value=""
						class="borderb" /> <a href="javascript:void(0)"
						class="delete_health_assess">X</a>
					</td>
				</tr>
				<tr>
					<td rowspan="3">健康指导</td>
					<td>建议选项</td>
					<td colspan="5" id="Guidance"><span class="optionMore">1
							纳入慢性病患者健康管理 </span> <span class="optionMore">2 建议复查 </span> <span
						class="optionMore">3 纳入慢性病患者健康管理 </span></td>
				</tr>
				<tr>
					<td>危险因素控制</td>
					<td colspan="4" id="RiskCrtl"><span class="optionMore">1戒烟
					</span> <span class="optionMore">2健康饮酒 </span> <span class="optionMore">3饮食
					</span> <span class="optionMore">4锻炼 </span> <span class="optionMore">5减体重
							(目标 <input type="number" name="RiskCrtlWeight" id="" value=""
							class="borderb w40" /> KG)
					</span> <span class="optionMore">6建议接种疫苗 <input type="text"
							name="RiskCrtlVaccine" id="" value="" /></span> <span
						class="optionMore">其他 <input type="text" name="RiskCrtlOther"
							id="" value="" /></span></td>
				</tr>
				<tr>
					<td>健康摘要</td>
					<td colspan="5"><textarea id="HealthSummary" rows="" cols=""
							style="width: 98%;"></textarea></td>
				</tr>
			</table>




			<div class="mt20"></div>
			<div class="paging chartSearch">
				<ul>
					<li class="active"><a href="javascript:void(0)">1</a></li>
					<li class=""><a href="javascript:void(0)">2</a></li>
					<li class=""><a href="javascript:void(0)">3</a></li>
					<li class=""><a href="javascript:void(0)">4</a></li>

				</ul>
			</div>


			<div class="footer_btn">
				<ul>
					<li><a id="saveButton" class="sibtn save_btn1" href="javascript:void(0)">保存</a></li>

				</ul>
			</div>
		</div>
</body>
<script type="text/javascript">

/**
 * ------------------------------全局共用方法、点击事件、初始化设置-------------------------------------
 */

	//日期改变时间
	$('#HealthDateList').change(function(){
		window.location.href="/FWS/examination/updateExaminationPage?personId=${personInfo.personId}"
						+ '&examId=' + $('#HealthDateList').val() + '&examDate=' + $("#HealthDateList").find("option:selected").text();
	});


	var PersonIDStr='${personInfo.personId}';

	//多选选中
	$('.optionMore').on('click',function(){
		var op=$(this);
		op.toggleClass('bluecolor');
		$(this).siblings('.Noption').removeClass('bluecolor');
	});
	
	//选中取消
	$(".Noption").on('click',function(){
		$(this).addClass('bluecolor').siblings().removeClass('bluecolor');
	});
	
	//单选选中
	$(".option").on('click',function(){
		$(this).addClass('bluecolor').siblings().removeClass('bluecolor');
	}) 

	//获取单选的选中值
	function getFieldSpanValue(sss){
		var fliedvalue=0;
		$.each(sss,function(i){
			if($(this).hasClass('bluecolor')){
				fliedvalue=i+1;
			}
		});
		return fliedvalue;
	}

	//添加住院史
	$('.delete_drug').eq(0).hide();
	$('.add_drug').on('click',function(){
		//住院史,和住院情况的高度+1;
		var rowspan1=parseInt($('.inHospital_situation').attr("rowspan"));
		var rowspan2=parseInt($('.inHospital_history').attr("rowspan"));
		$('.inHospital_situation').attr("rowspan",rowspan1+1);
		$('.inHospital_history').attr("rowspan",rowspan2+1);
		//克隆自己添加在后面；
		var add_tr='<tr class="add_drugTr">'+
		'					<td>'+
		'						<input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="InDate" id="" value="" class="borderb"/>/'+
		'						<input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="OutDate" id="" value="" class="borderb"/>'+
		'					</td>'+
		'					<td>'+
		'						<input type="text" name="Reason" id="" value="" class="borderb"/>'+
		'					</td>'+
		'					<td>'+
		'						<input type="text" name="OrgName" id="" value="" class="borderb"/>'+
		'					</td>'+
		'					<td>'+
		'						<input type="text" name="MedicalRecordNumber" id="" value="" class="borderb"/> <a href="javascript:void(0)" onclick="delete_drug(this);">X</a>'+
		'					</td>'+
		'				</tr>';
		
	
		/* var add_tr=$(".add_drugTr").eq(-1).clone(true);
		add_tr.find("input").val(""); */
		$("#hosp_title_tr").after(add_tr);
		//除了第一个x隐藏 其他的显示出来;
		$('.delete_drug').show();
		$('.delete_drug').eq(0).hide();
	});
	
	//删除住院史
	function delete_drug(x){
		//rowspan -1；
		var rowspan1=parseInt($('.inHospital_situation').attr("rowspan"));
		var rowspan2=parseInt($('.inHospital_history').attr("rowspan"));
		$('.inHospital_situation').attr("rowspan",rowspan1-1);
		$('.inHospital_history').attr("rowspan",rowspan2-1);
		//让他这一行消失；
		$(x).parents('tr').remove();
		
		return false;
	}

	//添加家庭病床史
	$('.delete_bed').eq(0).hide();
	$('.add_bed').on('click',function(){
		//住院史,和住院情况的高度+1;
		var rowspan1=parseInt($('.inHospital_situation').attr("rowspan"));
		var rowspan3=parseInt($('.inBed').attr("rowspan"));
		$('.inHospital_situation').attr("rowspan",rowspan1+1);
		$('.inBed').attr("rowspan",rowspan3+1);
		//克隆自己添加在后面；
		//$(".inBed_tr").eq(-1).after($(".inBed_tr").eq(-1).clone(true));
		//$(".inBed_tr").eq(-1).find('input').val("")
		var add_tr='<tr class="inBed_tr">'+
		'					<td>'+
		'						<input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="InDate" id="" value="" class="borderb"/>/'+
		'						<input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"  name="OutDate" id="" value="" class="borderb"/>'+
		'					</td>'+
		'					<td>'+
		'						<input type="text" name="Reason" id="" value="" class="borderb"/>'+
		'					</td>'+
		'					<td>'+
		'						<input type="text" name="OrgName" id="" value="" class="borderb"/>'+
		'					</td>'+
		'					<td>'+
		'						<input type="text" name="MedicalRecordNumber" id="" value="" class="borderb"/> <a href="javascript:void(0)" onclick="delete_bed(this);">X</a>'+
		'					</td>'+
		'				</tr>';
	
		$("#bed_title_tr").after(add_tr);
		//除了第一个x隐藏 其他的显示出来;
		$('.delete_bed').show();
		$('.delete_bed').eq(0).hide();
		return false;
	});
	
	//删除家庭病床史；
	function delete_bed(x){
		//rowspan -1；
		var rowspan1=parseInt($('.inHospital_situation').attr("rowspan"));
		var rowspan3=parseInt($('.inBed').attr("rowspan"));
		$('.inHospital_situation').attr("rowspan",rowspan1-1);
		$('.inBed').attr("rowspan",rowspan3-1);
		//让他这一行消失；
		$(x).parents('tr').remove();
		return false;
	}


	//添加体检用药记录
	$('.delete_drug2').eq(0).hide();
	$('.add_drug2').on('click',function(){
		//高度+1;
		var rowspan1=parseInt($('.drug_situation').attr("rowspan"));
		$('.drug_situation').attr("rowspan",rowspan1+1);
		//克隆自己添加在后面；
		var add_tr='	<tr  class="drug_situation_tr">'+
				'					<td><input type="text" name="DrugName" id="" value="" class="borderb"/></td>'+
				'					<td><input type="text" name="Usage" id="" value="" class="borderb"/></td>'+
				'					<td><input type="text" name="Amount" id="" value="" class="borderb"/></td>'+
				'					<td>'+
				'						<input type="text" name="MedicationTime" id="" value="" class="borderb w40"/>'+
				'						<select name="MedicationUnit" class="MedicationUnit">'+
				'							<option value="1">天</option>'+
				'							<option value="2">月</option>'+
				'							<option value="3">年</option>'+
				'						</select>'+
				'					</td>'+
				'					<td class="MedicationCompliance">'+
				'					    <span class="option">1规律</span>'+
				'						<span class="option">2间断</span>'+
				'						<span class="option">3不服药</span>'+
				'						<a href="javascript:void(0)" onclick="delete_drug2(this)">X</a>'+
				'					</td>'+
				'				</tr>';
				$(".drug_situation_tr").eq(-1).after(add_tr);
		//$(".drug_situation_tr").eq(-1).after($(".drug_situation_tr").eq(-1).clone(true));
		$(".drug_situation_tr").eq(-1).find('input').val("")
		$(".drug_situation_tr").eq(-1).find('span')
		//除了第一个x隐藏 其他的显示出来;
		$('.delete_drug2').show();
		$('.delete_drug2').eq(0).hide();
		//重新声明点击事件
		$(".option").on('click',function(){
			$(this).addClass('bluecolor').siblings().removeClass('bluecolor');
		}) 
	});
	
	//删除体检用药记录；
	function delete_drug2(x){
		
		//rowspan -1；
		var rowspan1=parseInt($('.drug_situation').attr("rowspan"));
		$('.drug_situation').attr("rowspan",rowspan1-1);
		//让他这一行消失；
		$(x).parents('tr').remove();
		return false;
	}

	//添加接种史
	$('.delete_inoculation').eq(0).hide();	
	$('.add_inoculation').on('click',function(){
		//住院史,和住院情况的高度+1;
		var rowspan1=parseInt($('.inoculation').attr("rowspan"));
		$('.inoculation').attr("rowspan",rowspan1+1);
		//克隆自己添加在后面；
		$(".inoculation_tr").eq(-1).after($(".inoculation_tr").eq(-1).clone(true));
		$(".inoculation_tr").eq(-1).find('input').val("")
		//除了第一个x隐藏 其他的显示出来;
		$('.delete_inoculation').show();
		$('.delete_inoculation').eq(0).hide();
		return false;
	});
	
	//删除接种史；
	$('.delete_inoculation').on('click',function(){
		//rowspan -1；
		var rowspan1=parseInt($('.inoculation').attr("rowspan"));
		$('.inoculation').attr("rowspan",rowspan1-1);
		//让他这一行消失；
		$(this).parents('tr').remove();
		return false;
	});

	//健康评价 添加删除
	$('.add_health_assess').on('click',function(){
		//住院史,和住院情况的高度+1;
		var rowspan1=parseInt($('.health_assess').attr("rowspan"));
		$('.health_assess').attr("rowspan",rowspan1+1);
		//克隆自己添加在后面；
		$(".health_assess_tr").eq(-1).after($(".health_assess_tr").eq(-1).clone(true));
		//除了第一个x隐藏 其他的显示出来;
		$('.delete_health_assess').show();
		$('.delete_health_assess').eq(0).hide();
		return false;
	});
	//点击删除；
	$('.delete_health_assess').on('click',function(){
		//rowspan -1；
		var rowspan1=parseInt($('.health_assess').attr("rowspan"));
		$('.health_assess').attr("rowspan",rowspan1-1);
		//让他这一行消失；
		$(this).parents('tr').remove();
		return false;
	});
	
	//医生姓名点击事件：选择责任医生
	$("#choose_doctor").on('click',function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				type: 2,
				title: '查询医生列表',
				shadeClose: true,
				area: ['70%', '70%'],
				content: '/FWS/common/doctorListPage?nameContainerId=DoctorName&idContainerId=DoctorID'//iframe的url
			});
		})
	});

	//认知功能 选择
	 $("#xuanzhe").on('click',function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				type: 2,
				title: '认知功能检查',
				shadeClose: true,
				shade: 0.8,
				area: ['500px', '410px'],
				content: '/FWS/examination/oldPersonCognizePage?scoreContainerId=CognitiveFunctionScore'
			});
			return false;
		})
	 });
	
	//情感状态选择
	$("#xuanzhe2").on('click',function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				type: 2,
				title: '情感状态检查',
				shadeClose: true,
				shade: 0.8,
				area: ['500px', '410px'],
				content: '/FWS/examination/oldPersonFeelingPage?scoreContainerId=EmotionalStateScore'//iframe的url
			});
			return false;
		})
	});
	
	//分页控制的选项卡
	$(".chartSearch li").eq(0).addClass('active');
	$(".chartSearch li").on('click',function(){
		var index=$(this).index();
		$(".tab_content").eq(index).show().siblings('.tab_content').hide();
		$(this).addClass('active').siblings().removeClass('active');
	})
	
	//体检报告
	
	
	
	/**
	*  -------------------------初始化设置结束---------------------------------------
	/
	
	/**
	*  -------------------------表回显处理开始----------------------------------------
	*/
	var all_symp = $('#symptomDiv span');//症状
	var all_SmokingStatus=$('#SmokingStatus span.option');//吸烟情况
	var all_DrinkingFrequency=$('#DrinkingFrequencyDiv span.option');//饮酒情况
	var all_Diet=$('#DietDiv span.option');//饮食情况
	var all_Alcohol=$('#AlcoholDiv span.option');//是否戒酒AlcoholTypeDiv
	var all_AlcoholType=$('#AlcoholTypeDiv span.option');//饮酒种类 
	var all_IsOe=$('#IsOeDiv span.option');//是否职业暴露
	//var all_IsProtection=$('#IsProtection span.option');//是否有防护措施  0 未选 1 无 2 有
	var RecordOneJson=${RecordOneJson};
	//体检ID隐藏域
	$('#exam_id').val(RecordOneJson.MtID);
	//体检日期
	var reExamDate=RecordOneJson.ExamDate
	$('input[name=rExamDate]').val(reExamDate);
	//责任医生姓名
	$('#DoctorName').text(RecordOneJson.master.DoctorName);
	$('input[name=DoctorID]').val(RecordOneJson.master.DoctorID)
	//体征回显
	
	for(var key in RecordOneJson.body){  
		//输入框回显
		$("input[name='"+key+"']").val(RecordOneJson.body[key]);
	}
	//症状回显  
	if(RecordOneJson.master.Symptom != null){
			var strs = RecordOneJson.master.Symptom.split(",");
			all_symp.each(function(i){
				var id = String(Math.pow(2, i));//计算出当前症状对应的真实ID
				if(strs.indexOf(id) > -1){//如果这个ID存在于服务器给的值，则为这个元素添加高亮
				all_symp.eq(i).toggleClass('bluecolor');
			}
		});
	}
	
	//其他症状回显
	var otherTextObject=RecordOneJson.otherText;
	$("input[name='SymptomOther']").val(otherTextObject.Symptom)
	

	//生活方式回显
	if(RecordOneJson.lifeStyle != null){
		for(var key in RecordOneJson.lifeStyle){  
			//输入框回显
			$("input[name='"+key+"']").val(RecordOneJson.lifeStyle[key])
		}
		//锻炼频率
		$('#ExerciseFrequency span').each(function(i){
			if(RecordOneJson.lifeStyle.ExerciseFrequency==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		//IsDrunkLastYearOp
		$('#IsDrunkLastYearOp span').each(function(i){
			if(RecordOneJson.lifeStyle.IsDrunkLastYear==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		//饮食习惯
		all_Diet.each(function(i){
			if(RecordOneJson.lifeStyle.Diet==i+1){
				all_Diet.eq(i).toggleClass('bluecolor');
			}
		});
		//吸烟情况
		all_SmokingStatus.each(function(i){
			if(RecordOneJson.lifeStyle.SmokingStatus==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		//饮酒频率
		all_DrinkingFrequency.each(function(i){
			if(RecordOneJson.lifeStyle.DrinkingFrequency==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		//是否戒酒
		all_Alcohol.each(function(i){
			if(RecordOneJson.lifeStyle.IsAlcohol==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		//饮酒种类
		all_AlcoholType.each(function(i){
			if(RecordOneJson.lifeStyle.AlcoholType==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		//是否职业暴露
		all_IsOe.each(function(i){
			if(RecordOneJson.lifeStyle.IsOe==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
	}
	
	//获取修改后的症状的值	
	function getBlueIds(sss){
		var blueId=0;//初始化症状的值
		sss.each(function(i){
			var id = Math.pow(2, i);
			if($(this).hasClass('bluecolor')){
				if(i==0){
					blueId=1
					return
				}else{
					blueId=blueId+id;
				}
			}
		});
		return blueId;
	}

	//毒物种类回显
	var findDataById = function(id){
		var ret = null;
		for(var i=0; i<json.length; i++){
			if("tr"+json[i].PoisonKind == id){
				ret = json[i];
			}
		}
		return ret;
	};
	if(RecordOneJson.exLifeOeList != null){
		var json = RecordOneJson.exLifeOeList;
		
		$('.row-poison').each(function(i){
			var that = $(this);
			var id = that.attr('id');
			var name = that.find('input[name=PoisonName]');
			var text = that.find('input[name=ProtectionMeasures]');
			var data = findDataById(id);
			
			if(data!=null){
				name.val(data.PoisonName);
				text.val(data.ProtectionMeasures);
				//data.IsProtection
				that.find('span').each(function(j){
					if(data.IsProtection==j+1){
						$(this).toggleClass('bluecolor');
					}
				})
			}
		});
	}

	
	//脏器功能回显
	if(RecordOneJson.organ != null){
		$('#Lips-option span').each(function(i){
			if(RecordOneJson.organ.Lips==i+1){
				$(this).toggleClass('bluecolor');
			}
		}) 
		$('#Dentition span').each(function(i){
			if(RecordOneJson.organ.Dentition==i+1){
				$(this).toggleClass('bluecolor');
			}
		}) 
		$('#Throat span').each(function(i){
			if(RecordOneJson.organ.Throat==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Hearing span').each(function(i){
			if(RecordOneJson.organ.Hearing==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#MotorFunction span').each(function(i){
			if(RecordOneJson.organ.MotorFunction==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
	}

	//查体回显 
	if(RecordOneJson.organ != null){
		$('#Fundus span').each(function(i){
			if(RecordOneJson.organ.Fundus==i+1){
				$(this).addClass('bluecolor');
			}
		})
		$('#DorsalisPedisArteryPulse span').each(function(i){
			if(RecordOneJson.body.DorsalisPedisArteryPulse==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Breast span').each(function(i){
			if(RecordOneJson.organ.Breast==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#AbdominalTenderness span').each(function(i){
			if(RecordOneJson.organ.AbdominalTenderness==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#AbdominalMass span').each(function(i){
			if(RecordOneJson.organ.AbdominalMass==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#TheAbdomenLiver span').each(function(i){
			if(RecordOneJson.organ.TheAbdomenLiver==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Splenomegaly span').each(function(i){
			if(RecordOneJson.organ.Splenomegaly==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#ShiftingDullness span').each(function(i){
			if(RecordOneJson.organ.ShiftingDullness==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Dre span').each(function(i){
			if(RecordOneJson.organ.Dre==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Rale span').each(function(i){
			if(RecordOneJson.organ.Rale==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Rhythm span').each(function(i){
			if(RecordOneJson.organ.Rhythm==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#HeartMurmur span').each(function(i){
			if(RecordOneJson.organ.HeartMurmur==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#LymphNodes span').each(function(i){
			if(RecordOneJson.organ.LymphNodes==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#BarrelChest span').each(function(i){
			if(RecordOneJson.organ.BarrelChest==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#BreathSounds span').each(function(i){
			if(RecordOneJson.organ.BreathSounds==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Skin span').each(function(i){
			if(RecordOneJson.organ.Skin==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Sclera span').each(function(i){
			if(RecordOneJson.organ.Sclera==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#LowerExtremityEdema span').each(function(i){
			if(RecordOneJson.organ.LowerExtremityEdema==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		
		for(var key in RecordOneJson.organ){
			$("input[name='"+key+"']").val((RecordOneJson.organ[key]))
		}
	}

	//妇科
	if(RecordOneJson.woman != null){
		$('#UterineAdnexa span').each(function(i){
			if(RecordOneJson.woman.UterineAdnexa==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Vulva span').each(function(i){
			if(RecordOneJson.woman.Vulva==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Vaginal span').each(function(i){
			if(RecordOneJson.woman.Vaginal==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Cervix span').each(function(i){
			if(RecordOneJson.woman.Cervix==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Palace span').each(function(i){
			if(RecordOneJson.woman.Palace==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#womenOther').val(RecordOneJson.woman.Other);
		
		for(var key in RecordOneJson.woman){
			$("input[name='"+key+"']").val((RecordOneJson.woman[key]))
		}
		
		$('input[name=Other]').val((RecordOneJson.woman.Other))
	}
	
	//辅助检查
	if(RecordOneJson.labora != null){
		for(var key in RecordOneJson.labora){  
			$("option[name='"+key+"']").val(RecordOneJson.labora[key])
			$("input[name='"+key+"']").val(RecordOneJson.labora[key])
		};
		$('#CervicalSmear span').each(function(i){
			if(RecordOneJson.labora.CervicalSmear==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#BUltrasonicWave span').each(function(i){
			if(RecordOneJson.labora.BUltrasonicWave==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#ChestXRay span').each(function(i){
			if(RecordOneJson.labora.ChestXRay==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#Ecg span').each(function(i){
			if(RecordOneJson.labora.Ecg==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#HepatitisBSurfaceAntigen span').each(function(i){
			if(RecordOneJson.labora.HepatitisBSurfaceAntigen==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#FecalOccultBlood span').each(function(i){
			if(RecordOneJson.labora.FecalOccultBlood==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		//心电图、x光、B超、宫颈涂片异常原因回显
		$('#EcgReason').val(RecordOneJson.labora.EcgReason);
		$('#ChestXRayReason').val(RecordOneJson.labora.ChestXRayReason);
		$('#BUltrasonicWaveReason').val(RecordOneJson.labora.BUltrasonicWaveReason);
		$('#CervicalSmearReason').val(RecordOneJson.labora.CervicalSmearReason);
	}
   //体检中医体质辨识
   if(RecordOneJson.chsCon != null){
	   $('#ModerateQuality span').each(function(i){
		   if(RecordOneJson.chsCon.ModerateQuality==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#QualityDeficiency span').each(function(i){
		   if(RecordOneJson.chsCon.QualityDeficiency==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#YangQuality span').each(function(i){
		   if(RecordOneJson.chsCon.YangQuality==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#YinQuality span').each(function(i){
		   if(RecordOneJson.chsCon.YinQuality==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#Phlegm span').each(function(i){
		   if(RecordOneJson.chsCon.Phlegm==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#DampHeat span').each(function(i){
		   if(RecordOneJson.chsCon.DampHeat==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#BloodQuality span').each(function(i){
		   if(RecordOneJson.chsCon.BloodQuality==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	   $('#QiQuality span').each(function(i){
		   if(RecordOneJson.chsCon.QiQuality==i+1){
			   $(this).eq(i).toggleClass('bluecolor');
		   }
	   })
	   $('#TeBingQuality span').each(function(i){
		   if(RecordOneJson.chsCon.TeBingQuality==i+1){
			   $(this).toggleClass('bluecolor');
		   }
	   })
	}
   
	//现存主要健康问题
	if(RecordOneJson.problems != null){
		$('#Cerebrovascular span').each(function(i){
			if(RecordOneJson.problems.Cerebrovascular==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Kidney span').each(function(i){
			if(RecordOneJson.problems.Kidney==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Heart span').each(function(i){
			if(RecordOneJson.problems.Heart==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Vascular span').each(function(i){
			if(RecordOneJson.problems.Vascular==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Eyes span').each(function(i){
			if(RecordOneJson.problems.Eyes==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Nervoussystems span').each(function(i){
			if(RecordOneJson.problems.Nervoussystems==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
		$('#Others span').each(function(i){
			if(RecordOneJson.problems.Others==i+1){
				$(this).toggleClass('bluecolor');
			}
		})
	}
    
	//主要用药 情况	 drugUseList 
	var durg_tr=$('.drug_situation_tr').eq(0);
	$.each(RecordOneJson.drugUseList,function(i){
		if(i == 0){
			$('.MedicationCompliance span').each(function(j){
				if(RecordOneJson.drugUseList[0].MedicationCompliance==j+1){
					$(this).toggleClass('bluecolor');
				}
			});
			for(var key in RecordOneJson.drugUseList[0]){
				$('.drug_situation_tr input[name="'+key+'"]').val(RecordOneJson.drugUseList[0][key])
			}
			var selectCount = $('.MedicationUnit').eq(0).find('option');  
			
			for(var i = 0 ; i<selectCount.length;i++){  
				if(selectCount[i].value==RecordOneJson.drugUseList[0].MedicationUnit){  
				        selectCount[i].selected=true;  
				}  
			}
		}else{
			var rowspan1=parseInt($('.drug_situation').attr("rowspan"));
			$('.drug_situation').attr("rowspan",rowspan1+1);
			//克隆自己添加在后面；
			var add_tr='	<tr  class="drug_situation_tr">'+
			'					<td><input type="text" name="DrugName" id="" value="'+RecordOneJson.drugUseList[i].DrugName+'" class="borderb"/></td>'+
			'					<td><input type="text" name="Usage" id="" value="'+RecordOneJson.drugUseList[i].Usage+'" class="borderb"/></td>'+
			'					<td><input type="text" name="Amount" id="" value="'+RecordOneJson.drugUseList[i].Amount+'" class="borderb"/></td>'+
			'					<td>'+
			'						<input type="text" name="MedicationTime" id="" value="'+RecordOneJson.drugUseList[i].MedicationTime+'" class="borderb w40"/>'+
			'						<select name="MedicationUnit" class="MedicationUnit">'+
			'							<option value="1">天</option>'+
			'							<option value="2">月</option>'+
			'							<option value="3">年</option>'+
			'						</select>'+
			'					</td>'+
			'					<td class="MedicationCompliance">'+
			'					    <span class="option">1规律</span>'+
			'						<span class="option">2间断</span>'+
			'						<span class="option">3不服药</span>'+
			'						<a href="javascript:void(0)" onclick="delete_drug2(this)">X</a>'+
			'					</td>'+
			'				</tr>';
			$(".drug_situation_tr").eq(-1).after(add_tr);
			//除了第一个x隐藏 其他的显示出来;
			$('.delete_drug2').show();
			$('.delete_drug2').eq(0).hide();
			
			var selectCount = $('.MedicationUnit').eq(i).find('option')
			for(var h = 0 ; h<selectCount.length;h++){  
				if(selectCount[h].value==RecordOneJson.drugUseList[i].MedicationUnit){  
					selectCount[h].selected=true;  
				}  
			} 
			var spanCount=$('.MedicationCompliance').eq(i).find('span')
			 
			for(var m = 0 ; m<spanCount.length;m++){  
				if(RecordOneJson.drugUseList[i].MedicationCompliance==m+1){
					$(spanCount[m]).addClass('bluecolor');
				}
			}
		}
	})
   
   
	//非免疫 规划预防接种史
	var vaccList_s=RecordOneJson.vaccList;
	$.each(vaccList_s,function(i){
	
		if(i==0){
			for(var key in vaccList_s[0]){
				$("#vaccList input[name='"+ key +"']").val(vaccList_s[0][key]);
			}
		}else{
			var rowspan1=parseInt($('.inoculation').attr("rowspan"));
			$('.inoculation').attr("rowspan",rowspan1+1);
			//克隆自己添加在后面；
			var ino_tr='<tr id="vaccList" class="inoculation_tr">'+
			'					<td><input type="text" name="VaccineName" id="" value="'+vaccList_s[i].VaccineName+'" class="borderb"/></td>'+
			'					<td><input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="VaccDate" id="" value="'+vaccList_s[i].VaccDate+'" class="borderb"/></td>'+
			'					<td colspan="3"><input type="text" name="VaccOrgName" id="" value="'+vaccList_s[i].VaccOrgName+'" class="borderb"/> <a href="javascript:void(0)" onclick="delete_inoculation(this)" >X</a></td>'+
			'				</tr>';
			$(".inoculation_tr").eq(-1).after(ino_tr)
			//除了第一个x隐藏 其他的显示出来;
			$('.delete_inoculation').show();
			$('.delete_inoculation').eq(0).hide();  
		}
	})
    
	//健康评价
	$('#Assessment span').each(function(i){
		if(RecordOneJson.master.Assessment==i+1){
			$(this).toggleClass('bluecolor');
		}
	})
	$("input[name='AssessmentAbnormal']").val(RecordOneJson.master.AssessmentAbnormal);
  

	//健康指导   
	var all_Guidance=$('#Guidance span');
	var all_RiskCrtl=$('#RiskCrtl span');
	
	if(RecordOneJson.master.Guidance != null){
		var strs = RecordOneJson.master.Guidance.split(",");
		all_Guidance.each(function(i){
			var id = String(Math.pow(2, i));//计算出当前症状对应的真实ID
			if(strs.indexOf(id) > -1){//如果这个ID存在于服务器给的值，则为这个元素添加高亮
				all_Guidance.eq(i).toggleClass('bluecolor');
			}
		});
	}
	
	if(RecordOneJson.master.RiskCrtl != null){
		var strs = RecordOneJson.master.RiskCrtl.split(",");
		all_RiskCrtl.each(function(i){
			var id = String(Math.pow(2, i));//计算出当前症状对应的真实ID
			if(strs.indexOf(id) > -1){//如果这个ID存在于服务器给的值，则为这个元素添加高亮
				all_RiskCrtl.eq(i).toggleClass('bluecolor');
			}
		});
	}
	
	for(var key in RecordOneJson.master){
		$("#RiskCrtl input[name='"+ key +"']").val(RecordOneJson.master[key]);
	}
    $('#HealthSummary').val(RecordOneJson.master.HealthSummary);
    $("input[name='HealthSummary']").val(RecordOneJson.master.HealthSummary);
    

	//筛查回显  
	if(RecordOneJson.scaleScore != null){
		$('#Health span').each(function(i){
			if(RecordOneJson.scaleScore.Health==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#LifeSkills span').each(function(i){
			if(RecordOneJson.scaleScore.LifeSkills==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#CognitiveFunction span').each(function(i){
			if(RecordOneJson.scaleScore.CognitiveFunction==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('#EmotionalState span').each(function(i){
			if(RecordOneJson.scaleScore.EmotionalState==i+1){
				$(this).toggleClass('bluecolor');
			}
		});
		$('input[name=LifeSkillsScore]').val(RecordOneJson.scaleScore.LifeSkillsScore);
		$('input[name=CognitiveFunctionScore]').val(RecordOneJson.scaleScore.CognitiveFunctionScore);
		$('input[name=EmotionalStateScore]').val(RecordOneJson.scaleScore.EmotionalStateScore);
	}
 

	//住院史、家庭病床史回显
	var hosList = RecordOneJson.hosList;
    if(hosList != null && hosList.length > 0){
    	var hospHtml = '';
    	var bedHtml = '';
    	var hospNum = 0;
    	var bedNum = 0;
    	
		for(var i = 0; i < hosList.length; i++){
			var innerHtml = '<td><input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="InDate" value="' + hosList[i].InDate + '" class="borderb"/>/'
				+ '<input type="date" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" name="OutDate" value="' + hosList[i].OutDate + '" class="borderb"/></td>'
				+ '<td><input type="text" name="Reason" value="' + hosList[i].Reason + '" class="borderb"/></td>'
				+ '<td><input type="text" name="OrgName" value="' + hosList[i].OrgName + '" class="borderb"/></td>'
			//住院史
    		if(hosList[i].HistoryType == 1){
    			hospHtml += '<tr class="add_drugTr">' + innerHtml + '<td><input type="text" name="MedicalRecordNumber" value="' + hosList[i].MedicalRecordNumber + '" class="borderb"/> <a href="javascript:void(0)" onclick="delete_drug(this);">X</a></td></tr>';
    			hospNum++;
    		}else if(hosList[i].HistoryType == 2){
    			//家庭病床史
    			bedHtml += '<tr class="inBed_tr">' + innerHtml + '<td><input type="text" name="MedicalRecordNumber" value="' + hosList[i].MedicalRecordNumber + '" class="borderb"/> <a href="javascript:void(0)" onclick="delete_bed(this);">X</a></td></tr>';
    			bedNum++;
    		}
    	}
		$('.inHospital_situation').attr("rowspan", 2 + hosList.length);
		if(hospNum > 0){
			$('.add_drugTr').remove();
 			$('.inHospital_history').attr("rowspan",1 + hospNum);
 			$("#hosp_title_tr").after(hospHtml);
 			//除了第一个x隐藏 其他的显示出来;
 			$('.delete_drug').show();
 			$('.delete_drug').eq(0).hide();
		}
		if(bedNum > 0){
			$('.inBed_tr').remove();
			$('.inBed').attr("rowspan",1 + bedNum);
 			$("#bed_title_tr").after(bedHtml);
 			//除了第一个x隐藏 其他的显示出来;
 			$('.delete_bed').show();
 			$('.delete_bed').eq(0).hide();
		}
		
    }
    
    //other中字段回显
    var otherInfo = RecordOneJson.otherText;
    $('[other-field]').each(function(){
    	$(this).val(otherInfo[$(this).attr('other-field')]);
	});
    
    /**
    *	---------------------------------------------表单回显结束--------------------------------------------
    */
    
	/**
	*	---------------------------------------------修改保存开始--------------------------------------------
	*/
	
	//保存按钮点击事件声明
	document.getElementById("saveButton").addEventListener('click',function(e){
		//序列化表单，封装body部分
		var Bodydate = $('#bodyForm').serializeArray();
		var Body = {}
		for(i = 0; i < Bodydate.length; i++){
			Body[Bodydate[i].name] = Bodydate[i].value;
		}
		Body['DorsalisPedisArteryPulse'] = getFieldSpanValue($('#DorsalisPedisArteryPulse span'))
		
		//生活方式封装
		var lifestyleData = $('#LifeStyleForm').serializeArray();
		var Diet = getFieldSpanValue(all_Diet);
		var SmokingStatus = getFieldSpanValue(all_SmokingStatus);
		var DrinkingFrequency = getFieldSpanValue(all_DrinkingFrequency);
		var IsAlcohol = getFieldSpanValue(all_Alcohol);
		var all_IsDrunkLastYearOp = $('#IsDrunkLastYearOp span')
		var IsDrunkLastYear = getFieldSpanValue(all_IsDrunkLastYearOp);
		var AlcoholType = getFieldSpanValue(all_AlcoholType);
		var IsOe = getFieldSpanValue(all_IsOe); 
		var LifeStyle = {};
		for(i = 0; i < lifestyleData.length; i++){
			LifeStyle[lifestyleData[i].name] = lifestyleData[i].value;
		}
		
		LifeStyle['Diet']=Diet;
		LifeStyle['SmokingStatus']=SmokingStatus;
		LifeStyle['DrinkingFrequency']=DrinkingFrequency;
		LifeStyle['IsAlcohol']=IsAlcohol;
		LifeStyle['IsDrunkLastYear']=IsDrunkLastYear;
		LifeStyle['AlcoholType']=AlcoholType;
		LifeStyle['IsOe']=IsOe;
		LifeStyle['Occupation']=$('#Occupation').val();
		LifeStyle['WorkingTime']=$('#WorkingTime').val();
		LifeStyle['ExerciseFrequency']=getFieldSpanValue($('#ExerciseFrequency span'));

		//职业病危害 封装
		var OePostion =[];
		$('.row-poison').each(function(i){
			var that = $(this);
			var name = that.find('input[name=PoisonName]');
			var text = that.find('input[name=ProtectionMeasures]');
			var s=that.find('span');
			var data={
				PoisonName:name.val(),
				ProtectionMeasures:text.val(),
				PoisonKind:i,
				IsProtection:getFieldSpanValue(s)
			};
			OePostion.push(data)
		});
		
		//脏器功能封装  Organ  todo 字符分割处理 other
		var all_Lips=$('#Lips-option span.option')
		var all_Dentition=$('#Dentition span.option')
		var all_Throat=$('#Throat span.option')
		var all_Hearing=$('#Hearing span.option')
		var all_Fundus=$('#Fundus span.option')
		var all_Skin=$('#Skin span.option')
		var all_Sclera=$('#Sclera span.option')
		var all_LymphNodes=$('#LymphNodes span.option')
		var all_BarrelChest=$('#BarrelChest span.option')
		var all_BreathSounds=$('#BreathSounds span.option')
		var Lips=getFieldSpanValue(all_Lips)
		var Dentition=getFieldSpanValue(all_Dentition)
		var Throat=getFieldSpanValue(all_Throat)
		var Hearing=getFieldSpanValue(all_Hearing)
		var Fundus=getFieldSpanValue(all_Fundus)
		var Skin=getFieldSpanValue(all_Skin)
		var Sclera=getFieldSpanValue(all_Sclera)
		var LymphNodes=getFieldSpanValue(all_LymphNodes)
		var BarrelChest=getFieldSpanValue(all_BarrelChest)
		var BreathSounds=getFieldSpanValue(all_BreathSounds)

		var all_Rale=$('#Rale span.option')
		var all_Rhythm=$('#Rhythm span.option')
		var all_HeartMurmur=$('#HeartMurmur span.option')
		var all_AbdominalTenderness=$('#AbdominalTenderness span.option')
		var all_AbdominalMass=$('#AbdominalMass span.option')
		var all_TheAbdomenLiver=$('#TheAbdomenLiver span.option')
		var all_ShiftingDullness=$('#ShiftingDullness span.option')
		var all_LowerExtremityEdema=$('#LowerExtremityEdema span.option')
		var all_Dre=$('#Dre span.option')
		var all_Breast=$('#Breast span.option')
		var Rale=getFieldSpanValue(all_Rale)
		var Rhythm=getFieldSpanValue(all_Rhythm)
		var HeartMurmur=getFieldSpanValue(all_HeartMurmur)
		var AbdominalTenderness=getFieldSpanValue(all_AbdominalTenderness)
		var AbdominalMass=getFieldSpanValue(all_AbdominalMass)
		var TheAbdomenLiver=getFieldSpanValue(all_TheAbdomenLiver)
		var ShiftingDullness=getFieldSpanValue(all_ShiftingDullness)
		var LowerExtremityEdema=getFieldSpanValue(all_LowerExtremityEdema)
		var Dre=getFieldSpanValue(all_Dre)
		var Breast=getFieldSpanValue(all_Breast)

		var Organ= {};
		Organ['LeftEye'] = $("input[name='LeftEye']").val();
		Organ['RightEye'] = $("input[name='RightEye']").val();
		Organ['LeftEyeVc'] = $("input[name='LeftEyeVc']").val();
		Organ['RightEyeVc'] = $("input[name='RightEyeVc']").val();
		
		Organ['Lips']=Lips;
		Organ['Dentition']=Dentition;
		Organ['Throat']=Throat;
		Organ['Hearing']=Hearing;
		Organ['Fundus']=Fundus+"|"+$('#FundusReason').val();
		Organ['Skin']=Skin;
		Organ['Sclera']=Sclera;
		Organ['LymphNodes']=LymphNodes;
		Organ['BarrelChest']=BarrelChest;
		Organ['BreathSounds']=BreathSounds+"|"+$('#BreathSoundsReason').val();
		Organ['Rale']=Rale;
		Organ['Rhythm']=Rhythm;
		Organ['HeartMurmur']=HeartMurmur+"|"+$('#HeartMurmurReason').val();
		Organ['AbdominalTenderness']=AbdominalTenderness+"|"+$('#AbdominalTendernessReason').val();
		Organ['AbdominalMass']=AbdominalMass+"|"+$('#AbdominalMassReason').val();
		Organ['TheAbdomenLiver']=TheAbdomenLiver+"|"+$('#TheAbdomenLiverReason').val();
		Organ['ShiftingDullness']=ShiftingDullness+"|"+$('#ShiftingDullnessReason').val();
		Organ['LowerExtremityEdema']=LowerExtremityEdema;
		Organ['Splenomegaly']=getFieldSpanValue($('#Splenomegaly span.option'))+"|"+$('#SplenomegalyReason').val()
		Organ['Dre']=Dre;
		Organ['Breast']=Breast; 
		Organ['MotorFunction']=getFieldSpanValue($('#MotorFunction span'))

		//妇女 检查 封装
		var Woman={}
		var Vaginal=getFieldSpanValue($('#Vaginal span.option'))+"|"+$('#VaginalReason').val()
		var UterineAdnexa=getFieldSpanValue($('#UterineAdnexa span.option'))+"|"+$('#UterineAdnexaReason').val()
		var Vulva=getFieldSpanValue($('#Vulva span.option'))+"|"+$('#VulvaReason').val()
		var Cervix=getFieldSpanValue($('#Cervix span.option'))+"|"+$('#CervixReason').val()
		var Palace=getFieldSpanValue($('#Palace span.option'))+"|"+$('#PalaceReason').val()
		Woman['Vaginal']=Vaginal;
		Woman['UterineAdnexa']=UterineAdnexa;
		Woman['Vulva']=Vulva;
		Woman['Cervix']=Cervix;
		Woman['Palace']=Palace;
		Woman['Other'] = $('#womenOther').val();

		//辅助检查 Labor
		var LaborDate=$('#Labor').serializeArray();
		var Labor= {};
		for(i=0;i<LaborDate.length;i++){
			Labor[LaborDate[i].name] = LaborDate[i].value;
		}
		var FecalOccultBlood=getFieldSpanValue($('#FecalOccultBlood span.option'))
		var Ecg =getFieldSpanValue($('#Ecg span.option'))+"|"+$('#EcgReason').val()
		var ChestXRay =getFieldSpanValue($('#ChestXRay span.option'))+"|"+$('#ChestXRayReason').val()
		var BUltrasonicWave =getFieldSpanValue($('#BUltrasonicWave span.option'))+"|"+$('#BUltrasonicWaveReason').val()
		var CervicalSmear =getFieldSpanValue($('#CervicalSmear span.option'))+"|"+$('#CervicalSmearReason').val()
		Labor['FecalOccultBlood']=FecalOccultBlood;
		Labor['HepatitisBSurfaceAntigen']=getFieldSpanValue($('#HepatitisBSurfaceAntigen span.option'));
		Labor['ChestXRay']=ChestXRay;
		Labor['BUltrasonicWave']=BUltrasonicWave;
		Labor['CervicalSmear']=CervicalSmear;
		Labor['Ecg']=Ecg;

		//中医体质封装  ChsCons
		var ChsCons={}
		var ModerateQuality=getFieldSpanValue($('#ModerateQuality span.option'))
		var QualityDeficiency=getFieldSpanValue($('#QualityDeficiency span.option'))
		var YangQuality=getFieldSpanValue($('#YangQuality span.option'))
		var YinQuality=getFieldSpanValue($('#YinQuality span.option'))
		var Phlegm=getFieldSpanValue($('#Phlegm span.option'))
		var DampHeat=getFieldSpanValue($('#DampHeat span.option'))
		var QiQuality=getFieldSpanValue($('#QiQuality span.option'))
		var TeBingQuality=getFieldSpanValue($('#TeBingQuality span.option'))
		ChsCons['ModerateQuality']=ModerateQuality;
		ChsCons['QualityDeficiency']=QualityDeficiency;
		ChsCons['YangQuality']=YangQuality;
		ChsCons['YinQuality']=YinQuality;
		ChsCons['Phlegm']=Phlegm;
		ChsCons['DampHeat']=DampHeat;
		ChsCons['QiQuality']=QiQuality;
		ChsCons['TeBingQuality']=TeBingQuality;


		//现存主要健康问题 封装
		var Problems={}
		var Heart=getFieldSpanValue($('#Heart span.option'))
		var Others=getFieldSpanValue($('#Others span.option'))
		var Nervoussystems=getFieldSpanValue($('#Nervoussystems span.option'))
		var Kidney=getFieldSpanValue($('#Kidney span.option'))
		var Cerebrovascular=getFieldSpanValue($('#Cerebrovascular span.option'))
		var Vascular=getFieldSpanValue($('#Vascular span.option'))
		var Eyes=getFieldSpanValue($('#Eyes span.option'))
		
		Problems['Heart']=Heart;
		Problems['Others']=Others;
		Problems['Nervoussystems']=Nervoussystems;
		Problems['Kidney']=Kidney;
		Problems['Cerebrovascular']=Cerebrovascular;
		Problems['Vascular']=Vascular;
		Problems['Eyes']=Eyes; 

		//Hospt 住院治疗情况封装
		var Hospt=[]
		$('.add_drugTr').each(function(i){
			var that = $(this);
			var nameInDate = that.find('input[name=InDate]');
			var nameOutDate = that.find('input[name=OutDate]');
			if($(nameInDate).val() != null && $(nameInDate).val() != '' && $(nameOutDate).val() != null && $(nameOutDate).val() != ''){
				var nameReason = that.find('input[name=Reason]');
				var nameOrgName = that.find('input[name=OrgName]');
				var nameMedicalRecord = that.find('input[name=MedicalRecordNumber]');
				var datas={
					HistoryType:1,
					InDate:$(nameInDate).val(),
					OutDate:$(nameOutDate).val(),
					OrgName:$(nameOrgName).val(),
					Reason:$(nameReason).val(),
					MedicalRecordNumber:$(nameMedicalRecord).val()
				};
				Hospt.push(datas)
			}
		});
		
		//家庭病床史封装
		$('.inBed_tr').each(function(i){
			var that = $(this);
			var nameInDate = that.find('input[name=InDate]');
			var nameOutDate = that.find('input[name=OutDate]');
			if($(nameInDate).val() != null && $(nameInDate).val() != '' && $(nameOutDate).val() != null && $(nameOutDate).val() != ''){
				var nameReason = that.find('input[name=Reason]');
				var nameOrgName = that.find('input[name=OrgName]');
				var nameMedicalRecord = that.find('input[name=MedicalRecordNumber]');
				var datai={
					HistoryType:2,
					InDate:$(nameInDate).val(),
					OutDate:$(nameOutDate).val(),
					OrgName:$(nameOrgName).val(),
					Reason:$(nameReason).val(),
					MedicalRecordNumber:$(nameMedicalRecord).val()
				};
				Hospt.push(datai)
			}
		}); 
		
		//主要用药 情况封装    todo span的值
		var Drug = [];
		var DrugName_item = $("input[name='DrugName']");
		var Usage_item = $("input[name='Usage']");
		var Amount_item = $("input[name='Amount']");
		var MedicationTime_item = $("input[name='MedicationTime']");
		var MedicationUnit_item = $("select[name='MedicationUnit']");
		
		for(var i=0; i<DrugName_item.length; i++){
			if($(DrugName_item[i]).val() != null && $(DrugName_item[i]).val() != ''){
				var data = {
						DrugName:$(DrugName_item[i]).val(),
						Usage:$(Usage_item[i]).val(),
						Amount :$(Amount_item[i]).val(),
						MedicationTime:$(MedicationTime_item[i]).val(),
						MedicationUnit:$(MedicationUnit_item[i]).val(),
						MedicationCompliance : getFieldSpanValue($('.MedicationCompliance').eq(i).children())
					}
					Drug.push(data);
			}
		}
    	
		//非免疫 规划预防接种史 封装 Vacc
    	var Vacc = [];
    	var VaccineName_item = $("input[name='VaccineName']");
    	var VaccDate_item = $("input[name='VaccDate']");
    	var VaccOrgName_item = $("input[name='VaccOrgName']");
    	
    	for(var i=0; i<VaccineName_item.length; i++){
    		if($(VaccineName_item[i]).val() != null && $(VaccineName_item[i]).val() != ''){
    			var data = {
        				VaccineName:$(VaccineName_item[i]).val(),
        				VaccDate:$(VaccDate_item[i]).val(),
        				VaccOrgName :$(VaccOrgName_item[i]).val(),
        				
        		}
        		Vacc.push(data);
    		}
    	}
    	
		//筛查得分回显和封装
		var ScaleScore ={};
   
  
		ScaleScore['LifeSkillsScore']=$('input[name=LifeSkillsScore]').val();
		ScaleScore['CognitiveFunctionScore']=$('input[name=CognitiveFunctionScore]').val();
		ScaleScore['EmotionalStateScore']=$('input[name=EmotionalStateScore]').val();
		
		ScaleScore['Health']=getFieldSpanValue($('#LifeSkills span'));
		ScaleScore['LifeSkills']=getFieldSpanValue($('#LifeSkills span'));
		ScaleScore['CognitiveFunction']=getFieldSpanValue($('#CognitiveFunction span'));
		ScaleScore['EmotionalState']=getFieldSpanValue($('#EmotionalState span'));
 
		//健康评价 封装  master里   "IsStandard": false
		var Master={}
		var Assessment=getFieldSpanValue($('#Assessment span'));
		var AssessmentAbnormal=$('input[name=AssessmentAbnormal]').val();
		Master['Assessment']=Assessment;
		Master['AssessmentAbnormal']=AssessmentAbnormal;
		
		//主表内容封装
		var Symptom=getBlueIds(all_symp);
		var Guidance=getBlueIds(all_Guidance);
		var RiskCrtl=getBlueIds(all_RiskCrtl);
		var RiskCrtlWeight=$('input[name=RiskCrtlWeight]').val();
		var RiskCrtlVaccine=$('input[name=RiskCrtlVaccine]').val();
		var HealthSummary=$('#HealthSummary').val();
		var RiskCrtlOther=$('input[name=RiskCrtlOther]').val();
		
		Master['Symptom']=Symptom;
		Master['Guidance']=Guidance;
		Master['RiskCrtl']=RiskCrtl;
		Master['RiskCrtlWeight']=RiskCrtlWeight;
		Master['RiskCrtlVaccine']=RiskCrtlVaccine;
		Master['HealthSummary']=HealthSummary;
		Master['RiskCrtlOther']=RiskCrtlOther;
		Master['IsStandard']=false;
		Master['UserID']='${sessionScope.doctorInfo.id}';
		
		var DoctorID=$('input[name=DoctorID]').val();
		var DoctorName=$('#DoctorName').text();
		var UserID;
		var UserName;
		
		var ExamDate=$('input[name=rExamDate]').val();
		
		Master['DoctorID']=DoctorID;
		Master['DoctorName']=DoctorName;
		Master['PersonID']=PersonIDStr;
		Master['ExamDate']=ExamDate;
  
		//封装Other部分
		var otherList = [];
		$('[other-field]').each(function(){
			if($(this).val() != null && $(this).val() != ''){
				var otherItem = {
						AttrName : $(this).attr('other-field'),
						OtherText : $(this).val()
				}
				otherList.push(otherItem);
			}
		});
  
		//将所有信息封装为统一json
		var saveParam = {};
	    saveParam.MtID = $('#exam_id').val();
		saveParam.ProductCode = "${ProductCode}";
		saveParam.Master = Master;
		saveParam.LifeStyle = LifeStyle;
		saveParam.Labor = Labor;
		saveParam.Body = Body;
		saveParam.Drug = Drug;
		saveParam.Organ = Organ;
		saveParam.Vacc = Vacc;
		saveParam.OrgID = '${sessionScope.doctorInfo.orgId}';
		saveParam.DataSouceCode = "01";//todo
		saveParam.ScaleScore =ScaleScore
		
		saveParam.Problems = Problems;
		
		saveParam.ChsCons = ChsCons;
		saveParam.Hospt = Hospt;
		saveParam.OePostion = OePostion;
		saveParam.Woman = Woman;
	
		saveParam.Other = otherList;
	
		layer.msg('是否保存？B超,心电图,尿常规,血常规等输入提示信息是体检完善度重要标志,请确认后再保存', {
			icon: 3,
			time: 0, //不自动关闭,
			btn: ['是', '否'],
			yes: function(index){
				layer.close(index);
				layer.load(1);
				$.ajax({
				    type: 'POST',
				    url: '/FWS/examination/saveExamination' ,
				    data: {
				    	dataJson : JSON.stringify(saveParam),
				    	doctorName:"${doctorName}"
				    } ,
				    success: function(data){
				    	layer.closeAll('loading');
				    	if(data.code == '200'){
				    		layer.msg('保存成功！', {
								icon: 1
							});
				    	}else{
				    		layer.msg('保存失败！', {
								icon: 2
							});
				    	}
				    },
				    error: function(){
				    	layer.closeAll('loading');
				    	layer.msg('保存失败！', {
							icon: 2
						});
				    }
				});
			}
		});
	});
    /**
    *	-----------------------------------------------保存方法结束-------------------------------------------
    */

</script>
<script type="text/javascript" src="/FWS/statics/js/examination/promptMsg.js"></script>
</html>
