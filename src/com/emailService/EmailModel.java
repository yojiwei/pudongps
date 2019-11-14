package com.emailService;

/**
 * 信访信件
 * @author Administrator
 *
 */
public class EmailModel {
	private String cw_number = "";//信访编号
	private String cw_incepttime = "";//信访信件接收时间
	private String cw_applyname = "";//发信人
	private String cw_emailfrom = "";//来源信箱
	private String cw_emailfor = "";//信访目的
	private String cw_applywork = "";//发信人单位
	private String cw_applyaddress = "";//发信人地址
	private String cw_applytel = "";//联系电话
	private String cw_applyemail = "";//联系邮件
	private String cw_is_us = "";//是否注册用户
	private String cw_deptfrom = "";//来自其他部门
	private String cw_deptdeliver_to = "";//其他部门转交时间
	private String cw_strSubject = "";//信访主题
	private String cw_strContent = "";//信件内容
	private String cw_zhuanjiao = "";//信件转交的状态
	private String cw_receivedept = "";//信件接受部门
	private String cw_querynum = "";//信件查询序列号
	private String wd_id = "";//区长名称ID
	private String wd_name = "";//区长名称
	//
	private String cw_transdept = "";//转办部门
	private String cw_transtimelimit = "";//转办时限
	private String cw_transadvice = "";//转办部门意见
	private String cw_closedept = "";//当前办结部门
	private String cw_closetime = "";//办结时间 
	private String cw_closer = "";//办结人
	private String cw_closeadvice = "";//办结意见
	//
	private String aa_name = "";//附件名字
	private String aa_content = "";//附件内容
	
	private String cw_status = "";//信件状态 
	//update by yo 20090413
	private String otherContact = "";//其他联系电话
	
	public String getAa_name() {
		return aa_name;
	}

	public void setAa_name(String aa_name) {
		this.aa_name = aa_name;
	}

	public String getAa_content() {
		return aa_content;
	}

	public void setAa_content(String aa_content) {
		this.aa_content = aa_content;
	}

	public String getCw_zhuanjiao() {
		return cw_zhuanjiao;
	}

	public void setCw_zhuanjiao(String cw_zhuanjiao) {
		this.cw_zhuanjiao = cw_zhuanjiao;
	}

	public String getCw_receivedept() {
		return cw_receivedept;
	}

	public void setCw_receivedept(String cw_receivedept) {
		this.cw_receivedept = cw_receivedept;
	}

	public String getCw_querynum() {
		return cw_querynum;
	}

	public void setCw_querynum(String cw_querynum) {
		this.cw_querynum = cw_querynum;
	}

	public EmailModel (){}
	
	public String getCw_number() {
		return cw_number;
	}

	public void setCw_number(String cw_number) {
		this.cw_number = cw_number;
	}

	public String getCw_incepttime() {
		return cw_incepttime;
	}

	public void setCw_incepttime(String cw_incepttime) {
		this.cw_incepttime = cw_incepttime;
	}

	public String getCw_applyname() {
		return cw_applyname;
	}

	public void setCw_applyname(String cw_applyname) {
		this.cw_applyname = cw_applyname;
	}

	public String getCw_emailfrom() {
		return cw_emailfrom;
	}

	public void setCw_emailfrom(String cw_emailfrom) {
		this.cw_emailfrom = cw_emailfrom;
	}

	public String getCw_emailfor() {
		return cw_emailfor;
	}

	public void setCw_emailfor(String cw_emailfor) {
		this.cw_emailfor = cw_emailfor;
	}

	public String getCw_applywork() {
		return cw_applywork;
	}

	public void setCw_applywork(String cw_applywork) {
		this.cw_applywork = cw_applywork;
	}

	public String getCw_applyaddress() {
		return cw_applyaddress;
	}

	public void setCw_applyaddress(String cw_applyaddress) {
		this.cw_applyaddress = cw_applyaddress;
	}

	public String getCw_applytel() {
		return cw_applytel;
	}

	public void setCw_applytel(String cw_applytel) {
		this.cw_applytel = cw_applytel;
	}

	public String getCw_applyemail() {
		return cw_applyemail;
	}

	public void setCw_applyemail(String cw_applyemail) {
		this.cw_applyemail = cw_applyemail;
	}

	public String getCw_is_us() {
		return cw_is_us;
	}

	public void setCw_is_us(String cw_is_us) {
		this.cw_is_us = cw_is_us;
	}

	public String getCw_deptfrom() {
		return cw_deptfrom;
	}

	public void setCw_deptfrom(String cw_deptfrom) {
		this.cw_deptfrom = cw_deptfrom;
	}

	public String getCw_deptdeliver_to() {
		return cw_deptdeliver_to;
	}

	public void setCw_deptdeliver_to(String cw_deptdeliver_to) {
		this.cw_deptdeliver_to = cw_deptdeliver_to;
	}

	public String getCw_strSubject() {
		return cw_strSubject;
	}

	public void setCw_strSubject(String cw_strSubject) {
		this.cw_strSubject = cw_strSubject;
	}

	public String getCw_strContent() {
		return cw_strContent;
	}

	public void setCw_strContent(String cw_strContent) {
		this.cw_strContent = cw_strContent;
	}

	public String getCw_status() {
		return cw_status;
	}

	public void setCw_status(String cw_status) {
		this.cw_status = cw_status;
	}

	public String getCw_transdept() {
		return cw_transdept;
	}

	public void setCw_transdept(String cw_transdept) {
		this.cw_transdept = cw_transdept;
	}

	public String getCw_transtimelimit() {
		return cw_transtimelimit;
	}

	public void setCw_transtimelimit(String cw_transtimelimit) {
		this.cw_transtimelimit = cw_transtimelimit;
	}

	public String getCw_transadvice() {
		return cw_transadvice;
	}

	public void setCw_transadvice(String cw_transadvice) {
		this.cw_transadvice = cw_transadvice;
	}

	public String getCw_closedept() {
		return cw_closedept;
	}

	public void setCw_closedept(String cw_closedept) {
		this.cw_closedept = cw_closedept;
	}

	public String getCw_closetime() {
		return cw_closetime;
	}

	public void setCw_closetime(String cw_closetime) {
		this.cw_closetime = cw_closetime;
	}

	public String getCw_closer() {
		return cw_closer;
	}

	public void setCw_closer(String cw_closer) {
		this.cw_closer = cw_closer;
	}

	public String getCw_closeadvice() {
		return cw_closeadvice;
	}

	public void setCw_closeadvice(String cw_closeadvice) {
		this.cw_closeadvice = cw_closeadvice;
	}

	public String getOtherContact() {
		return otherContact;
	}

	public void setOtherContact(String otherContact) {
		this.otherContact = otherContact;
	}

	public String getWd_id() {
		return wd_id;
	}

	public void setWd_id(String wd_id) {
		this.wd_id = wd_id;
	}

	public String getWd_name() {
		return wd_name;
	}

	public void setWd_name(String wd_name) {
		this.wd_name = wd_name;
	}

	

}
