package com.boco.common.enums;

import java.util.HashMap;
import java.util.Map;

public enum ApiStatusEnum {
	MAN((String) "1", "男"),
	WOMAN((String) "2", "女"),

	//系统级反馈码
	SUCCESS((Integer) 200, "成功"),
	FAIL((Integer) 1010, "处理失败"),
	ERROR_CODE((Integer) 1011, "未知错误，请咨询后台人员"),
	PARAM_CODE((Integer) 1012, "参数错误"),
	UPDATE_CODE((Integer) 1013, "有新版本，请更新"),
	NULL_DATA_CODE((Integer) 1014, "无数据"),
	NOT_MODIFIED_CODE((Integer) 1015, "使用缓存"),
	SIGN_ERROR((Integer) 1016, "签名失败"),
	DATA_FORMAT_ERROR((Integer) 1017, "POST JSON数据解析失败!"),
	DATA_EMPTY((Integer) 1018, "数据为空"),
	
	VERSION_SUCCESS((Integer) 1020, "版本验证成功"),
	VERSION_EMPTY((Integer) 1030,"版本号不能为空"),
	VERSION_ERROR((Integer) 1040, "版本号错误"),
	SESSION_TOKEN_VALID((Integer) 1050, "您未登录，重新登录"),
	SOCKET_CONN_FAIL((Integer) 1055, "网络环境较差，请稍后重试"),
	VERSION_UPGRADE((Integer) 1060, "新版本有更多优惠哦"),
	IM_ERROR((Integer) 1070, "聊天服务器注册失败"),
	
	//用户模块
	LOGIN_ERROR((Integer) 2010, "登录失败，手机号或密码错误"),
	USER_EMPTY((Integer) 2011, "用户不存在"),
	USER_ERROR((Integer) 2012, "该用户尚未签约"),
	ORDER_ERROR((Integer) 2013, "该用户尚未预约"),
	
	
	CODE_ERROR((Integer) 2021, "验证码错误"),
	CODE_VALID((Integer) 2022, "验证码无效"),
	
	PHONE_EXISTS((Integer) 2030, "手机号码已存在"),
	PHONE_NOT_EXISTS((Integer) 2031, "手机号码不存在"),
	OPENID_EXISTS((Integer) 2032, "OpenID已存在"),
	
	OLD_ERROR((Integer) 2032, "原密码错误"),
	NONE_CHANGED((Integer) 2033, "密码并未进行过更改"),
	IDCARD_OUTLAW((Integer) 2034, "身份证号不合法"),
	MOBILE_OUTLAW((Integer) 2035, "手机号不合法"),
	PASSWORD_OUTLAW((Integer) 2036, "密码含特殊字符"),
	
	USER_NOT_LOGIN((Integer) 2037, "用户尚未登录！"),
	USER_NOT((Integer) 2038, "没有查询到对应居民信息！"),
	DOC_LOGIN_ERROR((Integer) 2039, "登录失败，用户名或密码错误，或该账号已被冻结！"),
	AUTHEN_REPEAT((Integer) 2040, "绑定失败，该居民已绑定过其他账号，无法重复绑定！"),
	AUTHOR_REPEAT((Integer) 2041, "该用户已绑定过 ，无法重复绑定！"),
	DOC_REPEAT((Integer) 2042, "正在审核中，请耐心等待卫计委审核 ！"),
	DEAL_FAIL((Integer) 2043, "上传失败 ！"),
	SURRENDER_REQUEST_REPEAT((Integer) 2044, "该居民已申请解约，无法重复申请解约！"),
	
	//商品
	GOODS_NOT_EXISTS((Integer) 3001, "商品不存在"),
	ART_NOT_EXISTS((Integer) 3002, "帖子不存在"),
	
	//评论
	GOODS_COMMENT_NOT_GRANT((Integer) 4001, "您无权删除该评论"),
	GOODS_COMMENT_RUSERID((Integer) 4002, "必须指定回复给谁的用户ID"),
	GOODS_COMMENT_REPLYID((Integer) 4003, "必须指定回复评论ID"),
	GOODS_COMMENT_NOTREPLYME((Integer) 4004, "不能自己回复自己"),
	GOODS_COMMENT_NOTFOUND((Integer) 4005, "没有找到符合条件的评论"),
	
	//预约模块
	NO_USERRELATIONS((Integer) 5001, "找不到预约对象"),
	RE_BOOKING((Integer) 5002, "不能重复预约！"),
	UNKNOWN_BOOKING_TYPE((Integer) 5003, "未知的预约类型！"),
	
	//接种模块
	NO_VACCINENUM((Integer) 6001, "当天已预约量已满"),
	RE_INO((Integer) 6002, "你已经预约过当天的接种，不能重复预约"),
	ORDER_INO((Integer) 6003, "号源不够,预约失败"),
	ORDER_INO2((Integer) 6004, "当天还未发布号源"),
	
	//医生模块
	DOCTOR_UID_NOTFOUND((Integer) 7001, "医生UID有误"),
	NO_SUCH_DOCTOR((Integer) 7002, "未查到医生信息"),
	
	//体检模块
	NO_HEALTHCHECK_NUM((Integer) 8001, "当天已预约量已满"),
	RE_HEALTHCHECK((Integer) 8002, "你已经预约过当天的体检，不能重复预约"),
	
	
	//居民模块
	RE_ADD_RESIDENT((Integer) 9001, "该居民已存在，不能重复添加"),
	FM_NUM_NOEXIST((Integer) 9002, "该居民还没有家庭档案编号"),
	FM_INFO_NOEXIST((Integer) 9003, "该居民还没有家庭详细信息"),
	RE_NO_ORDER((Integer) 9004, "该居民还没有签约"),
	UNKNOWREGION((Integer) 1090, "未知的区划信息！"),
	NO_JURISDICTION((Integer) 1080, "没有权限,或已被删除！"),
	NO_MASTER((Integer) 1081, "该居民没有户主，无法签约！"),
	NO_DEL_SIGN((Integer) 1083, "该居民已签约，不能删除！"),
	
	//dubbo、redis报错
	REDIS_ERROR((Integer) 10001, "redis访问出错"),
	DUBBO_ERROR((Integer) 10002, "dubbo访问出错"),
	
	//签约模块
	RE_SIGN((Integer) 11001, "该居民已签约，不能重复签约"),
	RE_SIGN_REQUEST((Integer) 11002, "您已向该团队发出过签约申请，请勿重复发送"),
	NOT_SIGN((Integer) 11003, "该居民尚未签约"),
	REQUEST_NOT_FOUND((Integer) 11004, "没有查询到该条请求"),
	
	//慢病标签模块
	DEFAULT_NOT_ALLOW((Integer) 12001, "该标签为默认标签，无法进行该操作"),
	
	//健康评估
	ASSESSMENT_NOT_FOUND((Integer) 20001, "没有查询到该健康评估"),
	ASSESSMENT_NO_POWER((Integer) 20002, "您的账号没有权限评估，只能由医生账号评估(不包含公卫医生)");
	
	
	private Integer key;

	private String value;
	
	private String sex_key;
	

	private ApiStatusEnum(String value, String sex_key) {
		this.value = value;
		this.sex_key = sex_key;
	}

	public String getSex_key() {
		return sex_key;
	}

	public void setSex_key(String sex_key) {
		this.sex_key = sex_key;
	}

	private ApiStatusEnum(Integer key, String value) {
		this.key = key;
		this.value = value;
	}

	public Integer getKey() {
		return key;
	}

	public void setKey(Integer key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public static Map<Integer, String> getMap() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (ApiStatusEnum status : ApiStatusEnum.values()) {
			map.put(status.getKey(), status.getValue());
		}
		return map;
	}

}
