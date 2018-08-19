package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.JsonUtils;
import com.boco.modules.fdoc.service.SignService;
import com.boco.modules.fdoc.service.UserService;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.UserVo;

/**
 * 即时通讯、在线问诊controller
 * @author q
 *
 */

@Controller
@RequestMapping(value="/im",produces="application/json;charset=UTF-8")
public class IMController {
	@Resource
	UserService userService;
	@Resource
	SignService signService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/imPage", method = RequestMethod.GET)
	public String imPage(HttpServletRequest request, Model model){
		//从session获取当前登录用户
		Map<String, String> returnDataMap = (Map<String, String>) request.getSession().getAttribute("doc_session");
		
		System.out.println(JsonUtils.getJson(returnDataMap));
		
		//获取当前登录医生签约下的app用户列表，写入作用域
		SignVo vo = new SignVo();
		vo.setDocTeamId(returnDataMap.get("teamId"));
		
		List<UserVo> userList = signService.getSignedUserAccound(vo);
		model.addAttribute("userList", JsonUtils.getJson(userList));
		
		return "/im/im";
	}
	
	@RequestMapping(value="/getContsInfo", method = RequestMethod.GET)
	@ResponseBody
	public String getContsInfo(String uid){
		UserVo userDetail = userService.getUserDetail(uid);
		return JsonUtils.getJson(BaseJsonVo.success(userDetail));
	}
}
