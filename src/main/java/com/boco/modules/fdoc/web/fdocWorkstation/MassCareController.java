package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.boco.common.push.CloudMobilePush;
import com.boco.common.push.PushUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.modules.fdoc.model.GroupMsgTemplateEntity;
import com.boco.modules.fdoc.model.SendMsgEntity;
import com.boco.modules.fdoc.service.DiseaseLabelService;
import com.boco.modules.fdoc.service.SendMsgService;
import com.boco.modules.fdoc.vo.DiseaseLabelVo;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.wordnik.swagger.annotations.ApiOperation;
/**
 * 群发关怀
 * 
 * @author j
 *
 * @date 2017年7月5日
 */
@Controller
@RequestMapping(value = "/massCare", produces = "text/json;charset=utf-8")
public class MassCareController {
	
	@Resource
	DiseaseLabelService diseaseLabelService;
	@Resource
	SendMsgService sendMsgService;
	
	/** 
     * 跳转页面  
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/goIndex",method = RequestMethod.GET)
	public String getAllList(HttpServletRequest req, Model model){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		List<GroupMsgTemplateEntity> list=diseaseLabelService.getTemplateByDocTeam(doctorInfo.getTeamId());
		model.addAttribute("mlist", list);
		model.addAttribute("mlistJson", JsonUtils.getJson(list));
		//标签ID
		List<DiseaseLabelVo> labelids=diseaseLabelService.getLabelList(doctorInfo.getTeamId());
		model.addAttribute("labelids", labelids);
		return "/healthAdmin/massCare/massCare";
	}
	/**
	 * 
	 * 分页表格显示
	 * @param req
	 * @param model
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/getList",method = RequestMethod.GET)
	public String getList(HttpServletRequest req, Model model){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		List<GroupMsgTemplateEntity> list=diseaseLabelService.getTemplateByDocTeam(doctorInfo.getTeamId());
		return JsonUtils.getJson(BaseJsonVo.pageList(list, list.size()),BusinessConstants.JSON_ALL);

	}
	
	/** 
     * 跳转页面   模板列表--
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/moudelList",method = RequestMethod.GET)
	public String moudelList(HttpServletRequest req, Model model){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		List<GroupMsgTemplateEntity> list=diseaseLabelService.getTemplateByDocTeam(doctorInfo.getTeamId());
		model.addAttribute("mlist", list);
		model.addAttribute("mlistJson", JsonUtils.getJson(list));
		//标签ID
		List<DiseaseLabelVo> labelids=diseaseLabelService.getLabelList(doctorInfo.getTeamId());
		model.addAttribute("labelids", labelids);
		return "/healthAdmin/massCare/moudelList";
	}
	/** 
     * 跳转页面   自定义模板
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/makeMoudel",method = RequestMethod.GET)
	public String makeMoudel(HttpServletRequest req, Model model){
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		List<GroupMsgTemplateEntity> list=diseaseLabelService.getTemplateByDocTeam(doctorInfo.getTeamId());
		model.addAttribute("mlist", list);
		model.addAttribute("mlistJson", JsonUtils.getJson(list));
		return "/healthAdmin/massCare/makeMoudel";
	}
	
	/** 
     * 跳转页面 新增模板
     * @param req
     * @param model
     * @return
     *
     */
	@RequestMapping(value = "/addMoudel",method = RequestMethod.GET)
	public String addMoudel(HttpServletRequest req, Model model){
		return "/healthAdmin/massCare/addMoudel";
	}
	/**
	 * 群发信息
	 * @param templateContent 模板内容
	 * @param labelIDs 慢病标签ID，用,（小写逗号）隔开
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/sendMsgByDiseaseLabel", method = RequestMethod.GET)
	public String sendMsgByDiseaseLabel(@RequestParam String templateContent,@RequestParam String labelIDs){
		DiseaseLabelVo vo = new DiseaseLabelVo();
		vo.setIds(labelIDs);
		/** 签约成功推送给用户**/
		//获取接收推送的用户账号列表
		List<String> accounts = diseaseLabelService.getUsersInLabel(vo);
		CloudMobilePush push = new CloudMobilePush();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String title = "您的家庭医生为您发来关怀信息";
		push.androidPush(accounts, "您的家庭医生为您发来关怀信息", templateContent, BusinessConstants.PUSH_ACTIVITY,
				BusinessConstants.PUSH_ITEM_USER, PushUtils.packPushParam(BusinessConstants.PUSH_TYPE_LABEL_SENG, paramMap));
		/**
		 * 插入推送消息表
		 */
		SendMsgEntity msg = new SendMsgEntity(title,templateContent,BusinessConstants.PUSH_ITEM_USER_INT,
				BusinessConstants.PUSH_TYPE_LABEL_SENG,JsonUtils.getJsonFormat(paramMap));
		for (String account : accounts) {
			msg.setUid(account);
			sendMsgService.addMsg(msg);
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	/**
	 * 编辑 --自定义群发模板 
	 * @param id  群发模板ID，若新增则传0
	 * @param templateName 模板名称
	 * @param templateContent 模板内容 300字以内
	 * @param defaultFlag 是否为默认标签：0.否 1.是  若为默认标签，则无法删除，但能修改
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value = "/editGroupMsgTemplate", method = RequestMethod.POST)
	public String editGroupMsgTemplate(HttpServletRequest  req,@RequestParam Integer id,@RequestParam String templateName,@RequestParam String templateContent,@RequestParam String defaultFlag){
		//封装对象
		DoctorDetailVo doctorInfo=(DoctorDetailVo) req.getSession().getAttribute("doctorInfo");
		GroupMsgTemplateEntity entity = new GroupMsgTemplateEntity();
		entity.setId(id);
		entity.setDocTeamId(doctorInfo.getTeamId());
		entity.setTemplateName(templateName);
		entity.setTemplateContent(templateContent);
		entity.setDefaultFlag(defaultFlag);
		
		//判断执行新增还是修改操作
		if (id == 0) {
			diseaseLabelService.addGroupMsgTemplate(entity);
		}else {
			diseaseLabelService.updateGroupMsgTemplate(entity);
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
    /**
     * 删除群发模板
     * @param id
     * @param defaultFlag
     * @return
     *
     */
	@ResponseBody
	@RequestMapping(value = "/deleteGroupMsgTemplate", method = RequestMethod.POST)
	public String deleteGroupMsgTemplate(@RequestParam Integer id,@RequestParam String defaultFlag){
		//判断如果为默认模板，就不让修改
		if (BusinessConstants.DEFAULT_FLAG_DEFAULT.equals(defaultFlag)) {
			return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.DEFAULT_NOT_ALLOW.getKey(), ApiStatusEnum.DEFAULT_NOT_ALLOW.getValue()));
		}else {
			diseaseLabelService.deleteGroupMsgTemplate(id);
		}
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
}
