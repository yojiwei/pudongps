package com.userdeptsevice;
/**
 * 部门
 * @author Administrator
 *
 */
public class DeptModel {
	private String dt_id = "";//部门ID
	private String dt_name = "";//部门名称
	private String dt_parentid = "";//上级部门ID
	private String dt_sequence = "";//部门排序
	private String dt_operid = ""; //部门CODE
	private String dt_shortname = "";//部门的简称
	private String dt_active_flag="";//
	private String dt_iswork = "";//是否前台显示1是0否
	//
	public DeptModel(){}
	//
	public String getDt_id() {
		return dt_id;
	}
	public void setDt_id(String dt_id) {
		this.dt_id = dt_id;
	}
	public String getDt_name() {
		return dt_name;
	}
	public void setDt_name(String dt_name) {
		this.dt_name = dt_name;
	}
	public String getDt_parentid() {
		return dt_parentid;
	}
	public void setDt_parentid(String dt_parentid) {
		this.dt_parentid = dt_parentid;
	}
	public String getDt_sequence() {
		return dt_sequence;
	}
	public void setDt_sequence(String dt_sequence) {
		this.dt_sequence = dt_sequence;
	}
	public String getDt_active_flag() {
		return dt_active_flag;
	}
	public void setDt_active_flag(String dt_active_flag) {
		this.dt_active_flag = dt_active_flag;
	}
	public String getDt_iswork() {
		return dt_iswork;
	}
	public void setDt_iswork(String dt_iswork) {
		this.dt_iswork = dt_iswork;
	}
	public String getDt_operid() {
		return dt_operid;
	}
	public void setDt_operid(String dt_operid) {
		this.dt_operid = dt_operid;
	}
	public String getDt_shortname() {
		return dt_shortname;
	}
	public void setDt_shortname(String dt_shortname) {
		this.dt_shortname = dt_shortname;
	}

}
