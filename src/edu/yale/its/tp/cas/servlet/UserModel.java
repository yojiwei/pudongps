package edu.yale.its.tp.cas.servlet;

public class UserModel {
	
	private	String success="no";//用户默认登陆不成功

	private String id = ""; // 用户ID

	private String uid = ""; // 用户UID

	private String pwd = ""; // 用户密码

	private String name = ""; // 用户姓名

	private String sex = ""; // 用户性别

	private String regtime = ""; // 用户注册时间

	private String nickname = ""; // 用户昵称

	private String tel = ""; // 用户电话

	private String address = ""; // 用户地址

	private String zip = ""; // 用户邮政编码

	private String email = ""; // 用户邮箱

	private String idcardnumber = ""; // 用户身份证号码
	
	private String cellphonenumber = "";//用户的手机号码
	
	private String ws_id = ""; //用户网站标识

	private String isok = "1"; // 账号停用标识1正常,0账号停用

	private String cassite = ""; // 网站标识
	
	private String uk_id = "";//用户类别 
	
	private String status = "";//用户账号标志

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUk_id() {
		return uk_id;
	}

	public void setUk_id(String uk_id) {
		this.uk_id = uk_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCassite() {
		return cassite;
	}

	public void setCassite(String cassite) {
		this.cassite = cassite;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdcardnumber() {
		return idcardnumber;
	}

	public void setIdcardnumber(String idcardnumber) {
		this.idcardnumber = idcardnumber;
	}

	public String getIsok() {
		return isok;
	}

	public void setIsok(String isok) {
		this.isok = isok;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getRegtime() {
		return regtime;
	}

	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public String getCellphonenumber() {
		return cellphonenumber;
	}

	public void setCellphonenumber(String cellphonenumber) {
		this.cellphonenumber = cellphonenumber;
	}

	public String getWs_id() {
		return ws_id;
	}

	public void setWs_id(String ws_id) {
		this.ws_id = ws_id;
	}

}
