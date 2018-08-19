package com.boco.modules.fdoc.dao.statistics;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBpbsEntity;

@MyBatisDao
public interface StatisticsDayTeamBpbs extends CrudDao<StatisticsDayTeamBpbsEntity>{
	/**
	 * 
	 * getLastInfo:(获取最近一条统计信息). <br/>
	 * @author q
	 * @return
	 */
	
	public StatisticsDayTeamBpbsEntity getLastInfoByteamID(StatisticsDayTeamBpbsEntity entity);
	/**
	 * 
	 * callStatisticsProcedure:(手动调用存储过程). <br/>
	 * @author q
	 */
	public void callStatisticsProcedure();
}
