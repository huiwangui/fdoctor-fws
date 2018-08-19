package com.boco.modules.fdoc.web.fdocWorkstation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

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
import com.boco.modules.fdoc.service.DocService;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SysRegionService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;

/**
 * Description
 * @author lzz
 * @date 2017年7月18日 下午2:18:26
 */

@Controller
@RequestMapping(value="/diabetes",produces="application/json;charset=UTF-8")
public class DiabetesController2 {
	
	@Resource
	SysRegionService sysRegionService;
	@Resource
	DocService docService;
	@Resource
	PersonInformationService personInformationService;
	@Resource
	DocUserService docUserService;
	
	/**
	 * 首页
	 * Title DiabetesController.java
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
		return "/diabetes/queryDiabetes";
	}
	
	/**
	 * 查询糖尿病列表
	 * Title DiabetesController.java
	 * Description: 
	 * @param request
	 * @param model
	 * @param dataJson
	 * @param RegionCode
	 * @param KeyValueType
	 * @param KeyValue
	 * @param StartFollowupDate
	 * @param EndFollowupDate
	 * @param IsFollowup
	 * @param FollowupType
	 * @param Perfect
	 * @return
	 * @author lzz
	 */
	@ResponseBody
	@RequestMapping(value="/followupList",method=RequestMethod.GET)
	public String followupList(HttpServletRequest request,Model model,String  RegionCode,String KeyValueType,
			String KeyValue,String StartFollowupDate,String EndFollowupDate,String IsFollowup,String FollowupType,String Perfect,Integer pageSize,Integer pageIndex){
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		  
        Map<String, Object> paramMap = new HashMap<String, Object>();
        DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
        paramMap.put("ProductCode", vo.getProductCode());
        if(RegionCode==null){
			RegionCode="51";
		}
		paramMap.put("RegionCode", RegionCode);
        paramMap.put("BuildType","糖尿病"); 
		paramMap.put("PageIndex", pageIndex);
		paramMap.put("PageSize", pageSize);
		paramMap.put("KeyValue",KeyValue );
		paramMap.put("KeyValueType",KeyValueType );
		paramMap.put("StartFollowupDate", StartFollowupDate);
		paramMap.put("EndFollowupDate",EndFollowupDate );
		paramMap.put("IsFollowup",IsFollowup );
		paramMap.put("FollowupType",FollowupType );
		paramMap.put("Perfect", Perfect);
		
		
		//调用接口
		String response = RestfulUtils.getPublicData("59-7", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
		List<Map<String, Object> > list=(List<Map<String, Object> > )responseMap.get("Msg");
		Integer count=(Integer) responseMap.get("Total");
		count=count-15;
		
		return JsonUtils.getJson(BaseJsonVo.pageList(list, count));
	}
	
	/**
	 * 修改：获取随访详细信息
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateFollowup",method=RequestMethod.GET)
	public String updateFollowup(HttpServletRequest request,Model model,String ID,String PersonID){
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		String ProductCode=vo.getProductCode();
		Map<String, Object> paraMap=new HashMap<String,Object>();
		paraMap.put("ProductCode", ProductCode);
		paraMap.put("ID", ID);
		String response=RestfulUtils.getPublicData("59-3", paraMap);
		System.out.println("---随访详细---："+response);
		Map<String, Object> responseMap=JsonUtils.getObjectJsonMap(response);
		Map<String, Object> msgMap=(Map<String, Object>) responseMap.get("Msg");
		Map<String, Object> CmDiab=(Map<String, Object>) msgMap.get("cmDiabetes");
		Integer sumValue=(Integer) CmDiab.get("Symptom");
		if(sumValue!=null && !sumValue.equals("")){
			String sum=NumberUtils.bitand(sumValue);
			model.addAttribute("sum", sum);
		}
		
		//表详细信息
		ArrayList<Map<String, Object>> insulindrug=(ArrayList<Map<String, Object>>) msgMap.get("insulindrug");
		ArrayList<Map<String, Object>> drugJson=(ArrayList<Map<String, Object>>) msgMap.get("drugJson");
		model.addAttribute("drugJson",  JsonUtils.getJsonFormat(drugJson));
		//异常处理
		ArrayList<Map<String, Object>> otherList =(ArrayList<Map<String, Object>>) msgMap.get("otherJson");
		System.out.println(JsonUtils.getJsonFormat(otherList));
		model.addAttribute("otherList",JsonUtils.getJsonFormat(otherList));
		
		model.addAttribute("insulindrug", JsonUtils.getJsonFormat(insulindrug));
		model.addAttribute("data", msgMap);
		System.out.println("----------data:"+msgMap);
		//随访表头
		Map<String,Object> cmDiabetesMap=(Map<String, Object>) msgMap.get("cmDiabetes");
		String followUpDate=(String) cmDiabetesMap.get("FollowUpDate");
		Map<String, Object> lastMap=new HashMap<String,Object>();
		lastMap.put("ProductCode", ProductCode);
		lastMap.put("PersonID", PersonID);
		lastMap.put("FollowUpDate", followUpDate);
		String lastresponse=RestfulUtils.getPublicData("59-5", lastMap);
		System.out.println("---上次随访---"+lastresponse);
		Map<String, Object> lastresMap=JsonUtils.getObjectJsonMap(lastresponse);
		Map<String, Object> lmsgMap=(Map<String, Object>) lastresMap.get("Msg");
		
		Map<String, Object> exambodyMap=(Map<String, Object>) lmsgMap.get("ExamBody");
		Map<String, Object> lfupMap=(Map<String, Object>) lmsgMap.get("lastHyFollowup");
		//处理疾病既往史
		List<Map<String , Object>> disHisList=(List<Map<String, Object>>) lmsgMap.get("disHistory");
		String disHisString="";
		for(int i=0;i<disHisList.size();i++){
			if(i==disHisList.size()-1){
				disHisString+=disHisList.get(i).get("NAME");
			}else{
				disHisString+=disHisList.get(i).get("NAME")+" , ";
			}
			
		}
		//处理家族史
		List<Map<String , Object>> faHisList=(List<Map<String, Object>>) lmsgMap.get("familyHistory");
		String motherinfo="";
		String fatherinfo="";
		String sisbroinfo="";
		String soninfo="";
		for(int i=0;i<faHisList.size();i++){
			if(faHisList.get(i).get("RelationshipType").equals(1)){
				motherinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(2)){
				fatherinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(3)){
				sisbroinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(4)){
				soninfo=faHisList.get(i).get("Disease").toString();
			}
		}
		System.out.println("-------"+motherinfo+fatherinfo+sisbroinfo+soninfo);
		
		model.addAttribute("lfupMap",lfupMap );
		model.addAttribute("exambodyMap", exambodyMap);
		model.addAttribute("disHisString", disHisString);
		
		model.addAttribute("motherinfo", motherinfo);
		model.addAttribute("fatherinfo", fatherinfo);
		model.addAttribute("sisbroinfo", sisbroinfo);
		model.addAttribute("soninfo", soninfo);
		//查出姓名，性别，年龄，电话
		Map<String, Object> personinfoMap=new HashMap<String,Object>();
		personinfoMap.put("ProductCode", ProductCode);
		personinfoMap.put("ID", PersonID);
		String personinfo=RestfulUtils.getPublicData("55-10", personinfoMap);
		Map<String, Object> perMap=JsonUtils.getObjectJsonMap(personinfo);
		System.out.println(perMap);
		Map<String, Object> pmsgMap=(Map<String, Object>) perMap.get("Msg");
		String Name=(String) pmsgMap.get("Name");
		String PersonTel=(String) pmsgMap.get("PersonTel");
		String GenderCode=(String) pmsgMap.get("GenderCode");
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
		String BirthDay=(String) pmsgMap.get("BirthDay");
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd" );
		Date date = null;
		try {
			date=sdf.parse(BirthDay);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar now = Calendar.getInstance();
		Calendar birth = Calendar.getInstance();
		birth.setTime(date);
		int age=now.get(Calendar.YEAR)-birth.get(Calendar.YEAR);
		model.addAttribute("Name", Name);
		model.addAttribute("Gender", Gender);
		model.addAttribute("age", age);
		model.addAttribute("PersonTel",PersonTel );
		//转诊信息
		
		model.addAttribute("baseData",pmsgMap);
		model.addAttribute("doctorName", vo.getDocName());
		model.addAttribute("userName", userName);
		model.addAttribute("userId", vo.getId());
		return "/diabetes/diabetesFollowUp";
		
	}

	/**
	 * 修改后保存
	 * Title DiabetesController2.java
	 * Description: 
	 * @param request
	 * @param model
	 * @param dataJson
	 * @param saveParam
	 * @param doctorName
	 * @return
	 * @author lzz
	 */
	@ResponseBody
	@RequestMapping(value="/updateSave",method=RequestMethod.POST)
	public String updateSave(HttpServletRequest request,Model model, String dataJson,String saveParam,String doctorName){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		String productCode=vo.getProductCode();
		Map  map=JsonUtils.getSingleJsonMap(saveParam);
	    map.put("ProductCode",productCode);
		String response = RestfulUtils.getPublicData("59-2", map);
		System.out.println(response);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);

		if (responseMap.get("Result") == null || (Integer) responseMap.get("Result") == 0) {
			return JsonUtils.getJson(
					BaseJsonVo.empty(ApiStatusEnum.NULL_DATA_CODE.getKey(), ApiStatusEnum.NULL_DATA_CODE.getValue()));
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	
	/**
	 * 跳至糖尿病曲线，传递PersonId
	 * @param model
	 * @param personid
	 * @return
	 */
	@RequestMapping(value="/diabetesCurve",method=RequestMethod.GET)
	public String diabetesCurve(Model model,String PersonID){
		
		model.addAttribute("PersonID", PersonID);
		return "/diabetes/diabetesCurve";
		
	}
	/**
	 * 查询糖尿病曲线
	 * @param model
	 * @param dataJson
	 * @param PersonID 个人ID
	 * @param StartTime 时间起
	 * @param EndTime 时间终
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/queryDiabetesCurve",method=RequestMethod.GET)
	public String queryDiabetesCurve(HttpServletRequest request,Model model, String dataJson,String PersonID,String StartTime,String EndTime){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		Map<String, Object> paraMap=new HashMap<String,Object>();
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		paraMap.put("ProductCode",vo.getProductCode());
		paraMap.put("PersonID", PersonID);
		paraMap.put("StartTime", StartTime);
		paraMap.put("EndTime", EndTime);
		String response=RestfulUtils.getPublicData("59-6", paraMap);
		
		Map<String, Object> rMap = JsonUtils.getObjectJsonMap(response);
		System.out.println("---rmap"+rMap); 
		List<Map<String, Object>>  list=(List<Map<String,Object>>)rMap.get("Msg");
		//当大小为0时。放入map以待JSP校验
		if(list.size()==0){
			Map<String, Object> map = new HashMap<String, Object>();
		    map.put("key","key");
		    list.add(map);
			//System.out.println(JsonUtils.getJsonFormat(list));
			return JsonUtils.getJsonFormat(list);
		} 
		System.out.println("曲线数据："+JsonUtils.getJsonFormat(list));
		return JsonUtils.getJsonFormat(list);
		
	}
	
	/**
	 * 新建随访页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveFollowup",method=RequestMethod.GET)
	public  String saveFollowup(HttpServletRequest request,Model model,String ID,String PersonID){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		model.addAttribute("PersonID", PersonID);
		 DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		String ProductCode=vo.getProductCode();
		Map<String, Object> lastMap=new HashMap<String,Object>();
		lastMap.put("ProductCode", ProductCode);
		lastMap.put("PersonID", PersonID);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String followUpDate=df.format(new Date());
		model.addAttribute("followUpDate", followUpDate);
		lastMap.put("FollowUpDate", followUpDate);
		String lastresponse=RestfulUtils.getPublicData("59-5", lastMap);
		System.out.println("---上次随访---"+lastresponse);
		Map<String, Object> lastresMap=JsonUtils.getObjectJsonMap(lastresponse);
		Map<String, Object> lmsgMap=(Map<String, Object>) lastresMap.get("Msg");
		
		Map<String, Object> exambodyMap=(Map<String, Object>) lmsgMap.get("ExamBody");
		Map<String, Object> lfupMap=(Map<String, Object>) lmsgMap.get("lastHyFollowup");
		//处理疾病既往史
		List<Map<String , Object>> disHisList=(List<Map<String, Object>>) lmsgMap.get("disHistory");
		String disHisString="";
		for(int i=0;i<disHisList.size();i++){
			if(i==disHisList.size()-1){
				disHisString+=disHisList.get(i).get("NAME");
			}else{
				disHisString+=disHisList.get(i).get("NAME")+" , ";
			}
			
		}
		//处理家族史
		List<Map<String , Object>> faHisList=(List<Map<String, Object>>) lmsgMap.get("familyHistory");
		String motherinfo="";
		String fatherinfo="";
		String sisbroinfo="";
		String soninfo="";
		for(int i=0;i<faHisList.size();i++){
			if(faHisList.get(i).get("RelationshipType").equals(1)){
				motherinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(2)){
				fatherinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(3)){
				sisbroinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(4)){
				soninfo=faHisList.get(i).get("Disease").toString();
			}
		}
		
		model.addAttribute("lfupMap",lfupMap );
		model.addAttribute("exambodyMap", exambodyMap);
		model.addAttribute("disHisString", disHisString);
		
		model.addAttribute("motherinfo", motherinfo);
		model.addAttribute("fatherinfo", fatherinfo);
		model.addAttribute("sisbroinfo", sisbroinfo);
		model.addAttribute("soninfo", soninfo);
		//查出姓名，性别，年龄，电话
		Map<String, Object> personinfoMap=new HashMap<String,Object>();
		personinfoMap.put("ProductCode", ProductCode);
		personinfoMap.put("ID", PersonID);
		String personinfo=RestfulUtils.getPublicData("55-10", personinfoMap);
		Map<String, Object> perMap=JsonUtils.getObjectJsonMap(personinfo);
		System.out.println(perMap);
		Map<String, Object> pmsgMap=(Map<String, Object>) perMap.get("Msg");
		String Name=(String) pmsgMap.get("Name");
		String PersonTel=(String) pmsgMap.get("PersonTel");
		String GenderCode=(String) pmsgMap.get("GenderCode");
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
		String BirthDay=(String) pmsgMap.get("BirthDay");
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd" );
		Date date = null;
		try {
			date=sdf.parse(BirthDay);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar now = Calendar.getInstance();
		Calendar birth = Calendar.getInstance();
		birth.setTime(date);
		int age=now.get(Calendar.YEAR)-birth.get(Calendar.YEAR);
		model.addAttribute("Name", Name);
		model.addAttribute("Gender", Gender);
		model.addAttribute("age", age);
		model.addAttribute("PersonTel",PersonTel );
		//转诊信息
		model.addAttribute("baseDate", pmsgMap);
		model.addAttribute("doctorName", vo.getDocName());
		model.addAttribute("userId", vo.getId());
		return "/diabetes/saveFollowUp";
		
	}
	
	/**
	 * 跳至医生选择页面
	 * @param model
	 * @param personid
	 * @return
	 */
	@RequestMapping(value="/toDocSearh",method=RequestMethod.GET)
	public String toDocSearh(Model model,String PersonID){
		
		return "/diabetes/diabetesDocSearch";
		
	}
	
	/**
	 * 医生查询
	 * @param request
	 * @param model
	 * @param KeyValue
	 * @param OrgID
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/docSearch",method=RequestMethod.GET)
	public String docSearch(HttpServletRequest request,Model model,String KeyValue){
		Integer  start =Integer.parseInt(request.getParameter("start")) ;  
		Integer  length= Integer.parseInt(request.getParameter("length"));
		String  response=JsonUtils.getJsonFormat(docService.getDoctorList(KeyValue, length, start));
		
		System.out.println(response);
		List<Map> list1=JsonUtils.getObjectList(response, Map.class);
		System.out.println(list1);
	    Map<String, Object> map=new  HashMap<String, Object>();
		map.put("data",list1);
		map.put("iTotalRecords", docService.getDoctorCount(KeyValue));
		map.put("iTotalDisplayRecords",docService.getDoctorCount(KeyValue));
		map.put("recordsTotal",docService.getDoctorCount(KeyValue));
		map.put("recordsFiltered",docService.getDoctorCount(KeyValue));
		return JsonUtils.getJson(map);
		
	}
	
	//主页随访删除随访记录入口
	@RequestMapping(value="/toDelete",method=RequestMethod.GET)
	public String toDelete(HttpServletRequest request,Model model,String PersonID){
		model.addAttribute("PersonID", PersonID);
		return "/diabetes/deleteDiabetes";
			
	}
	/**
	 * 删除中查询个人历史随访记录
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/personalHistoryNext",method=RequestMethod.GET)
	public String personalHistoryNext(HttpServletRequest request,Model model,Integer pageSize,Integer pageIndex){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		//获取前台额外传递过来的查询条件  
		String PersonID =request.getParameter("PersonID");
        Map<String, Object> paramMap = new HashMap<String, Object>();
        DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
        paramMap.put("ProductCode", vo.getProductCode());
        paramMap.put("PersonID", PersonID);
        paramMap.put("PageIndex", pageIndex);
		paramMap.put("PageSize", pageSize);
		
		String response = RestfulUtils.getPublicData("59-1", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);	 
		System.out.println(JsonUtils.getJson(responseMap));
		List<Map<String, Object> > list=(List<Map<String, Object> > )responseMap.get("Msg");
		Integer count=Integer.valueOf((String) responseMap.get("Total"));
		return JsonUtils.getJson(BaseJsonVo.pageList(list, count));
		
	}
	/**
	 * 查询个人历史随访记录
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/personalHistoryNext2",method=RequestMethod.GET)
	public String personalHistoryNext2(HttpServletRequest request,Model model,Integer pageIndex,Integer pageSize){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		//获取前台额外传递过来的查询条件  
		String PersonID =request.getParameter("PersonID");
        Map<String, Object> paramMap = new HashMap<String, Object>();
        DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
        paramMap.put("ProductCode", vo.getProductCode());
        paramMap.put("PersonID", PersonID);
        paramMap.put("PageIndex", pageIndex);
		paramMap.put("PageSize", pageSize);
		
		String response = RestfulUtils.getPublicData("59-1", paramMap);
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
	 * Title DiabetesController2.java
	 * Description: 
	 * @param request
	 * @param model
	 * @return
	 * @author lzz
	 */
	@ResponseBody
	@RequestMapping(value="/deleteDiabetes",method=RequestMethod.POST)
	public String deleteDiabetes(HttpServletRequest request,Model model){
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		//获取前台额外传递过来的查询条件  
		String ID =request.getParameter("ID");
        Map<String, Object> paramMap = new HashMap<String, Object>();
        DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
        
        paramMap.put("ProductCode", vo.getProductCode());
        paramMap.put("ID", ID);
        String response=RestfulUtils.getPublicData("59-4", paramMap);
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
		return "/diabetes/diabetesFollowupHistory2";
				
	}
	
	/**
	 * 修改：获取随访详细信息
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/detailFollowup",method=RequestMethod.GET)
	public String detailFollowup(HttpServletRequest request,Model model,String ID,String PersonID){
		
		String userName = (String) request.getSession().getAttribute(BusinessConstants.USERNAME_IN_SESSION);
		DoctorDetailVo vo =docUserService.getDoctorByUsername(userName);
		String ProductCode=vo.getProductCode();
		Map<String, Object> paraMap=new HashMap<String,Object>();
		paraMap.put("ProductCode", ProductCode);
		paraMap.put("ID", ID);
		String response=RestfulUtils.getPublicData("59-3", paraMap);
		System.out.println("---随访详细---："+response);
		Map<String, Object> responseMap=JsonUtils.getObjectJsonMap(response);
		Map<String, Object> msgMap=(Map<String, Object>) responseMap.get("Msg");
		Map<String, Object> CmDiab=(Map<String, Object>) msgMap.get("cmDiabetes");
		Integer sumValue=(Integer) CmDiab.get("Symptom");
		if(sumValue!=null && !sumValue.equals("")){
			String sum=NumberUtils.bitand(sumValue);
			model.addAttribute("sum", sum);
		}
		
		//表详细信息
		ArrayList<Map<String, Object>> insulindrug=(ArrayList<Map<String, Object>>) msgMap.get("insulindrug");
		ArrayList<Map<String, Object>> drugJson=(ArrayList<Map<String, Object>>) msgMap.get("drugJson");
		model.addAttribute("drugJson",  JsonUtils.getJsonFormat(drugJson));
		//异常处理
		ArrayList<Map<String, Object>> otherList =(ArrayList<Map<String, Object>>) msgMap.get("otherJson");
		System.out.println(JsonUtils.getJsonFormat(otherList));
		model.addAttribute("otherList",JsonUtils.getJsonFormat(otherList));
		
		model.addAttribute("insulindrug", JsonUtils.getJsonFormat(insulindrug));
		model.addAttribute("data", msgMap);
		System.out.println("----------data:"+msgMap);
		//随访表头
		Map<String,Object> cmDiabetesMap=(Map<String, Object>) msgMap.get("cmDiabetes");
		String followUpDate=(String) cmDiabetesMap.get("FollowUpDate");
		Map<String, Object> lastMap=new HashMap<String,Object>();
		lastMap.put("ProductCode", ProductCode);
		lastMap.put("PersonID", PersonID);
		lastMap.put("FollowUpDate", followUpDate);
		String lastresponse=RestfulUtils.getPublicData("59-5", lastMap);
		System.out.println("---上次随访---"+lastresponse);
		Map<String, Object> lastresMap=JsonUtils.getObjectJsonMap(lastresponse);
		Map<String, Object> lmsgMap=(Map<String, Object>) lastresMap.get("Msg");
		
		Map<String, Object> exambodyMap=(Map<String, Object>) lmsgMap.get("ExamBody");
		Map<String, Object> lfupMap=(Map<String, Object>) lmsgMap.get("lastHyFollowup");
		//处理疾病既往史
		List<Map<String , Object>> disHisList=(List<Map<String, Object>>) lmsgMap.get("disHistory");
		String disHisString="";
		for(int i=0;i<disHisList.size();i++){
			if(i==disHisList.size()-1){
				disHisString+=disHisList.get(i).get("NAME");
			}else{
				disHisString+=disHisList.get(i).get("NAME")+" , ";
			}
			
		}
		//处理家族史
		List<Map<String , Object>> faHisList=(List<Map<String, Object>>) lmsgMap.get("familyHistory");
		String motherinfo="";
		String fatherinfo="";
		String sisbroinfo="";
		String soninfo="";
		for(int i=0;i<faHisList.size();i++){
			if(faHisList.get(i).get("RelationshipType").equals(1)){
				motherinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(2)){
				fatherinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(3)){
				sisbroinfo=faHisList.get(i).get("Disease").toString();
			}
			if(faHisList.get(i).get("RelationshipType").equals(4)){
				soninfo=faHisList.get(i).get("Disease").toString();
			}
		}
		System.out.println("-------"+motherinfo+fatherinfo+sisbroinfo+soninfo);
		
		model.addAttribute("lfupMap",lfupMap );
		model.addAttribute("exambodyMap", exambodyMap);
		model.addAttribute("disHisString", disHisString);
		
		model.addAttribute("motherinfo", motherinfo);
		model.addAttribute("fatherinfo", fatherinfo);
		model.addAttribute("sisbroinfo", sisbroinfo);
		model.addAttribute("soninfo", soninfo);
		//查出姓名，性别，年龄，电话
		Map<String, Object> personinfoMap=new HashMap<String,Object>();
		personinfoMap.put("ProductCode", ProductCode);
		personinfoMap.put("ID", PersonID);
		String personinfo=RestfulUtils.getPublicData("55-10", personinfoMap);
		Map<String, Object> perMap=JsonUtils.getObjectJsonMap(personinfo);
		System.out.println(perMap);
		Map<String, Object> pmsgMap=(Map<String, Object>) perMap.get("Msg");
		String Name=(String) pmsgMap.get("Name");
		String PersonTel=(String) pmsgMap.get("PersonTel");
		String GenderCode=(String) pmsgMap.get("GenderCode");
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
		String BirthDay=(String) pmsgMap.get("BirthDay");
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd" );
		Date date = null;
		try {
			date=sdf.parse(BirthDay);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar now = Calendar.getInstance();
		Calendar birth = Calendar.getInstance();
		birth.setTime(date);
		int age=now.get(Calendar.YEAR)-birth.get(Calendar.YEAR);
		model.addAttribute("Name", Name);
		model.addAttribute("Gender", Gender);
		model.addAttribute("age", age);
		model.addAttribute("PersonTel",PersonTel );
		//转诊信息
		
		model.addAttribute("baseData",pmsgMap);
		model.addAttribute("doctorName", vo.getDocName());
		model.addAttribute("userName", userName);
		model.addAttribute("userId", vo.getId());
		return "/diabetes/detailFollowUp";
		
	}
}
