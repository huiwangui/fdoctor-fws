<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html style="height:100%;">
	<head>
		<meta charset="UTF-8">
		<title>居民档案</title>
		<link rel="stylesheet" type="text/css" href="/FWS/statics/css/main.css">
		<script type="text/javascript" src="/FWS/statics/js/jquery-2.1.4.min.js"></script>	
		<link rel="stylesheet" href="/FWS/statics/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="/FWS/statics/layui/css/modules/layer/default/layer.css" media="all" />
        <script type="text/javascript" src="/FWS/statics/layui/layui.js"></script>
		<script type="text/javascript" src="/FWS/statics/layer/layer.js"></script>
		<script type="text/javascript" src="/FWS/statics/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="/FWS/statics/js/My97DatePicker/lang/zh-cn.js"></script>
		 
	</head>
	<body style="height:100%;">
		<div class="main" style="height:100%;">
			<div class="Edit_navbar ">
				<ul>
					<li>
						<a href="javascript:void(0)" class="active_li"> 基本信息 </a>
					</li>
					<li>
						<a href="javascript:void(0)">高血压随访 </a>
					</li>
					 <li>
						<a href="javascript:void(0)">糖尿病随访 </a>
					</li>
					<li>
						<a href="javascript:void(0)">体检  </a>
					</li> 
					<li>
						<a href="javascript:void(0)">报告  </a>
					</li> 
					
				</ul>
			</div>
			
			<!------------------------------------基本信息---------------------------->
			<div class="content_div" hidden="">
				<h1 style="font-size:18px;">基本信息</h1>
				<div class="clearfix">
					<div class="fl">
						姓名：<span id="tab2_name">${data.Name }</span>
					</div>
					<div class="fr">个人编号：<span>${data.PersonCode }</span></div>
				</div>
				<table border="1">
					<tr>
						<td>性别</td>
						<td colspan="3" id="GenderCodeTd">					 
							<a onClick="Gendering(this)" value="0" class="option">0  未知的性别    </a>
							<a onClick="Gendering(this)" value="1" class="option">1  男性    </a> 
							<a onClick="Gendering(this)" value="2" class="option">2  女性 </a> 
							<a onClick="Gendering(this)" value="9" class="option">9  未说明的性别 </a> 
							<span class="fr"><input type="number" name="GenderCode" id="GenderCode" value="${data.GenderCode }"  disabled="disabled" class="w20"/> </span>
						</td>
						<td>出生日期</td>
						<td>
							<input type="date" name="BirthDay" id="BirthDay" value="${BirthDay }" disabled="disabled" class="borderb"/>
						</td>
					</tr>
					<tr>
						<td>身份证号</td>
						<td colspan="3"><input type="text" name="CardID" id="tab_CardID" value="${data.CardID  }" disabled="disabled" class="borderb"/></td>
						<td>工作单位</td>
						<td colspan="3"><input type="text" name="WorkOrgName" id="WorkOrgName" value="${data.WorkOrgName }"   disabled="disabled" class="borderb"/></td>
					</tr>
					<tr>
						<td>本人电话</td>
						<td>
							<input type="text" name="PersonTel" id="PersonTel" value="${data.PersonTel }" disabled="disabled"  class="borderb"/>手机或固话
						</td>
						<td>联系人姓名</td>
						<td><input type="text" name="ContactPerson" id="ContactPerson" value="${data.ContactPerson }"  disabled="disabled"  class="borderb"/></td>
						<td>联系人电话</td>
						<td>
							<input type="text" name="ContactTel" id="ContactTel" value="${data.ContactTel }"  disabled="disabled" class="borderb"/> 手机或固话
						</td>
					</tr>
					<tr>
						<td>常住类型</td>
						<td colspan="3">
						  <c:choose>
						     <c:when test="${data.HukouInd eq 1 }">
						       <a onClick="HukouInding(this)" value="1" class="option bluecolor"  >1 户籍       </a>
							   <a onClick="HukouInding(this)" value="2" class="option">2 非户籍    </a> 
							   <span class="fr"><input type="number" name="HukouInd" id="HukouInd" value="${data.HukouInd }"  disabled="disabled"  class="w20"/> </span>
						     </c:when>
						      <c:when test="${data.HukouInd eq 2 }">
						       <a onClick="HukouInding(this)" value="1" class="option">1 户籍       </a>
							   <a onClick="HukouInding(this)" value="2" class="option bluecolor">2 非户籍    </a> 
						       <span class="fr"><input type="number" name="HukouInd" id="HukouInd" value="${data.HukouInd }"   disabled="disabled" class="w20"/> </span>
						     </c:when>
						     <c:otherwise>
					        	<a onClick="HukouInding(this)" value="1" class="option">1 户籍       </a>
								<a onClick="HukouInding(this)" value="2" class="option">2 非户籍    </a> 
								<span class="fr"><input type="number" name="HukouInd" id="HukouInd" value="${data.HukouInd }"  disabled="disabled"  class="w20"/> </span>
						     </c:otherwise>
						  </c:choose>
						
						</td>
						<td>民族</td>
						<td>
					 
							  <select name="NationCode" id="NationCode">
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
								<option title="其他 " value="99">其他 </option>
								 
							</select>  
						</td>
					</tr>
					<tr>
						<td>血型</td>
						<td colspan="5">	
						 <span id="BloodTypeTd">
						 	<a value="1" onClick="BloodTypeing(this)" class="option">1 A型  </a>
							<a value="2" onClick="BloodTypeing(this)" class="option">2 B型  </a>
							<a value="3" onClick="BloodTypeing(this)" class="option">3 O型  </a>
							<a value="4" onClick="BloodTypeing(this)" class="option">4 AB型  </a>
							<a value="5" onClick="BloodTypeing(this)" class="option">5 不详  </a>
						 </span>				 
							/RH阴性：	
							<span id="RhBloodTd">
								<a value="1" onClick="RhBlooding(this)" class="option">1 否  </a>
								<a value="2" onClick="RhBlooding(this)" class="option">2 是  </a>
								<a value="3" onClick="RhBlooding(this)" class="option">3 不详  </a>
							</span>					 
							<span class="fr"> <input type="number" name="BloodType" id="BloodType" value="${data.BloodType}"  disabled="disabled" class="w20"/>/<input type="number" name="RhBlood" id="RhBlood" value="${data.RhBlood }" disabled="disabled" class="w20"/></span>
						</td>
					</tr>
					<tr>
						<td>文化程度</td>
						<td colspan="5" id="EducationCodeTd">
							<a value="1" onClick="EducationCodeing(this)" class="option">1 文盲或半文盲  </a>
							<a value="2" onClick="EducationCodeing(this)" class="option">2 小学  </a>
							<a value="3" onClick="EducationCodeing(this)" class="option">3 初中  </a>
							<a value="4" onClick="EducationCodeing(this)" class="option">4 高中/技校/中专  </a>
							<a value="5" onClick="EducationCodeing(this)" class="option">5 大学专科及以上  </a>
							<a value="6" onClick="EducationCodeing(this)" class="option">6 不详  </a>
							<span class="fr"> <input type="number" name="EducationCode" id="EducationCode" value="${data.EducationCode}"  disabled="disabled" class="w20"/></span>
						</td>
					</tr>
					<tr>
						<td>职业</td>
						<td colspan="5" id="JobCodeTd">						 
							<a value="1" onClick="JobCodeing(this)" class="option">1 国家机关、党群组织、企业、事业单位负责人     </a>
							<a value="2" onClick="JobCodeing(this)" class="option">2 专业技术人员     </a>
							<a value="3" onClick="JobCodeing(this)" class="option">3 办事人员和有关人员     </a>
							<a value="4" onClick="JobCodeing(this)" class="option">4 商业、服务业人员     </a>
							<a value="5" onClick="JobCodeing(this)" class="option">5 农、林、牧、渔、水利业生产人员     </a>
							<a value="6" onClick="JobCodeing(this)" class="option">6 生产、运输设备操作人员及有关人员      </a>
							<a value="7" onClick="JobCodeing(this)" class="option">7 军人     </a>
							<a value="8" onClick="JobCodeing(this)" class="option">8 不便分类的其他从业人员  </a>
							<select id="JobOther" name="JobOther"> <!-- 这里还有待处理 -->
								<option value="学龄前">学龄前</option>
								<option value="学生">学生</option>
								<option value="农民">农民</option>
							</select>
							<span class="fr">  <input type="text" name="JobCode" id="JobCode" value="${data.JobCode}"  disabled="disabled" class="w20"/></span>
						</td>
					</tr>
					<tr>
						<td>婚姻状况</td>
						<td colspan="5" id="MarryStatusTd">					
							<a value="1" onClick="MarryStatusing(this)" class="option">1 未婚     </a>
							<a value="2" onClick="MarryStatusing(this)" class="option">2 已婚     </a>
							<a value="3" onClick="MarryStatusing(this)" class="option">3 丧偶     </a>
							<a value="4" onClick="MarryStatusing(this)" class="option">4 离婚     </a>
							<a value="5" onClick="MarryStatusing(this)" class="option">5 未说明的婚姻情况     </a>
							<span class="fr"> <input type="number" name="MarryStatus" id="MarryStatus" value="${data.MarryStatus}"  disabled="disabled" class="w20"/></span>
						</td>
					</tr>
					<tr>
						<td>医疗费用支付方式</td>
						<td colspan="5" id="PaymentWayTd">
							<a  href="javascript:void(0)" id="1" value="1" class="optionMore">1 城镇职工基本医疗保险   </a>      
							<a  href="javascript:void(0)" id="2" value="2" class="optionMore">2 城镇居民基本医疗保险   </a>
							<a  href="javascript:void(0)" id="3" value="4" class="optionMore">3 新型农村合作医疗   </a>
							<a   href="javascript:void(0)" id="4" value="8" class="optionMore">4 贫困救助    </a>
							<a   href="javascript:void(0)" id="5" value="16" class="optionMore">5 商业医疗保险   </a>
							<a   href="javascript:void(0)" id="6" value="32" class="optionMore">6 全公费   </a>
							<a   href="javascript:void(0)" id="7" value="64" class="Noption">7 全自费   </a>
							<a   href="javascript:void(0)" id="8" value="128" class="optionMore">8 其他  </a>
							<input type="text" name="OtherPaymentWaystring" id="OtherPaymentWaystring" value="${data.OtherPaymentWaystring }" disabled="disabled"  class="borderb"/></span>
							 <input type="hidden" name="Payment" id="PaymentWayAll" value="" class="w20"/>
						</td>
					</tr>
					<tr>
						<td>药物过敏</td>
						<td colspan="5" id="DrugAllergyHistoryingTd">
							<a value="1" id="1"  class="Noption">1 无    </a>
							<a value="2" id="2"  class="optionMore">2 青霉素     </a>
							<a value="4" id="3"  class="optionMore">3 磺胺     </a>
							<a value="8" id="4"  class="optionMore">4 链霉素     </a>
							<a value="16" id="5"  class="optionMore">5 其他    </a>
							<input type="text" name="OtherDrugAllergyHistory" id="OtherDrugAllergyHistory" value="${data.OtherDrugAllergyHistory }"  disabled="disabled" class="borderb"/>
						</td>
					</tr>
					<tr>
						<td>暴露史</td>
						<td colspan="5" id="ExposureHistoryTd">						 
						    <a value="1" id="1"   class="Noption">1 无     </a>
							<a value="2" id="2"  class="optionMore">2 化学品     </a>
							<a value="4" id="3"  class="optionMore">3 毒物     </a>
							<a value="8" id="4"  class="optionMore">4 射线    </a>
						</td>
					</tr>
					<tr>
						<td rowspan="4" class="jiwangshi">既往史</td>
						<td rowspan="">疾病</td>
						<td colspan="4" class="diseases_td" id="diseasesTd">
							<span class="Noption chosed">1 无</span>
							<span class="optionMore ">2 高血压</span>
							<span class="optionMore">3 糖尿病</span>
							<span class="optionMore">4 冠心病</span>
							<span class="optionMore">5 慢性阻塞性肺疾病</span>
							<span class="optionMore">6 恶性肿瘤</span>
							<span class="optionMore">7 脑卒中</span>
							<span class="optionMore">8 重性精神疾病</span>
							<span class="optionMore">9 结核病</span>
							<span class="optionMore">10 肝炎</span>
							<span class="optionMore">11 其它法定传染病</span>
							<span class="optionMore">12 职业病</span>
							<span class="optionMore">13 其它 </span>
						
							
							<div class="diseaseBox">
								<span class="box1">
									<span class="codeCon1 chosed">2</span>
									<span>确诊时间 <input   name="" id="highBloodPressure" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">3</span>
									<span>确诊时间 <input   name="" id="diabetes" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">4</span>
									<span>确诊时间 <input   name="" id="coronaryHeartdDisease" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">5</span>
									<span>确诊时间 <input   name="" id="chronicObstructivePulmonaryDisease" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">6</span>
									<span>确诊时间 <input   name="" id="cancer" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">7</span>
									<span>确诊时间 <input   name="" id="stroke" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">8</span>
									<span>确诊时间 <input   name="" id="severeMentalIllness" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">9</span>
									<span>确诊时间 <input   name="" id="tuberculosis" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">10</span>
									<span>确诊时间 <input   name="" id="hepatitis" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<span class="box1">
									<span class="codeCon1 chosed">11</span>
									<span>确诊时间 <input   name="" id="notifiableDisease" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								
								<span class="box1">
									<span class="codeCon1 chosed">12</span>
									<span>确诊时间 <input   name="" id="industrialDisease" value="" class="borderb" onClick="WdatePicker()"/></span>
								</span>
								<div class="box1">
									<span>其它疾病13.1</span>
									<input type="text" name="" id="DiseaseOther" value="" class="borderb"/>
									<span>确诊时间</span>
									<input  name="" id="DiseaseOtherDate" value="" class="borderb" onClick="WdatePicker()"/>
									<a href="javascript:void(0)" class="add_other_disase">+</a>
								</div>
								
								
							</div>
						</td>
					</tr>
					
					<tr>
						<td>手术</td>
						<td>
							<span class="option no_illness chosed" id="sshas1">1 无</span>
							<span class="option has_illness" id="sshas2">2 有</span>
						</td>
						<td colspan="3" id="operation" class="add_illness_td">
							<div class="add_illness" hidden="">
								名称： <input type="text" name="" id="" value="" class="borderb"/> 时间： <input  name="" id="" value="" class="borderb" onClick="WdatePicker()"/>  
								<a href="javascript:void(0)" class="add" id="addss">+</a>
							</div>
						</td>
					</tr>
					<tr>
						<td>外伤</td>
						<td>
							<span class="option no_illness chosed" id="wshas1">1 无</span>
							<span class="option has_illness" id="wshas2">2 有</span>
						</td>
						<td colspan="3" id="trauma" class="add_illness_td">
							<div class="add_illness" hidden="">
								名称： <input type="text" name="" id="" value="" class="borderb"/> 时间： <input  name="" id="" value="" class="borderb" onClick="WdatePicker()"/>  
								<a href="javascript:void(0)" class="add" >+</a>
							</div>
						</td>
					</tr>
					<tr>
						<td>输血</td>
						<td>
							<span class="option no_illness chosed" id="sxhas1">1 无</span>
							<span class="option has_illness" id="sxhas2">2 有</span>
						</td>
						<td colspan="3" id="transfusion" class="add_illness_td">
							<div class="add_illness" hidden="">
								名称： <input type="text" name="" id="" value="" class="borderb"/> 时间： <input  name="" id="" value="" class="borderb" onClick="WdatePicker()"/>  
								<a href="javascript:void(0)" class="add">+</a>
							</div>
						</td>
					</tr>
					<tr>
						<td rowspan="2">家族史</td>
						<td colspan="5" class="family_disase_td">
							<span class="option1 chosed" style="cursor: pointer;">1 父亲</span>
							
							<input type="number" name="f1" id="f1" value=""  class="w20 fn0"  disabled="disabled"/>
							<input type="number" name="f2" id="f2" value="" class="w20 fn0"  disabled="disabled"/> 
							<input type="number" name="f3" id="f3" value="" class="w20 fn0"  disabled="disabled"/> 
							<input type="number" name="f4" id="f4" value="" class="w20 fn0"  disabled="disabled"/>
							<input type="number" name="f5" id="f5" value="" class="w20 fn0"   disabled="disabled"/>
							<input type="number" name="f6" id="f6" value="" class="w20 fn0" disabled="disabled"/> 
							<input type="number" name="f7" id="f7" value="" class="w20 fn0" disabled="disabled"/> 
							<input type="number" name="f8" id="f8" value="" class="w20 fn0" disabled="disabled"/> 
							<input type="number" name="f9" id="f9" value="" class="w20 fn0" disabled="disabled"/> 
							<input type="number" name="f10" id="f10" value="" class="w20 fn0" disabled="disabled"/> 
							<input type="number" name="f11" id="f11" value="" class="w20 fn0" disabled="disabled"/> 
							<input type="number" name="f12" id="f12" value="" class="w20 fn0" disabled="disabled"/> <input type="text" name="" id="f_0" value=""  class="borderb fn0" disabled="disabled"/>
							<br>
							<span class="option2" style="cursor: pointer;">2 母亲</span>
							<input type="number" name="m1" id="m1" value=""  class="w20 fn1" disabled="disabled"/>
							<input type="number" name="m2" id="m2" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m3" id="m3" value="" class="w20 fn1" disabled="disabled"/>
							<input type="number" name="m4" id="m4" value="" class="w20 fn1" disabled="disabled"/>
							<input type="number" name="m5" id="m5" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m6" id="m6" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m7" id="m7" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m8" id="m8" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="f9" id="m9" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m10" id="m10" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m11" id="m11" value="" class="w20 fn1" disabled="disabled"/> 
							<input type="number" name="m12" id="m12" value="" class="w20 fn1" disabled="disabled"/> <input type="text" name="" id="f_1" value=""  class="borderb fn1" disabled="disabled"/>
							<br>
							<span class="option3" style="cursor: pointer;">3 兄弟姐妹</span>
							<input type="number" name="b1" id="b1" value=""  class="w20 fn2" disabled="disabled"/>
							<input type="number" name="b2" id="b2" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b3" id="b3" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b4" id="b4" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b5" id="b5" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b6" id="b6" value="" class="w20 fn2" disabled="disabled"/>
							<input type="number" name="b7" id="b7" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b8" id="b8" value="" class="w20 fn2" disabled="disabled"/>
							<input type="number" name="b9" id="b9" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b10" id="b10" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b11" id="b11" value="" class="w20 fn2" disabled="disabled"/> 
							<input type="number" name="b12" id="b12" value="" class="w20 fn2" disabled="disabled"/> <input type="text" name="" id="f_2" value=""  class="borderb fn2" disabled="disabled"/>
							<br>
							<span class="option4" style="cursor: pointer;">4 子女</span>
							<input type="number" name="s1" id="s1" value=""  class="w20 fn3" disabled="disabled"/>
							<input type="number" name="s2" id="s2" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s3" id="s3" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s4" id="s4" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s5" id="s5" value="" class="w20 fn3" disabled="disabled"/>
							<input type="number" name="s6" id="s6" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s7" id="s7" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s8" id="s8" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s9" id="s9" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s10" id="s10" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s11" id="s11" value="" class="w20 fn3" disabled="disabled"/> 
							<input type="number" name="s12" id="s12" value="" class="w20 fn3" disabled="disabled"/> <input type="text" name="" id="f_3" value=""  class="borderb fn3" disabled="disabled"/>
							
						</td>
					</tr>
					<tr>
						<td colspan="5" class="family_disase_conent">
							<a onClick="fillness(this)" href="javascript:void(0)" id="father1" value="1" class="Noption">1 无</a>      
							<a onClick="fillness(this)" href="javascript:void(0)" id="father2" value="2" class="optionMore" >2 高血压 </a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father3" value="4" class="optionMore">3 糖尿病</a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father4" value="8" class="optionMore">4 冠心病 </a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father5" value="16" class="optionMore">5 慢性阻塞性肺疾病 </a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father6" value="32" class="optionMore">6 恶性肿瘤 </a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father7" value="64" class="optionMore">7 脑卒中</a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father8" value="128" class="optionMore">8四肢发麻</a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father9" value="256" class="optionMore">9 结核病</a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father10" value="512" class="optionMore">10 肝炎</a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father11" value="1024" class="optionMore">11 先天畸形</a>
							<a onClick="fillness(this)" href="javascript:void(0)" id="father12" value="2048" class="optionMore">12 其它</a> 
						</td>
						<td colspan="5"  hidden  class="family_disase_conent">		 
							<a onClick="millness(this)" href="javascript:void(0)" id="mather1" value="1" class="Noption">1 无</a>      
							<a onClick="millness(this)" href="javascript:void(0)" id="mather2" value="2" class="optionMore">2 高血压 </a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather3" value="4" class="optionMore">3 糖尿病</a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather4" value="8" class="optionMore">4 冠心病 </a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather5" value="16" class="optionMore">5 慢性阻塞性肺疾病 </a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather6" value="32" class="optionMore">6 恶性肿瘤 </a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather7" value="64" class="optionMore">7 脑卒中</a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather8" value="128" class="optionMore">8四肢发麻</a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather9" value="256" class="optionMore">9 结核病</a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather10" value="512" class="optionMore">10 肝炎</a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather11" value="1024" class="optionMore">11 先天畸形</a>
							<a onClick="millness(this)" href="javascript:void(0)" id="mather12" value="2048" class="optionMore">12 其它</a> 
						</td>
						<td colspan="5" hidden   class="family_disase_conent">
						    <a onClick="billness(this)" href="javascript:void(0)" id="brather1" value="1" class="Noption">1 无</a>      
							<a onClick="billness(this)" href="javascript:void(0)" id="brather2" value="2" class="optionMore">2 高血压 </a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather3" value="4" class="optionMore">3 糖尿病</a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather4" value="8" class="optionMore">4 冠心病 </a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather5" value="16" class="optionMore">5 慢性阻塞性肺疾病 </a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather6" value="32" class="optionMore">6 恶性肿瘤 </a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather7" value="64" class="optionMore">7 脑卒中</a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather8" value="128" class="optionMore">8四肢发麻</a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather9" value="256" class="optionMore">9 结核病</a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather10" value="512" class="optionMore">10 肝炎</a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather11" value="1024" class="optionMore">11 先天畸形</a>
							<a onClick="billness(this)" href="javascript:void(0)" id="brather12" value="2048" class="optionMore">12 其它</a> 
						</td>
						<td colspan="5" hidden  class="family_disase_conent"> 
							<a onClick="sillness(this)" href="javascript:void(0)" id="son1" value="1" class="Noption">1 无</a>      
							<a onClick="sillness(this)" href="javascript:void(0)" id="son2" value="2" class="optionMore">2 高血压 </a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son3" value="4" class="optionMore">3 糖尿病</a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son4" value="8" class="optionMore">4 冠心病 </a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son5" value="16" class="optionMore">5 慢性阻塞性肺疾病 </a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son6" value="32" class="optionMore">6 恶性肿瘤 </a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son7" value="64" class="optionMore">7 脑卒中</a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son8" value="128" class="optionMore">8四肢发麻</a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son9" value="256" class="optionMore">9 结核病</a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son10" value="512" class="optionMore">10 肝炎</a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son11" value="1024" class="optionMore">11 先天畸形</a>
							<a onClick="sillness(this)" href="javascript:void(0)" id="son12" value="2048" class="optionMore">12 其它</a> 
						</td>
					</tr>
					<tr>
						<td>遗传病史</td>
						<td class="ycb">
							<span class="N1">1 无</span>
							<span class="N2" id="ycbs">2 有</span>
						</td>
						<td colspan="4" id="inheritance" class="ycb_content_td">
							<div class="box2" hidden="">
								名称： <input type="text" name="" id="" value="" class="borderb"/> 时间： <input  name="" id="" value="" class="borderb" onClick="WdatePicker()"/>  
								<a href="javascript:void(0)" class="add_box2">+</a>
							</div>
						</td>
					</tr>
					<tr>
						<td>残疾情况</td>
						<td colspan="5" id="DisabilityingTd" >						 
							<a onClick="Disabilitying(this)"  id="1" value="1" class="Noption">1 无残疾   </a>      
							<a onClick="Disabilitying(this)"  id="2" value="2" class="optionMore">2 视力残疾   </a>
							<a onClick="Disabilitying(this)"  id="3" value="4" class="optionMore">3 听力残疾   </a>
							<a onClick="Disabilitying(this)"  id="4" value="8" class="optionMore">4 言语残疾   </a>
							<a onClick="Disabilitying(this)"  id="5" value="16" class="optionMore">5 肢体残疾   </a>
							<a onClick="Disabilitying(this)"  id="6" value="32" class="optionMore">6 智力残疾   </a>
							<a onClick="Disabilitying(this)"  id="7" value="64" class="optionMore">7 精神残疾   </a>
							<a onClick="Disabilitying(this)"  id="8" value="128" class="optionMore">8 其它残疾   </a>
							<input type="text" name="OtherDisability" id="OtherDisability" value="${data.OtherDisability }" disabled="disabled" />
							<span>
								残疾证：<input type="text" name="DisabilityNumber" id="DisabilityNumber" value="${data.DisabilityNumber }"  disabled="disabled" class="borderb"/>
							</span>
							<span class="fr">
								<!-- <input type="number" name="Disability1" id="Disability1" value="" class="w20"/> 
								<input type="number" name="Disability2" id="Disability2" value="" class="w20"/> 
								<input type="number" name="Disability3" id="Disability3" value="" class="w20"/> 
								<input type="number" name="Disability4" id="Disability4" value="" class="w20"/> 
								<input type="number" name="Disability5" id="Disability5" value="" class="w20"/> 
								<input type="number" name="Disability6" id="Disability6" value="" class="w20"/> 
								<input type="number" name="Disability7" id="Disability7" value="" class="w20"/> 
								<input type="number" name="Disability8" id="Disability8" value="" class="w20"/> 
  -->
								 
							</span>
						</td>
					</tr>
					<tr>
						<td rowspan="5">生活环境</td>
						<td>厨房排风设施</td>
						<td colspan="4" id="KitchenExhaustTd">
							<a onClick="KitchenExhausting(this)"  id="1" value="1" class="option">1 无   </a>      
							<a onClick="KitchenExhausting(this)"  id="2" value="2" class="option">2 油烟机   </a>
							<a onClick="KitchenExhausting(this)"  id="3" value="4" class="option">3 换气扇   </a>
							<a onClick="KitchenExhausting(this)"  id="4" value="8" class="option">4 烟囱   </a>
							<span class="fr"><input type="number" name="KitchenExhaust" id="KitchenExhaust"  value="${data.KitchenExhaust}"  disabled="disabled" class="w20"/ > </span>
						</td>
					</tr>
					<tr>
						<td>燃料类型</td>
						<td colspan="4" id="FuelTypeTd">
							<a onClick="FuelTypeing(this)"  id="1" value="1" class="option">1 液化气    </a>      
							<a onClick="FuelTypeing(this)"  id="2" value="2" class="option">2 煤    </a>
							<a onClick="FuelTypeing(this)"  id="3" value="4" class="option">3 天然气    </a>
							<a onClick="FuelTypeing(this)"  id="4" value="8" class="option">4 沼气    </a>
							<a onClick="FuelTypeing(this)"  id="5" value="16" class="option">5 柴火    </a>
							<a onClick="FuelTypeing(this)"  id="6" value="32" class="option">6 其他  </a>
							<span class="fr"><input type="number" name="FuelType" id="FuelType"  value="${data.FuelType}"  class="w20" disabled="disabled"/> </span>
						</td>
					</tr>
					<tr>
						<td>饮水</td>
						<td colspan="4" id="DrinkingwaterTd">
						    <a onClick="Drinkingwatering(this)"  id="1" value="1" class="option">1 自来水    </a>      
							<a onClick="Drinkingwatering(this)"  id="2" value="2" class="option">2 经净化过滤的水    </a>
							<a onClick="Drinkingwatering(this)"  id="3" value="4" class="option">3 井水    </a>
							<a onClick="Drinkingwatering(this)"  id="4" value="8" class="option">4 河湖水    </a>
							<a onClick="Drinkingwatering(this)"  id="5" value="16" class="option">5 塘水    </a>
							<a onClick="Drinkingwatering(this)"  id="6" value="32" class="option">6 其他  </a>
							<span class="fr"><input type="number" name="Drinkingwater" id="Drinkingwater"  value="${data.Drinkingwater }"  disabled="disabled" class="w20"/> </span>
						</td>
					</tr>
					<tr>
						<td>厕所</td>
						<td colspan="4" id="ToiletTd"> 
							<a onClick="Toileting(this)"  id="1" value="1" class="option">1 卫生厕所    </a>      
							<a onClick="Toileting(this)"  id="2" value="2" class="option">2 一格或二格粪池式    </a>
							<a onClick="Toileting(this)"  id="3" value="4" class="option">3 马桶    </a>
							<a onClick="Toileting(this)"  id="4" value="8" class="option">4 露天粪坑    </a>
							<a onClick="Toileting(this)"  id="5" value="16" class="option">5 简易棚厕    </a>						 
							<span class="fr"><input type="number" name="Toilet" id="Toilet"  value="${data.Toilet }"  disabled="disabled" class="w20"/> </span>
						</td>
					</tr>
					<tr>
						<td>禽兽栏</td>
						<td colspan="4" id="LivestockColumnTd">							
							<a onClick="LivestockColumning(this)"  id="1" value="1" class="option">1 单设    </a>      
							<a onClick="LivestockColumning(this)"  id="2" value="2" class="option">2 室内    </a>
							<a onClick="LivestockColumning(this)"  id="3" value="4" class="option">3 室外    </a>
							 						 
							<span class="fr"><input type="number" name="LivestockColumn" id="LivestockColumn" value="${data.LivestockColumn }" disabled="disabled" class="w20"/> </span>
						</td>
					</tr>
				</table>
			</div>
			<!------------------------------------高血压---------------------------->
			<div class="content_div" hidden="">
		      <iframe src="/FWS/hypertension/toHistory?personID=${personId}"  width="100%" height="100%">
			 </iframe> 
			</div>
			
			<div class="content_div" hidden="">
				
		  <iframe src="/FWS/diabetes/toHistory?personID==${personId}"  width="100%" height="100%">
			  </iframe>	 
			</div>
<!------------------------------------体检---------------------------->
			<div class="content_div"  style="height:100%;" hidden="">
		      <iframe src="/FWS/examination/personExaminationListPage?personId=${personId}"  width="100%" height="100%">
		      
		      </iframe>
			</div>
	<!------------------------------------报告---------------------------->		
			<div class="content_div"  style="height:100%;" hidden="">
				      <iframe src="/FWS/resident/getMoreReport?personId=${personId}"  width="100%" height="100%">
				      
				      </iframe>
			</div>
		<!--    <div class="content_div" hidden="">
		   
		   
		   <div style="margin:0px; background-color: white;">
		        
		         <blockquote class="layui-elem-quote">
		        <form class="layui-form" action="">
		      
				  
		        <div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="date1" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
			      </div>--
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="date2" lay-verify="date" placeholder="" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
			      </div>
		        </div>
		    
				  
				 
				  <div class="layui-inline" >
					 <div class="layui-form-item"  style="margin-left: 0px">  
						   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
								 <div class="layui-input-inline">
						    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButton" type="button">查询</button>
						    	 </div>
							</div>
					 </div>
				  </div>  
				  
				    <div class="layui-inline" >
					 <div class="layui-form-item"  style="margin-left: 0px">  
						   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
								 <div class="layui-input-inline">
						    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButtonzhou" type="button">本周</button>
						    	 </div>
							</div>
					 </div>
				  </div>  
				  
				    <div class="layui-inline" >
					 <div class="layui-form-item"  style="margin-left: 0px">  
						   <div class="layui-inline" style="width:30%;margin-left: 0px;float:left" >
								 <div class="layui-input-inline">
						    	   <button class="layui-btn layui-btn-radius" style="width: 100%" id="selectButtonyue" type="button">本月</button>
						    	 </div>
							</div>
					 </div>
				  </div>  
					 
					</form>
		        </blockquote>
		        <div id="content" style="width: 100%;height: 500px;"></div>
		    </div>
		      
			</div> -->
			
			
		</div>
	</body>
	
	<script type="text/javascript">
	//性别处理
	if($('#GenderCode').val()==0){
		$('#GenderCodeTd a').eq(0).addClass('bluecolor')
	}else if(($('#GenderCode').val()==1)){
		$('#GenderCodeTd a').eq(1).addClass('bluecolor')
	}else if(($('#GenderCode').val()==2)){
		$('#GenderCodeTd a').eq(2).addClass('bluecolor')
	}else if(($('#GenderCode').val()==9)){
		$('#GenderCodeTd a').eq(3).addClass('bluecolor')
	}

	
	
	function Gendering(tr){
		
	}
	//常住类型
	function HukouInding(tr){
		
	}
 	//血型处理 
	function BloodTypeing(tr){
		
	}
	//RH阴性
	function RhBlooding(tr){
		
	}
	
	//文化程度
	function EducationCodeing(tr){
		
	}
	//职业
	function JobCodeing(tr){
		
		
	} 
	//婚姻状况
	function MarryStatusing(tr){
	
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
	//医疗费用支付方式回显
	var PaymentWaystr ='${PaymentWaystring}';
	var PaymentWayList=PaymentWaystr.split(",");
	//var strs = RecordOneJson.master.Symptom.split(",");
	$("#PaymentWayTd a").each(function(i){
	    var id = String(Math.pow(2, i));//计算出当前症状对应的真实ID
	    if(PaymentWayList.indexOf(id) > -1){//如果这个ID存在于服务器给的值，则为这个元素添加高亮
	   
	    	$("#PaymentWayTd a").eq(i).toggleClass('bluecolor');
	    }
	});
	
	
	
	//药物过敏回显
	var DrugAllergyHistorystr ='${DrugAllergyHistory}';
	var DrugAllergyHistoryList=DrugAllergyHistorystr.split(",");
	$('#DrugAllergyHistoryingTd a').each(function(i){
		var id=String(Math.pow(2, i))
	  if(DrugAllergyHistoryList.indexOf(id)>-1){
		 
		  $('#DrugAllergyHistoryingTd a').eq(i).addClass('bluecolor')
	  }
    })
	
	
	
	//暴露史回显
	var ExposureHistorystr ='${ExposureHistory}';
	var	ExposureHistoryList=ExposureHistorystr.split(",");
	getBlueColor($("#ExposureHistoryTd a"),ExposureHistoryList)
	

	//疾病回显
	var CmDataList ='${CmDataList}';
	if(CmDataList==''||CmDataList==null){}else{
	var CdList=JSON.parse(CmDataList); 
		if(CdList!=null&&CdList!=""){
			for(var i=0;i<CdList.length;i++){
				var cid=CdList[i].DiseaseKindID;
				var time =CdList[i].DiagnosisDate;
				var times = time.split("T");
				cid=cid.replace(/-/g,"").toUpperCase();
				if("52A0328740914BCE86ED10A4D2521816"==cid){
					//高血压
					  $('#diseasesTd a').eq(1).addClass('bluecolor')
					$("#highBloodPressure").val(times[0])
				}else if("7AA0AFF1DDA040F18510513DE3753547"==cid){
					//糖尿病
					 $('#diseasesTd a').eq(2).addClass('bluecolor')
					$("#diabetes").val(times[0])
				}else if("708DE71884C645D0AEF802E06C6B4B12"==cid){
					//冠心病
					 $('#diseasesTd a').eq(3).addClass('bluecolor')
					$("#coronaryHeartdDisease").val(times[0])
				}else if("C2B2CB0803EC46A684A00AE350A34251"==cid){
					//慢性阻塞性肺疾病
					 $('#diseasesTd a').eq(4).addClass('bluecolor')
					$("#chronicObstructivePulmonaryDisease").val(times[0])
				}else if("E63F8CF300D44FECBD6FF96B9FCAF39C"==cid){
					//恶性肿瘤
					 $('#diseasesTd a').eq(5).addClass('bluecolor')
					$("#cancer").val(times[0])
				}else if("37A51584E2EF43D09CEF1CE8D69BDEB8"==cid){
					//脑卒中
					 $('#diseasesTd a').eq(6).addClass('bluecolor')
					$("#stroke").val(times[0])
				}else if("FC6FF7E27F064D9C98DCD5C83E70F119"==cid){
					//重性精神疾病
					 $('#diseasesTd a').eq(7).addClass('bluecolor')
					$("#severeMentalIllness").val(times[0])
				}else if("52A0328740914BCE86ED10A4D2521814"==cid){
					//结核病
					 $('#diseasesTd a').eq(8).addClass('bluecolor')
					$("#tuberculosis").val(times[0])
				}else if("AB9E834EDC1B4FE68CD41C94767AFD9A"==cid){
					//肝炎
					 $('#diseasesTd a').eq(9).addClass('bluecolor')
					$("#hepatitis").val(times[0])
				}else if("DE414310BBCA47299208FD524D3B617A"==cid){
					//其他法定传染病
					 $('#diseasesTd a').eq(10).addClass('bluecolor')
					$("#notifiableDisease").val(times[0])
				}else if("930FAEAF1DA34246A2CBDDA86EE480CD"==cid){
					//职业病
					 $('#diseasesTd a').eq(11).addClass('bluecolor')
					$("#industrialDisease").val(times[0])
				}else if("9D9B81363B3C4A699ECB77AFF805D411"==cid){
					//其他
					$('#diseasesTd a').eq(12).addClass('bluecolor')
					$("#DiseaseOtherDate").val(times[0])
					$("#DiseaseOther").CdList[i].Remark;
				}
			}
		}
	}
	//经济类型回显
	$("#IncomeType").val("${data.IncomeType}");
	//状态回显
	$("#HrStatus").val("${data.HrStatus}");
	//备注信息回显
	$("#Remark").text("${data.Remark}");
 
	//状态变更说明回显
	$("#HrStatusRemark").text("${data.HrStatusRemark}");
	 
	//手术回显
	var HealthHistoryList ='${flist}';
	if(HealthHistoryList==''||HealthHistoryList==null){}else{
		var flist=JSON.parse(HealthHistoryList);  
		if(flist!=null&&flist!=""){
			for(var i=0;i<flist.length;i++){
				var time=flist[i].OccurrenceDate;
				var timestrs =time.split("T");
				if(flist[i].RecordType==3){
					//输血
					$('#sxhas2').addClass('bluecolor')
					$('#sxhas1').removeClass('chosed')
					if($("#transfusion input[name='name1']").length==0){
						var sx= '<div class="add_illness" >名称： <input type="text" name="name1"  value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"  value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="add">+</a></div>';
						$("#transfusion").html(sx);
					}else if($("#transfusion input[name='name1']").length>0){
						var sx= '<div class="add_illness" >名称： <input type="text" name="name1"  value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"  value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="delete" onclick="delete_this(this)">X</a></div>';
						$("#transfusion").append(sx);
					}
				}else if(flist[i].RecordType==2){
					//外伤
					$('#wshas2').addClass('bluecolor')
					$('#wshas1').removeClass('chosed')
					
					if($("#trauma input[name='name1']").length==0){
						var ws= '<div class="add_illness" >名称： <input type="text" name="name1"  value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"  value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="add">+</a></div>';
						$("#trauma").html(ws);
					}
					else if($("#trauma input[name='name1']").length>0){
						var ws= '<div class="add_illness" >名称： <input type="text" name="name1"  value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"  value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="delete" onclick="delete_this(this)">X</a></div>';
						$("#trauma").append(ws);
					}
				}else if(flist[i].RecordType==1){
					//手术
					$('#sshas2').addClass('bluecolor')
					$('#sshas1').removeClass('chosed')
					if($("#operation input[name='name1']").length==0){
					$("#operation").html("");
					var traumaoption= '<div class="add_illness" >名称： <input type="text" name="name1"  value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"  value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="add">+</a></div>';
					$("#operation").html(traumaoption);
					}else
				    if($("#operation input[name='name1']").length>0){
						var ss= '<div class="add_illness" >名称： <input type="text" name="name1"  value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"  value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="delete" onclick="delete_this(this)">X</a></div>';
						$("#operation").append(ss);
					} 
				}else if(flist[i].RecordType==4){
					//遗传病史
					console.log(flist[i].Name)
					$('.N1').removeClass('bluecolor')
					$('.N2').addClass('bluecolor')
					if($("#inheritance input[name=name1]").length==0){
					var inheritanceoption='<div class="box2" >名称： <input type="text" name="name1"   value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"   value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="add_box2">+</a></div>';
					$("#inheritance").html(inheritanceoption);
					}
					else if($("#inheritance input[name=name1]").length>0){
						var inheritanceoption='<div class="box2" >名称： <input type="text" name="name1"   value='+flist[i].Name+' class="borderb"/> 时间： <input type="text" name="time"   value='+ timestrs[0]+' class="borderb" onClick="WdatePicker()"/>'+'<a href="javascript:void(0)" class="delete" onclick="delete_this(this)">X</a></div>';
						$("#inheritance").append(inheritanceoption);
					}
				}
		
			}
		
		}
	}
	//家族史回显
	 var ss='${dataJson}'
	 var ssObject=JSON.parse(ss)
	 var FamilyHistory_mark=ssObject.FamilyHistory
		if(FamilyHistory_mark!=''&&FamilyHistory_mark!=null){
			for(var i in FamilyHistory_mark ){
			 if(FamilyHistory_mark[i].Remark!=''&&FamilyHistory_mark[i].Remark!=null){
				  $("#f_"+i).attr("disabled",false);
				 $("#f_"+i).val(FamilyHistory_mark[i].Remark)
			 }
			}
		} 
	//父亲回显
	var fillnessstr ='${fillness}';
	if(fillnessstr==''||fillnessstr==null){
		$('.fn0').val("")
		$('.fn0').eq(0).val("1")
		$('.family_disase_conent').eq(0).find('a').eq(0).addClass('bluecolor')
	}else{
		var fillnessList=fillnessstr.split(",");
		/* if(fillnessList.indexOf(2048)>-1){
			 $("#f_"+i).attr("disabled",false);
		} */
		getBlueColorWithObj($('.family_disase_conent').eq(0).find('a'),fillnessList,$('.fn0'))
	}
	//母亲回显
	var millnessstr ='${millness}';
	if(millnessstr==''||millnessstr==null){
		$('.fn1').val("")
		$('.fn1').eq(0).val("1")
		$('.family_disase_conent').eq(0).find('a').eq(0).addClass('bluecolor')
	}else{
	    var millnessList=millnessstr.split(",");
	    getBlueColorWithObj($('.family_disase_conent').eq(1).find('a'),millnessList,$('.fn1'))
		
	}
	//兄弟姐妹回显
	var billnessstr ='${billness}';
	if(millnessstr==''||millnessstr==null){
		$('.fn2').val("")
		$('.fn2').eq(0).val("1")
		$('.family_disase_conent').eq(2).find('a').eq(0).addClass('bluecolor')
	}else{
		var billnessList=billnessstr.split(",");
		getBlueColorWithObj($('.family_disase_conent').eq(2).find('a'),billnessList,$('.fn2'))
	}
	//子女回显
	var sillnessstr ='${sillness}';
	if(millnessstr==''||millnessstr==null){
		$('.fn3').val("")
		$('.fn3').eq(0).val("1")
		$('.family_disase_conent').eq(3).find('a').eq(0).addClass('bluecolor')
	}else{
		var sillnessList=sillnessstr.split(",");
		getBlueColorWithObj($('.family_disase_conent').eq(3).find('a'),sillnessList,$('.fn3'))
		
	}
	//家族史
	//父亲
	function fillness(tr){		 
		
		
	}
	 
	//母亲
	function millness(tr){		 
		
   }
	//兄弟姐妹
	function billness(tr){		 
		
	}
	//子女
	function sillness(tr){
		
		
	}
	
	//残疾情况
	function Disabilitying(tr){
		
	}
	//残疾情况回显
	var Disabilitystr ='${Disability}';
	console.log("残疾情况："+Disabilitystr)
	if(Disabilitystr==''||Disabilitystr==null||Disabilitystr==0||Disabilitystr==1){
		$('#DisabilityingTd a').eq(0).addClass('bluecolor')
	}else{
		var DisabilityList=Disabilitystr.split(",");
		getBlueColor($('#DisabilityingTd a'), DisabilityList)
	
	}
	//环境回显
	getBlueColorOderbyOne($('#KitchenExhaustTd a'), '${data.KitchenExhaust}')
	getBlueColorOderbyOne($('#FuelTypeTd a'), '${data.FuelType}')
	getBlueColorOderbyOne($('#DrinkingwaterTd a'), '${data.Drinkingwater}')
	getBlueColorOderbyOne($('#ToiletTd a'), '${data.Toilet}')
	getBlueColorOderbyOne($('#LivestockColumnTd a'), '${data.LivestockColumn}')


		
			
			
	
		

		
	
		
			
	
			
		
			
							
			
			
		
			
		
			
			
			
			
			
			
		
			
			
			
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
			//JobCode
			function JobCodeTd(){//职业
				$("#JobCodeTd").find("a").each(function(i){
					var value=$("#JobCode").val()
					if(value==i+1){
				      $(this).addClass('bluecolor')
				     }
					if(value.indexOf("学民")){
						
						$("#JobCodeTd").find("a").eq(7).addClass('bluecolor')
						$("#JobOther").find("option[value='${data.JobCode}']").attr("selected",true); 
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
	
	<!-- <script>
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
                url: '/FWS/resident/getAllUserReportByDoc',
                pageSize: 10,
                columns: [ {
                    fieldName: '上传者',
                    field: 'personName',
                   
                }, {
                    fieldName: '上传日期',
                    field: 'uptimeStr',
                    
                },{
                    fieldName: '描述',
                    field: 'reportDescription',
                    
                },{
                    fieldName: '操作',
                    field: 'tid',
                    colRender : 'crRender'
                }],
                even: true,
                //skin: 'row',
                checkbox: false,
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
            
        });
	}
    
     var zy='zy'
    
	//查询按钮声明点击事件，查询逻辑
    $('#selectButton').on('click', function(){
    	tableConfig();
    });
    $('#selectButtonzhou').on('click', function(){
    	zy='1'
    	tableConfig();
    });
    
    $('#selectButtonyue').on('click', function(){
    	zy='30'
    	tableConfig();
    });
    
    function getParams(){
    	var params = {
    		personId:'${personId}',
    		date1:$("#date1").val(),
    		date2:$("#date2").val(),
    		zy:zy
			   	}
    	return params;
    }
   
    function crRender(data){
    	
    	return '<a onclick="getDetail(\''+data+'\')">详情</a>'
    	
    }
    
    
    function getDetail(id){
 	   
   	 layer.open({
   		    type: 2
     			,area: ['560px', '430px']
     	        ,title :'报告详情'
   	   	    ,content: '${fws}/resident/getDetail?tid='+id
   	   	     
   		});		
   	   
   	   
   	   
      } 
  </script> -->
    
  
   
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
	  document.getElementById('date2').onclick = function(){
	    end.elem = this
	    laydate(end);
	  }
	  
	});
</script>
  
	<script type="text/javascript">
	$(function(){
		console.log('${dataJson}')
		console.log('=========================================================')
		console.log('${data.KitchenExhaust}')
		console.log('${data.FuelType}')
		console.log('${data.Drinkingwater}')
		console.log('${data.Toilet}')
		console.log('${data.LivestockColumn}')
		NationCodeView()
		EducationCodeTd()
		BloodTypeTd()
		RhBloodTd()
		JobCodeTd()
		MarryStatusTd()
		
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
