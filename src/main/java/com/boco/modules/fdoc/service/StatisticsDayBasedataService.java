package com.boco.modules.fdoc.service;

import java.util.List;

import com.boco.modules.fdoc.model.statistics.StatisticsDayBasedataEntity;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBasedataEntity;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBpbsEntity;
import com.boco.modules.fdoc.vo.statistics.StatisticsDayBasedataVo;

/**
 * 
 * ClassName: 基础数据分天统计service，包括总计、按照team、区划分组等 <br/>
 * @author q
 * @version 
 * @since JDK 1.7+
 */
public interface StatisticsDayBasedataService {
	/**
	 * 
	 * getBasedata:(总数综合统计. <br/>
	 * @author q
	 * @return
	 */
	public StatisticsDayBasedataEntity getBasedata();
	
	/**
	 * 获取增量数据
	 */
	public StatisticsDayBasedataVo getIncrementData();
	
	/**
	 *  获取城镇增量数据
	 */
	public StatisticsDayBasedataVo getTownIncrementData(String regionCode);
	
	/**
	 * 
	 * getTeamIncrementData:(获取团队增量数据). <br/>
	 * @author q
	 * @param teamId
	 * @return
	 */
	public StatisticsDayBasedataVo getTeamIncrementData(String teamId);
	
	/**
	 * 
	 * callDayBasedataProcedure:(调用基础数据统计存储过程). <br/>
	 * @author q
	 */
	public void callDayBasedataProcedure();
	
	/**
	 * 
	 * callDayBasedataTeamProcedure:(调用医生团队数据统计存储过程). <br/>
	 * @author q
	 */
	public void callDayBasedataTeamProcedure();
	
	/**
	 * 
	 * callDayBasedataTeamProcedure:(调用城镇数据统计存储过程). <br/>
	 * @author q
	 */
	public void callDayBasedataTownProcedure();
	/**
	 * 
	 * getLastInfoByDate:(通过统计日期获取统计信息 团队). <br/>
	 * @author j
	 * @return
	 */
	public StatisticsDayTeamBasedataEntity getLastInfoByDate(StatisticsDayTeamBasedataEntity entity);
	/**
	 * 通过团队获取统计血糖血压信息
	 * @param entity
	 * @return
	 *
	 */
	public StatisticsDayTeamBpbsEntity getLastInfoByteamID(StatisticsDayTeamBpbsEntity entity);
	/**
	 * 血糖血压存储过程
	 * 
	 *
	 */
	public void callBpbsStatisticsProcedure();
	
	
	/** 最近7天
	 * @param entity
	 * @return
	 *
	 */
	public List<StatisticsDayTeamBasedataEntity>  getLastInfoBySevenDate(StatisticsDayTeamBasedataEntity entity);
	/**
	 * 获取增长量 不含百分比
	 * @return
	 *
	 */
	public StatisticsDayBasedataVo getMainIncrementData(String teamId);
}  
