package com.boco.modules.boco;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.boco.common.JunitTestCase;
import com.boco.common.json.BaseJsonVo;
import com.boco.common.utils.JsonUtils;
import com.boco.common.utils.StringUtils;
import com.boco.modules.fdoc.model.AdEntity;
import com.boco.modules.fdoc.service.AdService;

public class AdServiceTest extends JunitTestCase{
	public void dealExplain(String field, String suffix, Map<String, Object> itemMap){
        //非空判断
        if (itemMap.get(field) != null && StringUtils.isNotEmpty((String)itemMap.get(field))) {
            //按照|分割为数组
            String[] split = ((String)itemMap.get(field)).split("\\\u0001");
            //重新填装字段
            itemMap.put(field, split[0]);
            if (split.length > 0) {
                //填装描述字段
                itemMap.put(field + suffix, split[1]);
            }
        }
    }
	
	@Resource
	AdService adService;
	
	@Test
	public void testAdService(){
		/*BaseJsonVo vo = adService.getAds();
		logger.info(((List<AdEntity>)vo.getData()).toString());*/
	}
	@Test
	public void ccaa(){
		Map map=new HashMap<>();
		map.put("abc", "2\u0001胸部太大");
		this.dealExplain("abc", "exp", map);
		System.out.println(map);
		
	}
}
