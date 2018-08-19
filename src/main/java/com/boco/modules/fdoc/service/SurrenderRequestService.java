package com.boco.modules.fdoc.service;

import java.util.List;

import com.boco.modules.fdoc.model.surrender.SurrenderRequestEntity;
import com.boco.modules.fdoc.vo.surrender.SurrenderRequestVo;
/**
 * 解约请求service层
 * @author stromer
 *
 */
public interface SurrenderRequestService {
	/**
	 * Tilte: updateSurrenderRequestById 
	 * Description:根据解约请求表的主键修改
	 * @return int
	 * @author h
	 */
	public int updateSurrenderRequestById(SurrenderRequestEntity entity);
	/**
	 * Tilte: insert 
	 * Description:解约申请
	 * @param entity
	 * @return int
	 * @author h
	 */
	int insert(SurrenderRequestEntity entity);
	
	/**
	 * 按团队获取解约记录和解约请求列表
	 * @param vo
	 * @return
	 */
	public List<SurrenderRequestVo> getSurrenderAndRequestList(SurrenderRequestVo vo);
	/**
	 * 获取解约记录总数
	 * @param vo
	 * @return
	 */
	public Integer getSurrenderListCount(SurrenderRequestVo vo);
	/**
	 * 获取解约请求详情
	 * @param id
	 * @return
	 */
	public SurrenderRequestVo getSurrenderRequestById(Integer id);
	/**
	 * 获取解约请求
	 * @param personId
	 * @return
	 */
	public List<SurrenderRequestEntity> getSurrenderRequestByPersonId(String personId); 
	/**
	 * 删除解约请求
	 * @param id
	 * @return
	 */
	public Integer deleteSurrenderRequestById(Integer id);
}
