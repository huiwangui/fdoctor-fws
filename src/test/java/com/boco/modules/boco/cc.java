package com.boco.modules.boco;

import com.boco.common.JunitTestCase;
import com.boco.common.utils.JsonUtils;
import com.boco.modules.fdoc.model.SysRegionEntity;
import com.boco.modules.fdoc.service.SysRegionService;

import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;

/**
 *
 *
 *
 *
 * Created by mojun on 2017/4/13.
 */
public class cc extends JunitTestCase {
	
	@Resource
	SysRegionService regionService;

    @Test
    public void cc() {
        String url = "http://192.168.15.50:8807/fdoctor/circle/findAll";
        Client client = ClientBuilder.newClient();

        WebTarget target = client.target(url);
        Response response = target.request().get();


        String value = response.readEntity(String.class);
        response.close();
        System.out.println(value);
    }
    
    @Test
    public void abc() {
    	List<SysRegionEntity> accurateChildrenRegions = regionService.getAllParentRegion("51", new ArrayList<SysRegionEntity>(), 9);
		System.out.println("accurateChildrenRegions"+accurateChildrenRegions);
		System.out.println(JsonUtils.getJsonFormat(accurateChildrenRegions));
	
    }

}



