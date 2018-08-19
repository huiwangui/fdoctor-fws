package com.boco.modules.fdoc.model.statistics;

import java.util.Date;

public class StatisticsDayTeamBpbsEntity {
	private int id;
	private int highBpCount ;//高血压
	private int lowBpCount ;//低血压
	private int normalBpCount;//正常血压
	private int highBsCount;//高血糖
	private int lowBsCount;//低血糖
	private int normalBsCount;//正常血糖
  	private	String  teamId ;
  	/**
	 * 统计日期
	 */
	private Date statisticsDate;

	/**
	 * 统计记录创建时间
	 */
	private Date createTime;
	public Date getStatisticsDate() {
		return statisticsDate;
	}
	public void setStatisticsDate(Date statisticsDate) {
		this.statisticsDate = statisticsDate;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHighBpCount() {
		return highBpCount;
	}
	public void setHighBpCount(int highBpCount) {
		this.highBpCount = highBpCount;
	}
	public int getLowBpCount() {
		return lowBpCount;
	}
	public void setLowBpCount(int lowBpCount) {
		this.lowBpCount = lowBpCount;
	}
	public int getNormalBpCount() {
		return normalBpCount;
	}
	public void setNormalBpCount(int normalBpCount) {
		this.normalBpCount = normalBpCount;
	}
	public int getHighBsCount() {
		return highBsCount;
	}
	public void setHighBsCount(int highBsCount) {
		this.highBsCount = highBsCount;
	}
	public int getLowBsCount() {
		return lowBsCount;
	}
	public void setLowBsCount(int lowBsCount) {
		this.lowBsCount = lowBsCount;
	}
	public int getNormalBsCount() {
		return normalBsCount;
	}
	public void setNormalBsCount(int normalBsCount) {
		this.normalBsCount = normalBsCount;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	
	


}
