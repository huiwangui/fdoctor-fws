package com.boco.modules.fdoc.web.fdocWorkstation;

import java.io.File;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.boco.common.comparator.AbnormalSignDateComparator;
import com.boco.common.comparator.UserComparator;
import com.boco.common.constants.BusinessConstants;
import com.boco.common.enums.ApiStatusEnum;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.persistence.Page;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.FTPUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.model.BloodSugerRecordEntity;
import com.boco.modules.fdoc.model.DiseaseDictionaryEntity;
import com.boco.modules.fdoc.model.DiseaseLabelEntity;
import com.boco.modules.fdoc.model.DiseaseLabelPersonRelationEntity;
import com.boco.modules.fdoc.model.HypertensionRecordEntity;
import com.boco.modules.fdoc.model.NationEntity;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.model.UserReportEntity;
import com.boco.modules.fdoc.service.BloodSugerRecordService;
import com.boco.modules.fdoc.service.DiseaseDictionaryService;
import com.boco.modules.fdoc.service.DiseaseLabelService;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.service.HypertensionRecordService;
import com.boco.modules.fdoc.service.NationService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SendMsgService;
import com.boco.modules.fdoc.service.SigServicepackService;
import com.boco.modules.fdoc.service.SignService;
import com.boco.modules.fdoc.service.UserService;
import com.boco.modules.fdoc.vo.DiseaseLabelVo;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.boco.modules.fdoc.vo.ServicepackDetailsVo;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.UserReportParamVo;
import com.boco.modules.fdoc.vo.UserReportVo;
/**
 * 健康管理  我的居民  标签管理  居民信息
 * 
 * @author j
 *
 * @date 2017年6月21日
 */
@Controller
@RequestMapping(value = "/resident", produces = "text/json;charset=utf-8")
public class MyinhabitantsController {
    static Map<String, Object> times =new HashMap<String, Object>();
	@Resource
	DiseaseLabelService diseaseLabelService;
	@Resource
	SendMsgService sendMsgService;
	@Resource
	PersonInformationService personService;
	@Resource
	SignService signService;
	@Resource
	NationService nationService;
	@Resource 
	SigServicepackService sigServicepackService;
	@Resource
	UserService userService;
	@Resource
	HypertensionRecordService hyperService;
	@Resource
	DocUserService docUserService;
	@Resource
	BloodSugerRecordService bloodSugerService;
	@Resource
	DiseaseDictionaryService diseaseService;

    /**跳转页面  
     * （到当前医生团队下的签约居民列表《带标签信息》）
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/golist",method = RequestMethod.GET)
	public String getAllList(HttpServletRequest req, Model model){
		//获取标签列表
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		List<DiseaseLabelVo>  lableList=diseaseLabelService.getLabelList(doctorInfo.getTeamId());
	    model.addAttribute("lableList", lableList);
	    model.addAttribute("lableListJson", JsonUtils.getJson(lableList));
		return "/healthAdmin/myresidents/residentList";
	}
	/**跳转页面  
     * （个人详细信息页面）
     * @param HttpServletRequest
     * @param Model
     * @param personId
     * @return
     *
     */
	@RequestMapping(value = "/personInfo",method = RequestMethod.GET)
	public String getPersonInfo(HttpServletRequest req, Model model,@RequestParam String personId){
		        DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
				// 获取居民详情
				PersonInformationVo personDetail = personService.getPersonDetailByPersonId(personId);
				if("1".equals(personDetail.getSex())){
					personDetail.setSex("男");
				}else if("2".equals(personDetail.getSex())){
					personDetail.setSex("女");
				}else{
					personDetail.setSex("不详");
				}
				model.addAttribute("personId", personId);
				// 调用卫计委接口获取婚姻状况、医疗费用支付方式、民族
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ProductCode",doctorInfo.getProductCode());
				
				map.put("ID", personId);
				String returnData = RestfulUtils.getPublicData("55-10", map);
				// 解析json
				Map<String, Object> resultMap = JsonUtils.getObjectJsonMap(returnData);
				if ((Integer)resultMap.get("Result") > 0) {
					Map<String, Object> dataMap = (Map<String, Object>) resultMap.get("Msg");
					//获取民族代码
					String nationCode = (String) dataMap.get("NationCode");
					//查询民族表,封装民族名称
					NationEntity nation = nationService.getNationByCode(nationCode);
					if (nation != null) {
						personDetail.setNation(nation.getNationName());
					}
					//获取婚姻状况代码并设置
					personDetail.setMarryStatus((String)dataMap.get("MarryStatus"));
					//获取医疗费用支付方式并设置
					personDetail.setPaymentWaystring((Integer)dataMap.get("PaymentWaystring"));
				}
				List<PersonInformationVo> familyMember=personService.getFamilyMember(personDetail.getFamilyId());
				//封装家庭信息
				if (familyMember != null) {
					for (PersonInformationVo memberVo : familyMember) {
						if("1".equals(memberVo.getSex())){
							memberVo.setSex("男");
						}else if("2".equals(memberVo.getSex())){
							memberVo.setSex("女");
						}else{
							memberVo.setSex("不详");
						}
					}
				}
				//排序放入 户主第一
				UserComparator comparator = new UserComparator();
				Collections.sort(familyMember, comparator);
				model.addAttribute("familyMember", JsonUtils.getJson(familyMember));
				// 设置居民慢病标签情况
				DiseaseLabelVo labelVo = new DiseaseLabelVo();
				labelVo.setPersonId(personId);
				labelVo.setDocTeamId(doctorInfo.getTeamId());
				List<DiseaseLabelVo> labelList = diseaseLabelService.getLabelListWithSelectFlag(labelVo);
				
				Map<String, Object> returnMap = new HashMap<String, Object>();
				returnMap.put("personInfo", personDetail);
				returnMap.put("labelList", labelList);
				// 封装签约信息
				SignVo signInfo = signService.getSignDetailByIdCard(personDetail.getIdCard());
				Map<String, Object> signMap = new HashMap<String, Object>();
				signMap.put("signType", signInfo.getSignType());
				signMap.put("signId", signInfo.getId());
				returnMap.put("signInfo", signMap);
				model.addAttribute("packs", signInfo.getPacks());
				model.addAttribute("vo", returnMap);
				model.addAttribute("voJson",JsonUtils.getJson(returnMap) );
				
			    //血压占比统计
				String productCode = null;

				if (StringUtils.isEmpty(doctorInfo.getUserName())) {
					//userName为空，为居民端调用
					List<DoctorDetailVo> list =signService.getSignDoctorTeamInfo(personId);
					if(list.size()>0){
						for(int i=0;i<list.size();i++){
							String value =list.get(i).getProductCode();
							if(value!=null&&!("".equals(value))){
								productCode =value;
							}
						}
					}else{
						return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.RE_NO_ORDER.getKey(), ApiStatusEnum.RE_NO_ORDER.getValue()));
					}
			
				}else {
					//医生端调用，获取该医生的productCode
					DoctorDetailVo docUser = docUserService.getDoctorByUsername(doctorInfo.getUserName());
					productCode = docUser.getProductCode();
				}
				
				// 查询本地库，获取血压记录总数
				Map<String, Integer> recordCount = hyperService.getRecordCount(personId);
				Integer allCount = recordCount.get("allCount");
				Integer lowCount = recordCount.get("lowCount");
				Integer normalCount = recordCount.get("normalCount");
				Integer highCount = recordCount.get("highCount");
				
				// 调用接口，获取公卫血压数据
				Map<String, Object> map2 = new HashMap<String, Object>();
				//map.put("ProductCode", PropertiesUtils.getValue("produce_code"));//TODO：未完成注册产品之前先用写死的produceCode
				//DoctorDetailVo doc = docUserService.getDoctorByUsername(userName);
				map2.put("ProductCode",productCode);
				
				map2.put("PersonID", personId);
				map2.put("PageSize", 100);	//调取前100条记录
				map2.put("PageIndex", 0);
				
				String returnDataboli = RestfulUtils.getPublicData("58-1", map2);
				if (JsonUtils.getObjectJsonMap(returnDataboli).get("Total")!= null && Integer.valueOf((String)JsonUtils.getObjectJsonMap(returnDataboli).get("Total")) > 0) {
					List<Map<String, Object>> hyperList = (List<Map<String, Object>>) JsonUtils.getObjectJsonMap(returnDataboli).get("Msg");
					for (Map<String, Object> hyperMap : hyperList) {
						if (hyperMap.get("Sbp") != null && hyperMap.get("Dbp") != null) {
							Double systolicPressure = Double.valueOf((Integer) hyperMap.get("Sbp"));	//收缩压
							Double diastolicPressure = Double.valueOf((Integer) hyperMap.get("Dbp"));	//舒张压
							
							if (systolicPressure < 90 || diastolicPressure < 60) {
								lowCount ++;
							}else if (90 <= systolicPressure && systolicPressure <= 139 && 60 <= diastolicPressure && diastolicPressure <= 89) {
								normalCount ++ ;
							}else {
								highCount ++;
							}
							allCount ++;
						}
					}
				}
				recordCount.clear();
				model.addAttribute("lowCount", lowCount);
				model.addAttribute("normalCount", normalCount);
				model.addAttribute("highCount", highCount);
				
		        return "/healthAdmin/myresidents/personInfo";
	}
   
	/**
	 * 查询居民（根据标签,姓名）
	 * @param req
	 * @param mode
	 * @param labelId
	 * @param personName
	 * @param pageSize
	 * @param pageIndex
	 * @return
	 *
	 */
	@RequestMapping(value = "/queryresident",method = RequestMethod.GET)
	@ResponseBody
	public String queryresident(HttpServletRequest req,Model mode,@RequestParam String labelId, 
			@RequestParam String personName,@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		if(StringUtils.isNotEmpty(labelId)){
			//封装参数
			DiseaseLabelVo vo = new DiseaseLabelVo();
			vo.setId(Integer.valueOf(labelId));
			vo.setPersonName(personName);
			//获取总数
			Integer personNotInLabelCount = diseaseLabelService.getPersonInLabelCount(vo);
			//封装分页参数
			Page<DiseaseLabelVo> page = new Page<DiseaseLabelVo>(pageIndex, pageSize);
			vo.setPage(page);
			//查询返回结果
			List<PersonInformationVo> personNotInLabel = diseaseLabelService.getPersonInLabel(vo);
			for (PersonInformationVo personInformationVo : personNotInLabel) {
				String  birthDay=DateUtils.formatDate(personInformationVo.getDateOfBirth()); 
				personInformationVo.setBirthDay(birthDay);
			}
			return JsonUtils.getJson(BaseJsonVo.pageList(personNotInLabel, personNotInLabelCount),BusinessConstants.JSON_ALL);
		}
		//封装查询参数
		SignVo vo = new SignVo();
		vo.setPersonName(personName);
		vo.setDocTeamId(doctorInfo.getTeamId());
		//查询总数
		Integer count = signService.getSignedCount(vo);
		//封装分页对象
		vo.setPage(new Page<SignVo>(pageIndex,pageSize));
		//查询列表
		List<PersonInformationVo> signedList = signService.getSignedList(vo);
		if(signedList!=null&&signedList.size()>0){
			for (PersonInformationVo personInformationVo : signedList) {
				if(personInformationVo.getDateOfBirth()!=null){
					String  birthDay=DateUtils.formatDate(personInformationVo.getDateOfBirth());  
					personInformationVo.setBirthDay(birthDay);
				}
			}
		}
		return JsonUtils.getJson(BaseJsonVo.pageList(signedList, count),BusinessConstants.JSON_ALL);

	}
	/**
	 * "删除标签
	 * 'labelId':'标签ID',
	 * 'defaultFlag':'是否为默认标签：0.否 1.是 '
	 * @param paramBody
	 * @return
	 *
	 */
	@RequestMapping(value = "/deleteLabel", method = RequestMethod.POST)
	public String deleteLabel(@RequestBody String paramBody){
		//解析json
		Map<String, Object> objectJsonMap = JsonUtils.getObjectJsonMap(paramBody);
		Integer labelId = (Integer) objectJsonMap.get("labelId");
		String defaultFlag = (String) objectJsonMap.get("defaultFlag");
		//判断如果为默认模板，就不让修改
		if (BusinessConstants.DEFAULT_FLAG_DEFAULT.equals(defaultFlag)) {
			return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.DEFAULT_NOT_ALLOW.getKey(), ApiStatusEnum.DEFAULT_NOT_ALLOW.getValue()));
		}else {
			diseaseLabelService.deleteLabel(labelId);
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	/**
	 * 编辑标签，包含修改标签、人员，新增标签、人员（医生端）
	 * 'labelId':'标签ID，若新增则传0，整数类型',
	 * 'teamId':'医生团队ID',
	 * 'labelName':'标签名',
	 * 'defaultFlag':'是否为默认标签：0.否 1.是 ',
	 * 'personIdList':['居民ID数组']
	 * @param paramBody
	 * @return
	 *
	 */
	@RequestMapping(value = "/editLabel", method = RequestMethod.POST)
	@ResponseBody
	public String editLabel( @RequestParam String dataJson ){
		//解析json
		Map<String, Object> objectJsonMap = JsonUtils.getObjectJsonMap(dataJson);
		System.out.println(objectJsonMap);
		String labelId = (String) objectJsonMap.get("labelId");
		String labelName = (String) objectJsonMap.get("labelName");
		String defaultFlag = (String) objectJsonMap.get("defaultFlag");
		String teamId = (String) objectJsonMap.get("teamId");
		List<String> personIdList = (List<String>) objectJsonMap.get("personIdList");
		
		//封装标签对象
		DiseaseLabelEntity labelEntity = new DiseaseLabelEntity();
		labelEntity.setId(Integer.valueOf(labelId));
		labelEntity.setLabelName(labelName);
		if(StringUtils.isNotEmpty(defaultFlag)){
		labelEntity.setDefaultFlag(defaultFlag);
		}
		labelEntity.setDocTeamId(teamId);
		if(StringUtils.isNotEmpty(labelName)){
				switch(labelName){
				 case  "高血压":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_HYPER);
					 break;
				 case  "糖尿病":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_DIABETES);
					 break;
				 case  "儿童":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_CHILD);
					 break;
				 case  "普通成人":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_CHENR);
					 break;
				 case  "老年人":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_OLDM);
					 break;
				 case  "重型精神病":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_MAJOR);
					 break;
				 case  "孕产妇":
					 labelEntity.setDiseaseCode(BusinessConstants.SIGN_YUNCH);
					 break;
				 default:
					 break;
				}
				
		}
		//封装对应关系集合
		List<DiseaseLabelPersonRelationEntity> relationList = new ArrayList<DiseaseLabelPersonRelationEntity>();
		if(personIdList!=null){
			for (String personId : personIdList) {
				DiseaseLabelPersonRelationEntity relationEntity = new DiseaseLabelPersonRelationEntity();
				relationEntity.setPersonId(personId);
				relationList.add(relationEntity);
			}
		}
		//判断是修改还是新增：若id为0，则为新增，否则为修改
		String id=null;
		if (Integer.valueOf(labelId) == 0) {
		  id=	diseaseLabelService.addLabelAndRelations(labelEntity, relationList);
		}else {
			diseaseLabelService.updateLabelAndRelations(labelEntity, relationList);
		}
		return JsonUtils.getJson(BaseJsonVo.success(id));
	}
	
	
	/**
	 * 删除标签
	 * @param labelId
	 * @return
	 *
	 */
	@RequestMapping(value = "/delLabel", method = RequestMethod.POST)
	@ResponseBody
	public String delLabel( @RequestParam String labelId ){
		diseaseLabelService.deleteLabel(Integer.valueOf(labelId));
		return JsonUtils.getJson(BaseJsonVo.success(labelId));
	}
	/**
	 * 标签管理页面
	 * @param req
	 * @return
	 *
	 */
	@RequestMapping(value = "/toLabel",method = RequestMethod.GET)
	public String  toLabel(Model model,HttpServletRequest req){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		//获取标签列表
		List<DiseaseLabelVo>  lableList=diseaseLabelService.getLabelList(doctorInfo.getTeamId());
	    model.addAttribute("lableList", lableList);
	    model.addAttribute("lableListJson", JsonUtils.getJson(lableList));
		return "/healthAdmin/myresidents/editLabel";
	}
	
	

    /**跳转页面  
     * （到当前医生团队下的签约居民列表不包含已选择标签的人员《带标签信息》）
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/addPersonView",method = RequestMethod.GET)
	public String addPersonList(HttpServletRequest req, Model model) {
		//获取标签列表
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		List<DiseaseLabelVo>  lableList=diseaseLabelService.getLabelList(doctorInfo.getTeamId());
	    model.addAttribute("lableList", lableList);
	    model.addAttribute("lableListJson", JsonUtils.getJson(lableList));
		return "/healthAdmin/myresidents/addLabelList";
	}
	
	/**跳转页面  
     * （到居民档案 ）
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/docmentInfo",method = RequestMethod.GET)
	public String docmentInfo(HttpServletRequest req, Model model,String personId) {
		//获取标签列表
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String,Object> docInfo = (Map<String,Object> ) req.getSession().getAttribute("doc_session");

		DoctorDetailVo vo =docUserService.getDoctorByUsername((String)docInfo.get("userName"));
		paramMap.put("ProductCode",vo.getProductCode());
		
		paramMap.put("ID", personId);
		String response = RestfulUtils.getPublicData("55-10", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
		if((int)responseMap.get("Result")==0){
			return "/healthAdmin/myresidents/docmentInfo";
		}
	    Map<String, Object>  list=   (Map<String, Object>) responseMap.get("Msg");
		//性别处理
	    String GenderCode= (String) list.get("GenderCode");
	    if("0".equalsIgnoreCase(GenderCode)){
	    	model.addAttribute("Gender", "未知");
	    }else if("1".equalsIgnoreCase(GenderCode)){
	    	model.addAttribute("Gender", "男");
	    }else if("2".equalsIgnoreCase(GenderCode)){
	    	model.addAttribute("Gender", "女");
	    }else if("9".equalsIgnoreCase(GenderCode)){
	    	model.addAttribute("Gender", "未说明");
	    }
	    
	    //出生日期处理
	    String BirthDaystr= (String) list.get("BirthDay");
	    String[] BirthDayList =BirthDaystr.split("T");
	    model.addAttribute("BirthDay", BirthDayList[0]);
	    //参加工作时间
	    String WorkDate= (String) list.get("WorkDate");
	    if(WorkDate!=null&&!("".equalsIgnoreCase(WorkDate))){
	        String[] WorkDateList =WorkDate.split("T");
	  	    model.addAttribute("WorkDate", WorkDateList[0]);
	    }
	  
	    //状态变更日期
	    String HrStatusDate= (String) list.get("HrStatusDate");
	    if(HrStatusDate!=null&&!("".equalsIgnoreCase(HrStatusDate))){
	    	String[] HrStatusDateList =HrStatusDate.split("T");
	  	    model.addAttribute("HrStatusDate", HrStatusDateList[0]);
	    }    
		//医疗费用支付方式处理
	    Integer PaymentWaystring =  (Integer) list.get("PaymentWaystring");		 
		if(PaymentWaystring!=null){
			 model.addAttribute("PaymentWaystring", NumberUtils.bitand(PaymentWaystring));
		}
	   
	    //药物过敏处理 
		Integer DrugAllergyHistory =  (Integer) list.get("DrugAllergyHistory");		 		
		if(DrugAllergyHistory!=null){
			model.addAttribute("DrugAllergyHistory", NumberUtils.bitand(DrugAllergyHistory));
		}
		
		//档案信息卡
		String DrugAllergyHistorystr = NumberUtils.bitand(DrugAllergyHistory);
		String[] DrugAllergyHistoryList =DrugAllergyHistorystr.split(",");
		StringBuffer dah = new StringBuffer();
		for(int i=0;i<DrugAllergyHistoryList.length;i++){
			String dString =DrugAllergyHistoryList[i];
			if("1".equalsIgnoreCase(dString)){
				dah.append("无");
			}else if("2".equalsIgnoreCase(dString)){
				dah.append("青霉素,");
			}else if("4".equalsIgnoreCase(dString)){
				dah.append("磺胺,");
			}else if("8".equalsIgnoreCase(dString)){
				dah.append("链霉素,");
			}  
		}
		//其它过敏史
		String OtherDrugAllergyHistory =(String) list.get("OtherDrugAllergyHistory");
		if(OtherDrugAllergyHistory!=null&&OtherDrugAllergyHistory!=""){
			dah.append(OtherDrugAllergyHistory);
		}
		model.addAttribute("DrugAllergyHistorystr", dah);
		//暴露史处理
		Integer ExposureHistory =  (Integer) list.get("ExposureHistory");	
		if(ExposureHistory!=0){
			model.addAttribute("ExposureHistory",NumberUtils.bitand(ExposureHistory));	
		}
		//家族史
		List<Map<String, Object> > FamilyHistoryList=(List<Map<String, Object> > )list.get("FamilyHistory");
		if(FamilyHistoryList.size()>0){
			for(int i=0;i<FamilyHistoryList.size();i++){
				Integer key =(Integer) FamilyHistoryList.get(i).get("RelationshipType");
				Integer Disease =  (Integer) FamilyHistoryList.get(i).get("Disease");
				if(1==key){ 
					model.addAttribute("fillness",NumberUtils.bitand(Disease));	
				}else if(2==key){		 
					model.addAttribute("millness",NumberUtils.bitand(Disease));	
				}else if(3==key){		 
					model.addAttribute("billness",NumberUtils.bitand(Disease));	
				}else if(4==key){	
					model.addAttribute("sillness",NumberUtils.bitand(Disease));	
				}
			}
		}
		//疾病处理
		List<Map<String, Object> > CmDataList=(List<Map<String, Object> > )list.get("CmData");
		model.addAttribute("CmDataList", JsonUtils.getJsonFormat(CmDataList));
		//手术,外伤,输血处理
		List<Map<String, Object> > flist=(List<Map<String, Object> > )list.get("HealthHistory");
		model.addAttribute("flist", JsonUtils.getJsonFormat(flist));
	    //残疾情况处理
		Integer Disability =  (Integer) list.get("Disability");		 
		if(Disability!=0){
			model.addAttribute("Disability", NumberUtils.bitand(Disability));
		}
		model.addAttribute("OtherDisability", (String)list.get("OtherDisability"));
		model.addAttribute("DisabilityNumber", (String)list.get("DisabilityNumber"));
		model.addAttribute("data", list);
		model.addAttribute("dataJson", JsonUtils.getJson(list));
		//model.addAttribute("ProductCode", PropertiesUtils.getValue("produce_code"));
		model.addAttribute("ProductCode", vo.getProductCode());
		//查询出疾病既往史
		StringBuffer buffer = new StringBuffer();
		List<Map<String, Object>> personDiseaseList = (List<Map<String, Object>>) list.get("CmData");
		for (Map<String, Object> personDiseaseMap : personDiseaseList) {
			String diseaseId = (String) personDiseaseMap.get("DiseaseKindID");
			DiseaseDictionaryEntity diseaseEntity = diseaseService.getDictionaryById(diseaseId.replace("-", "").toUpperCase());
			buffer.append(diseaseEntity.getDiseaseName() + "、");
		}
		String ill="";
		if(buffer.length()>0){
			ill=buffer.substring(0, buffer.length()-1);
		}
		model.addAttribute("cmData", ill);
		model.addAttribute("personId", personId);
 
		
		return "/healthAdmin/myresidents/docmentInfo";
	}
	
	/**
	 * 查看尚未加入此标签的签约人员
	 * @param teamId
	 * @param labelId
	 * @param personName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 *
	 */
	@RequestMapping(value = "/getPersonNotInLabel", method = RequestMethod.GET)
	@ResponseBody
	public String getPersonNotInLabel(HttpServletRequest req,@RequestParam Integer labelId,@RequestParam String personName,
			@RequestParam Integer pageIndex,@RequestParam Integer pageSize){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		//封装参数
		DiseaseLabelVo vo = new DiseaseLabelVo();
		vo.setDocTeamId(doctorInfo.getTeamId());
		vo.setPersonName(personName);
		vo.setId(labelId);
		//获取总数
		Integer personNotInLabelCount = diseaseLabelService.getPersonNotInLabelCount(vo);
		//封装分页参数
		Page<DiseaseLabelVo> page = new Page<DiseaseLabelVo>(pageIndex, pageSize);
		vo.setPage(page);
		//查询返回结果
		List<PersonInformationVo> personNotInLabel = diseaseLabelService.getPersonNotInLabel(vo);
		return JsonUtils.getJson(BaseJsonVo.pageList(personNotInLabel, personNotInLabelCount),BusinessConstants.JSON_ALL);

	}
	/**
	 * 删除标签和人的对应关系
	 * @param paramBody
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/changeSelectStatus", method = RequestMethod.POST)
	public String changeSelectStatus(@RequestParam String labelId,@RequestParam String personId){
		DiseaseLabelPersonRelationEntity entity = new DiseaseLabelPersonRelationEntity();
		entity.setLabelId(Integer.valueOf(labelId));
		entity.setPersonId(personId);
		List<DiseaseLabelPersonRelationEntity> relation = diseaseLabelService.getRelation(entity);
		if (relation.size() > 0) {
			diseaseLabelService.deleteRelation(entity);
		}else {
			diseaseLabelService.addRelation(entity);
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	

	/**
	 *跳转到最近7次血压记录页面（工作站）
	 * @param personId
	 * @return
	 *
	 */
	@RequestMapping(value = "/getHypertensionList", method = RequestMethod.GET)
	public String getHypertensionList(Model model, @RequestParam String personId ) {
		model.addAttribute("personId", personId);
		return "/healthAdmin/myresidents/hypertensionList";
	}
	

	/**
	 *跳转到最近7次血糖记录页面（工作站）
	 * @param personId
	 * @return
	 *
	 */
	@RequestMapping(value = "/getBloodList", method = RequestMethod.GET)
	public String getBloodList(Model model, @RequestParam String personId ) {
		model.addAttribute("personId", personId);
		return "/healthAdmin/myresidents/BloodSugerList";
	}
	/**
	 * 按时间点查询最近7次血压记录（工作站）
	 * @param qrtime 查询时间点 毫秒时间戳
	 * @param personId
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/getHypertensionListByTime", method = RequestMethod.GET)
	public String getHypertensionListByTime(HttpServletRequest req,@RequestParam Long qrtime, @RequestParam String personId ) {
		String productCode = null;
		String regionCode = null;
		String PersonName = null;
		String PersonCode = null;
	    PersonInformationEntity pentity=personService.getPersonInformationByPesronId(personId);
	    DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
	    productCode = doctorInfo.getProductCode();
		if (pentity!=null) {
			//userName为空，为居民端调用
			PersonName=pentity.getPersonName();
			regionCode=pentity.getRegionCode();
			PersonCode=pentity.getPersonCode();
			}else{
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.RE_NO_ORDER.getKey(), ApiStatusEnum.RE_NO_ORDER.getValue()));
			}
	   if(regionCode==null){
			//医生端调用，获取该医生的regionCode
			regionCode=doctorInfo.getRegionCode();
	   
		}
		// 查询本地库，获取血压记录总数
		List<HypertensionRecordEntity> recordList = hyperService.getRecordList(personId);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for (HypertensionRecordEntity entity : recordList) {
			Map<String, Object> itemMap = new HashMap<String, Object>();
			//放入传入日期之前的记录
			System.out.println(qrtime);
				if(entity.getMeasuringTime().getTime()<=qrtime){
				itemMap.put("timeStamp", entity.getMeasuringTime().getTime());
				itemMap.put("systolicPressure",entity.getSystolicPressure());
				itemMap.put("diastolicPressure", entity.getDiastolicPressure());
				list.add(itemMap);
				}
		}
		
		// 调用接口，获取公卫血压数据
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ProductCode",productCode);
		//区划 获取
		map.put("RegionCode", regionCode);
		map.put("KeyValueType", 2);
		map.put("KeyValue", PersonCode);
		map.put("StartFollowupDate", "2000-01-01");
		map.put("EndFollowupDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date(qrtime)));
		map.put("PageSize", 37);	//调取前7条记录
		map.put("PageIndex", 0);
		String returnData = RestfulUtils.getPublicData("58-6", map);
		System.out.println(JsonUtils.getJson(JsonUtils.getObjectJsonMap(returnData)));
		if (JsonUtils.getObjectJsonMap(returnData).get("Total")!= null&&(Integer) JsonUtils.getObjectJsonMap(returnData).get("Total")>0 ) {
			List<Map<String, Object>> hyperList = (List<Map<String, Object>>) JsonUtils.getObjectJsonMap(returnData).get("Msg");
			for (Map<String, Object> hyperMap : hyperList) {
				if (hyperMap.get("Sbp") != null && hyperMap.get("Dbp") != null) {
					String followUpDateStr = (String)hyperMap.get("FollowUpDateStr");
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("timeStamp", DateUtils.parseDate(followUpDateStr).getTime());
					itemMap.put("systolicPressure",hyperMap.get("Sbp"));
					itemMap.put("diastolicPressure", hyperMap.get("Dbp"));
					list.add(itemMap);
				}
			}
		}
		//把获取到的集合按照时间排序，并取最近7条
		AbnormalSignDateComparator comparator = new AbnormalSignDateComparator();
		Collections.sort(list,comparator);
		times.put("fws-qrtime-hyp", qrtime);
		if (list.size() > 7) {
			return JsonUtils.getJson(BaseJsonVo.pageList(list.subList(0, 7), list.subList(0, 7).size()),BusinessConstants.JSON_ALL);
		}else {
			return JsonUtils.getJson(BaseJsonVo.pageList(list, list.size()),BusinessConstants.JSON_ALL);
		}
	}
	/**
	 * 按时间点查询最近7次血糖记录
	 * @param personId
	 * @param qrtime 查询时间戳 毫秒
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/getBloodSugerListByTime", method = RequestMethod.GET)
	public String getBloodSugerListByTime(HttpServletRequest req, @RequestParam String personId,@RequestParam Long qrtime) {
			String productCode = null;
	    DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");

		if (StringUtils.isEmpty(doctorInfo.getUserName())) {
			//userName为空，为居民端调用
			List<DoctorDetailVo> list =signService.getSignDoctorTeamInfo(personId);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
					String value =list.get(i).getProductCode();
					if(value!=null&&!("".equals(value))){
						productCode =value;
					}
				}
			}else{
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.RE_NO_ORDER.getKey(), ApiStatusEnum.RE_NO_ORDER.getValue()));
			}
		}else {
			//医生端调用，获取该医生的productCode
			DoctorDetailVo docUser = docUserService.getDoctorByUsername(doctorInfo.getUserName());
			productCode = docUser.getProductCode();
		}
		// 查询本地库，获取血糖记录列表
		List<BloodSugerRecordEntity> recordList = bloodSugerService.getRecordList(personId);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for (BloodSugerRecordEntity entity : recordList) {
			if(entity.getMeasuringTime().getTime()<=qrtime){
			Map<String, Object> itemMap = new HashMap<String, Object>();
			itemMap.put("timeStamp", entity.getMeasuringTime().getTime());
			itemMap.put("bloodSuger",entity.getBloodSuger());
			list.add(itemMap);
			}
		}
		
		// 调用接口，获取公卫血糖数据
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ProductCode",productCode);
		
		map.put("PersonID", personId);
		map.put("StartTime", "2000-01-01");	//调取前100条记录
		map.put("EndTime", new SimpleDateFormat("yyyy-MM-dd").format(new Date(qrtime)));
		
		String returnData = RestfulUtils.getPublicData("59-6", map);
		
		if (JsonUtils.getObjectJsonMap(returnData).get("Count")!= null && Integer.valueOf((String)JsonUtils.getObjectJsonMap(returnData).get("Count")) > 0) {
			List<Map<String, Object>> rawList = (List<Map<String, Object>>) JsonUtils.getObjectJsonMap(returnData).get("Msg");
			for (Map<String, Object> rawMap : rawList) {
				if (rawMap.get("Data") != null) {
					String DateStr = (String)rawMap.get("Date");
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("timeStamp", DateUtils.parseDate(DateStr).getTime());
					itemMap.put("bloodSuger",rawMap.get("Data"));
					list.add(itemMap);
				}
			}
		}
		//把获取到的集合按照时间排序，并取最近7条
		AbnormalSignDateComparator comparator = new AbnormalSignDateComparator();
		Collections.sort(list,comparator);
		times.put("fws-qrtime-blood", qrtime);
		if (list.size() > 7) {
			return JsonUtils.getJson(BaseJsonVo.pageList(list.subList(0, 7), list.subList(0, 7).size()),BusinessConstants.JSON_ALL);
		}else {
			return JsonUtils.getJson(BaseJsonVo.pageList(list, list.size()),BusinessConstants.JSON_ALL);
		}
	}
	
	
	/**
	 * 按时间点查询最近7次血压记录（工作站图表显示）
	 * @param qrtime 查询时间点 毫秒时间戳
	 * @param personId
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/getHypertensionListByTimeOnly", method = RequestMethod.GET)
	public String getHypertensionListByTimeOnly(HttpServletRequest req, @RequestParam String personId ) {
		Long qrtime=(Long) times.get("fws-qrtime-hyp");
		if(qrtime==null){
			qrtime=new Date().getTime();
		}
		String productCode = null;
		String regionCode = null;
		String PersonName = null;
		String PersonCode = null;
	    PersonInformationEntity pentity=personService.getPersonInformationByPesronId(personId);
	    DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
	    productCode = doctorInfo.getProductCode();
		if (pentity!=null) {
			//userName为空，为居民端调用
			PersonName=pentity.getPersonName();
			regionCode=pentity.getRegionCode();
			PersonCode=pentity.getPersonCode();
			}else{
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.RE_NO_ORDER.getKey(), ApiStatusEnum.RE_NO_ORDER.getValue()));
			}
	   if(regionCode==null){
			//医生端调用，获取该医生的regionCode
			regionCode=doctorInfo.getRegionCode();
	   
		}
		// 查询本地库，获取血压记录总数
		List<HypertensionRecordEntity> recordList = hyperService.getRecordList(personId);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for (HypertensionRecordEntity entity : recordList) {
			Map<String, Object> itemMap = new HashMap<String, Object>();
			//放入传入日期之前的记录
				if(entity.getMeasuringTime().getTime()<=qrtime){
				itemMap.put("timeStamp", entity.getMeasuringTime().getTime());
				itemMap.put("systolicPressure",entity.getSystolicPressure());
				itemMap.put("diastolicPressure", entity.getDiastolicPressure());
				list.add(itemMap);
				}
		}
		
		// 调用接口，获取公卫血压数据
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ProductCode",productCode);
		//区划 获取
		map.put("RegionCode", regionCode);
		map.put("KeyValueType", 2);
		map.put("KeyValue", PersonCode);
		map.put("StartFollowupDate", "2000-01-01");
		map.put("EndFollowupDate",new SimpleDateFormat("yyyy-MM-dd").format(new Date(qrtime)));
		map.put("PageSize", 37);	//调取前7条记录
		map.put("PageIndex", 0);
		String returnData = RestfulUtils.getPublicData("58-6", map);
		System.out.println(JsonUtils.getJson(JsonUtils.getObjectJsonMap(returnData)));
		if (JsonUtils.getObjectJsonMap(returnData).get("Total")!= null&&(Integer) JsonUtils.getObjectJsonMap(returnData).get("Total")>0 ) {
			List<Map<String, Object>> hyperList = (List<Map<String, Object>>) JsonUtils.getObjectJsonMap(returnData).get("Msg");
			for (Map<String, Object> hyperMap : hyperList) {
				if (hyperMap.get("Sbp") != null && hyperMap.get("Dbp") != null) {
					String followUpDateStr = (String)hyperMap.get("FollowUpDateStr");
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("timeStamp", DateUtils.parseDate(followUpDateStr).getTime());
					itemMap.put("systolicPressure",hyperMap.get("Sbp"));
					itemMap.put("diastolicPressure", hyperMap.get("Dbp"));
					list.add(itemMap);
				}
			}
		}
		//把获取到的集合按照时间排序，并取最近7条
		AbnormalSignDateComparator comparator = new AbnormalSignDateComparator();
		Collections.sort(list,comparator);
		List<Object>  sbplist=new ArrayList<Object>();
		List<Object>  dbplist=new ArrayList<Object>();
		if (list.size() > 7) {
			list=list.subList(0, 7);
			for (Map<String, Object> dmap : list) {
				sbplist.add((Object) dmap.get("systolicPressure"));
				dbplist.add((Object) dmap.get("diastolicPressure"));
			}
			Map result=new  HashMap<>();
			result.put("Sbp", sbplist);
			result.put("Dbp", dbplist);
			return JsonUtils.getJson(result);
		}else {
			for (Map<String, Object> dmap : list) {
				sbplist.add((Object) dmap.get("systolicPressure"));
				dbplist.add((Object) dmap.get("diastolicPressure"));
			}
			Map result=new  HashMap<>();
			result.put("Sbp", sbplist);
			result.put("Dbp", dbplist);
			return JsonUtils.getJson(result);
		}
	}
	
	
	/**
	 * 血糖部分
	 * 血糖总共记录数、正常数、偏低偏高数
	 */
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/getBloodSugerNum", method = RequestMethod.GET)
	public String getBloodSugerNum(HttpServletRequest req,@RequestParam String personId) {
		String productCode = null;
		 DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		if (StringUtils.isEmpty(doctorInfo.getUserName())) {
			//userName为空，为居民端调用
			List<DoctorDetailVo> list =signService.getSignDoctorTeamInfo(personId);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
					String value =list.get(i).getProductCode();
					if(value!=null&&!("".equals(value))){
						productCode =value;
					}
				}
			}else{
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.RE_NO_ORDER.getKey(), ApiStatusEnum.RE_NO_ORDER.getValue()));
			}
		}else {
			//医生端调用，获取该医生的productCode
			DoctorDetailVo docUser = docUserService.getDoctorByUsername(doctorInfo.getUserName());
			productCode = docUser.getProductCode();
		}
		// 查询本地库，获取血糖记录总数
		Map<String, Integer> recordCount = bloodSugerService.getRecordCount(personId);
		Integer allCount = recordCount.get("allCount");
		Integer lowCount = recordCount.get("lowCount");
		Integer normalCount = recordCount.get("normalCount");
		Integer highCount = recordCount.get("highCount");
		
		// 调用接口，获取公卫血糖数据
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("ProductCode", PropertiesUtils.getValue("produce_code"));//TODO：未完成注册产品之前先用写死的produceCode
		//DoctorDetailVo doc = docUserService.getDoctorByUsername(userName);
		map.put("ProductCode",productCode);
		
		map.put("PersonID", personId);
		map.put("StartTime", "2000-01-01");	//调取前100条记录
		map.put("EndTime", DateUtils.formatDate(new Date()));
		
		String returnData = RestfulUtils.getPublicData("59-6", map);
		if (JsonUtils.getObjectJsonMap(returnData).get("Count")!= null && Integer.valueOf((String)JsonUtils.getObjectJsonMap(returnData).get("Count")) > 0) {
			List<Map<String, Object>> rawList = (List<Map<String, Object>>) JsonUtils.getObjectJsonMap(returnData).get("Msg");
			for (Map<String, Object> rawMap : rawList) {
				if (rawMap.get("Data") != null) {
					Double bloodSugerValue = Double.valueOf((String) rawMap.get("Data"));
					if (bloodSugerValue < 3.9) {
						lowCount ++;
					}else if (3.9 <= bloodSugerValue && bloodSugerValue < 7.0) {
						normalCount ++;
					}else {
						highCount ++;
					}
					allCount ++;
				}
			}
		}
		recordCount.clear();
		recordCount.put("allCount", allCount);
		recordCount.put("low", lowCount);
		recordCount.put("nor", normalCount);
		recordCount.put("high", highCount);
		
		return JsonUtils.getJson(recordCount);
	}
	
	
	/**
	 * 按时间点查询最近7次血糖记录（图表显示）
	 * @param personId
	 * @param qrtime 查询时间戳 毫秒
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/getBloodSugerListByTimeOnly", method = RequestMethod.GET)
	public String getBloodSugerListByTimeonly(HttpServletRequest req, @RequestParam String personId) {
		String productCode = null;
		Long qrtime=(Long) times.get("fws-qrtime-blood");
		if(qrtime==null){
			qrtime=new Date().getTime();
		}
	    DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");

		if (StringUtils.isEmpty(doctorInfo.getUserName())) {
			//userName为空，为居民端调用
			List<DoctorDetailVo> list =signService.getSignDoctorTeamInfo(personId);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
					String value =list.get(i).getProductCode();
					if(value!=null&&!("".equals(value))){
						productCode =value;
					}
				}
			}else{
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.RE_NO_ORDER.getKey(), ApiStatusEnum.RE_NO_ORDER.getValue()));
			}
		}else {
			//医生端调用，获取该医生的productCode
			DoctorDetailVo docUser = docUserService.getDoctorByUsername(doctorInfo.getUserName());
			productCode = docUser.getProductCode();
		}
		// 查询本地库，获取血糖记录列表
		List<BloodSugerRecordEntity> recordList = bloodSugerService.getRecordList(personId);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for (BloodSugerRecordEntity entity : recordList) {
			if(entity.getMeasuringTime().getTime()<=qrtime){
			Map<String, Object> itemMap = new HashMap<String, Object>();
			itemMap.put("timeStamp", entity.getMeasuringTime().getTime());
			itemMap.put("bloodSuger",entity.getBloodSuger());
			list.add(itemMap);
			}
		}
		
		// 调用接口，获取公卫血糖数据
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ProductCode",productCode);
		
		map.put("PersonID", personId);
		map.put("StartTime", "2000-01-01");	//调取前100条记录
		map.put("EndTime", new SimpleDateFormat("yyyy-MM-dd").format(new Date(qrtime)));
		
		String returnData = RestfulUtils.getPublicData("59-6", map);
		
		if (JsonUtils.getObjectJsonMap(returnData).get("Count")!= null && Integer.valueOf((String)JsonUtils.getObjectJsonMap(returnData).get("Count")) > 0) {
			List<Map<String, Object>> rawList = (List<Map<String, Object>>) JsonUtils.getObjectJsonMap(returnData).get("Msg");
			for (Map<String, Object> rawMap : rawList) {
				if (rawMap.get("Data") != null) {
					String DateStr = (String)rawMap.get("Date");
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("timeStamp", DateUtils.parseDate(DateStr).getTime());
					itemMap.put("bloodSuger",rawMap.get("Data"));
					list.add(itemMap);
				}
			}
		}
		//把获取到的集合按照时间排序，并取最近7条
		AbnormalSignDateComparator comparator = new AbnormalSignDateComparator();
		Collections.sort(list,comparator);
		List<Object>  bs=new ArrayList<Object>();
		if (list.size() > 7) {
			list=list.subList(0, 7);
			for (Map<String, Object> bloodsuger : list) {
				System.out.println(bloodsuger.get("bloodSuger"));
				bs.add((Object) bloodsuger.get("bloodSuger"));
			}
			
			return JsonUtils.getJson(bs);
		}else {
			for (Map<String, Object> bloodsuger : list) {
				bs.add((Object) bloodsuger.get("bloodSuger"));
			}
			return JsonUtils.getJson(bs);
		}
	}
	
	//服务包ID获取详情
	@ResponseBody
	@RequestMapping(value="/getServicePackDetail",method=RequestMethod.GET)
	public String  getServicePackDetail(Integer packId){
		List<ServicepackDetailsVo> list =sigServicepackService.getDetailsByPackId(packId) ;
		return JsonUtils.getJson(BaseJsonVo.pageList(list, list.size()),BusinessConstants.JSON_ALL);
		
	}
	  
	   /**
	    * 获取居民个人高血压随访列表
	    * @param pageSize
	    * @param pageIndex
	    * @param personId
	    * @return
	    *
	    */
	    @ResponseBody
	    @RequestMapping(value = "/getHypertensionListByPersonId", method = RequestMethod.GET)
	    public String getHypertensionListByPersonId(@RequestParam Integer pageSize, @RequestParam Integer pageIndex,
          @RequestParam String personId) {
	    	List<DoctorDetailVo>  list=signService.getSignDoctorTeamInfo(personId);
	    	String productCode = null;
	    	if(list.size()>0){
				for(int i=0;i<list.size();i++){
					String value =list.get(i).getProductCode();
					if(StringUtils.isNotEmpty(value)){
						productCode = value;
					}
				}
			}else{
				return JsonUtils.getJson(BaseJsonVo.pageList(null, null),BusinessConstants.JSON_ALL);
			}
	    	
	        // 封装查询参数，调用卫计委接口
	        Map<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("ProductCode", productCode);

	        paramMap.put("PersonID", personId);
	        paramMap.put("PageIndex", pageIndex - 1);
	        paramMap.put("PageSize", pageSize);
	        String diabetesListData = RestfulUtils.getPublicData("58-1", paramMap);
	        System.out.println("++++"+diabetesListData);
	        // 解析Json，封装返回参数
	        Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(diabetesListData);
	        if ((Integer) jsonMap.get("Result") == 0) {
	            // 返回result为0，提示内容
	        	 return JsonUtils.getJson(BaseJsonVo.pageList(null, null),BusinessConstants.JSON_ALL);
	        } else {
	            List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
	            Integer count = Integer.valueOf((String) jsonMap.get("Total"));
	            List<Map<String, Object>> dataList = (List<Map<String, Object>>) jsonMap
	                    .get("Msg");
	           //返回部分信息
	            for (Map<String, Object> map : dataList) {
	            	Map<String, Object> returnMap = new HashMap<String, Object>();
	            	//处理随访日期
	                if (map.get("FollowUpDate") != null && StringUtils.isNotEmpty((String)map.get("FollowUpDate"))) {
	                    String dateNum = StringUtils.getStringNum((String)map.get("FollowUpDate"));
	                    Long timeStamp = Long.parseLong(dateNum);
	                    if (StringUtils.isNotEmpty(dateNum)) {
	                    	returnMap.put("FollowUpDateStr", DateUtils.formatDate(new Date(timeStamp)));
	                    }
	                }         
					returnMap.put("hypertensionId", map.get("ID"));
					returnMap.put("personId", map.get("PersonID"));		 
					returnMap.put("personName", map.get("PersonName"));
					returnMap.put("sbp", map.get("Sbp"));
					returnMap.put("dbp", map.get("Dbp"));
					String bbb=String.valueOf(map.get("Sbp"))+"/"+String.valueOf(map.get("Dbp"));
					returnMap.put("dsds", bbb);
					returnMap.put("doctorName", map.get("DoctorName"));
					returnMap.put("followUpDate", map.get("FollowUpDateStr"));
					returnList.add(returnMap);
	 
				}
	            return JsonUtils.getJson(BaseJsonVo.pageList(returnList, returnList.size()),BusinessConstants.JSON_ALL);
	        }
	    
	    }
	    
	    
	   /**
	    * 获取居民个人糖尿病随访列表
	    * @param pageSize
	    * @param pageNo
	    * @param personId
	    * @return
	    *
	    */
	    @RequestMapping(value = "/getDiabetesListByPersonId", method = RequestMethod.GET)
	    public String getDiabetesListByPersonId(
	                                         @RequestParam Integer pageSize, @RequestParam Integer pageIndex,
	                                         @RequestParam String personId) {
	    	List<DoctorDetailVo>  list=signService.getSignDoctorTeamInfo(personId);
	    	String productCode=null;
	    	if(list!=null&&list.size()>0){
	    		for(int i=0;i<list.size();i++){
					String value =list.get(i).getProductCode();
					if(StringUtils.isNotEmpty(value)){
						productCode = value;
					}
				}
			}else{
				 return JsonUtils.getJson(BaseJsonVo.empty(
	                     ApiStatusEnum.RE_NO_ORDER.getKey(),
	                     ApiStatusEnum.RE_NO_ORDER.getValue()));
			}
	    	
	        // 封装查询参数，调用卫计委接口
	        Map<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("ProductCode", productCode);

	        paramMap.put("PersonID", personId);
	        paramMap.put("PageIndex", pageIndex - 1);
	        paramMap.put("PageSize", pageSize);
	        String diabetesListData = RestfulUtils.getPublicData("59-1", paramMap);
	        // 解析Json，封装返回参数
	        Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(diabetesListData);
	        if ((Integer) jsonMap.get("Result") == 0) {
	            // 返回result为0，提示内容
	            return JsonUtils.getJson(BaseJsonVo.empty(
	                    ApiStatusEnum.FAIL.getKey(), (String) jsonMap.get("Msg")));
	        } else {
	            List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
	            Integer count = Integer.valueOf((String) jsonMap.get("Total"));
	            List<Map<String, Object>> dataList = (List<Map<String, Object>>) jsonMap
	                    .get("Msg");
	           //返回部分信息
	            for (Map<String, Object> map : dataList) {
	            	Map<String, Object> returnMap = new HashMap<String, Object>();
	            	//处理随访日期
	                if (map.get("FollowUpDate") != null && StringUtils.isNotEmpty((String)map.get("FollowUpDate"))) {
	                    String dateNum = StringUtils.getStringNum((String)map.get("FollowUpDate"));
	                    Long timeStamp = Long.parseLong(dateNum);
	                    if (StringUtils.isNotEmpty(dateNum)) {
	                    	returnMap.put("FollowUpDateStr", DateUtils.formatDate(new Date(timeStamp)));
	                    }
	                }
	                returnMap.put("id", map.get("ID"));
					returnMap.put("dbp", map.get("Dbp"));
					returnMap.put("sbp", map.get("Sbp"));
					String bbb=String.valueOf(map.get("Sbp"))+"/"+String.valueOf(map.get("Dbp"));
					returnMap.put("dsds", bbb);
					returnMap.put("personName", map.get("PersonName"));
					returnMap.put("doctorName", map.get("DoctorName"));
					returnMap.put("fastingBloodGlucose", map.get("FastingBloodGlucose"));
	            	returnList.add(returnMap);
				}
	            return JsonUtils.getJson(BaseJsonVo.pageList(returnList, returnList.size()),BusinessConstants.JSON_ALL);
	        }
	    
	    }
	    /**
	     * 报告列表
	     * 用户上传的所有报告信息
	     * @param personId
	     * @param request
	     * @param pageSize
	     * @param pageIndex
	     * @param zs  本周 本月 查询 1表示周  30表示月
	     * @return
	     *
	     */
	    @ResponseBody
	    @RequestMapping(value = "/getAllUserReportByDoc", method = RequestMethod.GET)
		public String getAllUserReportByDoc(@RequestParam String personId,HttpServletRequest req,String zy,String date1,String date2,Integer pageSize,Integer pageIndex) {
		    Map map=(Map)req.getSession().getAttribute("doc_session");
           Date now=new Date();
           // 获得本周一0点时间  
            Date z0=DateUtils.getTimesWeekmorning();
           // 获得本周日24点时间  
            Date z6=DateUtils.getTimesWeeknight(); 
            // 获得本月第一天0点时间  
            Date y0= DateUtils.getTimesMonthmorning();
            // 获得本月最后一天24点时间  
            Date y30= DateUtils.getTimesMonthnight();
           
			// 封装查询对象
			UserReportParamVo pvo =new UserReportParamVo();
			 if(zy.equals("1")){
				 pvo.setTime("1");
				 pvo.setBegin(z0);
				 pvo.setEnd(z6);
	            }else if("30".equals(zy)){
   				 pvo.setTime("1");
   				 pvo.setBegin(y0);
   				 pvo.setEnd(y30);
	            }else {}
			 if(StringUtils.isNotEmpty(date1)||StringUtils.isNotEmpty(date2)){
				 pvo.setTime("1");
   				 try {
   					DateUtils.parse(date2);
   					Calendar dateEnd = Calendar.getInstance();
   					dateEnd.setTime(DateUtils.parse(date2));
   					dateEnd.add(dateEnd.DATE,1);
					pvo.setBegin(DateUtils.parse(date1));
					pvo.setEnd(dateEnd.getTime());
				} catch (ParseException e) {
					e.printStackTrace();
				}
   			
			 }
	   		
			pvo.setPersonId(personId);
			pvo.setUserName((String)map.get("userName")); 
			// 封装分页对象
			Page<UserReportParamVo> page = new Page<UserReportParamVo>(pageIndex,pageSize);
			pvo.setPage(page);
			List<UserReportVo> uVo =userService.getAllUserReportByPersonId(pvo);
		    if(uVo.size()>0&&uVo!=null){
		    	for(int i=0;i<uVo.size();i++){
		    		UserReportVo vo =uVo.get(i);
		    		vo.setUptimeStr(DateUtils.formatDate(vo.getUploadTime()));
		    		String status = vo.getStatus();
		    		if("0".equals(status)){
		    			//居民本人上传的报告
		    			UserReportVo rvo = userService.getPersonNameByPersonId(vo.getPersonId());
		    		    uVo.get(i).setPersonName(rvo.getPersonName());
		    		}else if("1".equals(status)){
		    			//医生上传的报告
		    			UserReportVo rvo = userService.getDoctorNameBydoctorId(vo.getDoctorId());
		    			uVo.get(i).setDocName(rvo.getDocName());
		    		}
		    	}
		    }
            return JsonUtils.getJson(BaseJsonVo.pageList(uVo, uVo.size()),BusinessConstants.JSON_ALL);

		}
	    
	     
	    /**
	     * 报告详情
	     * @param model
	     * @param tid
	     * @param req
	     * @return
	     *
	     */
	    @RequestMapping(value = "/getDetail", method = RequestMethod.GET)
		public String getAllUserReportByDoc(Model model,@RequestParam Integer tid,HttpServletRequest req) {
	    UserReportVo  userReportVo=	userService.getUserReportByTid(tid);
	         model.addAttribute("userReportVo", userReportVo);
	         String img=userReportVo.getImg();
	         model.addAttribute("imgs", img.split(","));
	         model.addAttribute("time",  DateUtils.formatDate(userReportVo.getImgTime()));
			return "/healthAdmin/myresidents/reportDetail";
			
	    
	    }
	    /**
	     * 页面跳转  更对
	     * @param personId
	     * @param req
	     * @return
	     *
	     */
	    @RequestMapping(value = "/getMoreReport", method = RequestMethod.GET)
		public String getMoreReport(Model model,@RequestParam String personId,HttpServletRequest req) {
	          model.addAttribute("personId", personId);
			return "/healthAdmin/myresidents/reportMore";
			
	    
	    }
	    
	    /**
	     * 页面跳转 上传页面
	     * @param personId
	     * @param req
	     * @return
	     *
	     */
	    @RequestMapping(value = "/upReport", method = RequestMethod.GET)
		public String upReport(Model model,@RequestParam String personId,HttpServletRequest req) {
	          model.addAttribute("personId", personId);
			return "/healthAdmin/myresidents/upReport";
			
	    
	    }
	    
	    /**
		 * 图片上传
		 * @param img
		 * @param request
		 * @return
		 *
		 */
		@RequestMapping(value = "/uploadUserSignByDocFWS", method = RequestMethod.POST)
		@ResponseBody
		public String editorImgUpload(@RequestParam("file") CommonsMultipartFile file[],
				HttpServletRequest request) {
			/**
			 * 图片上传部分
			 */
			StringBuilder addStrc = new StringBuilder();
			try {
				if(file.length>0){
					for (int i = 0; i < file.length; i++) {
						//System.out.println(file[i].getOriginalFilename() + "------" + file[i]);
						CommonsMultipartFile img =file[i];
						if (img != null && img.getOriginalFilename() != null && StringUtils.isNotEmpty(img.getOriginalFilename())) {					
							InputStream is = img.getInputStream();
							
							byte[] bs = new byte[1024];  
					        int len;
							// 生成jpeg图片
							String headSuffix = StringUtils.getSuffix(img.getOriginalFilename()); // 获取后缀名
							String signImgHeadName = UUID.randomUUID().toString()
									.substring(0, 8)
									+ "." + headSuffix; // 重命名为8位随机数
							
							//复制文件到指定路径 
							File saveFile = new File((request.getContextPath() + "/upload/img/report/" + signImgHeadName).substring(9)); 
							FileUtils.copyInputStreamToFile(is, saveFile); 
					        //上传文件到服务器 
							FTPUtils.upload(saveFile, "/upload/img/report/");
							addStrc.append((request.getContextPath() + "/upload/img/report/"+ signImgHeadName).substring(5)).append(",");
						}
					}
				}
				addStrc.deleteCharAt(addStrc.length()-1);
				Map<String, Object> returnMap = new HashMap<String, Object>();
				returnMap.put("code", 0);
				returnMap.put("msg", "图片上传成功");
				Map<String, Object> dataMap = new HashMap<String, Object>();
				dataMap.put("src", addStrc);
				returnMap.put("data", dataMap);
				return JsonUtils.getJson(returnMap);
			} catch (Exception e) {
				e.printStackTrace();
				Map<String, Object> returnMap = new HashMap<String, Object>();
				returnMap.put("code", 1);
				returnMap.put("msg", "图片上传失败");
				return JsonUtils.getJson(returnMap);
			}
		}
		
		/**
		 * 上传用户报告信息
		 * @param personId
		 * @param reportDescription
		 * @param imgTime
		 * @param file
		 * @param request
		 * @return
		 *
		 */
		@ResponseBody
		@RequestMapping(value = "/uploadUserReport", method = RequestMethod.POST)
		public String uploadUserReport(@RequestParam String personId,@RequestParam String reportDescription,@RequestParam String imgTime,@RequestParam String img, HttpServletRequest req) {
			try {
			// 封装对象
			 Map map=(Map)req.getSession().getAttribute("doc_session");
			UserReportEntity entity = new UserReportEntity();	
			entity.setPersonId(personId);
			entity.setImgTime(DateUtils.parse(imgTime));
			entity.setUploadTime(new Date());
		    entity.setReportDescription(reportDescription);	
		    entity.setStatus("1");//医生上传
		    StringBuilder addStrc = new StringBuilder();
		   	/*
			 * 1.根据uid查询出此人对应的上传图片记录
			 * 2.有,就添加此人的上传图片,没有此人的记录就增加一条记录
			 * 
			 */
			//UserReportVo vo =userService.getPersonImgByUid(personId);
			//找到登录医生对应的docid
			UserReportVo rVo =userService.getDoctorIdByUsername((String)map.get("userName"));
			entity.setDoctorId(rVo.getDoctorId());
			entity.setDocTeamId(rVo.getDocTeamId());
			entity.setImg(img.substring(0,img.length()-1));
			Integer flag =userService.insertUserReportByDoc(entity);
			if(flag==0){
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.DEAL_FAIL.getKey(), ApiStatusEnum.DEAL_FAIL.getValue())); 
			}
			return JsonUtils.getJson(BaseJsonVo.success(null));
			} catch (ParseException e) {
				e.printStackTrace();
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.DEAL_FAIL.getKey(), ApiStatusEnum.DEAL_FAIL.getValue())); 
			} 
			
			
		}
			 
		

}
