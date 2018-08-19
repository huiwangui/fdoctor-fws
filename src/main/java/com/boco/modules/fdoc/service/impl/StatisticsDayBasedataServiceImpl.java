package com.boco.modules.fdoc.service.impl;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.boco.common.utils.DateUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.modules.fdoc.dao.statistics.StatisticsDayBasedataDao;
import com.boco.modules.fdoc.dao.statistics.StatisticsDayTeamBasedataDao;
import com.boco.modules.fdoc.dao.statistics.StatisticsDayTeamBpbs;
import com.boco.modules.fdoc.dao.statistics.StatisticsDayTownBasedataDao;
import com.boco.modules.fdoc.model.statistics.StatisticsDayBasedataEntity;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBasedataEntity;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBpbsEntity;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTownBasedataEntity;
import com.boco.modules.fdoc.service.StatisticsDayBasedataService;
import com.boco.modules.fdoc.vo.statistics.StatisticsDayBasedataVo;

@Service
public class StatisticsDayBasedataServiceImpl implements StatisticsDayBasedataService{
	
	@Resource
	StatisticsDayBasedataDao dayBasedataDao;
	@Resource
	StatisticsDayTownBasedataDao townDao;
	@Resource
	StatisticsDayTeamBasedataDao teamDao;
	@Resource
	StatisticsDayTeamBpbs teamBpbsDao;

	@Override
	public StatisticsDayBasedataEntity getBasedata() {
		return dayBasedataDao.getLastInfo();
	}

	@Override
	public StatisticsDayBasedataVo getIncrementData() {
		StatisticsDayBasedataVo vo = new StatisticsDayBasedataVo();
		
		//获取最近一条信息
		StatisticsDayBasedataEntity lastInfo = dayBasedataDao.getLastInfo();
		
		//若表中为空，则返回新对象，所有值为0
		if (lastInfo == null) {
			return vo;
		}
		
		Date weekAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -7);
		Date twoWeeksAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -14);
		//获取一周前、两周前的数据，若为空，则定义为新对象，所有值为0
		StatisticsDayBasedataEntity weekAgoInfo = dayBasedataDao.getLastInfoByDate(weekAgoDate);
		weekAgoInfo = (weekAgoInfo != null) ? weekAgoInfo : new StatisticsDayBasedataEntity();
		
		StatisticsDayBasedataEntity twoWeeksAgoInfo = dayBasedataDao.getLastInfoByDate(twoWeeksAgoDate);
		twoWeeksAgoInfo = (twoWeeksAgoInfo != null) ? twoWeeksAgoInfo : new StatisticsDayBasedataEntity();
		
		//计算同比增长率
		vo.setPersonIncrement(getIncrement(lastInfo.getPersonCount(), weekAgoInfo.getPersonCount(), twoWeeksAgoInfo.getPersonCount()));
		vo.setSignIncrement(getIncrement(lastInfo.getSignCount(), weekAgoInfo.getSignCount(), twoWeeksAgoInfo.getSignCount()));
		vo.setOrgIncrement(getIncrement(lastInfo.getOrgCount(), weekAgoInfo.getOrgCount(), twoWeeksAgoInfo.getOrgCount()));
		vo.setTeamIncrement(getIncrement(lastInfo.getTeamCount(), weekAgoInfo.getTeamCount(), twoWeeksAgoInfo.getTeamCount()));
		vo.setHyperIncrement(getIncrement(lastInfo.getHyperCount(), weekAgoInfo.getHyperCount(), twoWeeksAgoInfo.getHyperCount()));
		vo.setDiabetesIncrement(getIncrement(lastInfo.getDiabetesCount(), weekAgoInfo.getDiabetesCount(), twoWeeksAgoInfo.getDiabetesCount()));
		vo.setChildrenIncrement(getIncrement(lastInfo.getChildrenCount(), weekAgoInfo.getChildrenCount(), twoWeeksAgoInfo.getChildrenCount()));
		vo.setMajorPsychosisIncrement(getIncrement(lastInfo.getMajorPsychosisCount(), weekAgoInfo.getMajorPsychosisCount(), twoWeeksAgoInfo.getMajorPsychosisCount()));
		
		//计算慢病月增长
		
		Calendar monthAgoCal = Calendar.getInstance();//获取当前日期 
		monthAgoCal.add(Calendar.MONTH, -1);
		monthAgoCal.set(Calendar.DAY_OF_MONTH, monthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上个月最后一天
		
		Calendar twoMonthAgoCal = Calendar.getInstance();//获取当前日期 
		twoMonthAgoCal.add(Calendar.MONTH, -2);
		twoMonthAgoCal.set(Calendar.DAY_OF_MONTH, twoMonthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上上个月最后一天
		
		StatisticsDayBasedataEntity monthAgoInfo = dayBasedataDao.getLastInfoByDate(new Date(DateUtils.getStartTimeOfDay(monthAgoCal.getTime())));
		monthAgoInfo = (monthAgoInfo != null) ? monthAgoInfo : new StatisticsDayBasedataEntity();
		
		StatisticsDayBasedataEntity twoMonthAgoInfo = dayBasedataDao.getLastInfoByDate(new Date(DateUtils.getStartTimeOfDay(twoMonthAgoCal.getTime())));
		twoMonthAgoInfo = (twoMonthAgoInfo != null) ? twoMonthAgoInfo : new StatisticsDayBasedataEntity();
		
		//设置慢病月增长数
		vo.setHyperMonthIncNum(monthAgoInfo.getHyperCount() - twoMonthAgoInfo.getHyperCount());
		vo.setDiabetesMonthIncNum(monthAgoInfo.getDiabetesCount() - twoMonthAgoInfo.getDiabetesCount());
		vo.setChildrenMonthIncNum(monthAgoInfo.getChildrenCount() - twoMonthAgoInfo.getChildrenCount());
		vo.setMajorPsychosisMonthIncNum(monthAgoInfo.getMajorPsychosisCount() - twoMonthAgoInfo.getMajorPsychosisCount());
		
		return vo;
	}
	
	/**
	 * 
	 * getIncrement:(计算同比增长率). <br/>
	 * @author q
	 * @param nowData
	 * @param weekAgoData
	 * @param twoWeeksAgoData
	 * @return
	 */
	public Double getIncrement(int nowData, int weekAgoData, int twoWeeksAgoData){
		//把int转为double，保持精度
		Double nowDouble = Double.valueOf(nowData);
		Double weekAgoDouble = Double.valueOf(weekAgoData);
		Double twoWeeksAgoDouble = Double.valueOf(twoWeeksAgoData);
		//计算方式为[（当前值-7天前值）-（7天前值-14天前值）]/（7天前值-14天前值）*100%  若分母为0，则直接取100%
		Double increment = 0.0;
		if (nowDouble - weekAgoDouble != 0) {
			increment = (double) ((weekAgoDouble - twoWeeksAgoDouble != 0) ?((nowDouble - weekAgoDouble) - (weekAgoDouble - twoWeeksAgoDouble))
					/ (weekAgoDouble - twoWeeksAgoDouble) : 1);
		}
		BigDecimal decimal = new BigDecimal(increment * 100);
		return decimal.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	@Override
	public StatisticsDayBasedataVo getTownIncrementData(String regionCode) {
		StatisticsDayBasedataVo vo = new StatisticsDayBasedataVo();
		//获取最近一条信息
		StatisticsDayTownBasedataEntity lastInfo = townDao.getLastInfo(regionCode);
		//若表中为空，则返回新对象，所有值为0
		if (lastInfo == null) {
			return vo;
		}
		//封装基础数据
		vo.setPersonCount(lastInfo.getPersonCount());
		vo.setSignCount(lastInfo.getSignCount());
		vo.setHyperCount(lastInfo.getHyperCount());
		vo.setDiabetesCount(lastInfo.getDiabetesCount());
		vo.setChildrenCount(lastInfo.getChildrenCount());
		vo.setMajorPsychosisCount(lastInfo.getMajorPsychosisCount());
		if (vo.getPersonCount() != 0) {
			Double signPer = Double.valueOf(vo.getSignCount()) / Double.valueOf(vo.getPersonCount());
			BigDecimal decimal = new BigDecimal(signPer * 100);
			vo.setSignPer(decimal.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
		}else {
			vo.setSignPer(0.0);
		}
		
		Date weekAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -7);
		Date twoWeeksAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -14);
		//获取一周前、两周前的数据，若为空，则定义为新对象，所有值为0
		StatisticsDayTownBasedataEntity entity = new StatisticsDayTownBasedataEntity();
		entity.setRegionCode(regionCode);
		entity.setStatisticsDate(weekAgoDate);
		
		StatisticsDayTownBasedataEntity weekAgoInfo = townDao.getLastInfoByDate(entity);
		weekAgoInfo = (weekAgoInfo != null) ? weekAgoInfo : new StatisticsDayTownBasedataEntity();
		
		entity.setStatisticsDate(twoWeeksAgoDate);
		StatisticsDayTownBasedataEntity twoWeeksAgoInfo = townDao.getLastInfoByDate(entity);
		twoWeeksAgoInfo = (twoWeeksAgoInfo != null) ? twoWeeksAgoInfo : new StatisticsDayTownBasedataEntity();
		
		//计算同比增长率
		vo.setPersonIncrement(getIncrement(lastInfo.getPersonCount(), weekAgoInfo.getPersonCount(), twoWeeksAgoInfo.getPersonCount()));
		vo.setSignIncrement(getIncrement(lastInfo.getSignCount(), weekAgoInfo.getSignCount(), twoWeeksAgoInfo.getSignCount()));
		vo.setOrgIncrement(getIncrement(lastInfo.getOrgCount(), weekAgoInfo.getOrgCount(), twoWeeksAgoInfo.getOrgCount()));
		vo.setTeamIncrement(getIncrement(lastInfo.getTeamCount(), weekAgoInfo.getTeamCount(), twoWeeksAgoInfo.getTeamCount()));
		vo.setHyperIncrement(getIncrement(lastInfo.getHyperCount(), weekAgoInfo.getHyperCount(), twoWeeksAgoInfo.getHyperCount()));
		vo.setDiabetesIncrement(getIncrement(lastInfo.getDiabetesCount(), weekAgoInfo.getDiabetesCount(), twoWeeksAgoInfo.getDiabetesCount()));
		vo.setChildrenIncrement(getIncrement(lastInfo.getChildrenCount(), weekAgoInfo.getChildrenCount(), twoWeeksAgoInfo.getChildrenCount()));
		vo.setMajorPsychosisIncrement(getIncrement(lastInfo.getMajorPsychosisCount(), weekAgoInfo.getMajorPsychosisCount(), twoWeeksAgoInfo.getMajorPsychosisCount()));
		
		//计算慢病月增长
		Calendar monthAgoCal = Calendar.getInstance();//获取当前日期 
		monthAgoCal.add(Calendar.MONTH, -1);
		monthAgoCal.set(Calendar.DAY_OF_MONTH, monthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上个月最后一天
		
		Calendar twoMonthAgoCal = Calendar.getInstance();//获取当前日期 
		twoMonthAgoCal.add(Calendar.MONTH, -2);
		twoMonthAgoCal.set(Calendar.DAY_OF_MONTH, twoMonthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上上个月最后一天
		
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(monthAgoCal.getTime())));
		StatisticsDayTownBasedataEntity monthAgoInfo = townDao.getLastInfoByDate(entity);
		monthAgoInfo = (monthAgoInfo != null) ? monthAgoInfo : new StatisticsDayTownBasedataEntity();
		
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(twoMonthAgoCal.getTime())));
		StatisticsDayTownBasedataEntity twoMonthAgoInfo = townDao.getLastInfoByDate(entity);
		twoMonthAgoInfo = (twoMonthAgoInfo != null) ? twoMonthAgoInfo : new StatisticsDayTownBasedataEntity();
		
		//设置慢病月增长数
		vo.setHyperMonthIncNum(monthAgoInfo.getHyperCount() - twoMonthAgoInfo.getHyperCount());
		vo.setDiabetesMonthIncNum(monthAgoInfo.getDiabetesCount() - twoMonthAgoInfo.getDiabetesCount());
		vo.setChildrenMonthIncNum(monthAgoInfo.getChildrenCount() - twoMonthAgoInfo.getChildrenCount());
		vo.setMajorPsychosisMonthIncNum(monthAgoInfo.getMajorPsychosisCount() - twoMonthAgoInfo.getMajorPsychosisCount());
		
		return vo;
	}

	@Override
	public StatisticsDayBasedataVo getTeamIncrementData(String teamId) {
		
		StatisticsDayBasedataVo vo = new StatisticsDayBasedataVo();
		//获取最近一条信息
		StatisticsDayTeamBasedataEntity lastInfo = teamDao.getLastInfo(teamId);
		//若表中为空，则返回新对象，所有值为0
		if (lastInfo == null) {
			return vo;
		}
		//封装基础数据
		vo.setSignCount(lastInfo.getSignCount());
		vo.setHyperCount(lastInfo.getHyperCount());
		vo.setDiabetesCount(lastInfo.getDiabetesCount());
		vo.setChildrenCount(lastInfo.getChildrenCount());
		vo.setMajorPsychosisCount(lastInfo.getMajorPsychosisCount());
		
		Date weekAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -7);
		Date twoWeeksAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -14);
		//获取一周前、两周前的数据，若为空，则定义为新对象，所有值为0
		StatisticsDayTeamBasedataEntity entity = new StatisticsDayTeamBasedataEntity();
		entity.setTeamId(teamId);
		entity.setStatisticsDate(weekAgoDate);
		
		StatisticsDayTeamBasedataEntity weekAgoInfo = teamDao.getLastInfoByDate(entity);
		weekAgoInfo = (weekAgoInfo != null) ? weekAgoInfo : new StatisticsDayTeamBasedataEntity();
		
		entity.setStatisticsDate(twoWeeksAgoDate);
		StatisticsDayTeamBasedataEntity twoWeeksAgoInfo = teamDao.getLastInfoByDate(entity);
		twoWeeksAgoInfo = (twoWeeksAgoInfo != null) ? twoWeeksAgoInfo : new StatisticsDayTeamBasedataEntity();
		
		//计算同比增长率
		vo.setSignIncrement(getIncrement(lastInfo.getSignCount(), weekAgoInfo.getSignCount(), twoWeeksAgoInfo.getSignCount()));
		vo.setHyperIncrement(getIncrement(lastInfo.getHyperCount(), weekAgoInfo.getHyperCount(), twoWeeksAgoInfo.getHyperCount()));
		vo.setDiabetesIncrement(getIncrement(lastInfo.getDiabetesCount(), weekAgoInfo.getDiabetesCount(), twoWeeksAgoInfo.getDiabetesCount()));
		vo.setChildrenIncrement(getIncrement(lastInfo.getChildrenCount(), weekAgoInfo.getChildrenCount(), twoWeeksAgoInfo.getChildrenCount()));
		vo.setMajorPsychosisIncrement(getIncrement(lastInfo.getMajorPsychosisCount(), weekAgoInfo.getMajorPsychosisCount(), twoWeeksAgoInfo.getMajorPsychosisCount()));
		vo.setThisWeekNum(lastInfo.getSignCount()-weekAgoInfo.getSignCount());
		vo.setThisWeekIncrement((lastInfo.getSignCount()-weekAgoInfo.getSignCount())-(weekAgoInfo.getSignCount()-twoWeeksAgoInfo.getSignCount()));
		
		//计算慢病月增长
		Calendar monthAgoCal = Calendar.getInstance();//获取当前日期 
		monthAgoCal.add(Calendar.MONTH, -1);
		monthAgoCal.set(Calendar.DAY_OF_MONTH, monthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上个月最后一天
		
		Calendar twoMonthAgoCal = Calendar.getInstance();//获取当前日期 
		twoMonthAgoCal.add(Calendar.MONTH, -2);
		twoMonthAgoCal.set(Calendar.DAY_OF_MONTH, twoMonthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上上个月最后一天
		
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(monthAgoCal.getTime())));
		StatisticsDayTeamBasedataEntity monthAgoInfo = teamDao.getLastInfoByDate(entity);
		monthAgoInfo = (monthAgoInfo != null) ? monthAgoInfo : new StatisticsDayTeamBasedataEntity();
		
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(twoMonthAgoCal.getTime())));
		StatisticsDayTeamBasedataEntity twoMonthAgoInfo = teamDao.getLastInfoByDate(entity);
		twoMonthAgoInfo = (twoMonthAgoInfo != null) ? twoMonthAgoInfo : new StatisticsDayTeamBasedataEntity();
		
		//设置慢病月增长数
		vo.setHyperMonthIncNum(monthAgoInfo.getHyperCount() - twoMonthAgoInfo.getHyperCount());
		vo.setDiabetesMonthIncNum(monthAgoInfo.getDiabetesCount() - twoMonthAgoInfo.getDiabetesCount());
		vo.setChildrenMonthIncNum(monthAgoInfo.getChildrenCount() - twoMonthAgoInfo.getChildrenCount());
		vo.setMajorPsychosisMonthIncNum(monthAgoInfo.getMajorPsychosisCount() - twoMonthAgoInfo.getMajorPsychosisCount());
		vo.setThisMonthNum(lastInfo.getSignCount()-monthAgoInfo.getSignCount());
		vo.setThisMonthIncrement((lastInfo.getSignCount()-monthAgoInfo.getSignCount())-(monthAgoInfo.getSignCount()-twoMonthAgoInfo.getSignCount()));
		
		return vo;
	}

	@Override
	public void callDayBasedataProcedure() {
		dayBasedataDao.callStatisticsProcedure();
	}

	@Override
	public void callDayBasedataTeamProcedure() {
		teamDao.callStatisticsProcedure();
		
	}

	@Override
	public void callDayBasedataTownProcedure() {
		townDao.callStatisticsProcedure();
	}

	@Override
	public StatisticsDayTeamBasedataEntity getLastInfoByDate(StatisticsDayTeamBasedataEntity entity) {
		return teamDao.getLastInfoByDate(entity);
	}

	@Override
	public StatisticsDayTeamBpbsEntity getLastInfoByteamID(StatisticsDayTeamBpbsEntity entity) {
		return teamBpbsDao.getLastInfoByteamID(entity);
	}

	@Override
	public void callBpbsStatisticsProcedure() {
		teamBpbsDao.callStatisticsProcedure();
		
	}

	@Override
	public List<StatisticsDayTeamBasedataEntity> getLastInfoBySevenDate(StatisticsDayTeamBasedataEntity entity) {
		return teamDao.getLastInfoBySevenDate(entity);
	}
	
	
	@Override
	public StatisticsDayBasedataVo getMainIncrementData(String teamId) {
		StatisticsDayBasedataVo vo = new StatisticsDayBasedataVo();
		//获取最近一条信息
		StatisticsDayTeamBasedataEntity lastInfo = teamDao.getLastInfo(teamId);
		//若表中为空，则返回新对象，所有值为0
		if (lastInfo == null) {
			return vo;
		}
		//封装基础数据
		vo.setSignCount(lastInfo.getSignCount());
		vo.setHyperCount(lastInfo.getHyperCount());
		vo.setDiabetesCount(lastInfo.getDiabetesCount());
		vo.setChildrenCount(lastInfo.getChildrenCount());
		vo.setMajorPsychosisCount(lastInfo.getMajorPsychosisCount());
		
		Date monday=DateUtils.getTimesWeekmorning();//本周 周一
		Date weekAgoDate = DateUtils.getDateBeforeOrAfter(monday, -1);//一周以前
		Date twoWeeksAgoDate = DateUtils.getDateBeforeOrAfter(monday, -8);//二周以前
		
		//Date weekAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -7);
		//Date twoWeeksAgoDate = DateUtils.getDateBeforeOrAfter(lastInfo.getStatisticsDate(), -14);
		//获取一周前、两周前的数据，若为空，则定义为新对象，所有值为0
		StatisticsDayTeamBasedataEntity entity = new StatisticsDayTeamBasedataEntity();
		entity.setTeamId(teamId);
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(weekAgoDate)));
		
		
		StatisticsDayTeamBasedataEntity weekAgoInfo = teamDao.getLastInfoByDate(entity);
		weekAgoInfo = (weekAgoInfo != null) ? weekAgoInfo : new StatisticsDayTeamBasedataEntity();
		
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(twoWeeksAgoDate)));
		StatisticsDayTeamBasedataEntity twoWeeksAgoInfo = teamDao.getLastInfoByDate(entity);
		twoWeeksAgoInfo = (twoWeeksAgoInfo != null) ? twoWeeksAgoInfo : new StatisticsDayTeamBasedataEntity();
		//计算同比增长率
		vo.setSignIncrement(getIncrement(lastInfo.getSignCount(), weekAgoInfo.getSignCount(), twoWeeksAgoInfo.getSignCount()));
		vo.setHyperIncrement(getIncrement(lastInfo.getHyperCount(), weekAgoInfo.getHyperCount(), twoWeeksAgoInfo.getHyperCount()));
		vo.setDiabetesIncrement(getIncrement(lastInfo.getDiabetesCount(), weekAgoInfo.getDiabetesCount(), twoWeeksAgoInfo.getDiabetesCount()));
		vo.setChildrenIncrement(getIncrement(lastInfo.getChildrenCount(), weekAgoInfo.getChildrenCount(), twoWeeksAgoInfo.getChildrenCount()));
		vo.setMajorPsychosisIncrement(getIncrement(lastInfo.getMajorPsychosisCount(), weekAgoInfo.getMajorPsychosisCount(), twoWeeksAgoInfo.getMajorPsychosisCount()));
		vo.setThisWeekNum(lastInfo.getSignCount()-weekAgoInfo.getSignCount());
		vo.setThisWeekIncrement((lastInfo.getSignCount()-weekAgoInfo.getSignCount())-(weekAgoInfo.getSignCount()-twoWeeksAgoInfo.getSignCount()));
		
		//计算慢病月增长
		Calendar monthAgoCal = Calendar.getInstance();//获取当前日期 
		monthAgoCal.add(Calendar.MONTH, -1);
		monthAgoCal.set(Calendar.DAY_OF_MONTH, monthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上个月最后一天
		
		Calendar twoMonthAgoCal = Calendar.getInstance();//获取当前日期 
		twoMonthAgoCal.add(Calendar.MONTH, -2);
		twoMonthAgoCal.set(Calendar.DAY_OF_MONTH, twoMonthAgoCal.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为上上个月最后一天
		
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(monthAgoCal.getTime())));
		StatisticsDayTeamBasedataEntity monthAgoInfo = teamDao.getLastInfoByDate(entity);
		monthAgoInfo = (monthAgoInfo != null) ? monthAgoInfo : new StatisticsDayTeamBasedataEntity();
		entity.setStatisticsDate(new Date(DateUtils.getStartTimeOfDay(twoMonthAgoCal.getTime())));
		StatisticsDayTeamBasedataEntity twoMonthAgoInfo = teamDao.getLastInfoByDate(entity);
		twoMonthAgoInfo = (twoMonthAgoInfo != null) ? twoMonthAgoInfo : new StatisticsDayTeamBasedataEntity();
		
		//设置慢病月增长数
		vo.setHyperMonthIncNum(monthAgoInfo.getHyperCount() - twoMonthAgoInfo.getHyperCount());
		vo.setDiabetesMonthIncNum(monthAgoInfo.getDiabetesCount() - twoMonthAgoInfo.getDiabetesCount());
		vo.setChildrenMonthIncNum(monthAgoInfo.getChildrenCount() - twoMonthAgoInfo.getChildrenCount());
		vo.setMajorPsychosisMonthIncNum(monthAgoInfo.getMajorPsychosisCount() - twoMonthAgoInfo.getMajorPsychosisCount());
		vo.setThisMonthNum(lastInfo.getSignCount()-monthAgoInfo.getSignCount());
		vo.setThisMonthIncrement((lastInfo.getSignCount()-monthAgoInfo.getSignCount())-(monthAgoInfo.getSignCount()-twoMonthAgoInfo.getSignCount()));
		
		return vo;
	}

}
