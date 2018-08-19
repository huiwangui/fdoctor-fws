package com.boco.modules.fdoc.vo;

import java.util.Date;

public class FollowUpOrderVo {
	private int id;
	private String orderNumber;
	private String patientId;
	private String orderStatus;
	private Date createTime;
	private String creatorUid;
	private Date cancleTime;
	private Date orderTime;
	private String clinicTime;
	private String fpName;
	private String patientName;
	private String hospitalName;
	private String hospitalAddress;
	private String sex;
	private String age;
	private String phone;
	private String timestr;
	//查询 参数  1 ，2,7 今天 明天 本周
	private String time;
	private Integer t1;
	private Integer t2;
	private Integer t7;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCreatorUid() {
		return creatorUid;
	}
	public void setCreatorUid(String creatorUid) {
		this.creatorUid = creatorUid;
	}
	public Date getCancleTime() {
		return cancleTime;
	}
	public void setCancleTime(Date cancleTime) {
		this.cancleTime = cancleTime;
	}
	public Date getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	public String getClinicTime() {
		return clinicTime;
	}
	public void setClinicTime(String clinicTime) {
		this.clinicTime = clinicTime;
	}
	 
	public String getFpName() {
		return fpName;
	}
	public void setFpName(String fpName) {
		this.fpName = fpName;
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
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
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
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public Integer getT1() {
		return t1;
	}
	public void setT1(Integer t1) {
		this.t1 = t1;
	}
	public Integer getT2() {
		return t2;
	}
	public void setT2(Integer t2) {
		this.t2 = t2;
	}
	public Integer getT7() {
		return t7;
	}
	public void setT7(Integer t7) {
		this.t7 = t7;
	}
	
	
	
	
}
