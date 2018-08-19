package com.boco.modules.fdoc.vo.surrender;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.boco.common.persistence.Page;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;


public class SurrenderRequestVo {
	/**
     * 主键id
     */
    private Integer id;

    /**
     * 居民id
     */
    private String personId;

    /**
     * 医生团队id
     */
    private String docTeamId;

    /**
     * 解约发起方 1,医生 2,用户
     */
    private String originator;

    /**
     * 居民电话号码
     */
    private String residentMobile;

    /**
     * 医生电话号码
     */
    private String docMobile;

    /**解约原因权值
     * 
     */
    private Integer reasonValue;

    /**
     * 其他解约原因
     */
    private String reasonOther;

    /**
     * 解约请求审核状态 1，审核中 2，拒绝解约 3，已解约(同意解约)
     */
    private String status;

    /**
     * 解约请求时间
     */
    private Date requestTime;

    /**
     * 审核时间
     */
    private Date auditTime;

    /**
     * 审核备注
     */
    private String auditRemark;
    /**
	 * 服务包权值
	 */
	private Integer servicePackValue;
    /**
     * 签约服务包集合
     */
    private List<SigServicepackEntity> packs;
    /**
     * 解约原因集合
     */
    private List<SurrenderReasonEntity> reasonPacks;
	/**
     * 居民姓名
     */
    private String personName;
    
    /**
     * 居民性别
     */
    private String sex;
    /**
     * 年龄
     */
    private Integer age;
    /**
     * 现住址
     */
    private String currentAddress;
    /**
	 * 居民身份证号
	 */
	private String idCard;
	
	/**
    * 签约图片
    */
    private String signImg;
    
    /**
     * 分页对象
     */
    private Page<SurrenderRequestVo> page;
    
    /**
	 * 签约ID对应的状态map
	 */
	private Map<String, Object> surrenderMap;
	/**
	 * 签约年限
	 */
	private Integer term;
	/**
	 * 签约服务包总价
	 */
	private Double serviceTotalPrice;
	/**
	 * 签约id
	 */
	/**
     * 解约请求时间
     */
    private String requestTimeStr;

    /**
     * 审核时间
     */
    private String auditTimeStr;
	private Integer signId;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getDocTeamId() {
		return docTeamId;
	}

	public void setDocTeamId(String docTeamId) {
		this.docTeamId = docTeamId;
	}

	public String getOriginator() {
		return originator;
	}

	public void setOriginator(String originator) {
		this.originator = originator;
	}

	public String getResidentMobile() {
		return residentMobile;
	}

	public void setResidentMobile(String residentMobile) {
		this.residentMobile = residentMobile;
	}

	public String getDocMobile() {
		return docMobile;
	}

	public void setDocMobile(String docMobile) {
		this.docMobile = docMobile;
	}

	public Integer getReasonValue() {
		return reasonValue;
	}

	public void setReasonValue(Integer reasonValue) {
		this.reasonValue = reasonValue;
	}

	public String getReasonOther() {
		return reasonOther;
	}

	public void setReasonOther(String reasonOther) {
		this.reasonOther = reasonOther;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getRequestTime() {
		return requestTime;
	}

	public void setRequestTime(Date requestTime) {
		this.requestTime = requestTime;
	}

	public Date getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}

	public String getAuditRemark() {
		return auditRemark;
	}

	public void setAuditRemark(String auditRemark) {
		this.auditRemark = auditRemark;
	}

	public List<SigServicepackEntity> getPacks() {
		return packs;
	}

	public void setPacks(List<SigServicepackEntity> packs) {
		this.packs = packs;
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

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getSignImg() {
		return signImg;
	}

	public void setSignImg(String signImg) {
		this.signImg = signImg;
	}

	public Page<SurrenderRequestVo> getPage() {
		return page;
	}

	public void setPage(Page<SurrenderRequestVo> page) {
		this.page = page;
	}

	public Integer getServicePackValue() {
		return servicePackValue;
	}

	public void setServicePackValue(Integer servicePackValue) {
		this.servicePackValue = servicePackValue;
	}

	public Map<String, Object> getSurrenderMap() {
		Map<String, Object>  map=new HashMap<>();
		map.put("id", this.id);
		map.put("status", this.status);
		return map;
	}

	public void setSurrenderMap(Map<String, Object> surrenderMap) {
		this.surrenderMap = surrenderMap;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public List<SurrenderReasonEntity> getReasonPacks() {
		return reasonPacks;
	}

	public void setReasonPacks(List<SurrenderReasonEntity> reasonPacks) {
		this.reasonPacks = reasonPacks;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public Double getServiceTotalPrice() {
		return serviceTotalPrice;
	}

	public void setServiceTotalPrice(Double serviceTotalPrice) {
		this.serviceTotalPrice = serviceTotalPrice;
	}

	public Integer getSignId() {
		return signId;
	}

	public void setSignId(Integer signId) {
		this.signId = signId;
	}

	public String getRequestTimeStr() {
		return requestTimeStr;
	}

	public void setRequestTimeStr(String requestTimeStr) {
		this.requestTimeStr = requestTimeStr;
	}

	public String getAuditTimeStr() {
		return auditTimeStr;
	}

	public void setAuditTimeStr(String auditTimeStr) {
		this.auditTimeStr = auditTimeStr;
	}
}
