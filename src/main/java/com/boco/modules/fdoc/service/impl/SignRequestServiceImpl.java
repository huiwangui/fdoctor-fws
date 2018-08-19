package com.boco.modules.fdoc.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.boco.common.constants.BusinessConstants;
import com.boco.common.utils.NumberUtils;
import com.boco.modules.fdoc.dao.PersonInformationDao;
import com.boco.modules.fdoc.dao.SigServicepackDao;
import com.boco.modules.fdoc.dao.SignRequestDao;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.SignRequestEntity;
import com.boco.modules.fdoc.service.DiseaseLabelService;
import com.boco.modules.fdoc.service.SignRequestService;
import com.boco.modules.fdoc.vo.DiseaseLabelVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.boco.modules.fdoc.vo.SignRequestVo;

@Service
public class SignRequestServiceImpl implements SignRequestService{

	@Resource
	SignRequestDao requestDao;
	@Resource
	SigServicepackDao servicePackDao;
	@Resource
	PersonInformationDao personDao;
    @Resource
	DiseaseLabelService labelService;
	
	/**
	 * 新增签约申请
	 */
	@Override
	public Map<String, Object> addSignRequestService(SignRequestEntity entity) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		entity.setCreateTime(new Date());
		entity.setStatus(BusinessConstants.SIGN_REQUEST_READY);
		if (requestDao.getByFamilyAndTeam(entity) != null) {
			returnMap.put("returnMsg", BusinessConstants.ERROR_RE_SIGN);
			return returnMap;
		}else {
			requestDao.insert(entity);
			returnMap.put("returnMsg", BusinessConstants.SUCCESS);
			returnMap.put("requestId", entity.getId());
			return returnMap;
		}
		
	}

	/**
	 * 单表查询
	 */
	@Override
	public SignRequestEntity getSignRequest(Integer id) {
		return requestDao.get(String.valueOf(id));
	}

	/**
	 * 获取签约申请列表
	 */
	@Override
	public List<SignRequestVo> getRequestList(SignRequestVo vo) {
		List<SignRequestVo> requestList = requestDao.getRequestList(vo);
		Double total=0.0;
		for (SignRequestVo signRequestVo : requestList) {
			//封装所选服务包列表信息
			String values = NumberUtils.bitand(signRequestVo.getServicePackValue());
			Map<String, String> valuesMap = new HashMap<String, String>();
			valuesMap.put("values", values);
			List<SigServicepackEntity> packs = servicePackDao.getServicePacksByValues(valuesMap);
			for (SigServicepackEntity sigServicepackEntity : packs) {
			    Double price=sigServicepackEntity.getPackPrice();
			    total+=price;
			}
			signRequestVo.setTotal(total);
			signRequestVo.setPacks(packs);
			//封装家庭信息
			PersonInformationVo masterInfo = personDao.getMasterInfo(signRequestVo.getFamilyId());
			if (masterInfo != null) {
				signRequestVo.setMasterName(masterInfo.getPersonName());
				signRequestVo.setMasterAge(masterInfo.getAge());
				signRequestVo.setMasterSex(masterInfo.getSex());
				signRequestVo.setFamilyUnit(masterInfo.getUnit());
			}
			signRequestVo.setFamilyNum(personDao.getMemberCountInFamily(signRequestVo.getFamilyId()));
			signRequestVo.setPersonInformationVo(personDao.getMasterInfo(signRequestVo.getFamilyId()));
			signRequestVo.setPolist(personDao.getFamilyMember(signRequestVo.getFamilyId()));
			Map<String,Object> signmap=new HashMap<String,Object>();
			signmap.put("id", signRequestVo.getId());
			signmap.put("cstauts", signRequestVo.getStatus());
			signRequestVo.setSignmap(signmap);
		}
		return requestList;
	}

	/**
	 * 获取签约申请总数
	 */
	@Override
	public Integer getRequestCount(SignRequestVo vo) {
		return requestDao.getRequestCount(vo);
	}

	/**
	 * 获取签约申请详情
	 */
	@Override
	public SignRequestVo getRequestDetail(Integer id) {
		//根据ID查询详情
		SignRequestVo requestDetail = requestDao.getRequestDetail(id);
		//封装所选服务包列表信息
				if(requestDetail!=null){
					String values = NumberUtils.bitand(requestDetail.getServicePackValue());
					Map<String, String> valuesMap = new HashMap<String, String>();
					valuesMap.put("values", values);
					List<SigServicepackEntity> packs = servicePackDao.getServicePacksByValues(valuesMap);
					requestDetail.setPacks(packs);
				}
		//封装标签信息
				DiseaseLabelVo labelVo = new DiseaseLabelVo();
				labelVo.setPersonId(requestDetail.getPersonId());
				labelVo.setDocTeamId(requestDetail.getDocTeamId());
				List<DiseaseLabelVo> labelList = labelService.getLabelListWithSelectFlag(labelVo);
				requestDetail.setLabels(labelList);
		
		//返回结果
		return requestDetail;
	}

	@Override
	public Integer dealSignRequest(SignRequestEntity entity) {
		return requestDao.update(entity);
	}

}
