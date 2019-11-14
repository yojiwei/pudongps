package com.webservise;
/**
 * 规范性文件类
 * @author Administrator
 *
 */
public class CriterionfileBean {
	//基本信息表
	private String cf_id = ""; //规范性文件ID
	private String cf_title = "";//规范性文件标题
	private String cf_userid = "";//规范性文件录入人员
	private String cf_filenumber = "";//文号
	private String cf_createDeptid = "";//制定机关
	private String cf_createDeptCode = "";//制定机关CODE
	private String cf_IssueTime = "";//发布时间
	private String cf_ActualizeTime = "";//实施时间 
	private String cf_CreateTime = "";//录入系统时间
	private String cf_endtime = "";//规范性文件停止执行时间
	private String cf_Validity = "";//时效性
	private String cf_SerialNumber = "";//备案序号
	private String cf_CensorResult = "";//审查结果
	private String cf_memo = "";//备注
	//内容表
	private String cf_content = "";//规范性文件内容
	//附件表
	private String cf_filename = "";//附件名称
	private String cf_name = "";//文件名
	private String cf_path = "";//附件路径
	//政策解读表
	private String pu_title = "";//政策解读标题
	private String pu_content = "";//政策解读内容
	
	public CriterionfileBean(){}

	public String getCf_id() {
		return cf_id;
	}

	public void setCf_id(String cf_id) {
		this.cf_id = cf_id;
	}

	public String getCf_title() {
		return cf_title;
	}

	public void setCf_title(String cf_title) {
		this.cf_title = cf_title;
	}

	public String getCf_userid() {
		return cf_userid;
	}

	public void setCf_userid(String cf_userid) {
		this.cf_userid = cf_userid;
	}

	public String getCf_filenumber() {
		return cf_filenumber;
	}

	public void setCf_filenumber(String cf_filenumber) {
		this.cf_filenumber = cf_filenumber;
	}

	public String getCf_createDeptid() {
		return cf_createDeptid;
	}

	public void setCf_createDeptid(String cf_createDeptid) {
		this.cf_createDeptid = cf_createDeptid;
	}

	public String getCf_createDeptCode() {
		return cf_createDeptCode;
	}

	public void setCf_createDeptCode(String cf_createDeptCode) {
		this.cf_createDeptCode = cf_createDeptCode;
	}

	public String getCf_IssueTime() {
		return cf_IssueTime;
	}

	public void setCf_IssueTime(String cf_IssueTime) {
		this.cf_IssueTime = cf_IssueTime;
	}

	public String getCf_ActualizeTime() {
		return cf_ActualizeTime;
	}

	public void setCf_ActualizeTime(String cf_ActualizeTime) {
		this.cf_ActualizeTime = cf_ActualizeTime;
	}

	public String getCf_CreateTime() {
		return cf_CreateTime;
	}

	public void setCf_CreateTime(String cf_CreateTime) {
		this.cf_CreateTime = cf_CreateTime;
	}

	public String getCf_endtime() {
		return cf_endtime;
	}

	public void setCf_endtime(String cf_endtime) {
		this.cf_endtime = cf_endtime;
	}

	public String getCf_Validity() {
		return cf_Validity;
	}

	public void setCf_Validity(String cf_Validity) {
		this.cf_Validity = cf_Validity;
	}

	public String getCf_SerialNumber() {
		return cf_SerialNumber;
	}

	public void setCf_SerialNumber(String cf_SerialNumber) {
		this.cf_SerialNumber = cf_SerialNumber;
	}

	public String getCf_CensorResult() {
		return cf_CensorResult;
	}

	public void setCf_CensorResult(String cf_CensorResult) {
		this.cf_CensorResult = cf_CensorResult;
	}

	public String getCf_memo() {
		return cf_memo;
	}

	public void setCf_memo(String cf_memo) {
		this.cf_memo = cf_memo;
	}

	public String getCf_content() {
		return cf_content;
	}

	public void setCf_content(String cf_content) {
		this.cf_content = cf_content;
	}

	public String getCf_filename() {
		return cf_filename;
	}

	public void setCf_filename(String cf_filename) {
		this.cf_filename = cf_filename;
	}

	public String getCf_name() {
		return cf_name;
	}

	public void setCf_name(String cf_name) {
		this.cf_name = cf_name;
	}

	public String getCf_path() {
		return cf_path;
	}

	public void setCf_path(String cf_path) {
		this.cf_path = cf_path;
	}

	public String getPu_title() {
		return pu_title;
	}

	public void setPu_title(String pu_title) {
		this.pu_title = pu_title;
	}

	public String getPu_content() {
		return pu_content;
	}

	public void setPu_content(String pu_content) {
		this.pu_content = pu_content;
	}
	
	
	

}
