package com.boco.modules.fdoc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.dao.SigServicepackDao;
import com.boco.modules.fdoc.dao.surrender.SurrenderInformationDao;
import com.boco.modules.fdoc.dao.surrender.SurrenderReasonDao;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderInformationEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;
import com.boco.modules.fdoc.service.SurrenderInformationService;
import com.boco.modules.fdoc.vo.surrender.SurrenderInfomationVo;
@Service
public class SurrenderInformationServiceImpl implements SurrenderInformationService {
	
	@Resource
	SurrenderInformationDao surrenderInformationDao;
	@Resource
	SigServicepackDao servicePackDao;
	@Resource
	SurrenderReasonDao surrenderReasonDao;
	@Override
	public int updateSurrenderInformationById(SurrenderInformationEntity entity) {
		return surrenderInformationDao.updateSurrenderInformationById(entity);
	}

	@Override
	public SurrenderInfomationVo getSurrenderDetailByRequestId(Integer requestId) {
		SurrenderInfomationVo vo = surrenderInformationDao.getSurrenderDetailByRequestId(requestId);
		//封装所选服务包列表信息
		if(vo!=null){
			String values = NumberUtils.bitand(vo.getServicePackValue());
			Map<String, String> valuesMap = new HashMap<String, String>();
			valuesMap.put("values", values);
			List<SigServicepackEntity> packs = servicePackDao.getServicePacksByValues(valuesMap);
			vo.setPacks(packs);
		}
		//封装解约原因列表信息
		if (StringUtils.isNotEmpty(String.valueOf(vo.getReasonValue()))) {
			String values = NumberUtils.bitand(vo.getReasonValue());
			Map<String, String> valuesMap = new HashMap<String, String>();
			valuesMap.put("values", values);
			List<SurrenderReasonEntity> reasonPacks = surrenderReasonDao.getReasonPackByValues(valuesMap);
			vo.setReasonPacks(reasonPacks);
		}
		return vo;
	}

}
