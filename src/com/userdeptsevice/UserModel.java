package com.userdeptsevice;
/**
 * 用户
 * @author Administrator
 *
 */
public class UserModel {
	private String ui_id = "";//后台用户ID
	private String ui_name = "";//后台用户姓名
	private String ui_uid = "";//后台用户登录名
	private String ui_password = "";//后台用户登录密码
	private String ui_active_flag = "";//帐号停用状态(1停用0正常)
	private String ui_sex = "";//后台用户性别
	private String dt_id = "";//用户所属部门ID
	private String ui_sequence = "";//用户所属排名
	private String ui_ip = "";//部门服务器IP
	//
	private String ui_action ="";//操作动作标记（同步新增、修改、删除）
	//
	public UserModel(){}
	
	public String getUi_id() {
		return ui_id;
	}
	public void setUi_id(String ui_id) {
		this.ui_id = ui_id;
	}
	public String getUi_name() {
		return ui_name;
	}
	public void setUi_name(String ui_name) {
		this.ui_name = ui_name;
	}
	public String getUi_uid() {
		return ui_uid;
	}
	public void setUi_uid(String ui_uid) {
		this.ui_uid = ui_uid;
	}
	public String getUi_password() {
		return ui_password;
	}
	public void setUi_password(String ui_password) {
		this.ui_password = ui_password;
	}
	public String getUi_active_flag() {
		return ui_active_flag;
	}
	public void setUi_active_flag(String ui_active_flag) {
		this.ui_active_flag = ui_active_flag;
	}
	public String getUi_sex() {
		return ui_sex;
	}
	public void setUi_sex(String ui_sex) {
		this.ui_sex = ui_sex;
	}
	public String getDt_id() {
		return dt_id;
	}
	public void setDt_id(String dt_id) {
		this.dt_id = dt_id;
	}
	public String getUi_sequence() {
		return ui_sequence;
	}
	public void setUi_sequence(String ui_sequence) {
		this.ui_sequence = ui_sequence;
	}
	public String getUi_ip() {
		return ui_ip;
	}
	public void setUi_ip(String ui_ip) {
		this.ui_ip = ui_ip;
	}
	public String getUi_action() {
		return ui_action;
	}
	public void setUi_action(String ui_action) {
		this.ui_action = ui_action;
	}
}
