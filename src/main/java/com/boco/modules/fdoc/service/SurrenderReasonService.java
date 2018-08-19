package com.boco.modules.fdoc.service;

import java.util.List;
import java.util.Map;

import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;

public interface SurrenderReasonService {

	/**
	 * 获取所有解约原因
	 * @return
	 */
	List<SurrenderReasonEntity> findAllReasonList();
	
	/**
	 * 
	 * getServicePacksByValues:(根据权值获取列表). <br/>
	 * @author q
	 * @param value 解约原因权值
	 * @return
	 */
	public List<SurrenderReasonEntity> getReasonPacksByValues(Integer value);
}
