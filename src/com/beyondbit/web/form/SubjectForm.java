package com.beyondbit.web.form;

public class SubjectForm {
	
	private String name = "";
	private String parentid = "";
	private String bossid = "";
	private String dtid = "";
	private String sjId = "";
	
	public String getBossid() {
		return bossid;
	}
	public void setBossid(String bossid) {
		this.bossid = bossid;
	}
	public String getDtid() {
		return dtid;
	}
	public void setDtid(String dtid) {
		this.dtid = dtid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getSjId() {
		return sjId;
	}
	public void setSjId(String sjId) {
		this.sjId = sjId;
	}

}
