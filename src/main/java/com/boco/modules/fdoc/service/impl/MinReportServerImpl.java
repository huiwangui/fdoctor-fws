package com.boco.modules.fdoc.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.boco.modules.fdoc.dao.MinReportDao;
import com.boco.modules.fdoc.model.ReportHealthmonitorEntity;
import com.boco.modules.fdoc.service.MinReportService;
import com.boco.modules.fdoc.vo.MinReportVo;

@Service
public class MinReportServerImpl implements MinReportService{
	@Resource
	MinReportDao minDao;

	@Override
	public List<ReportHealthmonitorEntity> findList(String idCode, Date startTime, Date endTime) {
		MinReportVo vo=new MinReportVo();
		vo.setIdCode(idCode);
		vo.setStartTime(startTime);
		vo.setEndTime(endTime);
		
		return minDao.findList(vo);
	}

}
