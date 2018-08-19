package com.boco.modules.fdoc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boco.common.constants.BusinessConstants;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.RestfulUtils;
import com.boco.modules.fdoc.dao.PersonInformationDao;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.service.PersonInformationService;
import com.boco.modules.fdoc.vo.PersonInformationVo;
@Service
public class PersonInformationServiceImpl implements PersonInformationService{
	
	@Resource
	PersonInformationDao personDao;

	@Override
	public PersonInformationVo getPersonInfoByIdCard(PersonInformationEntity entity) {
		return personDao.getPersonInfoByIdCard(entity);
	}

	@Override
	public PersonInformationEntity getPersonInformationByPesronId(String personId) {
		return personDao.getPersonInformationByPesronId(personId);
	}

	@Override
	public List<PersonInformationVo> getFamilyMember(String familyId) {
		return personDao.getFamilyMember(familyId);
	}

	@Override
	public PersonInformationVo getMasterInfo(String familyId) {
		return personDao.getMasterInfo(familyId);
	}

	@Override
	public PersonInformationVo getPersonDetailByPersonId(String personId) {
		return personDao.getPersonDetailByPersonId(personId);
	}

	@Override
	public List<PersonInformationEntity> getPersonInformationByUid(String uid) {		 
		return personDao.getPersonInformationByUid(uid) ;
	}

	@Override
	public List<PersonInformationVo> getPersonDetailByPersonName(String personName) {
		return personDao.getPersonDetailByPersonName(personName);
	}

	@Override
	@Transactional
	public String insertPersonInfo(PersonInformationEntity entity,
			Map<String, Object> paramMap) {
		// 设置状态为正常、未签约
		entity.setState(Integer.parseInt(BusinessConstants.USER_STATUS_NORMAL));
		entity.setIfSign(Integer.parseInt(BusinessConstants.NO));
		// 插入表
		personDao.insert(entity);
		// 调用卫计委接口
		String returnData = RestfulUtils.getPublicData("55-14", paramMap);
		if(returnData==null){
			throw new RuntimeException("远程调用返回异常");
		}else{
			Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(returnData);
			if ((Integer) jsonMap.get("Result")!=1) {
				// 返回result为0，抛出异常，回滚新增操作
				throw new RuntimeException((String) jsonMap.get("Msg"));
			}
			System.out.println(JsonUtils.getJsonFormat(jsonMap));
			return BusinessConstants.SUCCESS;
	    }

	}
	
	@Override
	@Transactional
	public String deletePerson(String personId, String productCode) {
		personDao.deletePerson(personId);
		
		//封装调用卫计委接口的参数Map
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("PersonID", personId);
		paramMap.put("ProductCode", productCode);
		
		String returnData = RestfulUtils.getPublicData("55-13", paramMap);
        Map<String, Object> jsonMap = JsonUtils.getObjectJsonMap(returnData);
        if ((Integer) jsonMap.get("Result") == 0) {
			// 返回result为0，抛出异常，回滚新增操作
			throw new RuntimeException((String) jsonMap.get("Msg"));
		}
        
		return BusinessConstants.SUCCESS;
	}

	@Override
	public Integer resetMaster(String familyId) {
		return personDao.resetMaster(familyId);
	}

	@Override
	public Integer setMaster(String masterIdCard) {
		return personDao.setMaster(masterIdCard);
		
	}

	@Override
	public int getMasterFlag(String familyId) {
		return personDao.getMasterFlag(familyId);
	}

	
}
