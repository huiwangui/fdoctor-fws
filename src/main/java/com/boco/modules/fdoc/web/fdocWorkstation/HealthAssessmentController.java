package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.constants.BusinessConstants;
import com.boco.common.enums.ApiStatusEnum;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.persistence.Page;
import com.boco.common.push.CloudMobilePush;
import com.boco.common.push.PushUtils;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.model.HealthAssessmentEntity;
import com.boco.modules.fdoc.model.SendMsgEntity;
import com.boco.modules.fdoc.service.HealthAssesmentService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SendMsgService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.HealthAssessmentVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;

/**
 * 评估
 * 
 * @author j
 *
 * @date 2017年7月4日
 */
@Controller
@RequestMapping(value = "/physicleAssessment", produces = "text/json;charset=utf-8")
public class HealthAssessmentController {
	
	

	@Resource
	HealthAssesmentService assessmentService;
	@Resource
	PersonInformationService personService;
	@Resource
	SendMsgService sendMsgService;
	
	
	/** 
     * 跳转页面  评估列表
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/goList",method = RequestMethod.GET)
	public String getAllList(HttpServletRequest req, Model model){
		return "/healthAdmin/assessment/assessmentList";
	}
	
	/** 
     * 跳转页面  评估详情
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/detail",method = RequestMethod.GET)
	public String detail(HttpServletRequest req, Model model,Integer id){
		HealthAssessmentVo detail = assessmentService.getHealthAssessmentDetail(id);
		model.addAttribute("crtime", DateUtils.formatDateTime(detail.getCreateTime()));
		model.addAttribute("detail", detail);
		
		//组合关键字
		StringBuffer keyWords = new StringBuffer("");
		// 异常类型，2为血糖1为血压
		if (detail.getBloodSuger() == null || detail.getBloodSuger() == 0) {
			keyWords.append("血压");
			switch (detail.getDetectionResult()) {
			case BusinessConstants.HYPERTENSION_RESULT_HIGH_LEVEL1:
				keyWords.append("轻度偏高");
				break;
			case BusinessConstants.HYPERTENSION_RESULT_HIGH_LEVEL2:
				keyWords.append("中度偏高");
				break;
			case BusinessConstants.HYPERTENSION_RESULT_HIGH_LEVEL3:
				keyWords.append("重度偏高");
				break;	
			case BusinessConstants.HYPERTENSION_RESULT_LOW:
				keyWords.append("偏低");
				break;
			default:
				break;
			}
		}else {
			keyWords.append("血糖");
			switch (detail.getDetectionResult()) {
			case BusinessConstants.BLOOD_SUGER_HIGH_LEVEL1:
				keyWords.append("轻度偏高");
				break;
			case BusinessConstants.BLOOD_SUGER_HIGH_LEVEL2:
				keyWords.append("中度偏高");
				break;
			case BusinessConstants.BLOOD_SUGER_HIGH_LEVEL3:
				keyWords.append("重度偏高");
				break;	
			case BusinessConstants.BLOOD_SUGER_LOW:
				keyWords.append("偏低");
				break;
			default:
				break;
			}
		}
		
		//将关键字写入作用域
		model.addAttribute("keyWords", keyWords.toString());
		return "/healthAdmin/assessment/assessmentDetail";
	}
	
	/** 
     * 跳转页面  评估添加
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/hand",method = RequestMethod.GET)
	public String hand(HttpServletRequest req, Model model,Integer id){
		HealthAssessmentVo detail = assessmentService.getHealthAssessmentDetail(id);
		model.addAttribute("crtime", DateUtils.formatDateTime(detail.getCreateTime()));
		model.addAttribute("detail", detail);
		//组合关键字
		StringBuffer keyWords = new StringBuffer("");
		// 异常类型，2为血糖1为血压
		if (detail.getBloodSuger() == null || detail.getBloodSuger() == 0) {
			keyWords.append("血压");
			switch (detail.getDetectionResult()) {
			case BusinessConstants.HYPERTENSION_RESULT_HIGH_LEVEL1:
				keyWords.append("轻度偏高");
				break;
			case BusinessConstants.HYPERTENSION_RESULT_HIGH_LEVEL2:
				keyWords.append("中度偏高");
				break;
			case BusinessConstants.HYPERTENSION_RESULT_HIGH_LEVEL3:
				keyWords.append("重度偏高");
				break;	
			case BusinessConstants.HYPERTENSION_RESULT_LOW:
				keyWords.append("偏低");
				break;
			default:
				break;
			}
		}else {
			keyWords.append("血糖");
			switch (detail.getDetectionResult()) {
			case BusinessConstants.BLOOD_SUGER_HIGH_LEVEL1:
				keyWords.append("轻度偏高");
				break;
			case BusinessConstants.BLOOD_SUGER_HIGH_LEVEL2:
				keyWords.append("中度偏高");
				break;
			case BusinessConstants.BLOOD_SUGER_HIGH_LEVEL3:
				keyWords.append("重度偏高");
				break;	
			case BusinessConstants.BLOOD_SUGER_LOW:
				keyWords.append("偏低");
				break;
			default:
				break;
			}
		}
		
		//将关键字写入作用域
		model.addAttribute("keyWords", keyWords.toString());
		return "/healthAdmin/assessment/assessmentHand";
	}

	/** 
     * 评估添加
     * @param id
     * @return
     *
     */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/handler",method = RequestMethod.POST)
	public String handler(HttpServletRequest req,Integer id,String pcontent,String medicationGuide){
		//从作用域中获取医生信息
		Map<String, String> docMap = (Map<String, String>) req.getSession().getAttribute("doc_session");
		
		//准备推送参数
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		//获取评估情况
		HealthAssessmentVo detail = assessmentService.getHealthAssessmentDetail(id);
		if (detail == null) {
			return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.ASSESSMENT_NOT_FOUND.getKey(),
							ApiStatusEnum.ASSESSMENT_NOT_FOUND.getValue()));
		}
		HealthAssessmentEntity entity=new HealthAssessmentEntity();
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		if(!"1".equals(doctorInfo.getDocType())){
			return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.ASSESSMENT_NO_POWER.getKey(),
					ApiStatusEnum.ASSESSMENT_NO_POWER.getValue()));
		}
        //实体赋值
		entity.setId(id);
		entity.setDocId(doctorInfo.getId());
		entity.setAssessmentTime(new Date());
		entity.setContent(pcontent);
		entity.setMedicationGuide(medicationGuide);
		// 异常类型，2为血糖1为血压
		if (detail.getBloodSuger() == null || detail.getBloodSuger() == 0) {
			paramMap.put("exceptionType", BusinessConstants.HEALTH_ASSESSMENT_TYPE_HYPER);
			entity.setTitle("血压");
		}else {
			paramMap.put("exceptionType", BusinessConstants.HEALTH_ASSESSMENT_TYPE_BLOODSUGER);
			entity.setTitle("血糖");
		}
		assessmentService.updateHealthAssesment(entity);
		
		// 推送给居民端
		PersonInformationVo personVo = personService.getPersonDetailByPersonId(detail.getPersonId());
		CloudMobilePush push = new CloudMobilePush();
		
		paramMap.put("id", entity.getId());
		
		// 判断具体是偏高还是偏低
		if (BusinessConstants.HYPERTENSION_RESULT_LOW.equals(detail.getDetectionResult())) {
			paramMap.put("result", "1");
		}else {
			paramMap.put("result", "3");
		}
		List<String> accounts = new ArrayList<String>();
		accounts.add(personVo.getUid());
		String title = "您有新的健康评估！";
		String content = "您的家庭医生"+docMap.get("docName")+"给您新增了健康评估！";
		push.androidPush(accounts, title, content, 
				BusinessConstants.PUSH_ACTIVITY, BusinessConstants.PUSH_ITEM_USER, PushUtils.packPushParam(BusinessConstants.PUSH_TYPE_HEALTH_ASSESSMENT, paramMap));
		/**
		 * 插入推送消息表
		 */
		SendMsgEntity msg = new SendMsgEntity(title,content,BusinessConstants.PUSH_ITEM_USER_INT,
				BusinessConstants.PUSH_TYPE_HEALTH_ASSESSMENT,JsonUtils.getJsonFormat(paramMap));
		for (String account : accounts) {
			msg.setUid(account);
			sendMsgService.addMsg(msg);
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	/**
	 * 评估列表主页
	 * @param req
	 * @param model
	 * @param status
	 * @param beginTime
	 * @param endTime
	 * @param personName
	 * @param pageSize
	 * @param pageIndex
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/indexList",method = RequestMethod.GET)
	public String indexList(HttpServletRequest req, Model model,@RequestParam String status,
			@RequestParam String beginTime,@RequestParam String endTime,@RequestParam String personName,
			@RequestParam Integer pageSize, @RequestParam Integer pageIndex){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		HealthAssessmentVo vo = new HealthAssessmentVo();
		vo.setDocTeamId(doctorInfo.getTeamId());
		vo.setStatus(status);
		if(StringUtils.isNotEmpty(beginTime.trim())){
			vo.setBeginDate(DateUtils.parseDate(beginTime));
		}
		
		if(StringUtils.isNotEmpty(endTime.trim())){
			Calendar   calendar   =   new   GregorianCalendar(); 
			calendar.setTime(DateUtils.parseDate(endTime)); 
		    calendar.add(calendar.DATE,1);
			vo.setEndDate(calendar.getTime());
		}
		
		vo.setPersonName(personName);
		if("1".equals(status)){
			if(beginTime.trim()!=""||endTime.trim()!=""){
				//获取总数
				Integer count = assessmentService.getHealthAssessmentCount(vo);
				//封装分页对象
				Page<HealthAssessmentVo> page = new Page<HealthAssessmentVo>(pageIndex, pageSize);
				vo.setPage(page);
				//查询list并返回
				List<HealthAssessmentVo> list = assessmentService.getHealthAssessmentWithStatusEq1List(vo);
				for (HealthAssessmentVo healthAssessmentVo : list) {
					
					// 获取居民详情
					PersonInformationVo personDetail = personService.getPersonDetailByPersonId(healthAssessmentVo.getPersonId());
					if("1".equals(personDetail.getSex())){
						personDetail.setSex("男");
					}else if("2".equals(personDetail.getSex())){
						personDetail.setSex("女");
					}else{
						personDetail.setSex("不详");
					}
					healthAssessmentVo.setAge(String.valueOf(personDetail.getAge()));
					healthAssessmentVo.setSex(personDetail.getSex());
				}
				return JsonUtils.getJson(BaseJsonVo.pageList(list, count),BusinessConstants.JSON_ALL);
				
			}else{
				//获取总数
				Integer count = assessmentService.getHealthAssessmentCount(vo);
				//封装分页对象
				Page<HealthAssessmentVo> page = new Page<HealthAssessmentVo>(pageIndex, pageSize);
				vo.setPage(page);
				//查询list并返回
				List<HealthAssessmentVo> list = assessmentService.getHealthAssessmentList(vo);
				for (HealthAssessmentVo healthAssessmentVo : list) {
					
					// 获取居民详情
					PersonInformationVo personDetail = personService.getPersonDetailByPersonId(healthAssessmentVo.getPersonId());
					if("1".equals(personDetail.getSex())){
						personDetail.setSex("男");
					}else if("2".equals(personDetail.getSex())){
						personDetail.setSex("女");
					}else{
						personDetail.setSex("不详");
					}
					healthAssessmentVo.setAge(String.valueOf(personDetail.getAge()));
					healthAssessmentVo.setSex(personDetail.getSex());
				}
				return JsonUtils.getJson(BaseJsonVo.pageList(list, count),BusinessConstants.JSON_ALL);
				
			}
		}
		//获取总数
		Integer count = assessmentService.getHealthAssessmentCount(vo);
		//封装分页对象
		Page<HealthAssessmentVo> page = new Page<HealthAssessmentVo>(pageIndex, pageSize);
		vo.setPage(page);
		//查询list并返回
		List<HealthAssessmentVo> list = assessmentService.getHealthAssessmentList(vo);
		for (HealthAssessmentVo healthAssessmentVo : list) {
			
			// 获取居民详情
			PersonInformationVo personDetail = personService.getPersonDetailByPersonId(healthAssessmentVo.getPersonId());
			if("1".equals(personDetail.getSex())){
				personDetail.setSex("男");
			}else if("2".equals(personDetail.getSex())){
				personDetail.setSex("女");
			}else{
				personDetail.setSex("不详");
			}
			healthAssessmentVo.setAge(String.valueOf(personDetail.getAge()));
			healthAssessmentVo.setSex(personDetail.getSex());
		}
		return JsonUtils.getJson(BaseJsonVo.pageList(list, count),BusinessConstants.JSON_ALL);
	}
	
	
}
