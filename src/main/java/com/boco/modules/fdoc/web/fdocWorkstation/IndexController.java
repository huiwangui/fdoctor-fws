package com.boco.modules.fdoc.web.fdocWorkstation;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.mapping.Array;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boco.common.jedis.JedisUtils;
import com.boco.common.utils.DateUtils;
import com.boco.common.utils.JsonUtils;
import com.boco.modules.fdoc.dao.statistics.StatisticsDayTeamBpbs;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBasedataEntity;
import com.boco.modules.fdoc.model.statistics.StatisticsDayTeamBpbsEntity;
import com.boco.modules.fdoc.service.DiseaseLabelService;
import com.boco.modules.fdoc.service.HospitalService;
import com.boco.modules.fdoc.service.SignService;
import com.boco.modules.fdoc.service.StatisticsDayBasedataService;
import com.boco.modules.fdoc.vo.DiseaseLabelVo;
import com.boco.modules.fdoc.vo.DoctorDetailVo;
import com.boco.modules.fdoc.vo.HospitalVo;
import com.boco.modules.fdoc.vo.SignVo;
import com.boco.modules.fdoc.vo.statistics.StatisticsDayBasedataVo;
/**
 * 首页展示
 * 
 * @author j
 *
 * @date 2017年7月10日
 */
@Controller
@RequestMapping( produces = "text/json;charset=utf-8")
public class IndexController {
	@Resource
	DiseaseLabelService diseaseLabelService;
	@Resource
	StatisticsDayBasedataService statisticsService;//统计服务
	@Resource
	HospitalService hospitalService;
	@Resource
	SignService signService;
	@RequestMapping(value = "/mainPage",method = RequestMethod.GET)
	public String StringsignRecord(HttpServletRequest request, Model model){
		//从session获取登录医生
		@SuppressWarnings("unchecked")
		Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
		//String tdkey=String.format("td_%s_s%", (String)docInfo.get("teamId"),DateUtils.getDateFormat());
		//按团队获取本周签约总数
		Date monday=DateUtils.getTimesWeekmorning();//本周 周一
		Date weekAgoDate = DateUtils.getDateBeforeOrAfter(monday, -1);//一周以前
		Date weekAgoDateTwo = DateUtils.getDateBeforeOrAfter(monday, -8);//二周以前
		Date monthAgoTwo=DateUtils.getEndOfMonth(Integer.valueOf(DateUtils.getYear()), Integer.valueOf(DateUtils.getMonth())-2);//二月以前
		StatisticsDayTeamBasedataEntity entity=new StatisticsDayTeamBasedataEntity();
		entity.setStatisticsDate(DateUtils.getDate());
		entity.setTeamId((String)docInfo.get("teamId"));
		StatisticsDayTeamBasedataEntity nowVo=statisticsService.getLastInfoByDate(entity);//今天最新数据
		entity.setStatisticsDate(weekAgoDate);
		StatisticsDayTeamBasedataEntity lastWeekVo=statisticsService.getLastInfoByDate(entity);//上周数据
		
		 Date lastMonth = DateUtils.getDateBeforeOrAfter(DateUtils.getTimesMonthmorning(), -1);//上月最后一天
		 entity.setStatisticsDate(lastMonth);
		 StatisticsDayTeamBasedataEntity lastMonthVo=statisticsService.getLastInfoByDate(entity);//上月最后一天数据
		 List<Integer> sevenList=new ArrayList<Integer>();
		 Date lastSevenDays = DateUtils.getDateBeforeOrAfterBegin(new Date(), -7);//最近7天
		 entity.setStatisticsDate(lastSevenDays);
		 System.out.println(lastSevenDays);
		 List<StatisticsDayTeamBasedataEntity>  listTeamBasedata = statisticsService.getLastInfoBySevenDate(entity);
		 for (int i =7; i >0; i--) {
			 boolean flag = false;
			 if(listTeamBasedata!=null&&listTeamBasedata.size()>0){
				 for(StatisticsDayTeamBasedataEntity lastSevenDaysVo:listTeamBasedata){
					 if(DateUtils.formatDate(lastSevenDaysVo.getStatisticsDate(), "yyyy-MM-dd").equals(DateUtils.formatDate(DateUtils.getDateBeforeOrAfterBegin(new Date(), -i),"yyyy-MM-dd"))){
						 int num=lastSevenDaysVo.getSignCount();
						 sevenList.add(num);
						 flag = true;
					 }
					
				 }
			 if(!flag){
				 flag = true;
				 sevenList.add(0);
			 }
			 }else{
				 sevenList.add(0);
			 }
			
             
		}
			 
	    System.out.println(sevenList);
     	entity.setStatisticsDate(weekAgoDateTwo);
 		StatisticsDayTeamBasedataEntity weekAgoDateTwoVo=statisticsService.getLastInfoByDate(entity);//二周以前数据
 	    entity.setStatisticsDate(monthAgoTwo);
 		StatisticsDayTeamBasedataEntity monthAgoTwoVo=statisticsService.getLastInfoByDate(entity);//二月以前数据
 		
 		Integer thisWeek=((nowVo==null)?0:nowVo.getSignCount())-((lastWeekVo==null)?0:lastWeekVo.getSignCount());//本周已签约人数
 		Integer twoWeek=((lastWeekVo==null)?0:lastWeekVo.getSignCount())-((weekAgoDateTwoVo==null)?0:weekAgoDateTwoVo.getSignCount());//上周签约人数
 		Integer IncreatWeek=thisWeek-twoWeek;//周增长数对比 
 		
 		
 		Integer thisMonth=((nowVo==null)?0:nowVo.getSignCount())-((lastMonthVo==null)?0:lastMonthVo.getSignCount());//本月已签人数
 		Integer twoMonth=((lastMonthVo==null)?0:lastMonthVo.getSignCount())-((monthAgoTwoVo==null)?0:monthAgoTwoVo.getSignCount());//上月签约人数
		Integer IncreatMonth=thisMonth-twoMonth;//月增长数对比 
		
		//调用增长服务 
		StatisticsDayBasedataVo statisticsDayBasedataVo=statisticsService.getMainIncrementData((String)docInfo.get("teamId"));
		
		model.addAttribute("thisWeek", statisticsDayBasedataVo.getThisWeekNum());
		model.addAttribute("IncreatWeek", statisticsDayBasedataVo.getThisWeekIncrement());
		model.addAttribute("thisMonth", statisticsDayBasedataVo.getThisMonthNum());
		model.addAttribute("IncreatMonth", statisticsDayBasedataVo.getThisMonthIncrement());
//		model.addAttribute("thisWeek", thisWeek);
//		model.addAttribute("IncreatWeek", IncreatWeek);
//		model.addAttribute("thisMonth", thisMonth);
//		model.addAttribute("IncreatMonth", IncreatMonth);
		model.addAttribute("sevenList", sevenList);
		model.addAttribute("nowVo", nowVo);
		
		List<DiseaseLabelVo>  lableList=diseaseLabelService.getLabelList((String)docInfo.get("teamId"));
		List<String> nameList=new ArrayList<String>();
		List<Integer> countList=new ArrayList<Integer>();
		for (DiseaseLabelVo diseaseLabelVo : lableList) {
			nameList.add(diseaseLabelVo.getLabelName());
			countList.add(diseaseLabelVo.getPersonCount());
			System.out.println(diseaseLabelVo.getPersonCount());
		}
		System.out.println(JsonUtils.getJson(countList));
		model.addAttribute("nameList", JsonUtils.getJson(nameList));
		model.addAttribute("countList", JsonUtils.getJson(countList));
	    model.addAttribute("lableList", lableList);
	    model.addAttribute("lableListJson", JsonUtils.getJson(lableList));
		
		return "/mainPage";
	}
	/**
	 * 血糖血压
	 * @param request
	 * @param model
	 * @return
	 *
	 */
	@ResponseBody
	@RequestMapping(value="/getBpbs",method=RequestMethod.GET)
	 public String getBpbs(HttpServletRequest request){
		 Map<String,Object> docInfo = (Map<String,Object> ) request.getSession().getAttribute("doc_session");
		 StatisticsDayTeamBpbsEntity entity=new StatisticsDayTeamBpbsEntity();
		 entity.setTeamId((String)docInfo.get("teamId"));
		return JsonUtils.getJson(statisticsService.getLastInfoByteamID(entity));
		 
	 }
	
	
	@RequestMapping(value="/getHospitalList", method = RequestMethod.GET)
	@ResponseBody
	public String getHospitalList(){
		HospitalVo vo = new HospitalVo();
		SignVo signvo=new SignVo();
		//int count=signService.getSignedCount(signvo);
		
		List<HospitalVo> hospitalList = hospitalService.getHospitalListWithTeamNum(vo);
		//if(count==0){
		//	return JsonUtils.getJson(hospitalList);
		//}
		for (HospitalVo hospitalVo : hospitalList) {
			if (hospitalVo.getTeamNum() == null) {
				hospitalVo.setTeamNum(0);
				hospitalVo.setSigningRate(0.0);
			}
		//	signvo.setRegionCode(hospitalVo.getRegionCode());
			//int regionCount=signService.getSignedCount(signvo);
			//hospitalVo.setSigningRate((double) (regionCount/count));
		}
		return   JsonUtils.getJson(hospitalList);
	}
	
}
