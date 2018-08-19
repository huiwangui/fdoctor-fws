package com.boco.modules.fdoc.web.fdocWorkstation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.constants.BusinessConstants;
import com.boco.common.enums.ApiStatusEnum;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.PropertiesUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.modules.fdoc.model.DiseaseDictionaryEntity;
import com.boco.modules.fdoc.service.DiseaseDictionaryService;
import com.boco.modules.fdoc.service.DocService;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SysRegionService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;

/**
 * Description
 * @author lzz
 * @date 2017年7月19日 下午5:12:43
 */
@Controller
@RequestMapping(value="/hypertension",produces = "application/json;charset=UTF-8")
public class HypertensionController2 {
	
	@Resource
	DiseaseDictionaryService diseaseService;
	@Resource
	SysRegionService sysRegionService ;
	@Resource
	PersonInformationService personInformationService;
	@Resource
	DocService docService;
	@Resource
	DocUserService docUserService;
	
	/**
	 * 首页
	 * Title HypertensionController2.java
	 * Description: 
	 * @param request
	 * @param model
	 * @return
	 * @author lzz
	 */
	@RequestMapping(value = "/toIndex", method = RequestMethod.GET)
	public String toIndex(HttpServletRequest request, Model model){
		
		String regionCode=PropertiesUtils.getValue("top_region");
		model.addAttribute("regionCode", regionCode);
		return "/hypertension/queryHypertension";
	}
	
	/**
	 * 高血压随访查询
	 * 
	 * @author h
	 */
	@ResponseBody
	@RequestMapping(value="/queryHypertensionFollowUp",method=RequestMethod.GET)
	public String queryHypertensionFollowUp(Model model, String dataJson,HttpServletRequest request,Integer pageSize,Integer pageIndex){
		String KeyValueType = request.getParameter("KeyValueType");
		String KeyValue = request.getParameter("KeyValue");
		String StartFollowupDate = request.getParameter("StartFollowupDate");
		String EndFollowupDate = request.getParameter("EndFollowupDate");
		String IsFollowup = request.getParameter("IsFollowup");
		String Perfect = request.getParameter("Perfect");
		String FollowupType = request.getParameter("FollowupType");
		String RegionCode = request.getParameter("RegionCode");
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		//获取前台额外传递过来的查询条件  
		Map<String, Object> paramMap = new HashMap<String, Object>();
       // paramMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
        paramMap.put("ProductCode", vo.getProductCode());
        if(RegionCode==null){
			RegionCode="51";
		}
    	paramMap.put("RegionCode", RegionCode);
    	paramMap.put("KeyValueType", KeyValueType); 
        paramMap.put("KeyValue",KeyValue); 
        paramMap.put("StartFollowupDate",StartFollowupDate); 
        paramMap.put("EndFollowupDate",EndFollowupDate); 
        paramMap.put("IsFollowup",IsFollowup); 
        paramMap.put("Perfect",Perfect); 
        paramMap.put("FollowupType",FollowupType); 
		paramMap.put("PageIndex", pageIndex);
		paramMap.put("PageSize", pageSize);		
 		String response = RestfulUtils.getPublicData("58-6", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);	 
		List<Map<String, Object> > list=(List<Map<String, Object> > )responseMap.get("Msg");
		//System.out.println(list);
		Integer count= (Integer) responseMap.get("Total");
		count=count-15;
		return JsonUtils.getJson(BaseJsonVo.pageList(list, count));		 
	}
	
	/**
	 * 回显某人的随访记录
	 * @param model
	 * @param dataJson
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/editFollowup",method=RequestMethod.GET)
	public String editFollowup(Model model, String dataJson,HttpServletRequest request){
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		String ID =request.getParameter("ID");
		String PersonName =request.getParameter("PersonName");
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		Map<String, Object> paramMap = new HashMap<String, Object>();
	   // paramMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
		paramMap.put("ProductCode", vo.getProductCode());
	    paramMap.put("ID", ID);
		String response = RestfulUtils.getPublicData("58-3", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response); 
		Map<String, Object>  map=( Map<String, Object>)  responseMap.get("Msg");
		Integer symptom =(Integer)(((Map<String, Object>)map.get("cmHypertension")).get("Symptom"));
		if(symptom!=null){
			model.addAttribute("symptom", NumberUtils.bitand(symptom));
		}
		String PersonID =(String)(((Map<String, Object>)map.get("cmHypertension")).get("PersonID"));
		model.addAttribute("data", map);
		//异常处理
		ArrayList<Map<String, Object>> otherList =(ArrayList<Map<String, Object>>) map.get("otherJson");
		System.out.println(JsonUtils.getJsonFormat(otherList));
		model.addAttribute("otherList",JsonUtils.getJsonFormat(otherList));
		//用药处理
		ArrayList<Map<String, Object>> drugUseList =(ArrayList<Map<String, Object>>) map.get("drugJson");
		model.addAttribute("drugUseList",JsonUtils.getJsonFormat(drugUseList));
		//查询上次随访记录
		String FollowUpDate =(String) (( Map<String, Object>)(( Map<String, Object>)  responseMap.get("Msg")).get("cmHypertension")).get("FollowUpDate");
		///Date(1487174400000)/
		FollowUpDate=FollowUpDate.replace("/Date(","").replace(")/", "");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		long t=new Long(FollowUpDate);
		Date dt = new Date(t);
		FollowUpDate =simpleDateFormat.format(dt);
		Map<String, Object> lastMap = new HashMap<String, Object>();
		//lastMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
		lastMap.put("ProductCode", vo.getProductCode());
		lastMap.put("PersonID", PersonID);
		lastMap.put("FollowUpDate", FollowUpDate);
		String lastResponse = RestfulUtils.getPublicData("58-5", lastMap);
		Map<String, Object> lastMap2 = JsonUtils.getObjectJsonMap(lastResponse); 
		Map<String, Object>  lastList=( Map<String, Object>) lastMap2.get("Msg");
		model.addAttribute("lastData", lastList);
		model.addAttribute("PersonName",PersonName);
		Map<String, Object> paramMap2 = new HashMap<String, Object>();
		//paramMap2.put("ProductCode", PropertiesUtils.getValue("produce_code"));
		paramMap2.put("ProductCode", vo.getProductCode());
		paramMap2.put("ID",PersonID);
		String response2 = RestfulUtils.getPublicData("55-10", paramMap2);
		Map<String, Object> responseMap2 = JsonUtils.getObjectJsonMap(response2); 
		Map<String, Object>  list2=( Map<String, Object>)  responseMap2.get("Msg");
		model.addAttribute("baseData",list2);//个人基本信息
		//查询出疾病既往史
		StringBuffer buffer = new StringBuffer();
		List<Map<String, Object>> personDiseaseList = (List<Map<String, Object>>) list2.get("CmData");
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
		//查询家族史
		StringBuffer familybuffer = new StringBuffer();
		StringBuffer parentbuffer = new StringBuffer();
		parentbuffer.append("父亲:");
		StringBuffer monthbuffer = new StringBuffer();
		monthbuffer.append("母亲:");
		StringBuffer brotherbuffer = new StringBuffer();
		brotherbuffer.append("兄弟姐妹:");
		StringBuffer sonbuffer = new StringBuffer();
		sonbuffer.append("子女:");
		List<Map<String, Object>> familyDiseaseList = (List<Map<String, Object>>) list2.get("CmData");
		for (Map<String, Object> familyDisease : familyDiseaseList) {
			String RelationshipType = (String) familyDisease.get("RelationshipType");
			String Disease = (String) familyDisease.get("Disease");
			if("1".equals(RelationshipType)){
				parentbuffer.append(Disease+",");
			}else if("2".equals(RelationshipType)){
				monthbuffer.append(Disease+",");
			}else if("3".equals(RelationshipType)){
				brotherbuffer.append(Disease+",");
			}else if("4".equals(RelationshipType)){
				sonbuffer.append(Disease+",");
			}
		}
		int pflag=parentbuffer.indexOf(",");
		String parent ="";
		if(pflag!=-1){
			parent =parentbuffer.substring(0, parentbuffer.length()-1);
		}else{
			parent= parentbuffer.substring(0, parentbuffer.length());
		}
		int mflag=monthbuffer.indexOf(",");
		String month ="";
		if(mflag!=-1){
			month =monthbuffer.substring(0, monthbuffer.length()-1);
		}else{
			month =monthbuffer.substring(0, monthbuffer.length());
		}
		int bflag=brotherbuffer.indexOf(",");
		String brother ="";
		if(bflag!=-1){
			brother =brotherbuffer.substring(0, brotherbuffer.length()-1);
		}else{
			brother =brotherbuffer.substring(0, brotherbuffer.length());
		}
		int sflag=sonbuffer.indexOf(",");
		String son ="";
		if(sflag!=-1){
			son =sonbuffer.substring(0, sonbuffer.length()-1);
		}else{
			son =sonbuffer.substring(0, sonbuffer.length());
		}
		familybuffer.append(parent+"  ").append(month+"  ").append(brother+"  ").append(son);
		model.addAttribute("FamilyHistory", familybuffer);
		String GenderCode =(String)list2.get("GenderCode");
		String Gender = null;
		if("0".equals(GenderCode)){
			Gender ="未知";
		}else if("1".equals(GenderCode)){
			Gender ="男";
		}else if("2".equals(GenderCode)){
			Gender ="女";
		}else if("2".equals(GenderCode)){
			Gender ="未说明";
		}
		String BirthDay =(String)list2.get("BirthDay");
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd" );
		Date date = null;
		try {
			date=sdf.parse(BirthDay);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int age=new Date().getYear()-date.getYear();
		String PersonTel =(String) list2.get("PersonTel");		
		model.addAttribute("Gender", Gender); 
 		model.addAttribute("age", age);
		model.addAttribute("PersonTel",PersonTel);
		//model.addAttribute("ProductCode", PropertiesUtils.getValue("produce_code"));
		model.addAttribute("ProductCode", vo.getProductCode());
		return "/hypertension/hypertensionFollowform";
	}
	
	/**
	 * 修改高血压随访记录
	 * @param vo
	 * @return
	 * @author h
	 */
	@ResponseBody
	@RequestMapping(value="/updateHypertensionFollowUpRecord",method=RequestMethod.POST)
	public String updateHypertensionFollowUpRecord(Model model, String dataJson,String saveParam){
		Map  map=JsonUtils.getSingleJsonMap(saveParam);	
		String response = RestfulUtils.getPublicData("58-2", map);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
		if (responseMap.get("Result") == null || (Integer) responseMap.get("Result") == 0) {
			return JsonUtils.getJson(
					BaseJsonVo.empty(ApiStatusEnum.NULL_DATA_CODE.getKey(), ApiStatusEnum.NULL_DATA_CODE.getValue()));
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	
	/**
	 * 增加随访回显基本信息
	 * @param model
	 * @param dataJson
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addFollowupShow",method=RequestMethod.GET)
	public String addFollowupShow(Model model, String PersonID,HttpServletRequest request){	
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		Map<String, Object> paramMap2 = new HashMap<String, Object>();
		
		//paramMap2.put("ProductCode", PropertiesUtils.getValue("produce_code"));		 
		paramMap2.put("ProductCode", vo.getProductCode());		 
		paramMap2.put("ID",PersonID);
		String response2 = RestfulUtils.getPublicData("55-10", paramMap2);
		Map<String, Object> responseMap2 = JsonUtils.getObjectJsonMap(response2); 
		Map<String, Object>  list2=( Map<String, Object>)  responseMap2.get("Msg");
		model.addAttribute("baseData",list2);//个人基本信息
		//查询出疾病既往史
		StringBuffer buffer = new StringBuffer();
		List<Map<String, Object>> personDiseaseList = (List<Map<String, Object>>) list2.get("CmData");
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
		//查询家族史
		StringBuffer familybuffer = new StringBuffer();
		StringBuffer parentbuffer = new StringBuffer();
		parentbuffer.append("父亲:");
		StringBuffer monthbuffer = new StringBuffer();
		monthbuffer.append("母亲:");
		StringBuffer brotherbuffer = new StringBuffer();
		brotherbuffer.append("兄弟姐妹:");
		StringBuffer sonbuffer = new StringBuffer();
		sonbuffer.append("子女:");
		List<Map<String, Object>> familyDiseaseList = (List<Map<String, Object>>) list2.get("CmData");
		for (Map<String, Object> familyDisease : familyDiseaseList) {
			String RelationshipType = (String) familyDisease.get("RelationshipType");
			String Disease = (String) familyDisease.get("Disease");
			if("1".equals(RelationshipType)){
				parentbuffer.append(Disease+",");
			}else if("2".equals(RelationshipType)){
				monthbuffer.append(Disease+",");
			}else if("3".equals(RelationshipType)){
				brotherbuffer.append(Disease+",");
			}else if("4".equals(RelationshipType)){
				sonbuffer.append(Disease+",");
			}
		}
		int pflag=parentbuffer.indexOf(",");
		String parent ="";
		if(pflag!=-1){
			parent =parentbuffer.substring(0, parentbuffer.length()-1);
		}else{
			parent= parentbuffer.substring(0, parentbuffer.length());
		}
		int mflag=monthbuffer.indexOf(",");
		String month ="";
		if(mflag!=-1){
			month =monthbuffer.substring(0, monthbuffer.length()-1);
		}else{
			month =monthbuffer.substring(0, monthbuffer.length());
		}
		int bflag=brotherbuffer.indexOf(",");
		String brother ="";
		if(bflag!=-1){
			brother =brotherbuffer.substring(0, brotherbuffer.length()-1);
		}else{
			brother =brotherbuffer.substring(0, brotherbuffer.length());
		}
		int sflag=sonbuffer.indexOf(",");
		String son ="";
		if(sflag!=-1){
			son =sonbuffer.substring(0, sonbuffer.length()-1);
		}else{
			son =sonbuffer.substring(0, sonbuffer.length());
		}
		familybuffer.append(parent+"  ").append(month+"  ").append(brother+"  ").append(son);
		model.addAttribute("FamilyHistory", familybuffer);
		String GenderCode =(String)list2.get("GenderCode");
		String Gender = null;
		if("0".equals(GenderCode)){
			Gender ="未知";
		}else if("1".equals(GenderCode)){
			Gender ="男";
		}else if("2".equals(GenderCode)){
			Gender ="女";
		}else if("2".equals(GenderCode)){
			Gender ="未说明";
		}
		String BirthDay =(String)list2.get("BirthDay");
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd" );
		Date date = null;
		try {
			date=sdf.parse(BirthDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		int age=new Date().getYear()-date.getYear();
		String PersonTel =(String) list2.get("PersonTel");		
		model.addAttribute("Gender", Gender); 
 		model.addAttribute("age", age);
		model.addAttribute("PersonTel",PersonTel);
		//model.addAttribute("ProductCode", PropertiesUtils.getValue("produce_code")); 
		model.addAttribute("ProductCode", vo.getProductCode()); 
		//最后一次随访记录
		Map<String, Object> paramMap1 = new HashMap<String, Object>();
		//paramMap1.put("ProductCode", PropertiesUtils.getValue("produce_code"));		 
		paramMap1.put("ProductCode", vo.getProductCode());		 
		paramMap1.put("PersonID",PersonID);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String followUpDate=df.format(new Date());	
		//当前时间
		model.addAttribute("followUpDate", followUpDate);
		paramMap1.put("FollowupDate",followUpDate);
		String response1 = RestfulUtils.getPublicData("58-5", paramMap1);
		Map<String, Object> responseMap1 = JsonUtils.getObjectJsonMap(response1); 
		Map<String, Object>  list1=( Map<String, Object>)  responseMap1.get("Msg");
		model.addAttribute("followUpList", list1);
		model.addAttribute("UserID",PersonID);
		return "/hypertension/addhypertensionFollowform";
	}
	
	/**
	 * 传递个人高血压 personID
	 * @param model
	 * @param dataJson
	 * @return
	 * @author h
	 */
	@RequestMapping(value="/personCurve",method=RequestMethod.GET)
	public String personCurve(Model model, String PersonID){
		model.addAttribute("personid", PersonID);		 
		return "/hypertension/personCurve";
	}
	
	/**
	 * 查询个人高血压随访曲线图
	 * @param model
	 * @param dataJson
	 * @return
	 * @author h
	 */
	@ResponseBody
	@RequestMapping(value="/queryHypertensionCurve",method=RequestMethod.GET)
	public String queryHypertensionCurve(HttpServletRequest request,Model model,String PersonID,String StartTime,String EndTime){
		Map<String, Object> paramMap = new HashMap<String, Object>();
	   
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		
	    paramMap.put("ProductCode",vo.getProductCode());
	    paramMap.put("PersonID", PersonID);
	    paramMap.put("StartTime",StartTime);
	    paramMap.put("EndTime", EndTime);
		String response = RestfulUtils.getPublicData("57-9", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);		 
		List<Map<String, Object>>  list=(List<Map<String,Object>>)  responseMap.get("Msg");
		if(list.size()==0){
			Map<String, Object> map = new HashMap<String, Object>();
		    map.put("key","key");
		    list.add(map);
			return JsonUtils.getJsonFormat(list);
		} 
		return JsonUtils.getJsonFormat(list);
	}
	
	//主页随访删除随访记录入口
	@RequestMapping(value="/toDelete",method=RequestMethod.GET)
	public String toDelete(HttpServletRequest request,Model model,String PersonID){
		model.addAttribute("PersonID", PersonID);
		return "/hypertension/deleteHypertension";
				
	}
	
	/**
	 * 删除中查询个人高血压历史
	 * @author h
	 */
	@ResponseBody
	@RequestMapping(value="/queryFollowUpHistory",method=RequestMethod.GET)
	public  String queryFollowUpHistory(Model model, HttpServletRequest request,Integer pageSize,Integer pageIndex){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		//获取前台额外传递过来的查询条件  
		String PersonID =request.getParameter("PersonID");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		//paramMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
        paramMap.put("ProductCode", vo.getProductCode());
        paramMap.put("PersonID", PersonID); 
		model.addAttribute("PersonID", PersonID);
		paramMap.put("PageIndex", pageIndex);
		paramMap.put("PageSize", pageSize);
		String response = RestfulUtils.getPublicData("58-1", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);	 
		List<Map<String, Object> > list=(List<Map<String, Object> > )responseMap.get("Msg");
		Integer count = Integer.valueOf((String)responseMap.get("Total"));;
		return JsonUtils.getJson(BaseJsonVo.pageList(list, count));	 	 
	}
	
	/**
	 * 查询个人高血压历史
	 * @author h
	 */
	@ResponseBody
	@RequestMapping(value="/queryFollowUpHistory2",method=RequestMethod.GET)
	public  String queryFollowUpHistory2(Model model, HttpServletRequest request,Integer pageSize,Integer pageIndex){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		
		//获取前台额外传递过来的查询条件  
		String PersonID =request.getParameter("PersonID");
		
        Map<String, Object> paramMap = new HashMap<String, Object>();
       // paramMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
        paramMap.put("ProductCode", vo.getProductCode());
        paramMap.put("PersonID", PersonID); 
		model.addAttribute("PersonID", PersonID);
		paramMap.put("PageIndex", pageIndex);
		paramMap.put("PageSize", pageSize);
		String response = RestfulUtils.getPublicData("58-1", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);	 
		if ((int) responseMap.get("Result") > 0) {
			List<Map<String, Object> > list=(List<Map<String, Object> > )responseMap.get("Msg");
			Integer count= Integer.valueOf((String) responseMap.get("Total"));
			return JsonUtils.getJson(BaseJsonVo.pageList(list, count),BusinessConstants.JSON_ALL);
		}else{
			return JsonUtils.getJson(BaseJsonVo.pageList(null, 0));
		}	 	 
	} 
	/**
	 * 删除随访
	 * Title HypertensionController2.java
	 * Description: 
	 * @param request
	 * @param model
	 * @return
	 * @author lzz
	 */
	@ResponseBody
	@RequestMapping(value="/deleteHypertension",method=RequestMethod.POST)
	public String deletedeleteHypertension(HttpServletRequest request,Model model){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		//获取前台额外传递过来的查询条件  
		String ID =request.getParameter("ID");
        Map<String, Object> paramMap = new HashMap<String, Object>();
        DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
        
        paramMap.put("ProductCode", vo.getProductCode());
        paramMap.put("ID", ID);
        String response=RestfulUtils.getPublicData("58-4", paramMap);
        Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);

		if (responseMap.get("Result") == null || (Integer) responseMap.get("Result") == 0) {
			return JsonUtils.getJson(
					BaseJsonVo.empty(ApiStatusEnum.FAIL.getKey(), ApiStatusEnum.FAIL.getValue()));
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
        
	}
	
	//个人历史随访记录入口
	@RequestMapping(value="/toHistory",method=RequestMethod.GET)
	public String toHistory(HttpServletRequest request,Model model,String PersonID){
		model.addAttribute("PersonID", PersonID);
		return "/hypertension/hypertensionFollowhistory2";
					
	}
	
	/**
	 * 查看某人的随访记录
	 * @param model
	 * @param dataJson
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/detailFollowup",method=RequestMethod.GET)
	public String detailFollowup(Model model, String dataJson,HttpServletRequest request){
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		String ID =request.getParameter("ID");
		String PersonName =request.getParameter("PersonName");
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		Map<String, Object> paramMap = new HashMap<String, Object>();
	   // paramMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
		paramMap.put("ProductCode", vo.getProductCode());
	    paramMap.put("ID", ID);
		String response = RestfulUtils.getPublicData("58-3", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response); 
		Map<String, Object>  map=( Map<String, Object>)  responseMap.get("Msg");
		Integer symptom =(Integer)(((Map<String, Object>)map.get("cmHypertension")).get("Symptom"));
		if(symptom!=null){
			model.addAttribute("symptom", NumberUtils.bitand(symptom));
		}
		String PersonID =(String)(((Map<String, Object>)map.get("cmHypertension")).get("PersonID"));
		model.addAttribute("data", map);
		//异常处理
		ArrayList<Map<String, Object>> otherList =(ArrayList<Map<String, Object>>) map.get("otherJson");
		System.out.println(JsonUtils.getJsonFormat(otherList));
		model.addAttribute("otherList",JsonUtils.getJsonFormat(otherList));
		//用药处理
		ArrayList<Map<String, Object>> drugUseList =(ArrayList<Map<String, Object>>) map.get("drugJson");
		model.addAttribute("drugUseList",JsonUtils.getJsonFormat(drugUseList));
		//查询上次随访记录
		String FollowUpDate =(String) (( Map<String, Object>)(( Map<String, Object>)  responseMap.get("Msg")).get("cmHypertension")).get("FollowUpDate");
		///Date(1487174400000)/
		FollowUpDate=FollowUpDate.replace("/Date(","").replace(")/", "");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		long t=new Long(FollowUpDate);
		Date dt = new Date(t);
		FollowUpDate =simpleDateFormat.format(dt);
		Map<String, Object> lastMap = new HashMap<String, Object>();
		//lastMap.put("ProductCode", PropertiesUtils.getValue("produce_code"));
		lastMap.put("ProductCode", vo.getProductCode());
		lastMap.put("PersonID", PersonID);
		lastMap.put("FollowUpDate", FollowUpDate);
		String lastResponse = RestfulUtils.getPublicData("58-5", lastMap);
		Map<String, Object> lastMap2 = JsonUtils.getObjectJsonMap(lastResponse); 
		Map<String, Object>  lastList=( Map<String, Object>) lastMap2.get("Msg");
		model.addAttribute("lastData", lastList);
		model.addAttribute("PersonName",PersonName);
		Map<String, Object> paramMap2 = new HashMap<String, Object>();
		//paramMap2.put("ProductCode", PropertiesUtils.getValue("produce_code"));
		paramMap2.put("ProductCode", vo.getProductCode());
		paramMap2.put("ID",PersonID);
		String response2 = RestfulUtils.getPublicData("55-10", paramMap2);
		Map<String, Object> responseMap2 = JsonUtils.getObjectJsonMap(response2); 
		Map<String, Object>  list2=( Map<String, Object>)  responseMap2.get("Msg");
		model.addAttribute("baseData",list2);//个人基本信息
		//查询出疾病既往史
		StringBuffer buffer = new StringBuffer();
		List<Map<String, Object>> personDiseaseList = (List<Map<String, Object>>) list2.get("CmData");
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
		//查询家族史
		StringBuffer familybuffer = new StringBuffer();
		StringBuffer parentbuffer = new StringBuffer();
		parentbuffer.append("父亲:");
		StringBuffer monthbuffer = new StringBuffer();
		monthbuffer.append("母亲:");
		StringBuffer brotherbuffer = new StringBuffer();
		brotherbuffer.append("兄弟姐妹:");
		StringBuffer sonbuffer = new StringBuffer();
		sonbuffer.append("子女:");
		List<Map<String, Object>> familyDiseaseList = (List<Map<String, Object>>) list2.get("CmData");
		for (Map<String, Object> familyDisease : familyDiseaseList) {
			String RelationshipType = (String) familyDisease.get("RelationshipType");
			String Disease = (String) familyDisease.get("Disease");
			if("1".equals(RelationshipType)){
				parentbuffer.append(Disease+",");
			}else if("2".equals(RelationshipType)){
				monthbuffer.append(Disease+",");
			}else if("3".equals(RelationshipType)){
				brotherbuffer.append(Disease+",");
			}else if("4".equals(RelationshipType)){
				sonbuffer.append(Disease+",");
			}
		}
		int pflag=parentbuffer.indexOf(",");
		String parent ="";
		if(pflag!=-1){
			parent =parentbuffer.substring(0, parentbuffer.length()-1);
		}else{
			parent= parentbuffer.substring(0, parentbuffer.length());
		}
		int mflag=monthbuffer.indexOf(",");
		String month ="";
		if(mflag!=-1){
			month =monthbuffer.substring(0, monthbuffer.length()-1);
		}else{
			month =monthbuffer.substring(0, monthbuffer.length());
		}
		int bflag=brotherbuffer.indexOf(",");
		String brother ="";
		if(bflag!=-1){
			brother =brotherbuffer.substring(0, brotherbuffer.length()-1);
		}else{
			brother =brotherbuffer.substring(0, brotherbuffer.length());
		}
		int sflag=sonbuffer.indexOf(",");
		String son ="";
		if(sflag!=-1){
			son =sonbuffer.substring(0, sonbuffer.length()-1);
		}else{
			son =sonbuffer.substring(0, sonbuffer.length());
		}
		familybuffer.append(parent+"  ").append(month+"  ").append(brother+"  ").append(son);
		model.addAttribute("FamilyHistory", familybuffer);
		String GenderCode =(String)list2.get("GenderCode");
		String Gender = null;
		if("0".equals(GenderCode)){
			Gender ="未知";
		}else if("1".equals(GenderCode)){
			Gender ="男";
		}else if("2".equals(GenderCode)){
			Gender ="女";
		}else if("2".equals(GenderCode)){
			Gender ="未说明";
		}
		String BirthDay =(String)list2.get("BirthDay");
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd" );
		Date date = null;
		try {
			date=sdf.parse(BirthDay);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int age=new Date().getYear()-date.getYear();
		String PersonTel =(String) list2.get("PersonTel");		
		model.addAttribute("Gender", Gender); 
 		model.addAttribute("age", age);
		model.addAttribute("PersonTel",PersonTel);
		//model.addAttribute("ProductCode", PropertiesUtils.getValue("produce_code"));
		model.addAttribute("ProductCode", vo.getProductCode());
		return "/hypertension/detailFollowform";
	}

}
