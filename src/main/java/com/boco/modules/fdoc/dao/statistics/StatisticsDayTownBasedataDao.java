package com.boco.modules.fdoc.dao.statistics;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTownBasedataEntity;

@MyBatisDao
public interface StatisticsDayTownBasedataDao extends CrudDao<StatisticsDayTownBasedataEntity>{
	/**
	 * 
	 * getLastInfo:(获取最近一条统计信息). <br/>
	 * @author q
	 * @return
	 */
	public StatisticsDayTownBasedataEntity getLastInfo(String regionCode);
	/**
	 * 
	 * getLastInfoByDate:(通过统计日期获取统计信息). <br/>
	 * @author q
	 * @return
	 */
	public StatisticsDayTownBasedataEntity getLastInfoByDate(StatisticsDayTownBasedataEntity entity);
	/**
	 * 
	 * callStatisticsProcedure:(手动调用存储过程). <br/>
	 * @author q
	 */
	public void callStatisticsProcedure();
}
