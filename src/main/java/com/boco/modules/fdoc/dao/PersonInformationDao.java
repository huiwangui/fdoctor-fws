package com.boco.modules.fdoc.dao;

import java.util.List;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.vo.PersonInformationVo;

@MyBatisDao
public interface PersonInformationDao extends CrudDao<PersonInformationEntity>{
	/**
	 * 
	 * getPersonInfoByScan:(医生端扫健康卡获取居民信息). <br/>
	 * @author q
	 * @param personCode
	 * @return
	 */
    public PersonInformationVo getPersonInfoByIdCard(PersonInformationEntity entity);
    /**
     * 
     * getPersonInformationByPesronId:(根据居民ID获取居民信息单表). <br/>
     * @author q
     * @param personId
     * @return
     */
    public PersonInformationEntity getPersonInformationByPesronId(String personId);
    /**
     * 
     * getFamilyMember:(根据家庭ID获取家庭成员). <br/>
     * @author q
     * @param familyId
     * @return
     */
    public List<PersonInformationVo> getFamilyMember(String familyId);
    /**
     * 
     * getPersonInfoByIdcardAndName:(根据身份证和姓名获取居民信息). <br/>
     * @author q
     * @return
     */
    public PersonInformationEntity getPersonInfoByIdcardAndName(String idCard, String personName);
    /**
     * 
     * getMasterInfo:(获取户主信息). <br/>
     * @author q
     * @param familyId
     * @return
     */
    public PersonInformationVo getMasterInfo(String familyId);
    /**
     * 
     * getPersonDetailByPersonId:(获取居民详细信息). <br/>
     * @author q
     * @param personId
     * @return
     */
    public PersonInformationVo getPersonDetailByPersonId(String personId);
    /**
     * 
     * getMemberCountInFamily:(获取家庭人员总数). <br/>
     * @author q
     * @param familyId
     * @return
     */
    public Integer getMemberCountInFamily(String familyId);
    /**
     * 根据居民uid查询其家庭成员
     * @param uid
     * @return
     */
    public List<PersonInformationEntity> getPersonInformationByUid(String uid);
    /**
     * 
     * getPersonCountByRegion:(根据区划查询居民人数). <br/>
     * @author q
     * @param vo
     * @return
     */
    public Integer getPersonCountByRegion(PersonInformationVo vo);
    /**
     * 
     * getPersonDetailByPersonId:(根据姓名获取居民详细信息). <br/>
     * @author q
     * @param personId
     * @return
     */
    public List<PersonInformationVo> getPersonDetailByPersonName(String personName);
	public Integer resetMaster(String familyId);
	public Integer setMaster(String masterIdCard);
	public void deletePerson(String personId);
	/**
	 * 查询是否有户主
	 * @param familyId
	 * @return
	 *
	 */
	int getMasterFlag(String familyId);
}
