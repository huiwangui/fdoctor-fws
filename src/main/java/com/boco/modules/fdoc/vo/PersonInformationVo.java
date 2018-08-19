package com.boco.modules.fdoc.vo;

import java.util.Date;
import java.util.List;

import com.boco.common.persistence.Page;

public class PersonInformationVo {
	/**
	 * 主键
	 */
	private String personId;

	/**
	 * 健康档案编号
	 */
	private String personCode;

	/**
	 * 对应家庭表的主键
	 */
	private String familyId;

	/**
	 * 自定义编号
	 */
	private String customNumber;

	/**
	 * 姓名
	 */
	private String personName;

	/**
	 * 性别
	 */
	private String sex;

	/**
	 * 出生日期
	 */
	private Date dateOfBirth;

	/**
	 * 出生日期
	 */
	private String birthDay;

	/**
	 * 身份证件号码
	 */
	private String idCard;

	/**
	 * 本人联系电话
	 */
	private String phoneNumber;

	/**
	 * 现住址
	 */
	private String currentAddress;

	/**
	 * 行政区划代码
	 */
	private String regionCode;

	/**
	 * 户主标识，1为户主
	 */
	private String masterFlag;

	/**
	 * 所属组名称
	 */
	private String unit;

	/**
	 * 是否签约 0.未签约 1.已签约
	 */
	private Integer ifSign;

	/**
	 * 0:注销 1:正常 2：封存 3:死亡 4:结案
	 */
	private Integer state;
	
	/**
	 * 家庭成员人数
	 */
	private Integer familyNum;
	/**
	 * 家庭成员
	 */
	private List<PersonInformationVo> polist;
	
	/**
	 * 分页对象
	 */
	private Page<PersonInformationVo> page;
	
	/**
	 * 年龄
	 */
	private Integer age;
	
	/**
	 * 身高
	 */
	private Double height;
	
	/**
	 * 体重
	 */
	private Double weight;
	
	/**
	 * 婚姻状况:1未婚,2已婚,3丧偶,4离婚,5未说明的婚姻状况
	 */
	private String marryStatus;

	/**
	 * 医疗费用支付方式:1成长职工基本医疗保险,2城镇居民基本医疗保险,4新型农村合作医疗,8商业医疗保险,16全公费,32全自费,64其他
	 */
	private Integer paymentWaystring;
	
	/**
	 * 民族
	 */
	private String nation;
	
	/**
	 * 头像url
	 */
	private String img;
	
	/**
	 * 账号uid
	 */
	private String uid;
	/**
	 * 对应的疾病标签
	 */
	private List<DiseaseLabelVo> labels;
	private String creator;
	
	/**
     * 基卫personId
     */
    private String jwPersonId;
    
	public String getJwPersonId() {
		return jwPersonId;
	}

	public void setJwPersonId(String jwPersonId) {
		this.jwPersonId = jwPersonId;
	}
	
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public List<DiseaseLabelVo> getLabels() {
		return labels;
	}

	public void setLabels(List<DiseaseLabelVo> labels) {
		this.labels = labels;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getPersonCode() {
		return personCode;
	}

	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}

	public String getFamilyId() {
		return familyId;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	public String getCustomNumber() {
		return customNumber;
	}

	public void setCustomNumber(String customNumber) {
		this.customNumber = customNumber;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getMasterFlag() {
		return masterFlag;
	}

	public void setMasterFlag(String masterFlag) {
		this.masterFlag = masterFlag;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Integer getIfSign() {
		return ifSign;
	}

	public void setIfSign(Integer ifSign) {
		this.ifSign = ifSign;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getFamilyNum() {
		return familyNum;
	}

	public void setFamilyNum(Integer familyNum) {
		this.familyNum = familyNum;
	}

	public Page<PersonInformationVo> getPage() {
		return page;
	}

	public void setPage(Page<PersonInformationVo> page) {
		this.page = page;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public String getMarryStatus() {
		return marryStatus;
	}

	public void setMarryStatus(String marryStatus) {
		this.marryStatus = marryStatus;
	}

	public Integer getPaymentWaystring() {
		return paymentWaystring;
	}

	public void setPaymentWaystring(Integer paymentWaystring) {
		this.paymentWaystring = paymentWaystring;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public List<PersonInformationVo> getPolist() {
		return polist;
	}

	public void setPolist(List<PersonInformationVo> polist) {
		this.polist = polist;
	}

	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	
	
}
