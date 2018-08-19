package com.boco.modules.fdoc.vo;

import java.util.Date;
import java.util.List;

import com.boco.common.persistence.Page;

public class OrderParamVo {
	private String uid;
	/**
	 * 医生登录
	 */
	private String userName;
	/**
	 * 订单编号
	 */
	private String orderNumber;
	/**
	 * 坐诊日期
	 */
	private Date clinicDate;
	/**
    * 0.上午  1.下午   
    */
    private String clinicTime;
    private String patientIds;
    /**
     * 体检项目
     */
    private String tjName;
    /**
     * 随访项目
     */
    private String fpName;
    /**
     * 订单状态
     */
    private String orderStatus;
    /**
	 * 分页对象
	 */
	private Page<OrderParamVo> page;
	/**
	 * 开始日期
	 */
	private Date beginTime;
	/**
	 *结束日期
	 */
	private Date endTime;
	/**
	 *特殊日期  1,2,7
	 */
	private String time;
	/**
	 * 机构ID
	 */
	private String orgId;
	/**
	 * 团队ID
	 */
	private String teamId;
	
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getClinicDate() {
		return clinicDate;
	}
	public void setClinicDate(Date clinicDate) {
		this.clinicDate = clinicDate;
	}
	public String getClinicTime() {
		return clinicTime;
	}
	public void setClinicTime(String clinicTime) {
		this.clinicTime = clinicTime;
	}
	public String getPatientIds() {
		return patientIds;
	}
	public void setPatientIds(String patientIds) {
		this.patientIds = patientIds;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public Page<OrderParamVo> getPage() {
		return page;
	}
	public void setPage(Page<OrderParamVo> page) {
		this.page = page;
	}
	public String getTjName() {
		return tjName;
	}
	public void setTjName(String tjName) {
		this.tjName = tjName;
	}
	public String getFpName() {
		return fpName;
	}
	public void setFpName(String fpName) {
		this.fpName = fpName;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Date getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	
	
	 
}
