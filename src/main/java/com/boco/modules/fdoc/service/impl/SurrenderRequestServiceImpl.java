package com.boco.modules.fdoc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.boco.common.utils.NumberUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.dao.SigServicepackDao;
import com.boco.modules.fdoc.dao.surrender.SurrenderReasonDao;
import com.boco.modules.fdoc.dao.surrender.SurrenderRequestDao;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderRequestEntity;
import com.boco.modules.fdoc.service.SurrenderReasonService;
import com.boco.modules.fdoc.service.SurrenderRequestService;
import com.boco.modules.fdoc.vo.surrender.SurrenderRequestVo;

@Service
public class SurrenderRequestServiceImpl implements SurrenderRequestService {
	
	@Resource
	SurrenderRequestDao surrenderDao;
	@Resource
	SigServicepackDao servicePackDao;
	@Resource
	SurrenderReasonDao surrenderReasonDao;
	
	@Override
	public int updateSurrenderRequestById(SurrenderRequestEntity entity) {
		return surrenderDao.updateSurrenderRequestById(entity);
	}



	@Override
	public List<SurrenderRequestVo> getSurrenderAndRequestList(SurrenderRequestVo vo) {
		return surrenderDao.getSurrenderAndRequestList(vo);
	}

	@Override
	public SurrenderRequestVo getSurrenderRequestById(Integer Id) {
		SurrenderRequestVo vo = surrenderDao.getSurrenderRequestById(Id);

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



	@Override
	public Integer getSurrenderListCount(SurrenderRequestVo vo) {
		return surrenderDao.getSurrenderListCount(vo);
	}



	@Override
	public int insert(SurrenderRequestEntity entity) {
		return surrenderDao.insert(entity);
	}



	@Override
	public List<SurrenderRequestEntity> getSurrenderRequestByPersonId(String personId) {
		return surrenderDao.getSurrenderRequestByPersonId(personId);
	}



	@Override
	public Integer deleteSurrenderRequestById(Integer id) {
		return surrenderDao.deleteSurrenderRequestById(id);
	}

}
