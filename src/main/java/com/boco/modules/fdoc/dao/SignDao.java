package com.boco.modules.fdoc.dao;

import java.util.List;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.DoctorUserEntity;
import com.boco.modules.fdoc.model.PersonInformationEntity;
import com.boco.modules.fdoc.model.SignAgreementEntity;
import com.boco.modules.fdoc.model.UserDocSignEntity;
import com.boco.modules.fdoc.model.UserEntity;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.PersonInformationVo;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.UserVo;

/**
 * 
 * ClassName: SignDao <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * Reason: 签约相关Dao. <br/>
 * date: 2017年2月8日 上午10:47:00 <br/>
 *
 * @author q
 * @version 
 * @since JDK 1.7+
 */
@MyBatisDao
public interface SignDao extends CrudDao<UserDocSignEntity>{
	/**
	 * 获取签约信息
	 * @param entity
	 * @return
	 */
	public UserDocSignEntity getSignRecord(UserDocSignEntity entity);

	/**
	 * 
	 * updateFamilySignFlag:(签约修改居民标识). <br/>
	 * @author q
	 * @param personEntity
	 * @return
	 */
	public Integer updateSignFlag(PersonInformationEntity personEntity);
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
	 * insertAgreement:(新增签约协议). <br/>
	 * @author q
	 * @param agreementEntity
	 * @return
	 */
	public Integer insertAgreement(SignAgreementEntity agreementEntity);
	/**
	 * 
	 * getSign:(查询签约). <br/>
	 * @author q
	 * @param entity
	 * @return
	 */
	public List<UserDocSignEntity> getFamilySign(UserDocSignEntity entity);
	/**
	 * 
	 * updateFamilySignFlag:(签约修改居民标识). <br/>
	 * @author q
	 * @param personEntity
	 * @return
	 */
	public Integer updateFamilySignFlag(PersonInformationEntity personEntity);
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
	 * getSignedCount:(查询已签约户数). <br/>
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
	 * getSignedCountByRegion:(根据区划获取签约人数). <br/>
	 * @author q
	 * @param vo
	 * @return
	 */
	public Integer getSignedCountByRegion(SignVo vo);
	
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
	public List<PersonInformationVo> getPersonListWithNoSignInfo(PersonInformationVo vo);
	
	/**
	 * 获取未签约列表总数
	 * @param vo
	 * @return
	 *
	 */
	public int getPersonListWithNoSignInfoCount(PersonInformationVo vo);
}
