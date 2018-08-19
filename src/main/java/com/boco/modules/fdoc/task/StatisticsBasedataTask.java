package com.boco.modules.fdoc.task;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.boco.modules.fdoc.service.StatisticsDayBasedataService;

/**
 * 
 * ClassName: 统计数据定时任务 <br/>
 * @author q
 * @version 
 * @since JDK 1.7+
 */
@Component("statisticsBasedataTask")
public class StatisticsBasedataTask {
	
	@Resource
	StatisticsDayBasedataService statisticsService;
	
	@Scheduled(cron = "0 0 23 * * ?")	//每天23点的时候触发
	public void basedataTask(){
		statisticsService.callDayBasedataProcedure();
	}
	
	@Scheduled(cron = "0 0 23 * * ?")	//每天23点的时候触发
	public void teamdataTask(){
		statisticsService.callDayBasedataTeamProcedure();
	}
	
	@Scheduled(cron = "0 0 23 * * ?")	//每天23点的时候触发
	public void towndataTask(){
		statisticsService.callDayBasedataTownProcedure();
	}
	
	@Scheduled(cron = "0 0 23 * * ?")	//每天23点的时候触发
	public void bpbsdataTask(){
		statisticsService.callBpbsStatisticsProcedure();
	}
}
