package com.boco.modules.fdoc.web.fdocWorkstation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.constants.BusinessConstants;
import com.boco.common.enums.ApiStatusEnum;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.IdGen;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.PingYinUtil;
import com.boco.common.utils.PropertiesUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.model.DiseaseDictionaryEntity;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.model.SysRegionEntity;
import com.boco.modules.fdoc.service.DiseaseDictionaryService;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SysRegionService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.wordnik.swagger.annotations.ApiOperation;
/**
 * 家庭档案管理
 * 
 * @author mojun
 *
 * @date 2017年7月10日
 */
@Controller
@RequestMapping(value = "/famliy", produces = "text/json;charset=utf-8")
public class FamliyController {
	@Resource
	DocUserService docUserService;
	@Resource
	SysRegionService regionService;
	@Resource
	DiseaseDictionaryService diseaseService;
	@Resource
	PersonInformationService  personInfoService;
	
	/**
	 * 获取子级区划列表
	 * @param parentCode 父级机构代码，如果要查询第一级机构，传入空字符串
	 * @return
	 *
	 */
	@RequestMapping(value = "/getChildrenRegions", method = RequestMethod.GET)
	@ResponseBody
	public String getHealthRecordByDoctor(@RequestParam String parentCode){
		if(parentCode==null){
			parentCode="510704";
		}
		List<Map> nodeList=new ArrayList<Map>();
		
		List<SysRegionEntity> accurateChildrenRegions = regionService.getChildrenRegions(parentCode.replace(",", ""));
		for (SysRegionEntity sysRegionEntity : accurateChildrenRegions) {
			Map<String,Object> map=new HashMap<String,Object>();
			String id=	sysRegionEntity.getRegionCode();
			String pid=sysRegionEntity.getParentCode();
			String name=sysRegionEntity.getName();
			map.put("id", id);
			map.put("pid", pid);
			map.put("name", name);
			map.put("regionID", sysRegionEntity.getId());
			if(id.length()<14){
			map.put("open", true);
			map.put("isParent", true);
			}else{
				map.put("open", false);
			}
			nodeList.add(map);
			
		}
		System.out.println(JsonUtils.getJson(BaseJsonVo.success(nodeList)));
		return JsonUtils.getJson(nodeList);
	}
	
	/**
	 * 跳转到档案列表
	 * @param request
	 * @param model
	 * @return
	 *
	 */
	@RequestMapping(value = "/indexList",method = RequestMethod.GET)
	public String indexList(HttpServletRequest request, Model model){
		return "/healthAdmin/famliy/indexList";
	}
    /**
     * 跳转到新增页面 新建家庭档案
     * @param request
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/addDoc",method = RequestMethod.GET)
	public String addDoc(HttpServletRequest request, Model model){
		
		//return "/mobile/healthRecord/editFamilyInfomation";
		return "/healthAdmin/famliy/addFamilyDocment";
	}
	/**
     * 跳转到新增页面 新建居民
     * @param request
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/addPersonDocment",method = RequestMethod.GET)
	public String addPersonDocment(HttpServletRequest request, Model model,String FamilyID){
		@SuppressWarnings("unchecked")
		Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
		DoctorDetailVo docUser = docUserService.getDoctorByUsername((String)docInfo.get("userName"));
		if (docUser == null) {
			return JsonUtils.getJson(BaseJsonVo.empty(
			ApiStatusEnum.NO_SUCH_DOCTOR.getKey(),
			ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
		String productCode = docUser.getProductCode();
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("ProductCode", productCode);
		pMap.put("FamilyID", FamilyID);
		String responses = RestfulUtils.getPublicData("54-7", pMap);
		Map<String, Object> rMap = JsonUtils.getObjectJsonMap(responses);
		if ((Integer) rMap.get("Result") == 0) {
		}else{
			model.addAttribute("add", (String) rMap.get("Msg"));
			
	    }
		//查询户主
		String responsesHz = RestfulUtils.getPublicData("54-4", pMap);
		Map<String, Object> hzMap = JsonUtils.getObjectJsonMap(responses);
		String MasterName=null;
		 System.out.println(JsonUtils.getJsonFormat(hzMap));
		if ((Integer) hzMap.get("Result") != 0) {
			 Map<String, Object> msgMap=   (Map<String, Object>) hzMap.get("Msg");
			 if(msgMap!=null){
				 MasterName=(String) msgMap.get("MasterName");
				 model.addAttribute("MasterName", MasterName);
			 }
			
		 }
		
		 if(StringUtils.isEmpty(MasterName)){
			//本地数据库查询
			 if(StringUtils.isNotEmpty(FamilyID)){
				int masterFlag= personInfoService.getMasterFlag(FamilyID);
				if(masterFlag>0){
					 model.addAttribute("MasterName", "1");
				}
			 }
			 
		 }
		
		model.addAttribute("isNewPerson", 1);
		model.addAttribute("FamilyID", FamilyID);
		return "/healthAdmin/famliy/healthRecord/addPeopleInformation";
	}
	/**
	 * 列表查询家庭档案列表
	 * @param request
	 * @param model
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/queryList",method = RequestMethod.GET)
	public String queryList(HttpServletRequest request, String  IsEmpty, String  masterName,String  familyCode,@RequestParam Integer pageSize, @RequestParam Integer pageIndex){
		//从session获取登录医生
		Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
		DoctorDetailVo docUser = docUserService.getDoctorByUsername((String)docInfo.get("userName"));
		if (docUser == null) {
			return JsonUtils.getJson(BaseJsonVo.empty(
			ApiStatusEnum.NO_SUCH_DOCTOR.getKey(),
			ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
		String productCode = docUser.getProductCode();
		Map<String, Object> paramMap=new HashMap<String,Object>();
		paramMap.put("ProductCode", productCode); 
		//paramMap.put("RegionCode", docUser.getRegionCode());
		paramMap.put("RegionCode", PropertiesUtils.getValue("top_region"));
		if(StringUtils.isNotEmpty(masterName)){
			paramMap.put("MasterName", masterName);
		}
		if(StringUtils.isNotEmpty(IsEmpty)){
			paramMap.put("IsEmpty", 1);
		}
		
		paramMap.put("FamilyCode", familyCode);
		paramMap.put("PageSize", pageSize);
		paramMap.put("PageIndex", pageIndex-1);
		String returnData=RestfulUtils.getPublicData("54-5", paramMap);
		//解析返回JSON
		Map<String, Object> returnMap = JsonUtils.getObjectJsonMap(returnData);
		if ((Integer) returnMap.get("Result") == 0) {
			// 返回result为0，提示内容
			return JsonUtils.getJson(BaseJsonVo.empty(
					ApiStatusEnum.FAIL.getKey(), (String) returnMap.get("Msg")));
		} 
		List<Map<String, Object>> list=(List<Map<String, Object>>) returnMap.get("Msg");
		System.out.println(JsonUtils.getJson(list));
		Integer total=(Integer) returnMap.get("Total");
		//再次查询
		return JsonUtils.getJson(BaseJsonVo.pageList(list, total),BusinessConstants.JSON_ALL);
		
	}
	    /**
	     * 家庭地址区划
	     * @param parentCode 父级机构代码，如果要查询第一级机构，传入空字符串
	     * @return
	     *
	     */
		@RequestMapping(value = "/getRegionTreeDataByZtree",method = RequestMethod.GET)
		@ResponseBody
		public String getRegionTreeDataByZtree(@RequestParam String parentCode){
			
			List<SysRegionEntity> accurateChildrenRegions = regionService.getAllParentRegion(parentCode, new ArrayList<SysRegionEntity>(), 9);
			return JsonUtils.getJson(BaseJsonVo.success(accurateChildrenRegions));
		}
		/**
		 * 新增家庭档案
		 * @param paramBody
		 * @return
		 *
		 */
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping(value = "/addFamilyRecord", method = RequestMethod.POST)
		public String addFamilyRecord(HttpServletRequest request,@RequestBody String paramBody){
			//准备参数map，以及famlilyList，由于业务需要，familyList每次只装一个
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<Map<String, Object>> familyList = new ArrayList<>();
			
			//声明每一个famliyList中的map
			Map<String, Object> itemMap = new HashMap<String, Object>();
			
			//json字符串转化为map
			Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(paramBody);
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			// 医生端调用，获取该医生的productCode
	        DoctorDetailVo docDetail = docUserService.getDoctorByUsername((String)docInfo.get("userName"));
	        if (docDetail == null) {
	        	return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_SUCH_DOCTOR.getKey(), ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
	        String productCode = docDetail.getProductCode();
	        paramMap.put("ProductCode", productCode);
	        
	        //封装建档日期
	        itemMap.put("BuildDate", DateUtils.formatDate(new Date()));
	        itemMap.put("Lastsynctime", DateUtils.formatDate(new Date()));
	        
	        //处理接口中带ID的字段
	        itemMap.put("BuildOrgID", docDetail.getOrgId());
	        itemMap.put("BuildEmployeeID", docDetail.getId());
	        
	        itemMap.put("RegionID", jsonMap.get("regionId"));
	        jsonMap.remove("regionId");
	        
	        itemMap.put("FamilyAddress", jsonMap.get("familyAddress"));
	        itemMap.put("MemberCount", jsonMap.get("memberCount"));
	        
	        
	       // itemMap.put("MasterCardID", jsonMap.get("masterIdCard"));
	       // jsonMap.remove("masterIdCard");
	        
	        //处理剩下的：改变首字母为大写
	        for (Map.Entry<String, Object> entry : jsonMap.entrySet()) {
				// 把key首字母改为大写
	        	itemMap.put(StringUtils.captureUpName(entry.getKey()),
						entry.getValue());
			}
	        //有无冰箱 boolean值
	        if(BusinessConstants.HAVE_ICEBOX.equals(jsonMap.get("HaveIcebox"))){
	        	itemMap.put("HaveIcebox", true);
	        }else{
	        	itemMap.put("HaveIcebox",false);
	        }
	        
	        familyList.add(itemMap);
	        paramMap.put("FamilyList", familyList);
	        System.out.println(JsonUtils.getJsonFormat(itemMap));
	        String returnData = RestfulUtils.getPublicData("54-1", paramMap);
	        Map<String, Object> returnMap = JsonUtils.getObjectJsonMap(returnData);
	        
	        if ((Integer) returnMap.get("Result") == 0) {
				// 返回result为0，提示内容
				return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.FAIL.getKey(), (String) returnMap.get("Msg")));
			}else{
				//保存成功，返回familyId
				Map<String, Object> dataMap = (Map<String, Object>) returnMap.get("Msg");
				System.out.println(JsonUtils.getJson(dataMap));
				return JsonUtils.getJson(BaseJsonVo.success(dataMap));
			}
		}
		
		
		/**
		 * 编辑居民的基本信息
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/editPeopleInfomation",method=RequestMethod.GET)
		public String editPeopleInfomation(HttpServletRequest request,Model model,String ID,String FamilyId,String RegionCode){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			@SuppressWarnings("unchecked")
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			String userName= (String)docInfo.get("userName");
		   // paramMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
			DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
			paramMap.put("ProductCode",vo.getProductCode());
			if(RegionCode==null){
				paramMap.put("ID", ID);
				String response = RestfulUtils.getPublicData("55-10", paramMap);
				Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
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
			    //民族
				model.addAttribute("NationCode", String.valueOf(list.get("NationCode")));
				
			    
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
				if(PaymentWaystring!=0){
					 model.addAttribute("PaymentWaystring", NumberUtils.bitand(PaymentWaystring));
				}
			   
			    //药物过敏处理 
				Integer DrugAllergyHistory =  (Integer) list.get("DrugAllergyHistory");		 		
				if(DrugAllergyHistory!=0){
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
				model.addAttribute("data", list);
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
				//查询户主地址
				Map<String, Object> pMap = new HashMap<String, Object>();
				//pMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
				pMap.put("ProductCode", vo.getProductCode());
				pMap.put("FamilyID", FamilyId);
				String responses = RestfulUtils.getPublicData("54-7", pMap);
				Map<String, Object> rMap = JsonUtils.getObjectJsonMap(responses);
			    String add=   (String) rMap.get("Msg");
				model.addAttribute("add", add);
				return "/healthAdmin/famliy/editPeopleInformation";
			}else{
				Map<String, Object> pMap = new HashMap<String, Object>();
				pMap.put("ProductCode", vo.getProductCode());
				pMap.put("FamilyID", FamilyId);
				String responses = RestfulUtils.getPublicData("54-4", pMap);
				Map<String, Object> rMap = JsonUtils.getObjectJsonMap(responses);
				if ((Integer) rMap.get("Result") == 0) {
					return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
				 }
				Map<String, Object> msgMap=   (Map<String, Object>) rMap.get("Msg");
				model.addAttribute("RegionID", msgMap.get("RegionID"));
				model.addAttribute("isNewPerson", 1);
				model.addAttribute("RegionCode", RegionCode);
				return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
			}
		}
		
		/**
		 * 新增居民的跳转页面
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/addPeopleInfomation",method=RequestMethod.GET)
		public String addPeopleInfomationView(HttpServletRequest request,Model model,String ID,String FamilyId){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			@SuppressWarnings("unchecked")
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			String userName= (String)docInfo.get("userName");
			DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
			paramMap.put("ProductCode",vo.getProductCode());
			if(ID!=null){
				paramMap.put("ID", ID);
				String response = RestfulUtils.getPublicData("55-10", paramMap);
				Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
				 if ((Integer) responseMap.get("Result") == 0) {
						return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
				}
			    Map<String, Object>  dataMap=   (Map<String, Object>) responseMap.get("Msg");
			    model.addAttribute("RegionID", dataMap.get("RegionID"));
			    model.addAttribute("RegionCode", dataMap.get("RegionCode"));
			    model.addAttribute("isNewPerson", 1);
				model.addAttribute("ResidenceAddress", dataMap.get("ResidenceAddress"));
				model.addAttribute("CurrentAddress", dataMap.get("CurrentAddress"));
				model.addAttribute("FamilyID", FamilyId);
			    return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
			    
			}else{
				Map<String, Object> pMap = new HashMap<String, Object>();
				pMap.put("ProductCode", vo.getProductCode());
				pMap.put("FamilyID", FamilyId);
				String responses = RestfulUtils.getPublicData("54-4", pMap);
				Map<String, Object> rMap = JsonUtils.getObjectJsonMap(responses);
				if ((Integer) rMap.get("Result") == 0) {
					return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
				 }
				Map<String, Object> msgMap=   (Map<String, Object>) rMap.get("Msg");
				 model.addAttribute("RegionID", msgMap.get("RegionID"));
				 model.addAttribute("isNewPerson", 1);//新增居民
				 model.addAttribute("FamilyID", FamilyId);
				return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
			}
		}
		/**
		 * 居民档案列表
		 * @param request
		 * @param model
		 * @param pageIndex
		 * @param pageSize
		 * @param RegionCode
		 * @param IsStatus
		 * @param Gender
		 * @param KeyCode
		 * @param KeyValue
		 * @param userName
		 * @return
		 *
		 */
		@ResponseBody
		@RequestMapping(value="/index",method=RequestMethod.GET)
		public String index(HttpServletRequest request,Model model,Integer pageIndex,Integer pageSize, String  RegionCode,String IsStatus,String Gender,String KeyCode,String KeyValue){
			//获取前台额外传递过来的查询条件  
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
	        Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ProductCode",(String)docInfo.get("productCode"));
	        
	        RegionCode=PropertiesUtils.getValue("top_region");
			paramMap.put("IsStatus", IsStatus);
			paramMap.put("Gender", Gender);
			paramMap.put("KeyCode", KeyCode);
			paramMap.put("KeyValue", KeyValue);
			paramMap.put("RegionCode", RegionCode);
			paramMap.put("PageIndex", pageIndex-1);
			paramMap.put("PageSize", pageSize);
			
			String response = RestfulUtils.getPublicData("55-12", paramMap);
			Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response); 
			 if ((Integer) responseMap.get("Result") == 0) {
				 return JsonUtils.getJson(BaseJsonVo.pageList(null,0),BusinessConstants.JSON_ALL);
			 }
			List<Map<String, Object> > list=(List<Map<String, Object> > )responseMap.get("Msg");
			Map<String, Object> map = JsonUtils.getObjectJsonMap(response); 
			return JsonUtils.getJson(BaseJsonVo.pageList(list,(Integer)responseMap.get("Total")),BusinessConstants.JSON_ALL);
		}
		
		/**
		 * 居民档案跳转
		 * @param request
		 * @param model
		 * @return
		 */
		@RequestMapping(value = "/healthRecord/healthIndex", method = RequestMethod.GET)
		public String queryindex(HttpServletRequest request, Model model) {
			return  "/healthAdmin/famliy/healthRecord/healthRecordIndex";
			
		}
		
		/**
		 * 查询居民的基本信息
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/queryPeopleInfomation",method=RequestMethod.GET)
		public String queryPeopleInfomation(HttpServletRequest request,Model model, String dataJson,String ID,String FamilyId){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");

			DoctorDetailVo vo =docUserService.getDoctorByUsername((String)docInfo.get("userName"));
			paramMap.put("ProductCode",vo.getProductCode());
			
			paramMap.put("ID", ID);
			String response = RestfulUtils.getPublicData("55-10", paramMap);
			Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
			
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
		    if(StringUtils.isNotEmpty(BirthDaystr)){
		    	String[] BirthDayList =BirthDaystr.split("T");
		    	 model.addAttribute("BirthDay", BirthDayList[0]);
		    }
		    
		   
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
			}
			
		
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
			System.out.println("查询到的居民信息：——---------------------------------------------");
			System.out.println(JsonUtils.getJson(list));
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
	 
			//查询户主地址
			Map<String, Object> pMap = new HashMap<String, Object>();
			pMap.put("ProductCode", vo.getProductCode());
			pMap.put("FamilyID", FamilyId);
			String responses = RestfulUtils.getPublicData("54-7", pMap);
			Map<String, Object> rMap = JsonUtils.getObjectJsonMap(responses);
		    String add=   (String) rMap.get("Msg");
			model.addAttribute("add", add);
	 
			return "/healthAdmin/famliy/healthRecord/editPeopleInformation";
		}
		
		/**
		 * 查询家庭的基本信息
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/queryFamilyInfomation",method=RequestMethod.GET)
		public String queryFamilyInfomation(HttpServletRequest request,Model model, String dataJson,String ID,String FamilyId){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			DoctorDetailVo vo =docUserService.getDoctorByUsername((String)docInfo.get("userName"));
			paramMap.put("ProductCode", vo.getProductCode());
		    paramMap.put("FamilyID", FamilyId);
			String response = RestfulUtils.getPublicData("54-4", paramMap);
			Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
			 Map<String, Object>  list=   (Map<String, Object>) responseMap.get("Msg");
			 System.out.println(JsonUtils.getJsonFormat(list));
			model.addAttribute("data", list);
			//查询家庭成员
			Map<String, Object> pMap = new HashMap<String, Object>();
			//pMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));	     
			pMap.put("ProductCode", vo.getProductCode());	     
			pMap.put("FamilyId", FamilyId);
			String fs = RestfulUtils.getPublicData("54-3", pMap);
			Map<String, Object> fMap = JsonUtils.getObjectJsonMap(fs);
			List<Map<String, Object> > flist=(List<Map<String, Object> > )fMap.get("Msg");
			model.addAttribute("flist", JsonUtils.getJsonFormat(flist));
			model.addAttribute("ProductCode", vo.getProductCode());
	        model.addAttribute("FamilyId", FamilyId);
	        model.addAttribute("ID", ID);
	        model.addAttribute("Jiandang","jiandang");
	        if(flist.size()>0&&flist!=null){
	        model.addAttribute("CurrentAddress",flist.get(0).get("CurrentAddress"));
	        }
			return "/healthAdmin/famliy/healthRecord/editFamilyInfomation";
		}
		/**
		 * 修改家庭档案
		 */
		@ResponseBody
		@RequestMapping(value="/updateFamilyInfomation",method=RequestMethod.POST)//
		public String updateFamilyInfomation(Model model, String saveParam){ 
			Map  map=JsonUtils.getSingleJsonMap(saveParam);	
			System.out.println(JsonUtils.getJsonFormat(map));
			String response = RestfulUtils.getPublicData("54-2", map);
			Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
			if (responseMap.get("Result") == null || (Integer) responseMap.get("Result") == 0) {
				return JsonUtils.getJson(
						BaseJsonVo.empty(ApiStatusEnum.NULL_DATA_CODE.getKey(), ApiStatusEnum.NULL_DATA_CODE.getValue()));
			}
			return JsonUtils.getJson(BaseJsonVo.success(""));
		}
		
		/**
		 * 居民档案浏览
		 * @param request
		 * @param model
		 * @return
		 */
		@RequestMapping(value = "/personRecordbrowse", method = RequestMethod.GET)
		public String personRecordbrowse(HttpServletRequest request, Model model) {
			String personId= request.getParameter("personId");
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			String userName= (String)docInfo.get("userName");
		    DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
			if(personId!=null){
				Map<String, Object> paramMap = new HashMap<String, Object>();
			    paramMap.put("ProductCode", vo.getProductCode());
			    paramMap.put("ID",personId);
				String response = RestfulUtils.getPublicData("55-10", paramMap);
				Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
			    Map<String, Object>  list=   (Map<String, Object>) responseMap.get("Msg");
			    model.addAttribute("data", list);
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
			    //年龄处理
			    String BirthDay =(String) list.get("BirthDay");
			    String[] BirthDayList =BirthDay.split("T");
			    SimpleDateFormat bDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			    try {
					Date bDate=bDateFormat.parse(BirthDayList[0]);
					Date nDate = new Date();
					int year = nDate.getYear()-bDate.getYear();
					model.addAttribute("year", year);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			    //药物过敏处理 
				Integer DrugAllergyHistory =  (Integer) list.get("DrugAllergyHistory");		 		
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
				//随访处理
				Map<String, Object> followMap = new HashMap<String, Object>();
				followMap.put("ProductCode", vo.getProductCode());
				followMap.put("PersonID", personId);	 
				followMap.put("PageIndex", 0);
				followMap.put("PageSize", 10);
				String followResponse = RestfulUtils.getPublicData("58-1", followMap);
				Map<String, Object> followResponseMap = JsonUtils.getObjectJsonMap(followResponse);
			    List<Map<String, Object>>  followlist=   (List<Map<String, Object>>) followResponseMap.get("Msg");
			    model.addAttribute("followlist", JsonUtils.getJsonFormat(followlist));			 
			    model.addAttribute("ProductCode", vo.getProductCode());			 
			 }
			return "/healthAdmin/famliy/healthRecord/personRecordbrowse";

		}
		
		/**
		 * 编辑居民档案 新增居民
		 * @param model
		 * @param dataJson
		 * @return
		 * @throws Exception 
		 */
		@ResponseBody
		@RequestMapping(value="/updateResidentHealthRecord",method=RequestMethod.POST)
		public String updateResidentHealthRecord(HttpServletRequest request,Model model, String saveParam,String isSave) throws RuntimeException{
			//解析参数json
    		Map<String, Object> dataMap = JsonUtils.getObjectJsonMap(saveParam);
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
            String userName=(String)docInfo.get("userName");
	    	if(!"1".equals(isSave)){//编辑
				String response = RestfulUtils.getPublicData("55-15", dataMap);
				Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
				if ((Integer) responseMap.get("Result") == 0) {
					return JsonUtils.getJson(
							BaseJsonVo.empty(ApiStatusEnum.ERROR_CODE.getKey(),(String)responseMap.get("Msg")) );
				}
				return JsonUtils.getJson(BaseJsonVo.success(""));			 
	    	}else{//新增居民档案
	    		System.out.println("保存----------------新增");
	    		//String ID=IdGen.uuid().toUpperCase();//新增居民ID
	    		//准备调用卫计委接口参数map
	    		Map<String, Object> itemMap = new HashMap<String, Object>(); 
	    		
	    		//准备本地持久化对象
	    		PersonInformationEntity personEntity = new PersonInformationEntity();
	    		
	            
	            //医生端调用，获取该医生的productCode
	            DoctorDetailVo docDetail = docUserService.getDoctorByUsername(userName);
	            if (docDetail == null) {
	            	return JsonUtils.getJson(BaseJsonVo.empty(
	    					ApiStatusEnum.NO_SUCH_DOCTOR.getKey(), ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
	    		}
	            String productCode = docDetail.getProductCode();
	            itemMap.put("ProductCode", productCode);
	            
	            //----------------------------封装Person(居民基本档案信息)部分--------------------------------
	            Map<String, Object> personItemMap = new HashMap<String, Object>();	//准备person部分map
	            Map<String, Object> personParamMap = (Map<String, Object>) dataMap.get("Person");
	            
	            //处理含ID的字段
	            personItemMap.put("CardID", personParamMap.get("CardID"));
	            personItemMap.put("BuildOrgID", docDetail.getOrgId());
	            personItemMap.put("BuildEmployeeID", docDetail.getId());
	            personItemMap.put("PUserID", docDetail.getId());
	            personItemMap.put("ResponsibilityID", docDetail.getId());
	            personItemMap.put("FamilyID", personParamMap.get("FamilyId"));
	            
	            
	            //处理默认日期
	            String nowDateStr = DateUtils.formatDate(new Date());
	            personItemMap.put("InFamilyDate", nowDateStr);
	            personItemMap.put("InOrgDate", nowDateStr);
	            personItemMap.put("HrStatusDate", nowDateStr);
	            personItemMap.put("BuildDate", nowDateStr);
	            personItemMap.put("Updatedate", nowDateStr);
	            personItemMap.put("Lastsynctime", nowDateStr);
	            
	            //处理名字相关
	            personItemMap.put("Name", personParamMap.get("Name"));
	            personItemMap.put("NamePinyin", PingYinUtil.cn2py((String)personParamMap.get("Name")));
	            
	            //处理默认医生信息
	            personItemMap.put("ResponsibilityDoctor", docDetail.getDocName());
	            personItemMap.put("BuildEmployeeName", docDetail.getDocName());
	            personItemMap.put("HouseholderRelationship",personParamMap.get("HouseholderRelationship"));
	            
	            //批处理：首字母换为大写
	            for (Map.Entry<String, Object> entry : personParamMap.entrySet()) {
	    			// 把key首字母改为大写
	            	personItemMap.put(StringUtils.captureUpName(entry.getKey()),
	    					entry.getValue());
	    		}
	            
	            //设置id、personCode
	            String itemId = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
	            
	            personItemMap.put("ID", itemId);
	            itemMap.put("Person", personItemMap);
	            System.out.println("个人iD"+itemId);
	            //设置本地化持久对象属性
	            personEntity.setPersonId(itemId);
	            personEntity.setJwPersonId(itemId);
	            personEntity.setFamilyId((String)personItemMap.get("FamilyID"));
	            personEntity.setCustomNumber((String)personParamMap.get("CustomNumber"));
	            personEntity.setPersonName(((String)personItemMap.get("Name")));
	            personEntity.setSex(((String)personParamMap.get("GenderCode")));
	            personEntity.setDateOfBirth(DateUtils.parseDate(((String)personParamMap.get("BirthDay"))));
	            personEntity.setIdCard(((String)personItemMap.get("CardID")));
	            personEntity.setPhoneNumber(((String)personParamMap.get("PersonTel")));
	            personEntity.setCurrentAddress(((String)personParamMap.get("CurrentAddress")));
	            //判断户主
	            if (BusinessConstants.YES.equals((String)personParamMap.get("HouseholderRelationship"))) {
	            	personEntity.setMasterFlag(BusinessConstants.YES);
	    		}
	            personEntity.setUnit(((String)personParamMap.get("unit")));
	            personEntity.setCreator(userName);
	            
	            
	            //----------------------------封装FamilyHistoryList(家庭既往史)部分--------------------------------
	            List<Map<String, Object>> familyHistoryItemList = new ArrayList<Map<String,Object>>();	//准备目标list
	            List<Map<String, Object>> familyHistoryParamList = (List<Map<String, Object>>) dataMap.get("familyHistoryList");
	            if(familyHistoryParamList!=null){
		            for (Map<String, Object> familyHistoryParamMap : familyHistoryParamList) {
		            	Map<String, Object> familyHistoryItemMap = new HashMap<String, Object>();
		            	//批处理：首字母换为大写
		                for (Map.Entry<String, Object> entry : familyHistoryParamMap.entrySet()) {
		        			// 把key首字母改为大写
		                	familyHistoryItemMap.put(StringUtils.captureUpName(entry.getKey()),
		        					entry.getValue());
		        		}
		                familyHistoryItemList.add(familyHistoryItemMap);
		    		}
	            }
	            itemMap.put("FamilyHistoryList", familyHistoryItemList);
	            
	            //----------------------------封装PersonHistoryList(个人既往史)部分--------------------------------
	            List<Map<String, Object>> personHistoryItemList = new ArrayList<Map<String,Object>>();	//准备目标list
	            List<Map<String, Object>> personHistoryParamList = (List<Map<String, Object>>) dataMap.get("PersonHistoryList");
	            if(personHistoryParamList!=null){
		            for (Map<String, Object> personHistoryParamMap : personHistoryParamList) {
		            	Map<String, Object> personHistoryItemMap = new HashMap<String, Object>();
		            	//批处理：首字母换为大写
		                for (Map.Entry<String, Object> entry : personHistoryParamMap.entrySet()) {
		        			// 把key首字母改为大写
		                	personHistoryItemMap.put(StringUtils.captureUpName(entry.getKey()),
		        					entry.getValue());
		        		}
		                personHistoryItemList.add(personHistoryItemMap);
		    		}
	            }
	            itemMap.put("PersonHistoryList", personHistoryItemList);
	            
	            //----------------------------封装CmDataList(个人疾病既往史)部分--------------------------------
	            List<Map<String, Object>> cmDataItemList = new ArrayList<Map<String,Object>>();	//准备目标list
	            List<Map<String, Object>> cmDataParamList = (List<Map<String, Object>>) dataMap.get("CmDataList");
	            if(cmDataParamList!=null){
		            for (Map<String, Object> cmDataParamMap : cmDataParamList) {
		            	Map<String, Object> cmDataItemMap = new HashMap<String, Object>();
		            	
		            	//处理特殊字段
		            	cmDataItemMap.put("RecordDate", nowDateStr);	//默认时间字段
		            	cmDataItemMap.put("DiseaseKindID", cmDataParamMap.get("DiseaseKindId"));	//疾病ID
		            	cmDataParamMap.remove("diseaseKindId");
		            	cmDataItemMap.put("DoctorID", docDetail.getId());	//医生ID
		            	cmDataItemMap.put("DoctorName", docDetail.getNickName());	//医生姓名
		            	cmDataItemMap.put("UserID", docDetail.getId());	//记录人ID
		            	cmDataItemMap.put("UserName", docDetail.getNickName());	//记录人姓名
		            	cmDataItemMap.put("OrgID", docDetail.getOrgId());	//机构ID
		            	
		            	//批处理：首字母换为大写
		                for (Map.Entry<String, Object> entry : cmDataParamMap.entrySet()) {
		        			// 把key首字母改为大写
		                	cmDataItemMap.put(StringUtils.captureUpName(entry.getKey()),
		        					entry.getValue());
		        		}
		                cmDataItemList.add(cmDataItemMap);
		    		}
	            }
	            itemMap.put("CmDataList", cmDataItemList);
	            //执行新增操作
	    		try {
	    			personInfoService.insertPersonInfo(personEntity, itemMap);
	    			 System.out.println("个人iD"+itemId);
	    		} catch (RuntimeException e) {
	    			return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.FAIL.getKey(), e.getMessage()));
	    		}
	    		 System.out.println("个人iD"+itemId);
	    		System.err.println(personEntity.getPersonId());
	    		return JsonUtils.getJson(BaseJsonVo.success(personEntity.getPersonId()));
	    	}
		       
	    	
		} 
		/**
		 * 删除家庭档案
		 * @param request
		 * @param ID
		 * @return
		 *
		 */
		@RequestMapping(value="/deleteFamilyDocument", method=RequestMethod.GET)
		@ResponseBody
		public String deleteFamilyDocument(HttpServletRequest request,String ID){
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			String ProductCode= (String)docInfo.get("productCode");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ProductCode", ProductCode);
			paramMap.put("ID", ID);
			String returnData = RestfulUtils.getPublicData("54-6", paramMap);
			Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(returnData);
			if ((Integer) jsonMap.get("Result")==1) {
				// 返回result为0，抛出异常，回滚新增操作
				return JsonUtils.getJson(BaseJsonVo.success(BusinessConstants.SUCCESS));
			}
			return JsonUtils.getJson(BaseJsonVo.error((String)jsonMap.get("Msg")));
			
		}
		/**
		 * 删除居民个人档案
		 * @param paramBody
		 * @return
		 *
		 */
		@ResponseBody
		@RequestMapping(value = "/deletePersonRecord", method = RequestMethod.POST)
		public String deletePersonRecord(HttpServletRequest request, String personId){
			Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
			String userName= (String)docInfo.get("userName");
			// 医生端调用，获取该医生的productCode
	        DoctorDetailVo docDetail = docUserService.getDoctorByUsername(userName);
	        if (docDetail == null) {
	        	return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_SUCH_DOCTOR.getKey(), ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
	        //验证删除权限
	        PersonInformationVo personInfo = personInfoService.getPersonDetailByPersonId(personId);
	        System.out.println("删除个人ID+personId");
	        if(personInfo==null){
	        	return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_JURISDICTION.getKey(), ApiStatusEnum.NO_JURISDICTION.getValue()));
	        }
	        if (!userName.equals(personInfo.getCreator())) {
	        	return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_JURISDICTION.getKey(), ApiStatusEnum.NO_JURISDICTION.getValue()));
			}
	        if (BusinessConstants.SIGN_STATUS_SIGNED.equals(personInfo.getIfSign())) {
	        	return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_DEL_SIGN.getKey(), ApiStatusEnum.NO_DEL_SIGN.getValue()));
			}
	        
	        //执行删除操作
			try {
				personInfoService.deletePerson(personId, docDetail.getProductCode());
			} catch (RuntimeException e) {
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.FAIL.getKey(), e.getMessage()));
			}
	        
			return JsonUtils.getJson(BaseJsonVo.success(null));
		}
	
}
