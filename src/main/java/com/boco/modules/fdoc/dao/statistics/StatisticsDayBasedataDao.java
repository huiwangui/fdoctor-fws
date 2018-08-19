package com.boco.modules.fdoc.dao.statistics;

import java.util.Date;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.statistics.StatisticsDayBasedataEntity;

@MyBatisDao
public interface StatisticsDayBasedataDao extends CrudDao<StatisticsDayBasedataEntity>{
	/**
	 * 
	 * getLastInfo:(获取最近一条统计信息). <br/>
	 * @author q
	 * @return
	 */
	public StatisticsDayBasedataEntity getLastInfo();
	/**
	 * 
	 * getLastInfoByDate:(通过统计日期获取统计信息). <br/>
	 * @author q
	 * @return
	 */
	public StatisticsDayBasedataEntity getLastInfoByDate(Date statisticsDate);
	/**
	 * 
	 * callStatisticsProcedure:(手动调用存储过程). <br/>
	 * @author q
	 */
	public void callStatisticsProcedure();
}
