package com.boco.common;

import com.boco.common.persistence.Page;
import com.boco.modules.fdoc.service.CircleService;
import com.boco.modules.fdoc.vo.ArticleVo;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:mybatis-config.xml",
		"classpath:datasource-druid.xml",
		"classpath:spring-context.xml",
		"classpath:spring-mybatis.xml" })
public class JunitTestCase {
	
	@Resource
	CircleService circleService;
	protected Logger logger = Logger.getLogger(getClass());
	
	@Test
	public void aa(){
		 File f =new File("d:\\1.txt");
	        try {
				
				
				
	            System.out.println(f.createNewFile());//当文件存在时返回false
	            System.out.println(f.delete());//当文件不存在时返回false
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	}
	@Test
	public void up(){
	/*Map<String, String> map=new HashMap<String, String>();
    map.put("1", "ggggg");
	map.remove("2");*/
		

	}
	
	
}
