package com.boco.modules.fdoc.vo;

import java.util.Date;

import com.boco.common.persistence.Page;

public class UserReportParamVo {
    private String personId;
    private String userName;
    private Date begin;
    private Date end;
    private String time;
	/**
	 * 分页对象
	 */
	private Page<UserReportParamVo> page;
	
	public Page<UserReportParamVo> getPage() {
		return page;
	}
	public void setPage(Page<UserReportParamVo> page) {
		this.page = page;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getBegin() {
		return begin;
	}
	public void setBegin(Date begin) {
		this.begin = begin;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

	
  
}
