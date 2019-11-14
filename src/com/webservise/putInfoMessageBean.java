package com.webservise;

public class putInfoMessageBean {
	public String messgaeid="";//信息主键
	public String deptcode="";//办理单位code
	public String deptname="";//办理单位 
	public String status="";//办理状态
	public String applytime="";//-办理时间
	public String flownum="";//办理流水号
	public String reback="";//办理结果
	public String checktype="";
	public String dealmode="";
	public String isovertime="";
	public String status_name="";//依申请公开的办理状态
	public String step = "";//依申请公开的状态
	
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getStatus_name() {
		return status_name;
	}
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	public String getChecktype() {
		return checktype;
	}
	public void setChecktype(String checktype) {
		this.checktype = checktype;
	}
	public String getDealmode() {
		return dealmode;
	}
	public void setDealmode(String dealmode) {
		this.dealmode = dealmode;
	}
	public String getIsovertime() {
		return isovertime;
	}
	public void setIsovertime(String isovertime) {
		this.isovertime = isovertime;
	}
	public String getApplytime() {
		return applytime;
	}
	public void setApplytime(String applytime) {
		this.applytime = applytime;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getFlownum() {
		return flownum;
	}
	public void setFlownum(String flownum) {
		this.flownum = flownum;
	}
	public String getMessgaeid() {
		return messgaeid;
	}
	public void setMessgaeid(String messgaeid) {
		this.messgaeid = messgaeid;
	}
	public String getReback() {
		return reback;
	}
	public void setReback(String reback) {
		this.reback = reback;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDeptcode() {
		return deptcode;
	}
	public void setDeptcode(String deptcode) {
		this.deptcode = deptcode;
	}
}
