package com.boco.modules.fdoc.service.impl;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boco.common.comparator.UserComparator;
import com.boco.common.constants.BusinessConstants;
import com.boco.common.utils.NumberUtils;
import com.boco.modules.fdoc.dao.DiseaseLabelDao;
import com.boco.modules.fdoc.dao.PersonDeseaseInfoDao;
import com.boco.modules.fdoc.dao.PersonInformationDao;
import com.boco.modules.fdoc.dao.SigServicepackDao;
import com.boco.modules.fdoc.dao.SignDao;
import com.boco.modules.fdoc.model.DiseaseLabelEntity;
import com.boco.modules.fdoc.model.DiseaseLabelPersonRelationEntity;
import com.boco.modules.fdoc.model.PersonDeseaseInfoEntity;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.model.SigServicepackEntity;
import com.boco.modules.fdoc.model.SignAgreementEntity;
import com.boco.modules.fdoc.model.UserDocSignEntity;
import com.boco.modules.fdoc.service.SignService;
import com.boco.modules.fdoc.vo.DiseaseLabelVo;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.UserVo;

@Service
public class SignServiceImpl implements SignService {

	@Resource
	SignDao signDao;
	@Resource
	SigServicepackDao servicePackDao;
	@Resource
	PersonInformationDao personDao;
	@Resource
	PersonDeseaseInfoDao deseaseInfoDao;
    @Resource
    DiseaseLabelDao diseaseLabelDao;
    
	/**
	 * 获取未签约的户主.
	 */
	@Override
	public List<PersonInformationVo> getNotSignMaster(PersonInformationVo vo) {
		List<PersonInformationVo> personList = signDao.getNotSignMaster(vo);
		for (PersonInformationVo personInformationVo : personList) {
			if("1".equals(personInformationVo.getSex())){
				personInformationVo.setSex("男");
			}else if("2".equals(personInformationVo.getSex())){
				personInformationVo.setSex("女");
			}else{
				personInformationVo.setSex("不详");
			}
			Integer count = personDao.getMemberCountInFamily(personInformationVo.getFamilyId());
			personInformationVo.setFamilyNum(count);
			//封装家庭信息
			List<PersonInformationVo> familyMember = personDao.getFamilyMember(personInformationVo.getFamilyId());
			if (familyMember != null) {
				for (PersonInformationVo memberVo : familyMember) {
					if("1".equals(memberVo.getSex())){
						memberVo.setSex("男");
					}else if("2".equals(memberVo.getSex())){
						memberVo.setSex("女");
					}else{
						memberVo.setSex("不详");
					}
				}
			}
			//排序放入 户主第一
			UserComparator comparator = new UserComparator();
			Collections.sort(familyMember, comparator);
			personInformationVo.setPolist(familyMember);
			/*//封装所选服务包列表信息
					
			List<SigServicepackEntity> packs = servicePackDao.findAllList();
		
			requestDetail.setPacks(packs);*/
		}
		
		return personList;
	}
	
	/**
	 * 获取未签约的户主.
	 */
	public List<PersonInformationVo> getNotSignMasterwithDocteamId(PersonInformationVo vo,String teamId) {
		List<PersonInformationVo> personList = signDao.getNotSignMaster(vo);
		for (PersonInformationVo personInformationVo : personList) {
			if("1".equals(personInformationVo.getSex())){
				personInformationVo.setSex("男");
			}else if("2".equals(personInformationVo.getSex())){
				personInformationVo.setSex("女");
			}else{
				personInformationVo.setSex("不详");
			}
			Integer count = personDao.getMemberCountInFamily(personInformationVo.getFamilyId());
			personInformationVo.setFamilyNum(count);
			//封装家庭信息
			List<PersonInformationVo> familyMember = personDao.getFamilyMember(personInformationVo.getFamilyId());
			if (familyMember != null) {
				for (PersonInformationVo memberVo : familyMember) {
					if("1".equals(memberVo.getSex())){
						memberVo.setSex("男");
					}else if("2".equals(memberVo.getSex())){
						memberVo.setSex("女");
					}else{
						memberVo.setSex("不详");
					}
					// 设置居民慢病标签情况
					DiseaseLabelVo labelVo = new DiseaseLabelVo();
					labelVo.setPersonId(memberVo.getPersonId());
					labelVo.setDocTeamId(teamId);
					List<DiseaseLabelVo> labelList = diseaseLabelDao.getLabelListWithSelectFlag(labelVo);
					memberVo.setLabels(labelList);
				}
			}
			//排序放入 户主第一
			UserComparator comparator = new UserComparator();
			Collections.sort(familyMember, comparator);
			personInformationVo.setPolist(familyMember);
			/*//封装所选服务包列表信息
					
			List<SigServicepackEntity> packs = servicePackDao.findAllList();
		
			requestDetail.setPacks(packs);*/
		}
		
		return personList;
	}
	/**
	 * 获取未签约的户主数量.
	 */
	@Override
	public Integer getNotSignMasterCount(PersonInformationVo vo) {
		return signDao.getNotSignMasterCount(vo);
	}
	
	/**
	 * 签约.
	 */
	@Override
	@Transactional
	public Map<String, Object> sign(UserDocSignEntity signEntity, List<PersonDeseaseInfoEntity> deseaseInfo) {
		Map<String, Object> returnMap = new HashMap<String, Object>(); 
		//判断是否重复签约
		signEntity.setStatus(BusinessConstants.SIGN_STATUS_SIGNED);
		UserDocSignEntity signRecords = signDao.getSignRecord(signEntity);
		if (signRecords != null) {
			returnMap.put("returnMsg", BusinessConstants.ERROR_RE_SIGN);
			return returnMap;	//进行中的签约状态数量>1  说明重复签约
		}
		signEntity.setSignTime(new Date());
		
		//插入签约主表,返回插入记录的主键
		signDao.insert(signEntity);
		
		//新增或修改居民慢病标识
		for (PersonDeseaseInfoEntity desease : deseaseInfo) {
			if (deseaseInfoDao.get(desease.getPersonId()) == null) {
				Date newDate = new Date();
				desease.setCreateTime(newDate);
				desease.setUpdateTime(newDate);
				deseaseInfoDao.insert(desease);
			}else {
				desease.setUpdateTime(new Date());
				deseaseInfoDao.update(desease);
			}
		}
		//找到团队对应的标签ID然后新增个人和标签ID的关系
		for (PersonDeseaseInfoEntity desease : deseaseInfo) {
			DiseaseLabelEntity	labelEntity=new DiseaseLabelEntity();
			labelEntity.setDocTeamId(signEntity.getDocTeamId());
			//儿童
			if(BusinessConstants.YES.equals(desease.getChildFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_CHILD);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//高血压
			if(BusinessConstants.YES.equals(desease.getHyperFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_HYPER);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//重型精神病
			if(BusinessConstants.YES.equals(desease.getMajorPsychosisFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_MAJOR);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//糖尿病
			if(BusinessConstants.YES.equals(desease.getDiabetesFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_DIABETES);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//老年人
			if(BusinessConstants.YES.equals(desease.getOldmFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_OLDM);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//普通成人
			if(BusinessConstants.YES.equals(desease.getAdultFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_CHENR);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//孕产妇
			if(BusinessConstants.YES.equals(desease.getMaternalFlag())){
				labelEntity.setDiseaseCode(BusinessConstants.SIGN_YUNCH);	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//特困户
			if(BusinessConstants.YES.equals(desease.getPoorFlag())){
				labelEntity.setLabelName("特困户");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//残疾人
			if(BusinessConstants.YES.equals(desease.getDisabledFlag())){
				labelEntity.setLabelName("残疾人");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//低保户
			if(BusinessConstants.YES.equals(desease.getSubsistenceFlag())){
				labelEntity.setLabelName("低保户");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//五保户
			if(BusinessConstants.YES.equals(desease.getFiveproFlag())){
				labelEntity.setLabelName("五保户");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//计生特户
			if(BusinessConstants.YES.equals(desease.getFamilyplanFlag())){
				labelEntity.setLabelName("计生特户");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//结核病
			if(BusinessConstants.YES.equals(desease.getTuberculosisFlag())){
				labelEntity.setLabelName("结核病");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
			//流动人口
			if(BusinessConstants.YES.equals(desease.getFloatFlag())){
				labelEntity.setLabelName("流动人口");	
				Integer lableId=diseaseLabelDao.selectlableid(labelEntity);
				DiseaseLabelPersonRelationEntity cc=new DiseaseLabelPersonRelationEntity();
				cc.setLabelId(lableId);
				cc.setPersonId(desease.getPersonId());
				diseaseLabelDao.insertRelation(cc);
			}
		}
		
		
		
		
		//修改居民表签约标识
		PersonInformationEntity person = new PersonInformationEntity();
		person.setPersonId(signEntity.getPersonId());
		person.setIfSign(BusinessConstants.PERSON_SIGN_STATUS_SIGNED);
		signDao.updateSignFlag(person);
		//封装返回map
		returnMap.put("returnMsg", BusinessConstants.SUCCESS_SIGN);
		returnMap.put("signId", signEntity.getId());
		return returnMap;
	}
	

	@Override
	public List<PersonInformationVo> getSignedList(SignVo vo) {
		return signDao.getSignedList(vo);
	}

	@Override
	public Integer getSignedCount(SignVo vo) {
		return signDao.getSignedCount(vo);
	}

	@Override
	public Integer getSignedFamilyCount(SignVo vo) {
		return signDao.getSignedFamilyCount(vo);
	}

	@Override
	public List<SignVo> getSignedFamilyList(SignVo vo) {
		List<SignVo> signedFamilyList = signDao.getSignedFamilyList(vo);
		
		
		return signedFamilyList;
	}

	@Override
	public SignVo getSignDetail(Integer signId) {
		SignVo signDetail = signDao.getSignDetail(signId);
		 //封装所选服务包列表信息
		if(signDetail!=null){
			String values = NumberUtils.bitand(signDetail.getServicePackValue());
			Map<String, String> valuesMap = new HashMap<String, String>();
			valuesMap.put("values", values);
			List<SigServicepackEntity> packs = servicePackDao.getServicePacksByValues(valuesMap);
			signDetail.setPacks(packs);
		}
		//封装标签信息
		DiseaseLabelVo labelVo = new DiseaseLabelVo();
		labelVo.setPersonId(signDetail.getPersonId());
		labelVo.setDocTeamId(signDetail.getDocTeamId());
		List<DiseaseLabelVo> labelList = diseaseLabelDao.getLabelListWithSelectFlag(labelVo);
		signDetail.setLabels(labelList);
		return signDetail;
	}

	@Override
	public SignVo getSignDetailByIdCard(String idCard) {
		SignVo signDetail = signDao.getSignDetailByIdCard(idCard);
		//封装已签约服务包
		if (signDetail != null) {
			String values = NumberUtils.bitand(signDetail.getServicePackValue());
			Map<String, String> valuesMap = new HashMap<String, String>();
			valuesMap.put("values", values);
			List<SigServicepackEntity> packs = servicePackDao.getServicePacksByValues(valuesMap);
			signDetail.setPacks(packs);
		}
		return signDetail;
	}

	@Override
	public List<String> getSignTeamUsers(String personId) {
		return signDao.getSignTeamUsers(personId);
	}

	@Override
	public List<String> getSignFamilyUsers(String userName) {
		return signDao.getSignFamilyUsers(userName);
	}

	@Override
	public List<DoctorDetailVo> getSignDoctorTeamInfo(String personId) {
		return signDao.getSignDoctorTeamInfo(personId);
	}

	@Override
	public SignVo getSignedCountByRegion(String regionCode) {
		//封装查询参数
		PersonInformationVo personVo = new PersonInformationVo();
		SignVo signVo = new SignVo();
		personVo.setRegionCode(regionCode);
		signVo.setRegionCode(regionCode);
		
		Integer personCount = personDao.getPersonCountByRegion(personVo);
		Integer signCount = signDao.getSignedCountByRegion(signVo);
		signVo.setSignedCount(signCount);
		signVo.setPersonCount(personCount);
		if (personCount != 0) {
			Double signPer = Double.valueOf(signCount) / Double.valueOf(personCount);
			BigDecimal decimal = new BigDecimal(signPer * 100);
			signVo.setSignPer(decimal.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
		}else {
			signVo.setSignPer(Double.valueOf(0));
		}
		
		return signVo;
	}

	@Override
	public List<UserVo> getSignedUserAccound(SignVo vo) {
		return signDao.getSignedUserAccound(vo);
	}

	@Override
	public Integer getSignedUserAccoundCount(SignVo vo) {
		return signDao.getSignedUserAccoundCount(vo);
	}

	@Override
	public Integer getSignAndRequestListCount(SignVo vo) {
		return signDao.getSignAndRequestListCount(vo);
	}

	@Override
	public List<SignVo> getSignAndRequestList(SignVo vo) {
		return signDao.getSignAndRequestList(vo);
	}

	@Override
	public SignVo getSignDetailBypersonId(String personId) {
		        
		return signDao.getSignDetailBypersonId(personId);
	}

	@Override
	public List<PersonInformationVo> getPersonListWithNoSignInfo(PersonInformationVo vo) {
		return signDao.getPersonListWithNoSignInfo(vo);
	}

	@Override
	public int getPersonListWithNoSignInfoCount(PersonInformationVo vo) {
		return signDao.getPersonListWithNoSignInfoCount(vo);
	}

	
}
