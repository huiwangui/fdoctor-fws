package com.boco.modules.fdoc.service;

import java.util.List;
import java.util.Map;

import com.boco.modules.fdoc.model.DoctorUserEntity;
import com.boco.modules.fdoc.model.PersonDeseaseInfoEntity;
import com.boco.modules.fdoc.model.SignAgreementEntity;
import com.boco.modules.fdoc.model.UserDocSignEntity;
import com.boco.modules.fdoc.model.UserEntity;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.UserVo;


/**
 * 签约相关service层
 * @author q
 *
 */
public interface SignService {
	/**
	 * 
	 * getNotSignMaster:(获取区域内未签约的家庭户主，按照姓名查询（包含其他家庭成员姓名）). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public List<PersonInformationVo> getNotSignMaster(PersonInformationVo vo);
	/**
	 * 
	 * getNotSignMasterCount:(获取区域内未签约的家庭户主总数，按照姓名查询（包含其他家庭成员姓名）). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public Integer getNotSignMasterCount(PersonInformationVo vo);
	/**
	 * 
	 * sign:(新增签约). <br/>
	 * @author q
	 * @param signEntity
	 * @param agreementEntity
	 * @return
	 */
	public Map<String, Object> sign(UserDocSignEntity signEntity, List<PersonDeseaseInfoEntity> deseaseInfo);
	/**
	 * 
	 * getSignedList:(查询已签约人员列表). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public List<PersonInformationVo> getSignedList(SignVo vo);
	/**
	 * 
	 * getSignedCount:(查询已签约人数). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public Integer getSignedCount(SignVo vo);
	/**
	 * 
	 * getSignedFamilyCount:(查询已签约的户数). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public Integer getSignedFamilyCount(SignVo vo);
	/**
	 * 
	 * getSignedFamilyList:(获取已签约家庭列表). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public List<SignVo> getSignedFamilyList(SignVo vo);
	/**
	 * 
	 * getSignDetail:(查看签约详情). <br/>
	 * @author q
	 * @param signId
	 * @return
	 */
	public SignVo getSignDetail(Integer signId);
	/**
	 * 
	 * getSignDetail:(通过身份证号获取签约详情). <br/>
	 * @author q
	 * @param signId
	 * @return
	 */
	public SignVo getSignDetailByIdCard(String idCard);
	/**
	 * 
	 * getSignTeamUsers:(获取同某人签约的医生团队账号列表，用于推送). <br/>
	 * @author q
	 * @return
	 */
	public List<String> getSignTeamUsers(String personId);
	/**
	 * 
	 * getSignFamilyUsers:(获取医生签约下的所有居民账号列表，用于推送). <br/>
	 * @author q
	 * @param userName
	 * @return
	 */
	public List<String> getSignFamilyUsers(String userName);
	/**
	 * 
	 * getSignDoctorTeamInfo:(获取与某人签约的医生团队信息). <br/>
	 * @author q
	 * @param personId
	 * @return
	 */
	public List<DoctorDetailVo> getSignDoctorTeamInfo(String personId);
	/**
	 * 
	 * getSignedCountByRegion:(查询区划范围内的签约人数). <br/>
	 * @author q
	 * @param regionCode
	 * @return
	 */
	public SignVo getSignedCountByRegion(String regionCode);
	/**
	 * 
	 * getSignedUserAccound:(获取医生已签约的用户app账号列表). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public List<UserVo> getSignedUserAccound(SignVo vo);
	
	/**
	 * 
	 * getSignedUserAccoundCount:(获取医生已签约的用户app账号总数). <br/>
	 * @author q
	 * @return
	 */
	public Integer getSignedUserAccoundCount(SignVo vo);
	
	/**
	 * 按团队获取签约记录和签约请求的总数
	 * @param vo
	 * @return
	 *
	 */
	public Integer getSignAndRequestListCount(SignVo vo);
	
	/**
	 * 按团队获取签约记录和签约请求列表
	 * @param vo
	 * @return
	 *
	 */
	public List<SignVo> getSignAndRequestList(SignVo vo);
	
	/**
	 * 根据personId获取签约详情
	 * @param personId
	 * @return
	 *
	 */
	public SignVo getSignDetailBypersonId(String personId);
	
	/**
	 * 获取未签约列表
	 * @param vo
	 * @return
	 *
	 */
	List<PersonInformationVo> getPersonListWithNoSignInfo(PersonInformationVo vo);
	
	/**
	 * 获取未签约列表总数
	 * @param vo
	 * @return
	 *
	 */
	public int getPersonListWithNoSignInfoCount(PersonInformationVo vo);
}
