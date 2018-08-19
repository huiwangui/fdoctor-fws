package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.Date;
import java.util.List;

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
import com.boco.common.exception.BusinessException;
import com.boco.common.jedis.JedisUtils;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.persistence.Page;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.modules.fdoc.service.FdoctorUPplanService;
import com.boco.modules.fdoc.service.HospitalService;
import com.boco.modules.fdoc.service.OrderImmuneService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SignService;
import com.boco.modules.fdoc.service.UserService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.FollowUpOrderVo;
import com.boco.modules.fdoc.vo.OrderImmuneVo;
import com.boco.modules.fdoc.vo.OrderParamVo;
import com.boco.modules.fdoc.vo.UpPlanVo;

/**
 * 预约管理（随访，免疫，体检）
 * 
 * @author j
 *
 * @date 2017年6月12日
 */
@Controller
@RequestMapping(value = "/appointment", produces = "text/json;charset=utf-8")
public class AppointmentController {
	@Resource
	HospitalService hospitalService;
	@Resource
	OrderImmuneService orderImmuneService;
	@Resource
	PersonInformationService personService;
	@Resource
	SignService signService;
	@Resource
	UserService userService; 
	
	//预约随访
	@RequestMapping(value = "/followPlan",method = RequestMethod.GET)
	public String getFllowPlan(HttpServletRequest req, Model model,@RequestParam String userName){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		OrderParamVo vo = new OrderParamVo();
		vo.setTeamId(doctorInfo.getTeamId());
		vo.setOrderStatus("0");	
		int count=orderImmuneService.getFollowUpOrderSumByuid(vo);
	    vo.setTime("1");
	    int t1=orderImmuneService.getFollowUpOrderSumByuid(vo);	
	    vo.setTime("2");
	    int t2=orderImmuneService.getFollowUpOrderSumByuid(vo);	
	    vo.setTime("7");
	    int t7=orderImmuneService.getFollowUpOrderSumByuid(vo);	
	    model.addAttribute("t1", t1);
	    model.addAttribute("t2", t2);
	    model.addAttribute("t7", t7);
	    System.out.println(userName);
	    System.out.println(t1);
	    System.out.println(t2);
	    System.out.println(t7);
		return "/appointment/followUp";
	}
	//预约随访详情
	@RequestMapping(value = "/followDetail",method = RequestMethod.GET)
	public String followDetail(HttpServletRequest request, Model model,@RequestParam String orderNumber){
		OrderParamVo vo = new OrderParamVo();
		vo.setOrderNumber(orderNumber);
		OrderImmuneVo orderImmuneVo=orderImmuneService.getFollowUpOrderDetailByDoc(vo);
		 model.addAttribute("ovo", orderImmuneVo);
		return "/appointment/followDetail";
	}
	//随访列表
	@RequestMapping(value = "/queryFollow",method = RequestMethod.GET)
	@ResponseBody
	public String queryFollow(HttpServletRequest req,Model mode,@RequestParam String userName,@RequestParam String beginTime,@RequestParam String endTime, @RequestParam String status, 
			@RequestParam String time,@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		OrderParamVo vo = new OrderParamVo();
		vo.setTeamId(doctorInfo.getTeamId());
		if("1".equals(status)||"3".equals(status)){
		    vo.setOrderStatus(status);
		}else{
			vo.setOrderStatus("0");	
		}
		vo.setBeginTime(DateUtils.parseDate(beginTime));
		vo.setEndTime(DateUtils.parseDate(endTime));
		vo.setTime(time);
		// 封装分页对象
		Page<OrderParamVo> page = new Page<OrderParamVo>(pageIndex,pageSize);
		vo.setPage(page);
		List<FollowUpOrderVo> list=orderImmuneService.getFollowUpOrderList(vo);
		//预约总数
		int count=orderImmuneService.getFollowUpOrderSumByuid(vo);
	    return JsonUtils.getJson(BaseJsonVo.pageList(list, count),BusinessConstants.JSON_ALL);
	}
	
	//预约免疫跳转页面
	@RequestMapping(value = "/immunity",method = RequestMethod.GET)
	public String immunity(HttpServletRequest req, Model model,@RequestParam String userName) throws Exception{
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		OrderParamVo vo = new OrderParamVo();
		vo.setOrgId(doctorInfo.getOrgId());
		vo.setOrderStatus("0");	
		vo.setTime("1");
		List<OrderImmuneVo> list1=orderImmuneService.getImmuneOrderListOfHistoryByDoc(vo);
		vo.setTime("2");
		List<OrderImmuneVo> list2=orderImmuneService.getImmuneOrderListOfHistoryByDoc(vo);
		vo.setTime("7");
		System.out.println("开始查询"+vo.getOrgId());
		List<OrderImmuneVo> list7=orderImmuneService.getImmuneOrderListOfHistoryByDoc(vo);
		System.out.println("本周查询结束"+vo.getTime()+"结果为"+list7.size());
	    model.addAttribute("t1", list1.size());
	    model.addAttribute("t2", list2.size());
	    model.addAttribute("t7", list7.size());
	    System.out.println(userName);
		return "/appointment/immunity";
	}
	
    //免疫列表
	@RequestMapping(value = "/queryImmunity",method = RequestMethod.GET)
	@ResponseBody
	public String queryImmunity(HttpServletRequest req,Model mode,@RequestParam String userName,@RequestParam String beginTime,@RequestParam String endTime, @RequestParam String status, 
			@RequestParam String time,@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {
		//通过医生获取机构ID
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		OrderParamVo vo = new OrderParamVo();
		vo.setOrgId(doctorInfo.getOrgId());
		if("1".equals(status)||"3".equals(status)){
		    vo.setOrderStatus(status);
		}else{
			vo.setOrderStatus("0");	
		}
		vo.setBeginTime(DateUtils.parseDate(beginTime));
		vo.setEndTime(DateUtils.parseDate(endTime));
		vo.setTime(time);
		// 封装分页对象
		Page<OrderParamVo> page = new Page<OrderParamVo>(pageIndex,pageSize);
		vo.setPage(page);
		List<OrderImmuneVo> list=orderImmuneService.getImmuneOrderListOfHistoryByDoc(vo);
		
		
		
	    return JsonUtils.getJson(BaseJsonVo.pageList(list, list.size()),BusinessConstants.JSON_ALL);
	}
	//预约免疫详情
	@RequestMapping(value = "/immunityDetail",method = RequestMethod.GET)
	public String immunityDetail(HttpServletRequest request, Model model,@RequestParam String orderNumber){
		OrderParamVo vo = new OrderParamVo();
		vo.setOrderNumber(orderNumber);
		OrderImmuneVo orderImmuneVo=orderImmuneService.getImmuneOrderDetailByDoc(vo);
		 model.addAttribute("ovo", orderImmuneVo);
		return "/appointment/immunityDetail";
	}

	//预约体检
	@RequestMapping(value = "/examination",method = RequestMethod.GET)
	public String examination(HttpServletRequest req, Model model,@RequestParam String userName){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		OrderParamVo vo = new OrderParamVo();
		vo.setUserName(userName);
		vo.setOrderStatus("0");	
		vo.setTeamId(doctorInfo.getTeamId());
		vo.setTime("1");
		List<OrderImmuneVo> list1=orderImmuneService.getPhysicalExaminationOrderListOfHistoryByDoc(vo);
		vo.setTime("2");
		List<OrderImmuneVo> list2=orderImmuneService.getPhysicalExaminationOrderListOfHistoryByDoc(vo);
		vo.setTime("7");
		List<OrderImmuneVo> list7=orderImmuneService.getPhysicalExaminationOrderListOfHistoryByDoc(vo);
	    model.addAttribute("t1", list1.size());
	    model.addAttribute("t2", list2.size());
	    model.addAttribute("t7", list7.size());
	    System.out.println(userName);
		return "/appointment/examination";
	}
	//体检列表
	@RequestMapping(value = "/queryExamination",method = RequestMethod.GET)
	@ResponseBody
	public String queryExamination(HttpServletRequest req,Model mode,@RequestParam String userName,@RequestParam String beginTime,@RequestParam String endTime, @RequestParam String status, 
			@RequestParam String time,@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		OrderParamVo vo = new OrderParamVo();
		vo.setTeamId(doctorInfo.getTeamId());
		if("1".equals(status)||"3".equals(status)){
		    vo.setOrderStatus(status);
		}else{
			vo.setOrderStatus("0");	
		}
		vo.setBeginTime(DateUtils.parseDate(beginTime));
		vo.setEndTime(DateUtils.parseDate(endTime));
		vo.setTime(time);
		// 封装分页对象
		Page<OrderParamVo> page = new Page<OrderParamVo>(pageIndex,pageSize);
		vo.setPage(page);
		List<OrderImmuneVo> list=orderImmuneService.getPhysicalExaminationOrderListOfHistoryByDoc(vo);
		
		
	    return JsonUtils.getJson(BaseJsonVo.pageList(list, list.size()),BusinessConstants.JSON_ALL);
	}
	
	//预约体检详情
	@RequestMapping(value = "/examinationDetail",method = RequestMethod.GET)
	public String examinationDetail(HttpServletRequest request, Model model,@RequestParam String orderNumber){
		OrderParamVo vo = new OrderParamVo();
		vo.setOrderNumber(orderNumber);
		OrderImmuneVo orderImmuneVo=orderImmuneService.getPhysicalExaminationOrderDetailByDoc(vo);
		 model.addAttribute("ovo", orderImmuneVo);
		 System.out.println("JSONP选择性:"+JsonUtils.getJsonFormat(orderImmuneVo));
		return "/appointment/examinationDetail";
	}
	
	
}
