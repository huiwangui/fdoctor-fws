package com.boco.modules.fdoc.model;

import java.util.Date;

public class SignRequestEntity {
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
     * 签约个人ID
     */
     private String personId;

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
     * 申请状态：1.待确认  2.已确认 3.已拒绝
     */
    private String status;

    /**
    * 申请发起时间
    */
    private Date createTime;
    
    
  
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}
	
}