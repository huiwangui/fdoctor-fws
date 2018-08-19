package com.boco.modules.fdoc.dao;

import java.util.List;


import com.boco.common.annotation.MyBatisDao;
import com.boco.modules.fdoc.model.ReportHealthmonitorEntity;
import com.boco.modules.fdoc.vo.MinReportVo;
/**
 * mindery体检查询（MinReport）
 * @author lzz
 *
 */
@MyBatisDao
public interface MinReportDao {
	
	/**
	 * 查询
	 * @param vo
	 * @return
	 */
	
	public List<ReportHealthmonitorEntity> findList(MinReportVo vo);

}
