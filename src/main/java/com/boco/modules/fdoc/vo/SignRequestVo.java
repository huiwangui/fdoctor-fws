package com.boco.modules.fdoc.vo;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.boco.common.persistence.Page;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.model.SigServicepackEntity;

public class SignRequestVo {

 
	/**
	 * 签约包总价
	 */
	private Double total;
	/**
	 * 签约申请户主身份证
	 */
	private String masterIdCard;

	/**
	 * 签约申请户主地址
	 */
	private String masterAdr;
	private Map<String,Object>  signmap;
	/**
	 * 签约申请户主年龄
	 */
	private Integer masterAge;

	/**
	 * 签约申请户主性别
	 */
	private String masterSex;
	
	 /**
     * 居民性别
     */
    private String sex;
    
    /**
     * 人员年龄
     */
    private Integer age;
    /**
     * 人员身份证
     */
    private String idCard;
    
	/**
     * 户主信息
     */
	private PersonInformationVo personInformationVo;
	 /**
     * 户主家庭成员列表信息
     */
	private  List<PersonInformationVo>  polist;

	/**
	 * 签约申请主键ID
	 */
	private Integer id;

	/**
	 * 团队ID
	 */
	private String docTeamId;

	/**
	 * 医生所属机构名称
	 */
	private String docOrgName;

	/**
	 * 签约家庭ID
	 */
	private String familyId;

	/**
	 * 签约图片
	 */
	private String signImg;

	/**
	 * 所选服务包权值，为多选值相加
	 */
	private Integer servicePackValue;

	/**
	 * 协议号
	 */
	private String agreementNum;

	/**
	 * 签约期限（年）
	 */
	private Integer term;

	/**
	 * 申请状态：1.待确认 2.已确认 3.已拒绝
	 */
	private String status;

	/**
	 * 申请发起时间
	 */
	private Date createTime;
	 /**
     * 签约状态：1.待确认 2.确认3.已拒绝
     */
     private String rqstatus;
     /**
 	 * 签约开始时间 
 	 */
 	private String begin;
 	/**
 	 * 签约结束时间时间 
 	 */
 	private String end;
	
	/**
	 * 签约申请户主姓名
	 */
	private String masterName;
	
	/**
	 * 签约申请家庭成员数量
	 */
	private Integer familyNum;
	
	/**
	 * 签约申请家庭所属单位
	 */
	private String familyUnit;
	
	/**
	 * 所签服务包
	 */
	private List<SigServicepackEntity> packs;
	
	/**
	 * 分页对象
	 */
	private Page<SignRequestVo> page;
	
	/**
	 * 医生团队中的医生姓名
	 */
	private String docName;
	
	/**
	 * 医生团队所属机构名
	 */
	private String orgName;
	
	/**
	 * 标签
	 */
	private List<DiseaseLabelVo> labels;
	/**
	 * 住址
	 */
	private String currentAddress;
	/**
	 * 个人id
	 */
	private String personId;
	/**
	 * 姓名
	 */
	private String personName;
	
	/**
	 * 签约结束时间
	 */
	private Date dueTime;
	

	public Date getDueTime() {
		return dueTime;
	}

	public void setDueTime(Date dueTime) {
		this.dueTime = dueTime;
	}
	
	
	
	
	
	
	
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public List<DiseaseLabelVo> getLabels() {
		return labels;
	}

	public void setLabels(List<DiseaseLabelVo> labels) {
		this.labels = labels;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDocTeamId() {
		return docTeamId;
	}

	public void setDocTeamId(String docTeamId) {
		this.docTeamId = docTeamId;
	}

	public String getDocOrgName() {
		return docOrgName;
	}

	public void setDocOrgName(String docOrgName) {
		this.docOrgName = docOrgName;
	}

	public String getFamilyId() {
		return familyId;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	public String getSignImg() {
		return signImg;
	}

	public void setSignImg(String signImg) {
		this.signImg = signImg;
	}

	public Integer getServicePackValue() {
		return servicePackValue;
	}

	public void setServicePackValue(Integer servicePackValue) {
		this.servicePackValue = servicePackValue;
	}

	public String getAgreementNum() {
		return agreementNum;
	}

	public void setAgreementNum(String agreementNum) {
		this.agreementNum = agreementNum;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public Integer getFamilyNum() {
		return familyNum;
	}

	public void setFamilyNum(Integer familyNum) {
		this.familyNum = familyNum;
	}

	public String getFamilyUnit() {
		return familyUnit;
	}

	public void setFamilyUnit(String familyUnit) {
		this.familyUnit = familyUnit;
	}

	public List<SigServicepackEntity> getPacks() {
		return packs;
	}

	public void setPacks(List<SigServicepackEntity> packs) {
		this.packs = packs;
	}

	public Page<SignRequestVo> getPage() {
		return page;
	}

	public void setPage(Page<SignRequestVo> page) {
		this.page = page;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public PersonInformationVo getPersonInformationVo() {
		return personInformationVo;
	}

	public void setPersonInformationVo(PersonInformationVo personInformationVo) {
		this.personInformationVo = personInformationVo;
	}

	public List<PersonInformationVo> getPolist() {
		return polist;
	}

	public void setPolist(List<PersonInformationVo> polist) {
		this.polist = polist;
	}
	public Integer getMasterAge() {
		return masterAge;
	}

	public void setMasterAge(Integer masterAge) {
		this.masterAge = masterAge;
	}

	public String getMasterSex() {
		return masterSex;
	}

	public void setMasterSex(String masterSex) {
		this.masterSex = masterSex;
	}
	public Map<String, Object> getSignmap() {
		return signmap;
	}

	public void setSignmap(Map<String, Object> signmap) {
		this.signmap = signmap;
	}
	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public String getMasterIdCard() {
		return masterIdCard;
	}

	public void setMasterIdCard(String masterIdCard) {
		this.masterIdCard = masterIdCard;
	}

	public String getMasterAdr() {
		return masterAdr;
	}

	public void setMasterAdr(String masterAdr) {
		this.masterAdr = masterAdr;
	}

	public String getRqstatus() {
		return rqstatus;
	}

	public void setRqstatus(String rqstatus) {
		this.rqstatus = rqstatus;
	}

	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
	
}
