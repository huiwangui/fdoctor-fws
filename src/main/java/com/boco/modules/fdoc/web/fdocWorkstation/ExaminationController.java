package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.annotations.Source;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.enums.ApiStatusEnum;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.PropertiesUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;

/**
 * 公卫体检
 * 
 * @author q
 *
 */
@Controller
@RequestMapping(value = "/examination", produces = "text/json;charset=utf-8")
public class ExaminationController {

	@Resource
	PersonInformationService personService;
	@Source
	DocUserService docUserService;

	/**
	 * 跳转页面 体检列表
	 * 
	 * @param req
	 * @param model
	 * @return
	 *
	 */
	@RequestMapping(value = "/examinationPage", method = RequestMethod.GET)
	public String examinationPage(HttpServletRequest req, Model model) {

		return "/examination/examList";
	}

	/**
	 * 
	 * @param req
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getExamList", method = RequestMethod.GET)
	@ResponseBody
	public String getExamList(HttpServletRequest req, Model model,
			String paramJson, Integer pageIndex, Integer pageSize) {
		// 将参数json转化为map
		Map<String, Object> paramMap = JsonUtils.getObjectJsonMap(paramJson);

		// 获取当前登录用户的productCode
		DoctorDetailVo doctorInfo = (DoctorDetailVo) req.getSession()
				.getAttribute("doctorInfo");
		paramMap.put("ProductCode", doctorInfo.getProductCode());
		paramMap.put("RegionCode", PropertiesUtils.getValue("top_region"));
		paramMap.put("PageSize", pageSize);
		paramMap.put("PageIndex", pageIndex - 1);

		// 调用卫计委接口，获取数据
		String result = RestfulUtils.getPublicData("56-2", paramMap);

		Map<String, Object> dataMap = JsonUtils.getObjectJsonMap(result);
		if ((int) dataMap.get("Result") > 0) {
			List<Map<String, Object>> list = (List<Map<String, Object>>) dataMap
					.get("Msg");
			Integer count = (Integer) dataMap.get("Total");
			return JsonUtils.getJson(BaseJsonVo.pageList(list, count));
		} else {
			return JsonUtils.getJson(BaseJsonVo.pageList(null, 0));
		}
	}

	/**
	 * 新增体检页面
	 * 
	 * @param request
	 * @param model
	 * @param radte
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toAddExamination", method = RequestMethod.GET)
	public String toAddExamination(HttpServletRequest request, Model model,
			String personId) {
		// 获取当前登录用户的productCode
		DoctorDetailVo doctorInfo = (DoctorDetailVo) request.getSession()
				.getAttribute("doctorInfo");

		// 获取居民详情
		PersonInformationVo personInfo = personService
				.getPersonDetailByPersonId(personId);
		
		// 如果本地查不到居民信息，提示前台
		if (personInfo == null) {
			model.addAttribute("personInfoMsg",
					"家庭医生系统未查到居民信息，但不影响体检编辑操作。可联系维护人员同步数据");
			personInfo = new PersonInformationVo();
			personInfo.setPersonId(personId);
		}
		model.addAttribute("personInfo", personInfo);

		//获取居民的历史体检列表
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ProductCode", doctorInfo.getProductCode());
		paramMap.put("PersonID", personId);
		String response = RestfulUtils.getPublicData("56-6", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
		
		//解析居民体检列表
		if (responseMap.get("Result") != null && (Integer) responseMap.get("Result") != 0) {
			
			//目标体检的上一次体检ID
			String beforeQueryExamId = null;
			List<Map<String, Object>> listMiIdAndExamDate = (List<Map<String, Object>>) responseMap.get("Msg");
			
			Map<String, Object> lastMap = listMiIdAndExamDate.get(0);	//获取最新的一次体检记录
			beforeQueryExamId = (String) lastMap.get("MtId");	//将ID、体检日期赋值给变量

			//通过personId和日期，调用接口56-7获取上一次体检信息
			Map<String, Object> beforeExamParam = new HashMap<String, Object>();
			beforeExamParam.put("ProductCode", doctorInfo.getProductCode());
			beforeExamParam.put("MtID", beforeQueryExamId);

			String beforeExamResponse = RestfulUtils.getPublicData("56-4", beforeExamParam);
			//解析上一次体检信息
			Map<String, Object> beforeExamResponseMap = JsonUtils.getObjectJsonMap(beforeExamResponse);
			Map<String, Object> beforeExamInfo = new HashMap<String, Object>();
			
			if (beforeExamResponseMap.get("Result") != null
					&& (Integer) beforeExamResponseMap.get("Result") != 0) {
				beforeExamInfo = (Map<String, Object>) beforeExamResponseMap.get("Msg");
				beforeExamInfo = (Map<String, Object>) beforeExamInfo.get("body");
				//处理体检日期
				if (beforeExamInfo.get("ExamDate") != null && StringUtils.isNotEmpty((String)beforeExamInfo.get("ExamDate"))) {
					String dateNum = StringUtils.getStringNum((String)beforeExamInfo.get("ExamDate"));
					Long timeStamp = Long.parseLong(dateNum);
					if (StringUtils.isNotEmpty(dateNum)) {
						beforeExamInfo.put("ExamDate", DateUtils.formatDate(new Date(timeStamp)));
					}
				}
				model.addAttribute("beforeExamInfo", beforeExamInfo);
			}
		}else{
			//无上次体检信息
			model.addAttribute("noExamMsg", "未查到上次体检信息");
		}
		
		model.addAttribute("PersonID", personId);
		return "/examination/addExamination";
	}

	/*
	 * 保存居民体检
	 */
	@RequestMapping(value = "/saveExamination", method = RequestMethod.POST)
	@ResponseBody
	public String saveExamnation(HttpServletRequest request, Model model,
			String dataJson) {

		// 获取当前登录用户的productCode
		DoctorDetailVo doctorInfo = (DoctorDetailVo) request.getSession()
				.getAttribute("doctorInfo");
		// 保存体检结果
		Map<String, Object> paramMap = JsonUtils.getObjectJsonMap(dataJson);
		paramMap.put("ProductCode", doctorInfo.getProductCode());
		
		String response = RestfulUtils.getPublicData("56-3", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
		if (responseMap.get("Result") == null
				|| (Integer) responseMap.get("Result") == 0) {
			return JsonUtils.getJson(BaseJsonVo.empty(
					ApiStatusEnum.NULL_DATA_CODE.getKey(),
					ApiStatusEnum.NULL_DATA_CODE.getValue()));
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	
	/*
	 * 删除居民体检页面
	 */
	@RequestMapping(value = "/deleteExaminationPage", method = RequestMethod.GET)
	public String deleteExaminationPage(HttpServletRequest request, Model model, String personId) {
		//把personId写入作用域
		model.addAttribute("personId", personId);
		
		return "/examination/deleteExamination";
	}
	
	/*
	 * 获取某个居民历史体检列表
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getPersonExamList", method = RequestMethod.GET)
	@ResponseBody
	public String getPersonExamList(HttpServletRequest request, Model model,
			String personId, Integer pageIndex, Integer pageSize) {
		// 获取当前登录用户的productCode
		DoctorDetailVo doctorInfo = (DoctorDetailVo) request.getSession().getAttribute("doctorInfo");
		
		//准备调用卫计委接口的参数map
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("PersonID", personId);
		paramMap.put("ProductCode", doctorInfo.getProductCode());
		paramMap.put("PageSize", pageSize);
		paramMap.put("PageIndex", pageIndex - 1);
		String response = RestfulUtils.getPublicData("56-1", paramMap);
		//解析返回结果
		Map<String, Object> dataMap = JsonUtils.getObjectJsonMap(response);
		
		if ((int) dataMap.get("Result") > 0) {
			List<Map<String, Object>> list = (List<Map<String, Object>>) dataMap.get("Msg");
			String count = (String) dataMap.get("Total");
			return JsonUtils.getJson(BaseJsonVo.pageList(list, Integer.parseInt(count)));
		} else {
			return JsonUtils.getJson(BaseJsonVo.pageList(null, 0));
		}
	}
	
	/*
	 * 删除居民体检
	 */
	@RequestMapping(value = "/deleteExamination", method = RequestMethod.POST)
	@ResponseBody
	public String deleteExamination(HttpServletRequest request, Model model,String examId) {
		// 获取当前登录用户的productCode
		DoctorDetailVo doctorInfo = (DoctorDetailVo) request.getSession().getAttribute("doctorInfo");
		
		//准备调用卫计委接口的参数map
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ProductCode", doctorInfo.getProductCode());
		paramMap.put("MtID", examId);
		
		//解析返回参数
		String response = RestfulUtils.getPublicData("56-5", paramMap);
		Map<String, Object> resultMap = JsonUtils.getObjectJsonMap(response);
		
		if ((int)resultMap.get("Result") > 0) {
			return JsonUtils.getJson(BaseJsonVo.success(null));
		}else {
			return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.FAIL.getKey(),
					String.valueOf(resultMap.get("Msg"))));
		}
	}
	

	/*
	 * 修改居民体检页面
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateExaminationPage", method = RequestMethod.GET)
	public String updateExaminationPage(HttpServletRequest request,
			Model model, String personId, String examId, String examDate) {
		
		// 获取当前登录用户的productCode
		DoctorDetailVo vo = (DoctorDetailVo) request.getSession()
						.getAttribute("doctorInfo");

		model.addAttribute("productCode", vo.getProductCode());

		//获取居民的历史体检列表
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ProductCode", vo.getProductCode());
		paramMap.put("PersonID", personId);
		String response = RestfulUtils.getPublicData("56-6", paramMap);
		Map<String, Object> responseMap = JsonUtils.getObjectJsonMap(response);
		
		List<String> listExamId = new ArrayList<>();	//用于封装居民体检ID列表的List,用于查找目标体检的上一次体检信息
		
		//解析居民体检列表
		if (responseMap.get("Result") != null && (Integer) responseMap.get("Result") != 0) {
			
			//作为查询详情条件的体检日期和体检ID
			String queryExamDateStr = null;
			String queryExamId = null;
			
			//目标体检的上一次体检ID
			String beforeQueryExamId = null;
			
			List<Map<String, Object>> listMiIdAndExamDate = (List<Map<String, Object>>) responseMap.get("Msg");
		
			//将体检的ID装入List
			for (Map<String, Object> map : listMiIdAndExamDate) {
				listExamId.add((String)map.get("MtId"));
			}
			
			//如果传入的体检ID和体检日期为空，说明为默认查询最近的一次体检
			if (StringUtils.isNotEmpty(examDate) && StringUtils.isNotEmpty(examId)) {
				queryExamDateStr = examDate;
				queryExamId = examId;
			}else {
				Map<String, Object> lastMap = listMiIdAndExamDate.get(0);	//获取最新的一次体检记录
				queryExamDateStr = (String) lastMap.get("ExamDate");
				queryExamId = (String) lastMap.get("MtId");	//将ID、体检日期赋值给变量
			}
			
			// personId查询居民信息
			PersonInformationEntity personInfo = personService.getPersonInformationByPesronId(personId);
			
			if (personInfo == null) {
				//本地查不到居民信息，在页面上展示提示
				model.addAttribute("personInfoMsg","家庭医生系统未查到居民信息，但不影响体检编辑操作。可联系维护人员同步数据");
				personInfo = new PersonInformationEntity();
				personInfo.setPersonId(personId);
			} else {
				Date dateOfBirth = personInfo.getDateOfBirth();
				//封装体检时的年龄
				if (dateOfBirth == null || "".equals(dateOfBirth)) {
					model.addAttribute("ExamAge", "");
				} else {
					Date queryExamDate = DateUtils.parseDate(queryExamDateStr);
					String age = String.valueOf(getAge(dateOfBirth, queryExamDate));
					model.addAttribute("ExamAge", age);
				}
			}
			//将居民信息写入作用域
			model.addAttribute("personInfo", personInfo);
			
			// 上一次体检时间
			if (listExamId.size() == 1 || (listExamId.lastIndexOf(queryExamId) == listExamId.size() - 1)) {
				//如果体检日期列表只有一次，或者当前体检是体检列表中的最后一次，说明只做了一次体检，默认上次体检也是当前这一次
				beforeQueryExamId = queryExamId;
				
			} else {
				//如果不满足上述条件，则为当前元素的下一个元素ID
				beforeQueryExamId = listExamId.get(listExamId.lastIndexOf(queryExamId) + 1);
			}
			

			//通过personId和日期，调用接口56-7获取上一次体检信息
			Map<String, Object> beforeExamParam = new HashMap<String, Object>();
			beforeExamParam.put("ProductCode", vo.getProductCode());
			beforeExamParam.put("MtID", beforeQueryExamId);

			String beforeExamResponse = RestfulUtils.getPublicData("56-4", beforeExamParam);
			//解析上一次体检信息
			Map<String, Object> beforeExamResponseMap = JsonUtils.getObjectJsonMap(beforeExamResponse);
			Map<String, Object> beforeExamInfo = new HashMap<String, Object>();
			
			if (beforeExamResponseMap.get("Result") != null
					&& (Integer) beforeExamResponseMap.get("Result") != 0) {
				beforeExamInfo = (Map<String, Object>) beforeExamResponseMap.get("Msg");
				beforeExamInfo = (Map<String, Object>) beforeExamInfo.get("body");
				//处理体检日期
				if (beforeExamInfo.get("ExamDate") != null && StringUtils.isNotEmpty((String)beforeExamInfo.get("ExamDate"))) {
					String dateNum = StringUtils.getStringNum((String)beforeExamInfo.get("ExamDate"));
					Long timeStamp = Long.parseLong(dateNum);
					if (StringUtils.isNotEmpty(dateNum)) {
						beforeExamInfo.put("ExamDate", DateUtils.formatDate(new Date(timeStamp)));
					}
				}
				model.addAttribute("beforeExamInfo", beforeExamInfo);
			}
			
			// 获取本次检查结果
			Map<String, Object> detailParamMap = new HashMap<String, Object>();
			detailParamMap.put("ProductCode", vo.getProductCode());
			detailParamMap.put("MtID", queryExamId);
			
			String examInfoResponse = RestfulUtils.getPublicData("56-4", detailParamMap);
			Map<String, Object> examInfoResponseMap = JsonUtils
					.getObjectJsonMap(examInfoResponse);

			if (examInfoResponseMap.get("Result") != null
					|| (Integer) examInfoResponseMap.get("Result") != 0) {

				//解析map，封装为前台需要的数据结构
				Map<String, Object> examDetailInfo = dealDetailInfo(examInfoResponseMap, queryExamId);
				
				// 体检时间和随访ID ProductCode
				model.addAttribute("listMtIdAndExamDate", listMiIdAndExamDate);
				model.addAttribute("RecordOneJson",
						JsonUtils.getJsonFormat(examDetailInfo));
			}
		}
		model.addAttribute("doctorName", vo.getDocName());
		model.addAttribute("ProductCode", vo.getProductCode());
		
		
		return "/examination/physicalEdit";
	}
	
	
	/**
	 * 老年人认知功能页面
	 */
	@RequestMapping(value = "/oldPersonCognizePage", method = RequestMethod.GET)
	public String oldPersonCognizePage(HttpServletRequest request, Model model, String scoreContainerId) {
		//把id写入作用域
		model.addAttribute("scoreContainerId", scoreContainerId);
		
		return "/examination/oldPersoncognize";
	}
	
	/**
	 * 老年人情感状态页面
	 */
	@RequestMapping(value = "/oldPersonFeelingPage", method = RequestMethod.GET)
	public String oldPersonfeeling(HttpServletRequest request, Model model, String scoreContainerId) {
		//把id写入作用域
		model.addAttribute("scoreContainerId", scoreContainerId);
		
		return "/examination/oldPersonfeeling";
	}
	
	/**
	 * 个人体检列表页面
	 */
	@RequestMapping(value = "/personExaminationListPage", method = RequestMethod.GET)
	public String personExaminationListPage(HttpServletRequest request, Model model, String personId) {
		//把personId写入作用域
		model.addAttribute("personId", personId);
		
		return "/examination/personExaminationList";
	}
	
	/**
	 * 个人体检详情页面
	 */
	@RequestMapping(value = "/examDetailPage", method = RequestMethod.GET)
	public String examDetailPage(HttpServletRequest request, Model model, String examId, String personId) {
		// 获取当前登录用户的productCode
		DoctorDetailVo vo = (DoctorDetailVo) request.getSession()
						.getAttribute("doctorInfo");
		// personId查询居民信息
		PersonInformationEntity personInfo = personService.getPersonInformationByPesronId(personId);
		
		if (personInfo == null) {
			//本地查不到居民信息，在页面上展示提示
			model.addAttribute("personInfoMsg","家庭医生系统未查到居民信息，但不影响体检查看操作。可联系维护人员同步数据");
			personInfo = new PersonInformationEntity();
			personInfo.setPersonId(personId);
		}
		model.addAttribute("personInfo", personInfo);
		
		// 获取本次检查结果
		Map<String, Object> detailParamMap = new HashMap<String, Object>();
		detailParamMap.put("ProductCode", vo.getProductCode());
		detailParamMap.put("MtID", examId);
		
		String examInfoResponse = RestfulUtils.getPublicData("56-4", detailParamMap);
		System.out.println(examInfoResponse);
		Map<String, Object> examInfoResponseMap = JsonUtils
				.getObjectJsonMap(examInfoResponse);

		if (examInfoResponseMap.get("Result") != null
				|| (Integer) examInfoResponseMap.get("Result") != 0) {

			//解析map，封装为前台需要的数据结构
			Map<String, Object> examDetailInfo = dealDetailInfo(examInfoResponseMap, examId);
			
			// 体检时间和随访ID ProductCode
			model.addAttribute("RecordOneJson",
					JsonUtils.getJsonFormat(examDetailInfo));
		}
		
		return "/examination/examDetail";
	}
	

	/**
	 * 计算年龄
	 * @param birthday
	 * @param date
	 * @return
	 */
	private int getAge(Date birthday, Date date) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(date);
		long nowmillSeconds = c1.getTimeInMillis();

		Calendar c2 = Calendar.getInstance();
		c2.setTime(birthday);
		long birmillSeconds = c2.getTimeInMillis();

		Calendar c3 = Calendar.getInstance();
		long millis = nowmillSeconds - birmillSeconds;
		c3.setTimeInMillis(millis);

		int year = c3.get(Calendar.YEAR);
		if (year > 1970) {
			return year - 1970;
		}
		return year;

	}
	
	/**
	 * 
	 * dealExplain:(处理用|隔开的部分). <br/>
	 * @author q
	 * @param field 字段名
	 * @param suffix  字段描述的后缀
	 * @param itemMap  目标map
	 * @return
	 */
	public void dealExplain(String field, String suffix, Map<String, Object> itemMap){
		
		//非空判断
		if (itemMap.get(field) != null && StringUtils.isNotEmpty((String)itemMap.get(field))) {
			if (((String)itemMap.get(field)).contains("|")) {
				if (!((String)itemMap.get(field)).equals("|")) {
					//按照|分割为数组
					String[] split = ((String)itemMap.get(field)).split("\\|");
					//重新填装字段
					if (split.length > 0) {
						itemMap.put(field, split[0]);
					}
					if (split.length > 1) {
						itemMap.put(field + suffix, split[1]);
					}
				}else {
					itemMap.put(field + suffix, "");
					itemMap.put(field, null);
				}
			}
		}
	}
	
	/**
	 * 处理体检详情通用方法
	 * @param jsonMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> dealDetailInfo(Map<String, Object> jsonMap, String examId){
		Map<String, Object> map = new HashMap<String, Object>();
		map = (Map<String, Object>) jsonMap.get("Msg");
		
		map.put("MtID", examId);
		// 获取随访时间数据，把返回的"Date(时间戳)"的数据格式改成yyyy-MM-dd的时间格式

		if (((Map<String, Object>) map.get("master")).get("ExamDate") != null
				&& !"".equals(((Map<String, Object>) map.get("master"))
						.get("ExamDate"))) {
			String adate = (String) (((Map<String, Object>) map
					.get("master")).get("ExamDate"));
			String regEx = "[^0-9]";
			Pattern p = Pattern.compile(regEx);
			Matcher m = p.matcher(adate);
			Long ExamDateLong = Long.parseLong(m.replaceAll("").trim());
			String examDate = DateUtils.formatDate(new Date(ExamDateLong));
			map.put("ExamDate", examDate);
			((Map<String, Object>) map.get("master")).put("ExamDate",
					examDate);
		}

		// 处理时间，转化为yyyy-mm-dd格式
		if (((List<Map<String, Object>>) map.get("vaccList")) != null
				&& !"".equals(((List<Map<String, Object>>) map.get("vaccList")))) {
			for (int i = 0; i < ((List<Map<String, Object>>) map.get("vaccList"))
					.size(); i++) {
				if (((List<Map<String, Object>>) map.get("vaccList")).get(i).get(
						"VaccDate") != null) {
					
					String vaccDate = StringUtils.getStringNum((String)((List<Map<String, Object>>) map.get("vaccList")).get(i).get("VaccDate"));
					Long timeStamp = Long.parseLong(vaccDate);
					
					((List<Map<String, Object>>) map.get("vaccList")).get(i).put("VaccDate", DateUtils.formatDate(new Date(timeStamp)));
					
				}
				if (((List<Map<String, Object>>) map.get("vaccList")).get(i).get(
						"ExamDate") != null) {
					((List<Map<String, Object>>) map.get("vaccList")).get(i).remove(
							"ExamDate");
				}
			}
		}
		//
		if (((List<Map<String, Object>>) map.get("drugUseList")) != null
				&& !"".equals(((List<Map<String, Object>>) map.get("drugUseList")))) {
			for (int i = 0; i < ((List<Map<String, Object>>) map.get("drugUseList"))
					.size(); i++) {
				if (((List<Map<String, Object>>) map.get("drugUseList")).get(i).get(
						"ExamDate") != null) {
					((List<Map<String, Object>>) map.get("drugUseList")).get(i).remove(
							"ExamDate");
				}
			}
		}

		//
		if (((List<Map<String, Object>>) map.get("hosList")) != null
				&& !"".equals(((List<Map<String, Object>>) map.get("hosList")))) {
			for (int i = 0; i < ((List<Map<String, Object>>) map.get("hosList")).size(); i++) {
				
				if (((List<Map<String, Object>>) map.get("hosList")).get(i).get(
						"InDate") != null) {
					String inDate = StringUtils.getStringNum((String)((List<Map<String, Object>>) map.get("hosList")).get(i).get("InDate"));
					Long timeStamp = Long.parseLong(inDate);
					
					((List<Map<String, Object>>) map.get("hosList")).get(i).put("InDate", DateUtils.formatDate(new Date(timeStamp)));
				}
				if (((List<Map<String, Object>>) map.get("hosList")).get(i).get(
						"OutDate") != null) {
					String outDate = StringUtils.getStringNum((String)((List<Map<String, Object>>) map.get("hosList")).get(i).get("OutDate"));
					Long timeStamp = Long.parseLong(outDate);
					((List<Map<String, Object>>) map.get("hosList")).get(i).put("OutDate", DateUtils.formatDate(new Date(timeStamp)));
				}
			}
		}

		// 分隔符处理 脏器功能回显 BreathSounds

		Map<String, Object> organ = (Map<String, Object>) map.get("organ");
		if (map.get("organ") != null) {
			String Fundus = (String) organ.get("Fundus");
			if (StringUtils.isNotEmpty((Fundus))) {
				dealExplain("Fundus", "Reason", organ);
			}

			String BreathSounds = (String) organ.get("BreathSounds");
			if (StringUtils.isNotEmpty(BreathSounds)) {
				dealExplain("BreathSounds", "Reason", organ);
			}

			String HeartMurmur = (String) organ.get("HeartMurmur");
			if (StringUtils.isNotEmpty(HeartMurmur)) {
				dealExplain("HeartMurmur", "Reason", organ);
			}

			String AbdominalTenderness = (String) organ.get("AbdominalTenderness");
			if (StringUtils.isNotEmpty(AbdominalTenderness)) {
				dealExplain("AbdominalTenderness", "Reason", organ);
			}

			String AbdominalMass = (String) organ.get("AbdominalMass");
			if (StringUtils.isNotEmpty(AbdominalMass)) {
				dealExplain("AbdominalMass", "Reason", organ);
			}

			String TheAbdomenLiver = (String) organ.get("TheAbdomenLiver");
			if (StringUtils.isNotEmpty(TheAbdomenLiver)) {
				dealExplain("TheAbdomenLiver", "Reason", organ);
			}

			String Splenomegaly = (String) organ.get("Splenomegaly");
			if (StringUtils.isNotEmpty(Splenomegaly)) {
				dealExplain("Splenomegaly", "Reason", organ);
			}

			String ShiftingDullness = (String) organ.get("ShiftingDullness");
			if (StringUtils.isNotEmpty(ShiftingDullness)) {
				dealExplain("ShiftingDullness", "Reason", organ);
			}
			
			map.put("organ", organ);

		}
		//分隔符处理 妇科
		Map<String, Object> women = (Map<String, Object>) map.get("woman");
		if (women != null) {

			String Vulva = (String) women.get("Vulva");
			if (StringUtils.isNotEmpty(Vulva)) {
				dealExplain("Vulva", "Reason", women);
			}

			String Vaginal = (String) women.get("Vulva");
			if (StringUtils.isNotEmpty(Vaginal)) {
				dealExplain("Vaginal", "Reason", women);
			}

			String Cervix = (String) women.get("Cervix");
			if (StringUtils.isNotEmpty(Cervix)) {
				dealExplain("Cervix", "Reason", women);
			}

			String Palace = (String) women.get("Palace");
			if (StringUtils.isNotEmpty(Palace)) {
				dealExplain("Palace", "Reason", women);
			}

			String UterineAdnexa = (String) women.get("UterineAdnexa");
			if (StringUtils.isNotEmpty(UterineAdnexa)) {
				dealExplain("UterineAdnexa", "Reason", women);
			}

		}
		map.put("woman", women);
		
		//分隔符处理  辅助检查
		Map<String, Object> labora = (Map<String, Object>) map.get("labora");
		if (labora != null) {
			String ecg = (String) labora.get("Ecg");
			if (StringUtils.isNotEmpty(ecg)) {
				dealExplain("Ecg", "Reason", labora);
			}
			
			String chestXRay = (String) labora.get("ChestXRay");
			if (StringUtils.isNotEmpty(chestXRay)) {
				dealExplain("ChestXRay", "Reason", labora);
			}
			
			String buiTrasonicWave = (String) labora.get("BUltrasonicWave");
			if (StringUtils.isNotEmpty(buiTrasonicWave)) {
				dealExplain("BUltrasonicWave", "Reason", labora);
			}
			
			String cervicalSmear = (String) labora.get("CervicalSmear");
			if (StringUtils.isNotEmpty(cervicalSmear)) {
				dealExplain("CervicalSmear", "Reason", labora);
			}
		}
		map.put("labora", labora);

		// 获取症状信息，把2的幂次表示法分割为逗号隔开的数组 
		if (((Map<String, Object>) map.get("master")).get("Symptom") != null) {
			Integer symptomInt = ((Integer) ((Map<String, Object>) map.get("master"))
					.get("Symptom"));

			((Map<String, Object>) map.get("master")).put("Symptom",
					NumberUtils.bitand(symptomInt));
		}
		
		// 获取健康指导信息，把2的幂次表示法分割为逗号隔开的数组 
		if (((Map<String, Object>) map.get("master")).get("Guidance") != null) {
			Integer GuidanceInt = ((Integer) ((Map<String, Object>) map.get("master"))
					.get("Guidance"));

			((Map<String, Object>) map.get("master")).put("Guidance",
					NumberUtils.bitand(GuidanceInt));
		}
		
		// 获取危险控制因素，把2的幂次表示法分割为逗号隔开的数组 
		if (((Map<String, Object>) map.get("master")).get("RiskCrtl") != null) {
			Integer RiskCrtlInt = ((Integer) ((Map<String, Object>) map.get("master"))
					.get("RiskCrtl"));

			((Map<String, Object>) map.get("master")).put("RiskCrtl",
					NumberUtils.bitand(RiskCrtlInt));
		}
		
		//处理otherText字段
		Map<String, Object> otherMap = new HashMap<String, Object>();
		if (map.get("otherText") != null && StringUtils.isNotEmpty(((String) map.get("otherText")))) {
			otherMap = JsonUtils.getObjectJsonMap(((String) map.get("otherText")).replaceAll("'", "\""));
		}
		map.put("otherText", otherMap);
		
		return map;
	}
}
