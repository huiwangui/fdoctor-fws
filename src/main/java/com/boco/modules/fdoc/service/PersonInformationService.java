package com.boco.modules.fdoc.service;

import java.util.List;
import java.util.Map;

import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.vo.PersonInformationVo;


public interface PersonInformationService {
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
     * getPersonInformationByPesronId:(根据居民ID获取居民信息). <br/>
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
     * 根据居民uid查询其家庭成员
     * @param uid
     * @return
     */
    public List<PersonInformationEntity> getPersonInformationByUid(String uid);
    
    /**
     * 
     * getPersonDetailByPersonId:(根据姓名获取居民详细信息). <br/>
     * @author q
     * @param personId
     * @return
     */
    public List<PersonInformationVo> getPersonDetailByPersonName(String personName);
    
    /**
     * 添加居民
     * @param entity
     * @return
     * @throws Exception 
     *
     */
	String insertPersonInfo(PersonInformationEntity entity, Map<String, Object> item);
	/**
	 * 删除居民
	 * @param personId
	 * @param productCode
	 * @return
	 *
	 */
	String deletePerson(String personId, String productCode);
    /**
     * 重置户主
     * @param familyId
     * @return
     *
     */
	Integer resetMaster(String familyId);
	Integer setMaster(String masterIdCard);
	/**
	 * 查询是否有户主
	 * @param familyId
	 * @return
	 *
	 */
	int getMasterFlag(String familyId);
}
