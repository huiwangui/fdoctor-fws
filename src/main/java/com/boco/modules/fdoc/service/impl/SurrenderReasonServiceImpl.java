package com.boco.modules.fdoc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.boco.common.utils.NumberUtils;
import com.boco.modules.fdoc.dao.surrender.SurrenderReasonDao;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;
import com.boco.modules.fdoc.service.SurrenderReasonService;

@Service
public class SurrenderReasonServiceImpl implements SurrenderReasonService {
	
	@Resource
	SurrenderReasonDao  surrenderReasonDao;
	@Override
	public List<SurrenderReasonEntity> findAllReasonList() {
		return surrenderReasonDao.findAllReasonList();
	}
	@Override
	public List<SurrenderReasonEntity> getReasonPacksByValues(Integer value) {
		
		String values = NumberUtils.bitand(value);
		Map<String, String> valuesMap = new HashMap<String, String>();
		valuesMap.put("values", values);
		List<SurrenderReasonEntity> reasonPacks = surrenderReasonDao.getReasonPackByValues(valuesMap);
		return reasonPacks;
	}
		
}
