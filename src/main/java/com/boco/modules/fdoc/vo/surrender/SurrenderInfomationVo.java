package com.boco.modules.fdoc.vo.surrender;

import java.util.Date;
import java.util.List;

import com.boco.common.persistence.Page;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.surrender.SurrenderReasonEntity;

public class SurrenderInfomationVo {
	/**
     * 主键id
     */
    private Integer id;

    /**
     * 签约请求表id
     */
    private Integer requestId;

    /**
     * 区划码
     */
    private String regionCode;

    /**
     * 医院id
     */
    private String orgId;

    /**
     * 服务包权值
     */
    private Integer servicePackValue;

    /**
     * 签约上传图片地址
     */
    private String signImg;

    /**
     * 签约类型：1.医生端主动签约 2.居民端提出申请完成签约
     */
    private String signType;

    /**
     * 签约时备注
     */
    private String signRemark;

    /**
     * 签约时间
     */
    private Date signTime;

    /**
     * 签约结束时间
     */
    private Date dueTime;
    
    /**
     * 签约服务包集合
     */
    private List<SigServicepackEntity> packs;
    
    /**
     * 居民姓名
     */
    private String personName;
    
    /**
     * 居民性别
     */
    private String sex;
    
    /**
	 * 居民身份证号
	 */
	private String idCard;
	
	/**
     * 居民电话号码
     */
    private String residentMobile;
	
	/**
	 * 现住址
	 */
	private String currentAddress;
	/**
     * 分页对象
     */
    private Page<SurrenderInfomationVo> page;
    
    /**解约原因权值
     * 
     */
    private Integer reasonValue;

    /**
     * 其他解约原因
     */
    private String reasonOther;

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
     * 解约原因集合
     */
    private List<SurrenderReasonEntity> reasonPacks;
    /**
	 * 签约年限
	 */
	private Integer term;
	/**
	 * 签约服务包总价
	 */
	private Double serviceTotalPrice;
    

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRequestId() {
		return requestId;
	}

	public void setRequestId(Integer requestId) {
		this.requestId = requestId;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public Integer getServicePackValue() {
		return servicePackValue;
	}

	public void setServicePackValue(Integer servicePackValue) {
		this.servicePackValue = servicePackValue;
	}

	public String getSignImg() {
		return signImg;
	}

	public void setSignImg(String signImg) {
		this.signImg = signImg;
	}

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	public String getSignRemark() {
		return signRemark;
	}

	public void setSignRemark(String signRemark) {
		this.signRemark = signRemark;
	}

	public Date getSignTime() {
		return signTime;
	}

	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}

	public Date getDueTime() {
		return dueTime;
	}

	public void setDueTime(Date dueTime) {
		this.dueTime = dueTime;
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

	public Page<SurrenderInfomationVo> getPage() {
		return page;
	}

	public void setPage(Page<SurrenderInfomationVo> page) {
		this.page = page;
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

	public String getResidentMobile() {
		return residentMobile;
	}

	public void setResidentMobile(String residentMobile) {
		this.residentMobile = residentMobile;
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
}
