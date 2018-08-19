package com.boco.modules.fdoc.dao.surrender;

import java.util.List;
import java.util.Map;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;
@MyBatisDao
public interface SurrenderReasonDao  extends CrudDao<SurrenderReasonEntity>{
	
	/**
	 * 获取所有解约原因
	 * @return
	 */
	public List<SurrenderReasonEntity> findAllReasonList();
	
	/**
	 * 
	 * getServicePacksByValues:(根据权值获取列表). <br/>
	 * @author q
	 * @param values 解约原因权值，以逗号隔开
	 * @return
	 */
	public List<SurrenderReasonEntity> getReasonPackByValues(Map<String, String> valuesMap);
	
}
