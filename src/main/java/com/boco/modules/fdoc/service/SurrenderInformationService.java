package com.boco.modules.fdoc.service;

import com.boco.modules.fdoc.model.surrender.SurrenderInformationEntity;
import com.boco.modules.fdoc.vo.surrender.SurrenderInfomationVo;

/**
 * 解约相关service层
 * @author stromer
 *
 */
public interface SurrenderInformationService {
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
