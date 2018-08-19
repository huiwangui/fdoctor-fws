package com.boco.modules.fdoc.web.fdocWorkstation;

import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.boco.common.constants.BusinessConstants;
import com.boco.common.jedis.JedisUtils;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.sms.SmsVo;
import com.boco.common.utils.FTPUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.service.DocService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.wordnik.swagger.annotations.ApiOperation;

/**
 * 工作站公共方法控制器
 * @author q
 *
 */
@Controller
@RequestMapping(produces="application/json;charset=UTF-8",value="/common")
public class CommonController {
	
	@Resource
	DocService docService;
	
	/**
	 * 
	 * imgUpload:(图片上传处理). <br/>
	 * 
	 * @author q
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/imgUpload", method = RequestMethod.POST)
	@ResponseBody
	public String imgUpload(@RequestParam("file") CommonsMultipartFile img,
			HttpServletRequest request) {
		/**
		 * 图片上传部分
		 */
		try {
			InputStream is = img.getInputStream();

			// 生成jpeg图片
			String headSuffix = StringUtils.getSuffix(img.getOriginalFilename()); // 获取后缀名
			String signImgHeadName = UUID.randomUUID().toString().substring(0, 8)
					+ "." + headSuffix; // 重命名为8位随机数

			// 复制文件到指定路径
			File saveFile = new File(
					(request.getContextPath() + "/upload/img/" + signImgHeadName)
							.substring(9));
			FileUtils.copyInputStreamToFile(is, saveFile);
			// 上传文件到服务器
			FTPUtils.upload(saveFile, "/upload/img/");

			return JsonUtils.getJson(BaseJsonVo.success("/upload/img/"
					+ signImgHeadName));
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtils.getJson(BaseJsonVo.error());
		}
	}
	
	@RequestMapping(value = "/sendSmsCode", method = RequestMethod.GET)
	@ResponseBody
	public String sendSmsCodeToDoc(@RequestParam String mobile, HttpServletRequest request){
		SmsVo vo = new SmsVo(mobile, BusinessConstants.SMS_SEND_ITEM_DOC);
		JedisUtils.set("sms"+mobile, vo.getSmsCode(), vo.getTimeout());
		vo.sendSmsMsg();
		return JsonUtils.getJson(BaseJsonVo.success(null));
	}
	
	/**
	 * 公卫部分选择责任医生的公共页面
	 * @param nameContainerId：用于显示责任医生姓名的span的id
	 * @param idContainerId：用于显示责任医生ID的hidden的id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/doctorListPage", method = RequestMethod.GET)
	public String doctorListPage(@RequestParam String nameContainerId, @RequestParam String idContainerId, Model model){
		//写入作用域，用于选择医生后的回显
		model.addAttribute("nameContainerId", nameContainerId);
		model.addAttribute("idContainerId", idContainerId);
		
		return "/common/doctorList";
	}
	
	/**
	 * 获取医生列表数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getDoctorList", method = RequestMethod.GET)
	@ResponseBody
	public String getDoctorList(@RequestParam String doctorName, Model model, @RequestParam Integer pageIndex, @RequestParam Integer pageSize){
		//获取医生列表
		List<DoctorDetailVo> doctorList = docService.getDoctorList(doctorName, pageSize, pageIndex);
		
		//获取医生数量
		Integer doctorCount = docService.getDoctorCount(doctorName);
		
		return JsonUtils.getJson(BaseJsonVo.pageList(doctorList, doctorCount));
	}
}
