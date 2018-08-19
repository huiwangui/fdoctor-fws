 package com.boco.modules.fdoc.dao.surrender;

import com.boco.common.annotation.MyBatisDao;
import com.boco.common.persistence.CrudDao;
import com.boco.modules.fdoc.model.surrender.SurrenderInformationEntity;
import com.boco.modules.fdoc.vo.surrender.SurrenderInfomationVo;

/**
 * Tilte: SurrenderInformationDao 
 * Description:
 * @author h
 * @date  2017年11月28日下午5:34:43
 * @version 1.0
 *  
 */
@MyBatisDao
public interface SurrenderInformationDao extends CrudDao<SurrenderInformationEntity>{
	
	/**
	 * Tilte: updateSurrenderInformationById 
	 * Description:根据解约信息表的主键修改
	 * @param entity
	 * @return int
	 * @author h
	 */
	public int updateSurrenderInformationById(SurrenderInformationEntity entity);
	
	/**
	 * 查看解约详情
	 * @param requestId
	 * @return
	 */
	public  SurrenderInfomationVo getSurrenderDetailByRequestId(Integer requestId);
}
