package com.boco.modules.fdoc.model;
import java.util.Date;


   /**
    * report_healthmonitor 实体类
    * Thu Apr 13 10:26:57 CST 2017 lzz
    */ 


public class ReportHealthmonitorEntity{
	/**
	 * 主键，Guid
	 */
	private String Id;
	/**
	 * 请求号
	 */
	private String RequestNo;
	/**
	 * 第二ID
	 */
	private String PersonCode;
	/**
	 * 类型
	 */
	private Integer PersonType;
	/**
	 * 居民姓名
	 */
	private String PersonName;
	/**
	 * 英文缩写
	 */
	private String EnglishName;
	/**
	 * 性别(1,男)
	 */
	private Integer Gender;
	/**
	 * 身份证号码
	 */
	private String IdCode;
	/**
	 * 档案号
	 */
	private String ArchiveCode;
	/**
	 * 健康卡号
	 */
	private String HealthCode;
	/**
	 * 出生日期
	 */
	private Date Birthday;
	/**
	 * 名族
	 */
	private Integer Nation;
	/**
	 * 种族
	 */
	private Integer Race;
	/**
	 * 照片
	 */
	private String Photo;
	/**
	 * 户籍地址
	 */
	private String Address;
	/**
	 * 身高
	 */
	private Integer Height;
	/**
	 * 体重
	 */
	private float Weight;
	/**
	 * 腰围
	 */
	private float WaistLine;
	/**
	 * 体质指数
	 */
	private float BMI;
	/**
	 * 左侧收缩压
	 */
	private Integer LeftSys;
	/**
	 * 左侧舒展压
	 */
	private Integer LeftDia;
	/**
	 * 右侧收缩压
	 */
	private Integer RightSys;
	/**
	 * 右侧舒张压
	 */
	private Integer RightDia;
	/**
	 * 脉率
	 */
	private Integer PR;
	/**
	 * 心率
	 */
	private Integer HR;
	/**
	 * 血氧饱和度
	 */
	private Integer SpO2;
	/**
	 * 体温
	 */
	private float Temp;
	/**
	 * 呼吸
	 */
	private Integer Resp;
	/**
	 * 心电数据
	 */
	private String EcgData;
	/**
	 * 心电数据报表地址
	 */
	private String EcgReport;
	/**
	 * 白细胞（尿常规）
	 */
	private String UrineLeu;
	/**
	 * 酸碱度（尿常规）
	 */
	private String UrinePH;
	/**
	 * 亚硝酸呀（尿常规）
	 */
	private String UrineNit;
	/**
	 * 葡萄糖（尿常规）
	 */
	private String UrineGlu;
	/**
	 * 蛋白质（尿常规）
	 */
	private String UrinePro;
	/**
	 * 维生素（尿常规）
	 */
	private String UrineVC;
	/**
	 * 比重（尿常规）
	 */
	private String UrineSG;
	/**
	 * 尿胆原（尿常规）
	 */
	private String UrineUbg;
	/**
	 * 胆红素（尿常规）
	 */
	private String UrineBil;
	/**
	 * 酮体（尿常规）
	 */
	private String UrineKet;
	/**
	 * 隐血（尿常规）
	 */
	private String UrineBld;
	/**
	 * 空腹血糖
	 */
	private float BeforeMealFbg;
	/**
	 * 餐后血糖
	 */
	private float AfterMealFbg;
	/**
	 * 白细胞数目
	 */
	private String WBC;
	/**
	 * 淋巴细胞数目
	 */
	private String Lymph;
	/**
	 * 中间细胞数目
	 */
	private String Mid;
	/**
	 * 中性粒细胞数目
	 */
	private String Gran;
	/**
	 * 淋巴细胞百分比
	 */
	private String LymphPercent;
	/**
	 * 中性细胞百分比
	 */
	private String MidPercent;
	/**
	 * 中性粒细胞百分比
	 */
	private String GranPercent;
	/**
	 * 红细胞数目
	 */
	private String RBC;
	/**
	 * 血红蛋白
	 */
	private String HGB;
	/**
	 * 平均红细胞体积
	 */
	private String MCV;
	/**
	 * 平均红细胞血红蛋白含量
	 */
	private String MCH;
	/**
	 * 平均红细胞血红蛋白浓度
	 */
	private String MCHC;
	/**
	 * 平红细胞分页宽度变异系数
	 */
	private String RDWCV;
	/**
	 * 平红细胞分布宽度标准差
	 */
	private String RDWSD;
	/**
	 * 红细胞压积
	 */
	private String HCT;
	/**
	 * 血小板数目
	 */
	private String PLT;
	/**
	 * 平均血小板体积
	 */
	private String MPV;
	/**
	 * 血小板分页宽度
	 */
	private String PDW;
	/**
	 * 血小板压积
	 */
	private String PCT;
	/**
	 * 大血小板比率
	 */
	private String PLCR;
	/**
	 * 白细胞分布直方图
	 */
	private String WBCHistogram;
	/**
	 * 红细胞分布直方图 
	 */
	private String RBCHistogram;
	/**
	 * 血小板分布直方图
	 */
	private String PLTHistogram;
	/**
	 * 尿机类型
	 */
	private Integer UrineType;
	/**
	 * 检验结果的单位制式
	 */
	private Integer U120Unit;
	/**
	 * 白细胞（尿常规）
	 */
	private String U120LEU;
	/**
	 * 白细胞参考（尿常规）
	 */
	private String U120LEUSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120LEUFlag;
	/**
	 * 酸碱度（尿常规）
	 */
	private String U120PH;
	/**
	 * 酸碱度参考（尿常规）
	 */
	private String U120PHSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120PHFlag;
	/**
	 * 亚硝酸盐（尿常规）
	 */
	private String U120NIT;
	/**
	 * 亚硝酸盐参考（尿常规）
	 */
	private String U120NITSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120NITFlag;
	/**
	 * 葡萄糖（尿常规）
	 */
	private String U120GLU;
	/**
	 * 葡萄糖参考（尿常规）
	 */
	private String U120GLUSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120GLUFlag;
	/**
	 * 蛋白质（尿常规）
	 */
	private String U120PRO;
	/**
	 * 蛋白质参考（尿常规）
	 */
	private String U120PROSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120PROFlag;
	/**
	 * 比重（尿常规）
	 */
	private String U120SG;
	/**
	 * 比重参考（尿常规）
	 */
	private String U120SGSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120SGFlag;
	/**
	 * 尿胆原（尿常规）
	 */
	private String U120URO;
	/**
	 * 尿胆原参考（尿常规）
	 */
	private String U120UROSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120UROFlag;
	/**
	 * 胆红素（尿常规）
	 */
	private String U120BIL;
	/**
	 * 胆红素参考（尿常规）
	 */
	private String U120BILSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120BILFlag;
	/**
	 * 酮体（尿常规）
	 */
	private String U120KET;
	/**
	 * 酮体参考（尿常规）
	 */
	private String U120KETSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120KETFlag;
	/**
	 * 隐血（尿常规）
	 */
	private String U120BLO;
	/**
	 * 隐血参考（尿常规）
	 */
	private String U120BLOSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120BLOFlag;
	/**
	 * 尿钙，只有尿常规参数为15项时才存在
	 */
	private String U120CA;
	/**
	 * 尿钙参考，只有尿常规参数为15项时才存在
	 */
	private String U120CASymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120CAFlag;
	/**
	 * 微量白蛋白
	 */
	private String U120ALBU;
	/**
	 * 微量白蛋白参考
	 */
	private String U120ALBUSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120ALBUFlag;
	/**
	 * 抗坏血酸，只有尿常规参数为15项时才存在
	 */
	private String U120ASC;
	/**
	 * 抗坏血酸参考，只有尿常规参数为15项时才存在
	 */
	private String U120ASCSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120ASCFlag;
	/**
	 * 抗坏血酸，只有尿常规参数为15项时才存在
	 */
	private String U120CRE;
	/**
	 * 抗坏血酸参考，只有尿常规参数为15项时才存在
	 */
	private String U120CRESymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120CREFlag;
	/**
	 * p:c
	 */
	private String U120PC;
	/**
	 * p:c参考
	 */
	private String U120PCSymbol;
	/**
	 * 参数值是否 正常    true:正常   false: 异常
	 */
	private boolean U120PCFlag;
	/**
	 * 血红蛋白
	 */
	private float MissionHB;
	/**
	 * 血红蛋白单位
	 */
	private Integer MissionUnit;
	/**
	 * 红细胞压积
	 */
	private Integer MissionHCT;
	/**
	 * 
	 */
	private Integer Mean;
	/**
	 * 
	 */
	private float cho;
	/**
	 * 
	 */
	private float tg;
	/**
	 * 
	 */
	private float hdl;
	/**
	 * 
	 */
	private float ldl;
	/**
	 * 所属云实例
	 */
	private String SaaSId;
	/**
	 * 机构
	 */
	private String OrgId;
	/**
	 * 创建人
	 */
	private String Creater;
	/**
	 * 检查日期
	 */
	private Date CreateDate;
	/**
	 * 测量设备序列号
	 */
	private String DeviceSN;
	/**
	 * 数据来源1，仪器上次;2，app上传
	 */
	private Integer SourceType;
	/**
	 * 版本
	 */
	private Date Version;
	/**
	 * 是否同步
	 */
	private Integer IsSync;
	public void setId(String Id){
	this.Id=Id;
	}
	public String getId(){
		return Id;
	}
	public void setRequestNo(String RequestNo){
	this.RequestNo=RequestNo;
	}
	public String getRequestNo(){
		return RequestNo;
	}
	public void setPersonCode(String PersonCode){
	this.PersonCode=PersonCode;
	}
	public String getPersonCode(){
		return PersonCode;
	}
	public void setPersonName(String PersonName){
	this.PersonName=PersonName;
	}
	public String getPersonName(){
		return PersonName;
	}
	public void setEnglishName(String EnglishName){
	this.EnglishName=EnglishName;
	}
	public String getEnglishName(){
		return EnglishName;
	}
	public void setIdCode(String IdCode){
	this.IdCode=IdCode;
	}
	public String getIdCode(){
		return IdCode;
	}
	public void setArchiveCode(String ArchiveCode){
	this.ArchiveCode=ArchiveCode;
	}
	public String getArchiveCode(){
		return ArchiveCode;
	}
	public void setHealthCode(String HealthCode){
	this.HealthCode=HealthCode;
	}
	public String getHealthCode(){
		return HealthCode;
	}
	public void setPhoto(String Photo){
	this.Photo=Photo;
	}
	public String getPhoto(){
		return Photo;
	}
	public void setAddress(String Address){
	this.Address=Address;
	}
	public String getAddress(){
		return Address;
	}
	public void setHeight(Integer Height){
	this.Height=Height;
	}
	public Integer getHeight(){
		return Height;
	}
	public void setWeight(float Weight){
	this.Weight=Weight;
	}
	public float getWeight(){
		return Weight;
	}
	public void setWaistLine(float WaistLine){
	this.WaistLine=WaistLine;
	}
	public float getWaistLine(){
		return WaistLine;
	}
	public void setBMI(float BMI){
	this.BMI=BMI;
	}
	public float getBMI(){
		return BMI;
	}
	public void setLeftSys(Integer LeftSys){
	this.LeftSys=LeftSys;
	}
	public Integer getLeftSys(){
		return LeftSys;
	}
	public void setLeftDia(Integer LeftDia){
	this.LeftDia=LeftDia;
	}
	public Integer getLeftDia(){
		return LeftDia;
	}
	public void setRightSys(Integer RightSys){
	this.RightSys=RightSys;
	}
	public Integer getRightSys(){
		return RightSys;
	}
	public void setRightDia(Integer RightDia){
	this.RightDia=RightDia;
	}
	public Integer getRightDia(){
		return RightDia;
	}
	public void setPR(Integer PR){
	this.PR=PR;
	}
	public Integer getPR(){
		return PR;
	}
	public void setHR(Integer HR){
	this.HR=HR;
	}
	public Integer getHR(){
		return HR;
	}
	public void setSpO2(Integer SpO2){
	this.SpO2=SpO2;
	}
	public Integer getSpO2(){
		return SpO2;
	}
	public void setTemp(float Temp){
	this.Temp=Temp;
	}
	public float getTemp(){
		return Temp;
	}
	public void setResp(Integer Resp){
	this.Resp=Resp;
	}
	public Integer getResp(){
		return Resp;
	}
	public String getEcgData() {
		return EcgData;
	}
	public void setEcgData(String ecgData) {
		EcgData = ecgData;
	}
	public String getEcgReport() {
		return EcgReport;
	}
	public void setEcgReport(String ecgReport) {
		EcgReport = ecgReport;
	}
	public void setUrineLeu(String UrineLeu){
	this.UrineLeu=UrineLeu;
	}
	public String getUrineLeu(){
		return UrineLeu;
	}
	public void setUrinePH(String UrinePH){
	this.UrinePH=UrinePH;
	}
	public String getUrinePH(){
		return UrinePH;
	}
	public void setUrineNit(String UrineNit){
	this.UrineNit=UrineNit;
	}
	public String getUrineNit(){
		return UrineNit;
	}
	public void setUrineGlu(String UrineGlu){
	this.UrineGlu=UrineGlu;
	}
	public String getUrineGlu(){
		return UrineGlu;
	}
	public void setUrinePro(String UrinePro){
	this.UrinePro=UrinePro;
	}
	public String getUrinePro(){
		return UrinePro;
	}
	public void setUrineVC(String UrineVC){
	this.UrineVC=UrineVC;
	}
	public String getUrineVC(){
		return UrineVC;
	}
	public void setUrineSG(String UrineSG){
	this.UrineSG=UrineSG;
	}
	public String getUrineSG(){
		return UrineSG;
	}
	public void setUrineUbg(String UrineUbg){
	this.UrineUbg=UrineUbg;
	}
	public String getUrineUbg(){
		return UrineUbg;
	}
	public void setUrineBil(String UrineBil){
	this.UrineBil=UrineBil;
	}
	public String getUrineBil(){
		return UrineBil;
	}
	public void setUrineKet(String UrineKet){
	this.UrineKet=UrineKet;
	}
	public String getUrineKet(){
		return UrineKet;
	}
	public void setUrineBld(String UrineBld){
	this.UrineBld=UrineBld;
	}
	public String getUrineBld(){
		return UrineBld;
	}
	public void setBeforeMealFbg(float BeforeMealFbg){
	this.BeforeMealFbg=BeforeMealFbg;
	}
	public float getBeforeMealFbg(){
		return BeforeMealFbg;
	}
	public void setAfterMealFbg(float AfterMealFbg){
	this.AfterMealFbg=AfterMealFbg;
	}
	public float getAfterMealFbg(){
		return AfterMealFbg;
	}
	public void setWBC(String WBC){
	this.WBC=WBC;
	}
	public String getWBC(){
		return WBC;
	}
	public void setLymph(String Lymph){
	this.Lymph=Lymph;
	}
	public String getLymph(){
		return Lymph;
	}
	public void setMid(String Mid){
	this.Mid=Mid;
	}
	public String getMid(){
		return Mid;
	}
	public void setGran(String Gran){
	this.Gran=Gran;
	}
	public String getGran(){
		return Gran;
	}
	public void setLymphPercent(String LymphPercent){
	this.LymphPercent=LymphPercent;
	}
	public String getLymphPercent(){
		return LymphPercent;
	}
	public void setMidPercent(String MidPercent){
	this.MidPercent=MidPercent;
	}
	public String getMidPercent(){
		return MidPercent;
	}
	public void setGranPercent(String GranPercent){
	this.GranPercent=GranPercent;
	}
	public String getGranPercent(){
		return GranPercent;
	}
	public void setRBC(String RBC){
	this.RBC=RBC;
	}
	public String getRBC(){
		return RBC;
	}
	public void setHGB(String HGB){
	this.HGB=HGB;
	}
	public String getHGB(){
		return HGB;
	}
	public void setMCV(String MCV){
	this.MCV=MCV;
	}
	public String getMCV(){
		return MCV;
	}
	public void setMCH(String MCH){
	this.MCH=MCH;
	}
	public String getMCH(){
		return MCH;
	}
	public void setMCHC(String MCHC){
	this.MCHC=MCHC;
	}
	public String getMCHC(){
		return MCHC;
	}
	public void setHCT(String HCT){
	this.HCT=HCT;
	}
	public String getHCT(){
		return HCT;
	}
	public void setPLT(String PLT){
	this.PLT=PLT;
	}
	public String getPLT(){
		return PLT;
	}
	public void setMPV(String MPV){
	this.MPV=MPV;
	}
	public String getMPV(){
		return MPV;
	}
	public void setPDW(String PDW){
	this.PDW=PDW;
	}
	public String getPDW(){
		return PDW;
	}
	public void setPCT(String PCT){
	this.PCT=PCT;
	}
	public String getPCT(){
		return PCT;
	}
	public void setWBCHistogram(String WBCHistogram){
	this.WBCHistogram=WBCHistogram;
	}
	public String getWBCHistogram(){
		return WBCHistogram;
	}
	public void setRBCHistogram(String RBCHistogram){
	this.RBCHistogram=RBCHistogram;
	}
	public String getRBCHistogram(){
		return RBCHistogram;
	}
	public void setPLTHistogram(String PLTHistogram){
	this.PLTHistogram=PLTHistogram;
	}
	public String getPLTHistogram(){
		return PLTHistogram;
	}
	public void setU120LEU(String U120LEU){
	this.U120LEU=U120LEU;
	}
	public String getU120LEU(){
		return U120LEU;
	}
	public void setU120LEUSymbol(String U120LEUSymbol){
	this.U120LEUSymbol=U120LEUSymbol;
	}
	public String getU120LEUSymbol(){
		return U120LEUSymbol;
	}
	public void setU120LEUFlag(boolean U120LEUFlag){
	this.U120LEUFlag=U120LEUFlag;
	}
	public boolean getU120LEUFlag(){
		return U120LEUFlag;
	}
	public void setU120PH(String U120PH){
	this.U120PH=U120PH;
	}
	public String getU120PH(){
		return U120PH;
	}
	public void setU120PHSymbol(String U120PHSymbol){
	this.U120PHSymbol=U120PHSymbol;
	}
	public String getU120PHSymbol(){
		return U120PHSymbol;
	}
	public void setU120PHFlag(boolean U120PHFlag){
	this.U120PHFlag=U120PHFlag;
	}
	public boolean getU120PHFlag(){
		return U120PHFlag;
	}
	public void setU120NIT(String U120NIT){
	this.U120NIT=U120NIT;
	}
	public String getU120NIT(){
		return U120NIT;
	}
	public void setU120NITSymbol(String U120NITSymbol){
	this.U120NITSymbol=U120NITSymbol;
	}
	public String getU120NITSymbol(){
		return U120NITSymbol;
	}
	public void setU120NITFlag(boolean U120NITFlag){
	this.U120NITFlag=U120NITFlag;
	}
	public boolean getU120NITFlag(){
		return U120NITFlag;
	}
	public void setU120GLU(String U120GLU){
	this.U120GLU=U120GLU;
	}
	public String getU120GLU(){
		return U120GLU;
	}
	public void setU120GLUSymbol(String U120GLUSymbol){
	this.U120GLUSymbol=U120GLUSymbol;
	}
	public String getU120GLUSymbol(){
		return U120GLUSymbol;
	}
	public void setU120GLUFlag(boolean U120GLUFlag){
	this.U120GLUFlag=U120GLUFlag;
	}
	public boolean getU120GLUFlag(){
		return U120GLUFlag;
	}
	public void setU120PRO(String U120PRO){
	this.U120PRO=U120PRO;
	}
	public String getU120PRO(){
		return U120PRO;
	}
	public void setU120PROSymbol(String U120PROSymbol){
	this.U120PROSymbol=U120PROSymbol;
	}
	public String getU120PROSymbol(){
		return U120PROSymbol;
	}
	public void setU120PROFlag(boolean U120PROFlag){
	this.U120PROFlag=U120PROFlag;
	}
	public boolean getU120PROFlag(){
		return U120PROFlag;
	}
	public void setU120SG(String U120SG){
	this.U120SG=U120SG;
	}
	public String getU120SG(){
		return U120SG;
	}
	public void setU120SGSymbol(String U120SGSymbol){
	this.U120SGSymbol=U120SGSymbol;
	}
	public String getU120SGSymbol(){
		return U120SGSymbol;
	}
	public void setU120SGFlag(boolean U120SGFlag){
	this.U120SGFlag=U120SGFlag;
	}
	public boolean getU120SGFlag(){
		return U120SGFlag;
	}
	public void setU120URO(String U120URO){
	this.U120URO=U120URO;
	}
	public String getU120URO(){
		return U120URO;
	}
	public void setU120UROSymbol(String U120UROSymbol){
	this.U120UROSymbol=U120UROSymbol;
	}
	public String getU120UROSymbol(){
		return U120UROSymbol;
	}
	public void setU120UROFlag(boolean U120UROFlag){
	this.U120UROFlag=U120UROFlag;
	}
	public boolean getU120UROFlag(){
		return U120UROFlag;
	}
	public void setU120BIL(String U120BIL){
	this.U120BIL=U120BIL;
	}
	public String getU120BIL(){
		return U120BIL;
	}
	public void setU120BILSymbol(String U120BILSymbol){
	this.U120BILSymbol=U120BILSymbol;
	}
	public String getU120BILSymbol(){
		return U120BILSymbol;
	}
	public void setU120BILFlag(boolean U120BILFlag){
	this.U120BILFlag=U120BILFlag;
	}
	public boolean getU120BILFlag(){
		return U120BILFlag;
	}
	public void setU120KET(String U120KET){
	this.U120KET=U120KET;
	}
	public String getU120KET(){
		return U120KET;
	}
	public void setU120KETSymbol(String U120KETSymbol){
	this.U120KETSymbol=U120KETSymbol;
	}
	public String getU120KETSymbol(){
		return U120KETSymbol;
	}
	public void setU120KETFlag(boolean U120KETFlag){
	this.U120KETFlag=U120KETFlag;
	}
	public boolean getU120KETFlag(){
		return U120KETFlag;
	}
	public void setU120BLO(String U120BLO){
	this.U120BLO=U120BLO;
	}
	public String getU120BLO(){
		return U120BLO;
	}
	public void setU120BLOSymbol(String U120BLOSymbol){
	this.U120BLOSymbol=U120BLOSymbol;
	}
	public String getU120BLOSymbol(){
		return U120BLOSymbol;
	}
	public void setU120BLOFlag(boolean U120BLOFlag){
	this.U120BLOFlag=U120BLOFlag;
	}
	public boolean getU120BLOFlag(){
		return U120BLOFlag;
	}
	public void setU120CA(String U120CA){
	this.U120CA=U120CA;
	}
	public String getU120CA(){
		return U120CA;
	}
	public void setU120CASymbol(String U120CASymbol){
	this.U120CASymbol=U120CASymbol;
	}
	public String getU120CASymbol(){
		return U120CASymbol;
	}
	public void setU120CAFlag(boolean U120CAFlag){
	this.U120CAFlag=U120CAFlag;
	}
	public boolean getU120CAFlag(){
		return U120CAFlag;
	}
	public void setU120ALBU(String U120ALBU){
	this.U120ALBU=U120ALBU;
	}
	public String getU120ALBU(){
		return U120ALBU;
	}
	public void setU120ALBUSymbol(String U120ALBUSymbol){
	this.U120ALBUSymbol=U120ALBUSymbol;
	}
	public String getU120ALBUSymbol(){
		return U120ALBUSymbol;
	}
	public void setU120ALBUFlag(boolean U120ALBUFlag){
	this.U120ALBUFlag=U120ALBUFlag;
	}
	public boolean getU120ALBUFlag(){
		return U120ALBUFlag;
	}
	public void setU120ASC(String U120ASC){
	this.U120ASC=U120ASC;
	}
	public String getU120ASC(){
		return U120ASC;
	}
	public void setU120ASCSymbol(String U120ASCSymbol){
	this.U120ASCSymbol=U120ASCSymbol;
	}
	public String getU120ASCSymbol(){
		return U120ASCSymbol;
	}
	public void setU120ASCFlag(boolean U120ASCFlag){
	this.U120ASCFlag=U120ASCFlag;
	}
	public boolean getU120ASCFlag(){
		return U120ASCFlag;
	}
	public void setU120CRE(String U120CRE){
	this.U120CRE=U120CRE;
	}
	public String getU120CRE(){
		return U120CRE;
	}
	public void setU120CRESymbol(String U120CRESymbol){
	this.U120CRESymbol=U120CRESymbol;
	}
	public String getU120CRESymbol(){
		return U120CRESymbol;
	}
	public void setU120CREFlag(boolean U120CREFlag){
	this.U120CREFlag=U120CREFlag;
	}
	public boolean getU120CREFlag(){
		return U120CREFlag;
	}
	public void setU120PC(String U120PC){
	this.U120PC=U120PC;
	}
	public String getU120PC(){
		return U120PC;
	}
	public void setU120PCSymbol(String U120PCSymbol){
	this.U120PCSymbol=U120PCSymbol;
	}
	public String getU120PCSymbol(){
		return U120PCSymbol;
	}
	public void setU120PCFlag(boolean U120PCFlag){
	this.U120PCFlag=U120PCFlag;
	}
	public boolean getU120PCFlag(){
		return U120PCFlag;
	}
	public void setMissionHB(float MissionHB){
	this.MissionHB=MissionHB;
	}
	public float getMissionHB(){
		return MissionHB;
	}
	public void setMean(Integer Mean){
	this.Mean=Mean;
	}
	public Integer getMean(){
		return Mean;
	}
	public void setCho(float cho){
	this.cho=cho;
	}
	public float getCho(){
		return cho;
	}
	public void setTg(float tg){
	this.tg=tg;
	}
	public float getTg(){
		return tg;
	}
	public void setHdl(float hdl){
	this.hdl=hdl;
	}
	public float getHdl(){
		return hdl;
	}
	public void setLdl(float ldl){
	this.ldl=ldl;
	}
	public float getLdl(){
		return ldl;
	}
	public void setSaaSId(String SaaSId){
	this.SaaSId=SaaSId;
	}
	public String getSaaSId(){
		return SaaSId;
	}
	public void setOrgId(String OrgId){
	this.OrgId=OrgId;
	}
	public String getOrgId(){
		return OrgId;
	}
	public void setCreater(String Creater){
	this.Creater=Creater;
	}
	public String getCreater(){
		return Creater;
	}
	public void setCreateDate(Date CreateDate){
	this.CreateDate=CreateDate;
	}
	public Date getCreateDate(){
		return CreateDate;
	}
	public void setDeviceSN(String DeviceSN){
	this.DeviceSN=DeviceSN;
	}
	public String getDeviceSN(){
		return DeviceSN;
	}
	public Integer getPersonType() {
		return PersonType;
	}
	public void setPersonType(Integer personType) {
		PersonType = personType;
	}
	public Integer getGender() {
		return Gender;
	}
	public void setGender(Integer gender) {
		Gender = gender;
	}
	public Date getBirthday() {
		return Birthday;
	}
	public void setBirthday(Date birthday) {
		Birthday = birthday;
	}
	public Integer getNation() {
		return Nation;
	}
	public void setNation(Integer nation) {
		Nation = nation;
	}
	public Integer getRace() {
		return Race;
	}
	public void setRace(Integer race) {
		Race = race;
	}
	public String getRDWCV() {
		return RDWCV;
	}
	public void setRDWCV(String rDWCV) {
		RDWCV = rDWCV;
	}
	public String getRDWSD() {
		return RDWSD;
	}
	public void setRDWSD(String rDWSD) {
		RDWSD = rDWSD;
	}
	public String getPLCR() {
		return PLCR;
	}
	public void setPLCR(String pLCR) {
		PLCR = pLCR;
	}
	public Integer getSourceType() {
		return SourceType;
	}
	public void setSourceType(Integer sourceType) {
		SourceType = sourceType;
	}
	public Date getVersion() {
		return Version;
	}
	public void setVersion(Date version) {
		Version = version;
	}
	public Integer getUrineType() {
		return UrineType;
	}
	public void setUrineType(Integer urineType) {
		UrineType = urineType;
	}
	public Integer getU120Unit() {
		return U120Unit;
	}
	public void setU120Unit(Integer u120Unit) {
		U120Unit = u120Unit;
	}
	public Integer getMissionUnit() {
		return MissionUnit;
	}
	public void setMissionUnit(Integer missionUnit) {
		MissionUnit = missionUnit;
	}
	public Integer getMissionHCT() {
		return MissionHCT;
	}
	public void setMissionHCT(Integer missionHCT) {
		MissionHCT = missionHCT;
	}
	public Integer getIsSync() {
		return IsSync;
	}
	public void setIsSync(Integer isSync) {
		IsSync = isSync;
	}
	
}

