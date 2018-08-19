package com.boco.modules.fdoc.web.fdocWorkstation;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;
import java.util.UUID;
import java.util.zip.Inflater;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import com.boco.common.utils.StringUtils;
import com.alibaba.druid.sql.visitor.functions.Now;
import com.boco.common.comparator.UserComparator;
import com.boco.common.constants.BusinessConstants;
import com.boco.common.enums.ApiStatusEnum;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.persistence.Page;
import com.boco.common.push.CloudMobilePush;
import com.boco.common.push.PushUtils;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.FTPUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.MatcherUtiles;
import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.PropertiesUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.modules.fdoc.dao.surrender.SurrenderRequestDao;
import com.boco.modules.fdoc.model.PersonDeseaseInfoEntity;
import com.boco.modules.fdoc.model.SendMsgEntity;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.SignAgreementEntity;
import com.boco.modules.fdoc.model.SignRequestEntity;
import com.boco.modules.fdoc.model.UserDocSignEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderInformationEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderRequestEntity;
import com.boco.modules.fdoc.service.DocService;
import com.boco.modules.fdoc.service.DocUserService;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.service.SendMsgService;
import com.boco.modules.fdoc.service.SigServicepackService;
import com.boco.modules.fdoc.service.SignRecordService;
import com.boco.modules.fdoc.service.SignRequestService;
import com.boco.modules.fdoc.service.SignService;
import com.boco.modules.fdoc.service.SurrenderInformationService;
import com.boco.modules.fdoc.service.SurrenderReasonService;
import com.boco.modules.fdoc.service.SurrenderRequestService;
import com.boco.modules.fdoc.service.UserService;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.boco.modules.fdoc.vo.SignRequestVo;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.surrender.SurrenderInfomationVo;
import com.boco.modules.fdoc.vo.surrender.SurrenderRequestVo;
/**
 * 签约管理
 * 
 * @author j
 *
 * @date 2017年6月20日
 */
@Controller
@RequestMapping(value = "/signAdmin", produces = "text/json;charset=utf-8")
public class SignController {
	@Resource
	PersonInformationService personService;
	@Resource
	SignRecordService signRecordService;
	@Resource
	SignRequestService requestService;
	@Resource
	SignService signService;
	@Resource
	DocService docService;
	@Resource
	SigServicepackService sigServicepackService;
	@Resource
	DocUserService docUserService;
	@Resource
	SendMsgService sendMsgService;
	@Resource
	UserService userService;
	@Resource
	SurrenderRequestService surrenderRequestService;
	@Resource 
	SurrenderReasonService surrenderReasonService;
	@Resource
	SurrenderInformationService surrenderInformationService;
	/**
	 * 签约请求记录
	 * @param request
	 * @param model
	 * @return
	 *
	 */
	@RequestMapping(value = "/signRecord",method = RequestMethod.GET)
	public String StringsignRecord(HttpServletRequest request, Model model){
		return "/sign/signRecord";
	}
	
	/**
	 * 去签约
	 * @param request
	 * @param model
	 * @return
	 *
	 */
	@RequestMapping(value = "/goSign",method = RequestMethod.GET)
	public String goSign(HttpServletRequest request, Model model){
		return "/sign/goSign";
	}
	

	/**
	 * 查询当前医生下的签约人员申请信息列表
	 * @param personName
	 * @param docTeamId
	 * @param status
	 * @param pageSize
	 * @param pageIndex
	 * @return JSON
	 *
	 */
	@RequestMapping(value = "/querySignRequestInfo")
	@ResponseBody
	public String querySignRequestList(@RequestParam String personName,@RequestParam String docTeamId, @RequestParam String status, 
			@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {

		//封装查询对象
		SignVo vo = new SignVo();
		vo.setDocTeamId(docTeamId);
		if(StringUtils.isNotEmpty(status)){
			vo.setStatus(status);
		}
		if(StringUtils.isNotEmpty(personName)){
			vo.setPersonName(personName);
		}
		
		//获取总数
		Integer CountSign = signService.getSignAndRequestListCount(vo);
		//封装分页对象、查询列表
		vo.setPage(new Page<SignVo>(pageIndex,pageSize));
		List<SignVo> signList = signService.getSignAndRequestList(vo);
		return JsonUtils.getJson(BaseJsonVo.pageList(signList,CountSign),BusinessConstants.JSON_ALL);
	  }
	   /**
	    * 查询当前医生下的签约人员信息 服务包信息 团队信息
	    * @param model
	    * @param request
	    * @param response
	    * @param id
	    * @param status
	    * @return
	    *
	    */
	    @RequestMapping(value="/contractHandling" )
		public String  contractHandlingDetail(Model model,HttpServletRequest request,HttpServletResponse response,@RequestParam Integer id,@RequestParam String status) {
		 //签约ID 获取团队信息 和服务包信息
		 //已签约
		 if(BusinessConstants.SIGN_REQUEST_OK.equals(status)){
			 SignVo vo = signService.getSignDetail(id);
		     if(vo!=null){
		    	 //获取到的状态为1 修改为2作为页面上的显示需要
		    	 vo.setStatus(BusinessConstants.SIGN_REQUEST_OK);
		    	 //性别处理
		    	 if(BusinessConstants.SEX_MAN.equals(vo.getSex())){
			    	 vo.setSex(ApiStatusEnum.MAN.getSex_key());
			     }else if(BusinessConstants.SEX_WOMAN.equals(vo.getSex())){
			    	 vo.setSex(ApiStatusEnum.WOMAN.getSex_key());
				 }else {
					vo.setSex(BusinessConstants.SEX_NON);
				 }
		     }
			 model.addAttribute("vo",vo);
			
		 }else{
		
		    SignRequestVo vo = requestService.getRequestDetail(id);
		    if(vo!=null){
		    	 //性别处理
		    	 if(BusinessConstants.SEX_MAN.equals(vo.getSex())){
			    	 vo.setSex(ApiStatusEnum.MAN.getSex_key());
			     }else if(BusinessConstants.SEX_WOMAN.equals(vo.getSex())){
			    	 vo.setSex(ApiStatusEnum.WOMAN.getSex_key());
				 }else {
					vo.setSex(BusinessConstants.SEX_NON);
				 }
		     }
		    model.addAttribute("vo",vo);
		    }
		 return "/sign/contractHandling";
		}
		/**
		 * 待签约处理列表
		 * @param personName
		 * @param docTeamId
		 * @param request
		 * @param response
		 * @param pageSize
		 * @param pageIndex
		 * @return
		 *
		 */
		@RequestMapping(value = "/querySignRequestStatuseq1")
		@ResponseBody
		public String  querySignRequestStatuseq1(@RequestParam String personName,@RequestParam String docTeamId,HttpServletRequest request,HttpServletResponse response,@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {
		
			SignRequestVo vo = new SignRequestVo();
			vo.setDocTeamId(docTeamId);
			vo.setStatus("1");
			//获取总数1
			Integer requestCount1 = requestService.getRequestCount(vo);
			
			//封装分页对象、查询列表1
			vo.setPage(new Page<SignRequestVo>(pageIndex,pageSize));
			
			List<SignRequestVo> requestList1 = requestService.getRequestList(vo);
			return JsonUtils.getJson(BaseJsonVo.pageList(requestList1,requestCount1),BusinessConstants.JSON_ALL);
		}
		/**
		 * 获取未签约的人员（医生端）
		 * @param docTeamId
		 * @param personName
		 * @param pageSize
		 * @param pageIndex
		 * @return
		 *
		 */
		@RequestMapping(value = "/getNotSignMasterforwork", method = RequestMethod.GET)
		@ResponseBody
		public String getNotSignMaster(@RequestParam String docTeamId,
				@RequestParam String personName, @RequestParam Integer pageSize,
				@RequestParam Integer pageIndex) {
			// 封装查询对象
			PersonInformationVo personVo = new PersonInformationVo();
			personVo.setPersonName(personName);
			
			// 封装分页对象
			Page<PersonInformationVo> page = new Page<PersonInformationVo>(pageIndex,
					pageSize);
			personVo.setPage(page);
			// 查找结果、返回
			List<PersonInformationVo> notSignedList = signService.getPersonListWithNoSignInfo(personVo);
			Integer count = signService.getPersonListWithNoSignInfoCount(personVo);
			System.out.println(JsonUtils.getJsonFormat(notSignedList));
			return JsonUtils.getJson(BaseJsonVo.pageList(notSignedList,count),BusinessConstants.JSON_ALL);
			
		}
		/**
		 * 去签约显示页面
		 * @param model
		 * @param request
		 * @param response
		 * @return
		 *
		 */
		@RequestMapping(value = "/contractHandlingByDoc")
		public String  contractHandlingDoc(Model model,HttpServletRequest request,HttpServletResponse response,HttpSession session ,@RequestParam String personId) {
		    PersonInformationVo  vo=  personService.getPersonDetailByPersonId(personId);
		    
		    //获取服务包
		    List<SigServicepackEntity> packs= sigServicepackService.getAll();
		    if(vo!=null){
		    	 //性别处理
		    	 if(BusinessConstants.SEX_MAN.equals(vo.getSex())){
			    	 vo.setSex(ApiStatusEnum.MAN.getSex_key());
			     }else if(BusinessConstants.SEX_WOMAN.equals(vo.getSex())){
			    	 vo.setSex(ApiStatusEnum.WOMAN.getSex_key());
				 }else {
					vo.setSex(BusinessConstants.SEX_NON);
				 }
		     }
			model.addAttribute("vo", vo);
			model.addAttribute("packs", packs);
			
			//处理签约标签验证
			String username = (String) session.getAttribute("username_in_session");
			// 医生端调用，获取该医生的productCode
			DoctorDetailVo docUser = docUserService.getDoctorByUsername(username);
			String productCode = docUser.getProductCode();
			Map<String, Object> paramMap=new HashMap<String,Object>();
			//根据身份证来查询
			paramMap.put("KeyCode", "2");
			paramMap.put("KeyValue", vo.getIdCard());
		 
			paramMap.put("PageIndex", 0);
			paramMap.put("PageSize", 10);
			paramMap.put("ProductCode", productCode);
			String returnData=RestfulUtils.getPublicData("55-12", paramMap);
			//解析返回JSON
			Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(returnData);
			List<Map<String, Object>> dataList = (List<Map<String, Object>>) jsonMap.get("Msg");
			//存放慢病权值
			int labelValue =0;
			if(dataList.size()>0){
				Map<String, Object> map = dataList.get(0);
				//高血压2
				if(map.get("TG")!=null){
					labelValue +=2;
				}
				//糖尿病4
				if(map.get("TT")!=null){
					labelValue +=4;
				}
				//重性精神病16
				if(map.get("TJ")!=null){
					labelValue +=16;
				}
			}
			//老年人就是65岁以上的，儿童就是0-6岁的
			Integer age = vo.getAge();
			if(age>65){
				labelValue +=32;
			}else if(0<=age && age<=6){
				labelValue +=8;
			}
			//查询是否有孕产妇档案
			Map<String, Object> ycfMap=new HashMap<String,Object>();
			ycfMap.put("ProductCode", productCode);
			ycfMap.put("PersonID", vo.getJwPersonId());
			String ycfData=RestfulUtils.getPublicData("63-0", ycfMap);
			//解析返回JSON
			Map<String, Object> ycfReturnMap = JsonUtils.getObjectJsonMap(ycfData);
			Map<String, Object> ycfdata = (Map<String, Object>) ycfReturnMap.get("Msg");
			String status = (String)ycfdata.get("status");
			//说明已建档案
			if("true".equals(status)){
				labelValue +=128;
			}
			model.addAttribute("labelValue", labelValue);
		    return "/sign/contractHandlingDoc";
		}
		
		//签约订单号生成
		public String  getSignAgrmember(){
			    StringBuilder sb = new StringBuilder("QY");
		        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
		        sb.append(calendar.get(Calendar.YEAR));
		        if (calendar.get(Calendar.MONTH) < 10) {
		            sb.append("0");
		        }
		        sb.append(calendar.get(Calendar.MONTH) + 1);
		        if (calendar.get(Calendar.DAY_OF_MONTH) < 10) {
		            sb.append("0");
		        }
		        sb.append(calendar.get(Calendar.DAY_OF_MONTH));
		        String timestamp = String.valueOf(System.currentTimeMillis());
		        sb.append(timestamp.substring(timestamp.length() - 4));
		        int num = new Random().nextInt(10000);
		        if (num < 10) {
		            sb.append("000");
		        } else if (num >= 10 && num < 100) {
		            sb.append("00");
		        } else if (num >= 100 && num < 1000) {
		            sb.append("0");
		        }
		        sb.append(num);

			return sb.toString();
		}
		/**
		 * 图片上传
		 * @param img
		 * @param request
		 * @return
		 *
		 */
		@RequestMapping(value = "/uploadUserSignByDocFWS", method = RequestMethod.POST)
		@ResponseBody
		public String editorImgUpload(@RequestParam("file") CommonsMultipartFile img,
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
						(request.getContextPath() + "/upload/sign/" + signImgHeadName)
								.substring(6));
				FileUtils.copyInputStreamToFile(is, saveFile);
				// 上传文件到服务器
				FTPUtils.upload(saveFile, "/upload/sign/");

				String webServerIp = PropertiesUtils.getValue("ftp_web_server_ip");
				Map<String, Object> returnMap = new HashMap<String, Object>();
				returnMap.put("code", 0);
				returnMap.put("msg", "图片上传成功");
				Map<String, Object> dataMap = new HashMap<String, Object>();
				dataMap.put("src", webServerIp + "/upload/sign/"+ signImgHeadName);
				returnMap.put("data", dataMap);
				return JsonUtils.getJson(returnMap);
			} catch (Exception e) {
				e.printStackTrace();
				Map<String, Object> returnMap = new HashMap<String, Object>();
				returnMap.put("code", 1);
				returnMap.put("msg", "图片上传失败");
				return JsonUtils.getJson(returnMap);
			}
		}
		/**
		 * 保存签约  医生主动签约
 		 * @param userName
		 * @param familyId
		 * @param img
		 * @param servicePackValue
		 * @param term
		 * @param labelJson
		 * @param request
		 * @return
		 *
		 */
		@RequestMapping(value = "/saveDoctorSign", method = RequestMethod.POST)
		@ResponseBody
		public String editorImgUpload(@RequestParam String userName,@RequestParam String personId,@RequestParam(required=false) Integer requestId,@RequestParam(required=false) String img,
				@RequestParam String labelJson, HttpServletRequest request,@RequestParam Integer term,@RequestParam Integer servicePackValue) {
            try{
            	//** 获取医生ID、医生姓名、医生所属机构名称 **//*
    			DoctorDetailVo doctor = docUserService
    					.getDoctorByUsername(userName);
    			if (doctor == null) {
    				return JsonUtils.getJson(BaseJsonVo.empty(
    						ApiStatusEnum.NO_SUCH_DOCTOR.getKey(),
    						ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
    			}
				UserDocSignEntity en = new UserDocSignEntity();
				
				/**
				 解析疾病信息json
				 */
				List<PersonDeseaseInfoEntity> deseaseInfoList = new ArrayList<PersonDeseaseInfoEntity>();
				List<Map> objectList = JsonUtils.getObjectList(labelJson, Map.class);
				for (Map map : objectList) {
					PersonDeseaseInfoEntity entity = null;
					Integer deseaseInfo = (Integer) map.get("value");
					if (deseaseInfo == 1) {
						entity = new PersonDeseaseInfoEntity(personId, "0", "0", "0", "0","0", "0", "0");
					}else {
						entity = new PersonDeseaseInfoEntity(personId, deseaseInfo);
					}
					deseaseInfoList.add(entity);
				}
				
				
				
				//设置持久化对象信息（签约对象和签约协议对象）
				if(StringUtils.isNotEmpty(img)){
					en.setSignImg(img.substring(25));
				}
				en.setDocTeamId(doctor.getTeamId());
				en.setPersonId(personId);
				en.setDocOrgName(doctor.getOrgName());
				Date date=new Date();
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.YEAR,term);
				en.setSignTime(date);
				en.setDueTime(cal.getTime());
				en.setDocOrgAddress(doctor.getOrgAddress());
				en.setSignType(BusinessConstants.SIGN_TYPE_DOC);	//设置签约类型为医生端主动签约
				en.setServicePackValue(servicePackValue);
				SignRequestEntity signRequest = null;
				if(requestId!=null){
					//获取签约请求对象
				    signRequest = requestService.getSignRequest(requestId);
					if(signRequest!=null){
						en.setSignImg(signRequest.getSignImg());
					}
				}
	              
				Map<String, Object> returnMap = signService.sign(en,deseaseInfoList); // 执行新签约操作
				String signResult = (String) returnMap.get("returnMsg");
				if (BusinessConstants.ERROR_RE_SIGN.equals(signResult)) {
					return JsonUtils.getJson(BaseJsonVo.empty(
							ApiStatusEnum.RE_SIGN.getKey(),
							ApiStatusEnum.RE_SIGN.getValue()));
				}
				if(signRequest!=null){
					signRequest.setStatus(BusinessConstants.SIGN_REQUEST_OK);
					requestService.dealSignRequest(signRequest);
				}
				//修改状态为已同意
				
				//** 签约成功推送给用户**//
				Map<String, Object> pushMap = new HashMap<String, Object>();
				pushMap.put("signId", returnMap.get("signId"));
				CloudMobilePush push = new CloudMobilePush();
				//获取推送居民账号列表
				List<String> accounts = userService.getAccountsByPersonId(personId);
				//获取医生团队队长信息
				DoctorDetailVo teamLeaderInfo = docService.getTeamLeaderInfo(doctor.getTeamId());
				 //推送安卓端
				String title = "您已成功签约";
				String content = "您已和"+teamLeaderInfo.getDocName()+"医生团队成功签约！";
				push.androidPush(accounts, title, content, 
					 BusinessConstants.PUSH_ACTIVITY, BusinessConstants.PUSH_ITEM_USER, PushUtils.packPushParam(BusinessConstants.PUSH_TYPE_SIGN, pushMap));
				// 插入推送消息表
				 
				SendMsgEntity msg = new SendMsgEntity(title,content,BusinessConstants.PUSH_ITEM_USER_INT,
						BusinessConstants.PUSH_TYPE_SIGN,JsonUtils.getJsonFormat(pushMap));
				for (String account : accounts) {
					msg.setUid(account);
					sendMsgService.addMsg(msg);
				}
			} catch (Exception e) {
				e.printStackTrace();
				return JsonUtils
						.getJson(BaseJsonVo.empty(ApiStatusEnum.FAIL.getKey(),
								ApiStatusEnum.FAIL.getValue()));
			}
			return JsonUtils.getJson(BaseJsonVo.success(null));
		}
	    
		/**
		 * 同意签约请求
		 * @param requestBody
		 * @return
		 *
		 */
		@RequestMapping(value = "/dealSignRequestFWS", method = RequestMethod.POST)
		@Transactional
		@ResponseBody
		public String dealSignRequest(@RequestParam String userName,@RequestParam Integer requestId) {
			SignRequestEntity entity = new SignRequestEntity();
			entity.setId(requestId);
			
			/** 获取医生ID、医生姓名、医生所属机构名称 **/
			DoctorDetailVo doctor = docUserService.getDoctorByUsername(userName);
			if (doctor == null) {
				return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_SUCH_DOCTOR.getKey(),
						ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
			//获取签约请求对象
			SignRequestEntity signRequest = requestService.getSignRequest(requestId);
			
			//判断户主信息，没有户主不让签约
			if (personService.getMasterInfo(signRequest.getFamilyId()) == null) {
				return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_MASTER.getKey(),
						ApiStatusEnum.NO_MASTER.getValue()));
			}
				/**
				 * 同意签约
				 */
				//执行签约逻辑
				UserDocSignEntity en = new UserDocSignEntity();
				SignAgreementEntity agreement = new SignAgreementEntity();
				
				//把签约请求对象的各个属性赋值给签约对象和签约协议对象
				en.setFamilyId(signRequest.getFamilyId());
				en.setDocOrgName(signRequest.getDocOrgName());
				en.setDocTeamId(signRequest.getDocTeamId());
				en.setSignImg(signRequest.getSignImg());
				en.setSignType(BusinessConstants.SIGN_TYPE_USER);
				en.setDocOrgAddress(doctor.getOrgAddress());
				en.setServicePackValue(signRequest.getServicePackValue());
				
				agreement.setServicePackValue(signRequest.getServicePackValue());
				agreement.setSignTime(new Date());
				agreement.setAgreementNum(signRequest.getAgreementNum());
				agreement.setDueTime(DateUtils.getYearLaterDate(new Date(), signRequest.getTerm()));
				
				Map<String, Object> returnMap = signService.sign(en, null); // 执行新签约操作
				String signResult = (String) returnMap.get("returnMsg");
				
				if (BusinessConstants.ERROR_RE_SIGN.equals(signResult)) {
					return JsonUtils.getJson(BaseJsonVo.empty(
							ApiStatusEnum.RE_SIGN.getKey(),
							ApiStatusEnum.RE_SIGN.getValue()));
				}
				
				//修改状态为已同意
				entity.setStatus(BusinessConstants.SIGN_REQUEST_OK);
				requestService.dealSignRequest(entity);
				
				/** 签约成功推送给用户**/
				Map<String, Object> pushMap = new HashMap<String, Object>();
				pushMap.put("signId", returnMap.get("signId"));
				CloudMobilePush push = new CloudMobilePush();
				//获取推送居民账号列表
				List<String> accounts = userService.getAccountsByFamilyId(signRequest.getFamilyId());
				//获取医生团队队长信息
				DoctorDetailVo teamLeaderInfo = docService.getTeamLeaderInfo(doctor.getTeamId());
				 //推送安卓端
				String title = "您已成功签约";
				String content = "您已和"+teamLeaderInfo.getDocName()+"医生团队成功签约！";
				push.androidPush(accounts, title, content, 
					 BusinessConstants.PUSH_ACTIVITY, BusinessConstants.PUSH_ITEM_USER, PushUtils.packPushParam(BusinessConstants.PUSH_TYPE_SIGN_REQUEST_SUCCESS, pushMap));
				/**
				 * 插入推送消息表
				 */
				SendMsgEntity msg = new SendMsgEntity(title,content,BusinessConstants.PUSH_ITEM_USER_INT,
						BusinessConstants.PUSH_TYPE_SIGN_REQUEST_SUCCESS,JsonUtils.getJsonFormat(pushMap));
				for (String account : accounts) {
					msg.setUid(account);
					sendMsgService.addMsg(msg);
				}
				return JsonUtils.getJson(BaseJsonVo.success(null));
		}
		
		
		/**
		 * 拒绝签约
		 * @param requestBody
		 * @return
		 *
		 */
		@RequestMapping(value = "/cancleSignRequestFWS", method = RequestMethod.POST)
		@Transactional
		@ResponseBody
		public String cancleSignRequestFWS(@RequestParam String userName,@RequestParam Integer requestId) {
			SignRequestEntity entity = new SignRequestEntity();
			entity.setId(requestId);
			
			/** 获取医生ID、医生姓名、医生所属机构名称 **/
			DoctorDetailVo doctor = docUserService.getDoctorByUsername(userName);
			if (doctor == null) {
				return JsonUtils.getJson(BaseJsonVo.empty(
						ApiStatusEnum.NO_SUCH_DOCTOR.getKey(),
						ApiStatusEnum.NO_SUCH_DOCTOR.getValue()));
			}
			//获取签约请求对象
			SignRequestEntity signRequest = requestService.getSignRequest(requestId);
			
			/**
			 * 拒绝
			 */
			//修改状态为已拒绝
			entity.setStatus(BusinessConstants.SIGN_REQUEST_REFUSED);
			requestService.dealSignRequest(entity);
			
			/** 签约成功推送给用户**/
			Map<String, Object> pushMap = new HashMap<String, Object>();
			pushMap.put("requestId", requestId);
			CloudMobilePush push = new CloudMobilePush();
			//获取推送居民账号列表
			List<String> accounts = userService.getAccountsByFamilyId(signRequest.getFamilyId());
			//获取医生团队队长信息
			DoctorDetailVo teamLeaderInfo = docService.getTeamLeaderInfo(doctor.getTeamId());
			 //推送安卓端
			String title = "您的签约请求已被拒绝";
			String content = "很抱歉，您与"+teamLeaderInfo.getDocName()+"医生团队的签约请求已被拒绝！";
			push.androidPush(accounts, title, content, 
				 BusinessConstants.PUSH_ACTIVITY, BusinessConstants.PUSH_ITEM_USER, PushUtils.packPushParam(BusinessConstants.PUSH_TYPE_SIGN_REQUEST_FAIL, pushMap));
			/**
			 * 插入推送消息表
			 */
			SendMsgEntity msg = new SendMsgEntity(title,content,BusinessConstants.PUSH_ITEM_USER_INT,
					BusinessConstants.PUSH_TYPE_SIGN_REQUEST_FAIL,JsonUtils.getJsonFormat(pushMap));
			for (String account : accounts) {
				msg.setUid(account);
				sendMsgService.addMsg(msg);
			}
			return JsonUtils.getJson(BaseJsonVo.success(null));
		}
	
		/**
		 * 签约请求记录
		 * @param request
		 * @param model
		 * @return
		 *
		 */
		@RequestMapping(value = "/surrenderRecord",method = RequestMethod.GET)
		public String surrenderRecord(HttpServletRequest request, Model model){
			return "/sign/surrenderRecord";
		}
		
		/**
	    * 查询当前医生下的签约人员信息，去解约
	    * @param model
	    * @param request
	    * @param response
	    * @param id
	    * @param status
	    * @return
	    *
	    */
	    @RequestMapping(value="/goSurrender",method = RequestMethod.GET)
		public String  goSurrender(Model model,HttpServletRequest request,HttpServletResponse response,@RequestParam Integer id,@RequestParam String status) {
		 //签约ID 获取团队信息 和服务包信息
		 SignVo vo = signService.getSignDetail(id);
	     if(vo!=null){
	    	 //获取到的状态为1 修改为2作为页面上的显示需要
	    	 vo.setStatus(BusinessConstants.SIGN_REQUEST_OK);
	    	 //性别处理
	    	 if(BusinessConstants.SEX_MAN.equals(vo.getSex())){
		    	 vo.setSex(ApiStatusEnum.MAN.getSex_key());
		     }else if(BusinessConstants.SEX_WOMAN.equals(vo.getSex())){
		    	 vo.setSex(ApiStatusEnum.WOMAN.getSex_key());
			 }else {
				vo.setSex(BusinessConstants.SEX_NON);
			 }
	     }
	     //封装签约年限和签约总价格
	     Calendar calEnd = Calendar.getInstance();
	     Calendar calStart = Calendar.getInstance();
	     calEnd.setTime(vo.getDueTime());
	     calStart.setTime(vo.getSignTime());
	     Integer term = calEnd.get(Calendar.YEAR)-calStart.get(calStart.YEAR);
	     vo.setTerm(term);
	     Double serviceTotalPrice = 0.0;
	     for (SigServicepackEntity pack : vo.getPacks()) {
			serviceTotalPrice = serviceTotalPrice+ pack.getPackPrice()*term;
		}
	     vo.setServiceTotalPrice(serviceTotalPrice);
	     //获取医生电话信息
	     List<DoctorDetailVo> doctorList = docService.getDoctorTeamMemberByTeamId(vo.getDocTeamId());
	     for (DoctorDetailVo doctorDetailVo : doctorList) {
			if (vo.getDocName().equalsIgnoreCase(doctorDetailVo.getDocName())) {
				model.addAttribute("doctorPhone",doctorDetailVo.getPhoneNumber());
			}
		}
	  
	     //获取原因包
	     List<SurrenderReasonEntity> reasonPacks = surrenderReasonService.findAllReasonList();
		 model.addAttribute("vo",vo);
		 model.addAttribute("reasonPacks", reasonPacks);
		 return "/sign/surrenderApply";
		}
	    
	    /**
		 * 查询当前医生下的解约记录列表
		 * @param personName
		 * @param docTeamId
		 * @param status
		 * @param pageSize
		 * @param pageIndex
		 * @return JSON
		 *
		 */
		@RequestMapping(value = "/querySurrenderInfo")
		@ResponseBody
		public String querySurrenderList(@RequestParam String personName,@RequestParam String docTeamId, @RequestParam String status, 
				@RequestParam Integer pageSize, @RequestParam Integer pageIndex) {

			//封装查询对象
			SurrenderRequestVo vo = new SurrenderRequestVo();
			vo.setDocTeamId(docTeamId);
			if(StringUtils.isNotEmpty(status)){
				vo.setStatus(status);
			}
			if(StringUtils.isNotEmpty(personName)){
				vo.setPersonName(personName);
			}
			
			//获取总数
			Integer CountSurrender = surrenderRequestService.getSurrenderListCount(vo);
			//封装分页对象、查询列表 
			vo.setPage(new Page<SurrenderRequestVo>(pageIndex,pageSize));
			List<SurrenderRequestVo> surrenderList = surrenderRequestService.getSurrenderAndRequestList(vo);
			return JsonUtils.getJson(BaseJsonVo.pageList(surrenderList,CountSurrender),BusinessConstants.JSON_ALL);
		  }
		
		/**
	    * 查询当前医生下的解约人员信息 服务包信息 团队信息
	    * @param model
	    * @param request
	    * @param response
	    * @param id
	    * @param status
	    * @return
	    */
	    @RequestMapping(value="/surrenderHandling" )
		public String  surrenderHandlingDetail(Model model,HttpServletRequest request,HttpServletResponse response,@RequestParam Integer id,@RequestParam String status) {
	    	//解约申请ID 获取团队信息 和服务包信息
	    	SurrenderRequestVo vo = surrenderRequestService.getSurrenderRequestById(id);
	    	
	    	//封装签约年限和签约总价格
	    	SignVo signVo = signService.getSignDetailBypersonId(vo.getPersonId());
		    vo.setTerm(signVo.getTerm());
		    Double serviceTotalPrice = 0.0;
		    for (SigServicepackEntity pack : vo.getPacks()) {
		    	serviceTotalPrice = serviceTotalPrice+ pack.getPackPrice()*signVo.getTerm();
			}
		    vo.setServiceTotalPrice(serviceTotalPrice);
		    vo.setSignId(signVo.getId());
		    if (vo.getAuditTime()!=null) {
		    	vo.setAuditTimeStr(DateUtils.formatDate(vo.getAuditTime(), "yyyy-MM-dd"));
			}
		    vo.setRequestTimeStr(DateUtils.formatDate(vo.getRequestTime(), "yyyy-MM-dd"));
		    model.addAttribute("vo", vo);

			return "/sign/surrenderHandling";
		}
	    
	    /**
		 * 保存解约  医生主动解约
 		 * @param userName
		 * @param familyId
		 * @param img
		 * @param servicePackValue
		 * @param term
		 * @param labelJson
		 * @param request
		 * @return
		 *
		 */
		@RequestMapping(value = "/doctorSurrender", method = RequestMethod.POST)
		@ResponseBody
		public String doctorSurrender(@RequestParam String docTeamId,@RequestParam String personId,@RequestParam Integer reasonValue,
				HttpServletRequest request,@RequestParam String reasonOther,@RequestParam String doctorPhone,@RequestParam String personPhone) {
            //查看是否已经有在审核中的解约申请
			List<SurrenderRequestEntity>  requestEntity = surrenderRequestService.getSurrenderRequestByPersonId(personId);
			if (requestEntity.size()>0) {
				for (SurrenderRequestEntity surrenderRequestEntity : requestEntity) {
					if ("1".equals(surrenderRequestEntity.getStatus())) {
						return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.SURRENDER_REQUEST_REPEAT.getKey(), ApiStatusEnum.SURRENDER_REQUEST_REPEAT.getValue()));
					}
				}
			}
			
			//判断电话号码是否合法
			if (!MatcherUtiles.mobileMach(doctorPhone)) {
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.MOBILE_OUTLAW.getKey(), "医生"+ApiStatusEnum.MOBILE_OUTLAW.getValue()));
			}
			if (!MatcherUtiles.mobileMach(personPhone)) {
				return JsonUtils.getJson(BaseJsonVo.empty(ApiStatusEnum.MOBILE_OUTLAW.getKey(), "居民"+ApiStatusEnum.MOBILE_OUTLAW.getValue()));
			}
			//插入解约请求
			SurrenderRequestEntity entity = new SurrenderRequestEntity();
			String values = NumberUtils.bitand(reasonValue);
			if (values.contains("8")) {//包含其他原因权值，设置其他原因
				entity.setReasonOther(reasonOther);
			}
			entity.setPersonId(personId);
			entity.setDocTeamId(docTeamId);
			entity.setOriginator("1");
			entity.setResidentMobile(personPhone);
			entity.setDocMobile(doctorPhone);
			entity.setReasonValue(reasonValue);
			entity.setStatus("1");
			entity.setRequestTime(new Date());
			int flag = surrenderRequestService.insert(entity);
			
			if(flag ==1){
				return JsonUtils.getJson(BaseJsonVo.success(null));
			}else{
				return JsonUtils.getJson(BaseJsonVo.error(null));
			}
		}
		
		/**
		 * 取消解约申请
		 * @param docTeamId
		 * @param requestId 解约申请ID
		 * @return
		 */
		@RequestMapping(value = "/cancleSurrenderRequest", method = RequestMethod.POST)
		@Transactional
		@ResponseBody
		public String cancleSurrenderRequest(@RequestParam String docTeamId,@RequestParam Integer requestId) {
			SurrenderRequestVo vo = surrenderRequestService.getSurrenderRequestById(requestId);
			if (vo==null) {
				return JsonUtils.getJson(BaseJsonVo.error());
			}
			int flag = surrenderRequestService.deleteSurrenderRequestById(requestId);
			
			if(flag ==1){
				return JsonUtils.getJson(BaseJsonVo.success(null));
			}else{
				return JsonUtils.getJson(BaseJsonVo.error(null));
			}
		}
		
		/**
		    * 已解约详情
		    * @param model
		    * @param request
		    * @param response
		    * @param id
		    * @param status
		    * @return
		    */
		    @RequestMapping(value="/surrenderDetail" )
			public String  surrenderDetail(Model model,HttpServletRequest request,HttpServletResponse response,@RequestParam Integer id,@RequestParam String status) {
		    	//解约申请ID 获取团队信息 和服务包信息
		    	SurrenderRequestVo vo = surrenderRequestService.getSurrenderRequestById(id);
		    	
		    	//封装签约年限和签约总价格
		    	SurrenderInfomationVo surrenderInfomationVo = surrenderInformationService.getSurrenderDetailByRequestId(vo.getId());
		    	
			    vo.setTerm(surrenderInfomationVo.getTerm());
			    Double serviceTotalPrice = 0.0;
			    for (SigServicepackEntity pack : surrenderInfomationVo.getPacks()) {
			    	serviceTotalPrice = serviceTotalPrice+ pack.getPackPrice()*surrenderInfomationVo.getTerm();
				}
			    vo.setServiceTotalPrice(serviceTotalPrice);
			    vo.setSignId(surrenderInfomationVo.getId());
			    if (vo.getAuditTime()!=null) {
			    	vo.setAuditTimeStr(DateUtils.formatDate(vo.getAuditTime(), "yyyy-MM-dd"));
				}
			    vo.setRequestTimeStr(DateUtils.formatDate(vo.getRequestTime(), "yyyy-MM-dd"));
			    model.addAttribute("vo", vo);

				return "/sign/surrenderHandling";
			}
}
