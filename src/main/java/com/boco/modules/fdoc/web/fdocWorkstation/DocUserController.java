package com.boco.modules.fdoc.web.fdocWorkstation;

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
import com.boco.common.jedis.JedisUtils;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.MatcherUtiles;
import com.boco.modules.fdoc.model.DoctorEntity;
import com.boco.modules.fdoc.model.DoctorUserEntity;
import com.boco.modules.fdoc.service.DocService;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.DoctorUserVo;

@Controller
@RequestMapping(produces = "application/json;charset=UTF-8")
public class DocUserController {

	@Resource
	DocService docService;
	@Resource
	DocUserService docUserService;

	@RequestMapping(value = "/docLogin")
	@ResponseBody
	public String login(HttpServletRequest request, Model model) {
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		DoctorUserEntity userEntity = new DoctorUserEntity(userName, password);

		// 登录验证
		DoctorUserEntity verifyUser = docUserService.verifyUser(userEntity);
		if (verifyUser == null) {
			// 若没有查询到该对象，返回用户名或密码错误
			return JsonUtils.getJson(BaseJsonVo.empty(
					ApiStatusEnum.DOC_LOGIN_ERROR.getKey(),
					ApiStatusEnum.DOC_LOGIN_ERROR.getValue()));
		} else {
			DoctorDetailVo doctorInfo = docService.getDoctorInfo(verifyUser
					.getDoctorId());
			if (doctorInfo == null) {
				return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_SUCH_DOCTOR.getKey(),
						ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
			doctorInfo.setProductCode(verifyUser.getProductCode());
			// 把用户登录数据存入MAP
			Map<String, String> returnDataMap = new HashMap<String, String>();
			returnDataMap.put("userName", userName);
			returnDataMap.put("password", password);
			returnDataMap.put("img", verifyUser.getImg());
			returnDataMap.put("nickName", verifyUser.getNickName());
			returnDataMap.put("doctorId", doctorInfo.getId());
			returnDataMap.put("docName", doctorInfo.getDocName());
			returnDataMap.put("sex", doctorInfo.getSex());
			returnDataMap.put("deptName", doctorInfo.getDeptName());
			returnDataMap.put("orgId", doctorInfo.getOrgId());
			returnDataMap.put("orgName", doctorInfo.getOrgName());
			returnDataMap.put("regionCode", doctorInfo.getRegionCode());
			returnDataMap.put("teamId", doctorInfo.getTeamId());
			returnDataMap.put("docType", doctorInfo.getDocType());
			returnDataMap.put("productCode", doctorInfo.getProductCode());
			// 将登陆用户写入session
			request.getSession().setAttribute("doc_session", returnDataMap);
			request.getSession().setAttribute("doctorInfo", doctorInfo);
			request.getSession().setAttribute("username_in_session", userName);
			// 返回登录结果
			return JsonUtils.getJson(BaseJsonVo.success(returnDataMap));
		}

	}

	@RequestMapping(value = "/indexPage", method = RequestMethod.GET)
	public String showIndexPage(HttpServletRequest request, Model model) {

		return "/index";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("doc_session");
		request.getSession().removeAttribute("doctorInfo");
		return "redirect:/";
	}

	/**
	 * 个人信息页
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/doctorInfoPage", method = RequestMethod.GET)
	public String doctorInfoPage(HttpServletRequest request, Model model) {
		return "/userInfo/doctorInfo";
	}

	/**
	 * 修改医生信息
	 * @param request
	 * @param model
	 * @param userEntity
	 * @param docEntity
	 * @param smsCode
	 * @param mobileFlag
	 * @return
	 */
	@RequestMapping(value = "/updateDoctorUser", method = RequestMethod.POST)
	@ResponseBody
	public String updateDoctorUser(HttpServletRequest request, Model model,
			DoctorUserEntity userEntity, DoctorEntity docEntity,
			String smsCode, boolean mobileFlag) {
		// 判断手机号有没有经过修改，如果有修改，判断
		if (mobileFlag) {
			if (!smsCode.equals(JedisUtils.get("sms"
					+ docEntity.getPhoneNumber()))) {
				return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.CODE_ERROR.getKey(),
						ApiStatusEnum.CODE_ERROR.getValue()));
			}
		}
		docUserService.updateDocUser(userEntity, docEntity);

		// 重新将修改之后的对象放入作用域

		DoctorDetailVo doctorInfo = docService.getDoctorInfo(docEntity.getId());
		// 把用户登录数据存入MAP
		Map<String, String> returnDataMap = new HashMap<String, String>();
		returnDataMap.put("userName", userEntity.getUserName());
		returnDataMap.put("img", userEntity.getImg());
		returnDataMap.put("nickName", userEntity.getNickName());
		returnDataMap.put("doctorId", doctorInfo.getId());
		returnDataMap.put("docName", doctorInfo.getDocName());
		returnDataMap.put("sex", doctorInfo.getSex());
		returnDataMap.put("deptName", doctorInfo.getDeptName());
		returnDataMap.put("orgId", doctorInfo.getOrgId());
		returnDataMap.put("orgName", doctorInfo.getOrgName());
		returnDataMap.put("regionCode", doctorInfo.getRegionCode());
		returnDataMap.put("teamId", doctorInfo.getTeamId());
		returnDataMap.put("docType", doctorInfo.getDocType());
		returnDataMap.put("password", doctorInfo.getPassword());
		// 将登陆用户写入session
		request.getSession().setAttribute("doc_session", returnDataMap);
		request.getSession().setAttribute("doctorInfo", doctorInfo);
		request.getSession().setAttribute("username_in_session", userEntity.getUserName());

		return JsonUtils.getJson(BaseJsonVo.success(null));
	}

	/**
	 * 用户修改密码
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	@ResponseBody
	public String validatePassword(HttpServletRequest request, Model model,
			String userName, DoctorUserVo vo) {
		// 判断新密码是否合法
		if (!MatcherUtiles.noSpecialChar((vo.getNewPassword()))) {
			return JsonUtils.getJson(BaseJsonVo.empty(
					ApiStatusEnum.PASSWORD_OUTLAW.getKey(),
					ApiStatusEnum.PASSWORD_OUTLAW.getValue()));
		}
		// 判断原密码是否正确
		DoctorUserEntity entity = new DoctorUserEntity(vo.getUserName(),
				vo.getPassword());
		DoctorUserEntity verifyUser = docUserService.verifyUser(entity);
		if (verifyUser == null) {
			// 原密码错误：返回提示
			return JsonUtils.getJson(BaseJsonVo.empty(
					ApiStatusEnum.OLD_ERROR.getKey(),
					ApiStatusEnum.OLD_ERROR.getValue()));
		} else {
			// 原密码正确：修改密码
			entity = new DoctorUserEntity(vo.getUserName(), vo.getNewPassword());
			docUserService.updateDocUser(entity, null);
			return JsonUtils.getJson(BaseJsonVo.success(null));
		}
	}
	
	/**
	 * 个人信息页
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/teamInfoPage", method = RequestMethod.GET)
	public String teamInfo(HttpServletRequest request, Model model) {
		//从session获取登录医生
		DoctorDetailVo doctorInfo = (DoctorDetailVo) request.getSession().getAttribute("doctorInfo");
		
		//查询团队信息，写入作用域
		List<DoctorDetailVo> teamInfo = docService.getDoctorTeamMemberByDocId(doctorInfo.getId());
		model.addAttribute("teamInfo", teamInfo);
		System.out.println(JsonUtils.getJson(teamInfo));
		return "/userInfo/teamInfo";
	}

}
