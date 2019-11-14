package com.emailService;
/**
 * 反馈类信件
 * @author Administrator
 *
 */
public class BznetlvencfeedBack {
	private String cw_netlvid = "";//网上信访件ID
	private String cw_noticetype = "";//告知单类型
	private String cw_content = "";//邮件内容 
	private String cw_status = "";//邮件状态
	
	public BznetlvencfeedBack(){}

	public String getCw_netlvid() {
		return cw_netlvid;
	}

	public void setCw_netlvid(String cw_netlvid) {
		this.cw_netlvid = cw_netlvid;
	}

	public String getCw_noticetype() {
		return cw_noticetype;
	}

	public void setCw_noticetype(String cw_noticetype) {
		this.cw_noticetype = cw_noticetype;
	}

	public String getCw_content() {
		return cw_content;
	}

	public void setCw_content(String cw_content) {
		this.cw_content = cw_content;
	}

	public String getCw_status() {
		return cw_status;
	}

	public void setCw_status(String cw_status) {
		this.cw_status = cw_status;
	}

}
