package com.boco.modules.fdoc.model;

import java.util.Date;

public class SigServicepackEntity {
    /**
    * 主键
    */
    private Integer id;

    /**
    * 服务包名称
    */
    private String packName;

    /**
    * 服务包权值，必须为2的幂次方，且不能重复
    */
    private Integer packValue;

    /**
    * 服务包价格
    */
    private Double packPrice;

    /**
    * 用户应付金额
    */
    private Double userPay;

    /**
    * 机构分成比例  1-100 
    */
    private Float orgratio;

    /**
    * 建议人群
    */
    private String adviceGroup;

    /**
    * 目标
    */
    private String target;

    /**
    * 创建者
    */
    private String createby;

    /**
    * 创建时间
    */
    private Date createtime;

    /**
    * 修改者
    */
    private String updateby;

    /**
    * 跟新时间
    */
    private Date updatetime;

    /**
    * 描述
    */
    private String remarks;
    
    /**
     * 服务包种类  1.基础服务  2.增值服务
     */
    private String packType;

    /**
    * 0:正常  1：逻辑删除
    */
    private Short delFlag;
    
    /**
     * 次数
     */
    private Integer frequency;
    

    public Integer getFrequency() {
		return frequency;
	}

	public void setFrequency(Integer frequency) {
		this.frequency = frequency;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPackName() {
        return packName;
    }

    public void setPackName(String packName) {
        this.packName = packName;
    }

    public Integer getPackValue() {
        return packValue;
    }

    public void setPackValue(Integer packValue) {
        this.packValue = packValue;
    }

    public Double getPackPrice() {
        return packPrice;
    }

    public void setPackPrice(Double packPrice) {
        this.packPrice = packPrice;
    }

    public Double getUserPay() {
        return userPay;
    }

    public void setUserPay(Double userPay) {
        this.userPay = userPay;
    }

    public Float getOrgratio() {
        return orgratio;
    }

    public void setOrgratio(Float orgratio) {
        this.orgratio = orgratio;
    }

    public String getAdviceGroup() {
        return adviceGroup;
    }

    public void setAdviceGroup(String adviceGroup) {
        this.adviceGroup = adviceGroup;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getCreateby() {
        return createby;
    }

    public void setCreateby(String createby) {
        this.createby = createby;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getUpdateby() {
        return updateby;
    }

    public void setUpdateby(String updateby) {
        this.updateby = updateby;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Short getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Short delFlag) {
        this.delFlag = delFlag;
    }

	public String getPackType() {
		return packType;
	}

	public void setPackType(String packType) {
		this.packType = packType;
	}
    
    
}