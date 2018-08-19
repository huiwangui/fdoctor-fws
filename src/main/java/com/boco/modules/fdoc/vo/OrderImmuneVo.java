package com.boco.modules.fdoc.vo;

import java.util.Date;

public class OrderImmuneVo {
	//订单号
	private String 	orderNumber;
	//创建时间
	private Date createTime;
	//创建时间
	private String createTimeStr;
	//订单状态
	private String orderStatus;
	//接种人id
	private String patientId;
	//接种时间
	private Date clinicDate;
	//上午还是下午
	private String  clinicTime;
	//接种人姓名
	private String patientName;
	//接种医院名称
	private String hospitalName;
	//接种医院地址
	private String hospitalAddress;
	//接种人电话
	private String phoneNumber;
	//接种人地址
	private String personAddress;
	private String age;
	private String sex;
	private String timestr;
	private String phone;
	/**
	 * 项目名称
	 */
	private String projectName;
	private String day;
	private String creatorUid;
    private String tjName;
	
    
	public String getTjName() {
		return tjName;
	}
	public void setTjName(String tjName) {
		this.tjName = tjName;
	}
	public String getCreatorUid() {
		return creatorUid;
	}
	public void setCreatorUid(String creatorUid) {
		this.creatorUid = creatorUid;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTimestr() {
		return timestr;
	}
	public void setTimestr(String timestr) {
		this.timestr = timestr;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
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
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public String getHospitalAddress() {
		return hospitalAddress;
	}
	public void setHospitalAddress(String hospitalAddress) {
		this.hospitalAddress = hospitalAddress;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getPersonAddress() {
		return personAddress;
	}
	public void setPersonAddress(String personAddress) {
		this.personAddress = personAddress;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getCreateTimeStr() {
		return createTimeStr;
	}
	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}
	
	
	
	
}
