package com.boco.modules.fdoc.service;

import java.util.Date;
import java.util.List;

import com.boco.modules.fdoc.model.ReportHealthmonitorEntity;
/**
 * 
 * @author lzz
 *
 */
public interface MinReportService {
	
	/**
	 * findList:(获取某人时间范围内的体检记录). <br/>
	 * @param idCode
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<ReportHealthmonitorEntity> findList(String idCode,Date startTime,Date endTime);

}
