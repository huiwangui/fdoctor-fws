package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.PropertiesUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.modules.fdoc.vo.DoctorDetailVo;

/**
 * 老年人体检
 * @author q
 *
 */
@Controller
@RequestMapping(value = "/oldExamination", produces = "text/json;charset=utf-8")
public class OldExaminationController {
	
	/**
	 * 跳转页面 老年人体检列表
	 * 
	 * @param req
	 * @param model
	 * @return
	 *
	 */
	@RequestMapping(value = "/examinationPage", method = RequestMethod.GET)
	public String examinationPage(HttpServletRequest req, Model model) {

		return "/examination/oldExamList";
	}
	
	
	/**
	 * 获取老年人体检列表
	 * @param req
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getOldExamList", method = RequestMethod.GET)
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
		String result = RestfulUtils.getPublicData("56-8", paramMap);

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
}
