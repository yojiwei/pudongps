package com.website;

import com.component.database.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import com.util.*;

//update by yaojiwei 20081118
public class CassoUser extends MyCDataControl {
	private String _id;
	private String _uid = "";
	private String _pwd = "";
	private String _userName = "";
	private String _email = "";
	private String _tel = "";
	private String _sex = "";
	private String _ukid="";  //用户类别
	private String _regdate =null;    //注册时间
	private String _address = "";
	private boolean _login = false; // 登录标签
	private CLog log = null;
	private String _zip = "";
	private String _idCardNumber = "";//身份证
	private String _cellphonenumber="";//电话号码
	private String _status = "";//用户状态
	private String _isok = "";//用户停用状态标志1正常0已停用
	private MyCDataCn dCn = null;
	private MyCDataImpl dImpl = null;

	public String getIsok() {
		return _isok;
	}

	public void setIsok(String isok) {
		this._isok = isok;
	}

	public String getStatus() {
		return _status;
	}

	public void setStatus(String status) {
		this._status = status;
	}

	public String getCellphonenumber() {
		return _cellphonenumber;
	}

	public void setCellphonenumber(String cellphonenumber) {
		this._cellphonenumber = cellphonenumber;
	}

	public CassoUser() {
		log = new CLog();
	}

	public CassoUser(MyCDataCn dCn) {
		super(dCn);
		//log = new CLog(dCn);
	}
	/**
	 * 同步pudong数据库
	 * @param uid
	 * @return
	 */
//	public User(MyCDataCn mydCn) {
//		super(mydCn);
//		log = new CLog(mydCn);
//	}
	

	public boolean login(String uid) {//, String pwd, String wid
		uid = uid.toLowerCase();
		//pwd = getMD5(pwd);
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer("");
		try {
			sql.append("select us_id,us_uid,us_pwd from tb_user where us_uid = '"+CTools.replacequote(uid)+"'");
			rs = executeQuery(sql.toString()); // 执行sql
			if (rs.next()) {
				_id = rs.getString("us_id");
				_uid = rs.getString("us_uid");
				_pwd = rs.getString("us_pwd");
//				_userName = rs.getString("us_name");
//				_email = rs.getString("us_email");
//				_tel = rs.getString("us_tel");
//				_address = rs.getString("us_address");
//				_zip = rs.getString("us_zip");
				_login = true;
//				_idCardNumber = rs.getString("us_idcardnumber");
				log.setLog(CLog.LOGIN, "用户登录", "登录成功", _uid);
				log.closeStmt();
				rs.close();
				return true; // 成功登录
			} else {
				log.setLog(CLog.LOGIN, "用户登录", "登录失败", uid);
				log.closeStmt();
				rs.close();
				return false;
			}
		} catch (Exception ex) {
			raise(ex, "登录的时候出现异常错误", "login(String uid,String pwd,String wid)");
			return false;
		}
	}

	public void logout() {
		dCn = new MyCDataCn();
		//log = new CLog(dCn);
		log.setLog(CLog.LOGIN, "用户登录", "退出成功", _userName);
		log.closeStmt();
		this.close();
		_id = "";
		_uid = "";
		_pwd = "";
		_userName = "";
		_email = "";
		_tel = "";
		_address = "";
		_login = false;
		_idCardNumber = "";
		_cellphonenumber="";
		_ukid="";
		
	}

	public boolean isLogin() {
		return _login;
	}

	public String getId() {
		return _id;
	}

	public String getUid() {
		return _uid;
	}

	public String getPwd() {
		return _pwd;
	}

	public String getUserName() {
		return _userName;
	}

	public String getEmail() {
		return _email;
	}

	public String getTel() {
		return _tel;
	}

	public String getAddress() {
		return _address;
	}

	/**
	 * @roseuid 3E12AAB200C1
	 */
	private void setLog() {
	}
	/**
	 * add USER
	 * @return
	 */
	public int newUser() {
		dCn = new MyCDataCn();
		dImpl = new MyCDataImpl(dCn);
		dCn.beginTrans();
		_id = dImpl
				.addNew("tb_user", "us_id", MyCDataImpl.PRIMARY_KEY_IS_VARCHAR);
		setValue(dImpl);
		if (isDup(dImpl)) {
			return 1;
		}
		dImpl.update();

		if (dCn.getLastErrString().equals("")) {
			dCn.commitTrans();
			this.close();
			return 0;
		} else {
			dCn.rollbackTrans();
			System.out.println(dCn.getLastErrString());
			this.close();
			return 2;
		}
	}
	/**
	 * update USER
	 */
	public void updateUser() {
		dCn = new MyCDataCn();
		dImpl = new MyCDataImpl(dCn);
		dCn.beginTrans();

		dImpl.edit("tb_user", "us_id", _id);
		setValue(dImpl);
		dImpl.update();

		if (dCn.getLastErrString().equals("")) {
			dCn.commitTrans();
			this.close();
		} else {
			dCn.rollbackTrans();
			this.close();
		}
	}
	/**
	 * delete USER
	 */
	public void deleteUser() {
		dCn = new MyCDataCn();
		dImpl = new MyCDataImpl(dCn);
		dCn.beginTrans();

		dImpl.delete("tb_user", "us_id", _id);

		if (dCn.getLastErrString().equals("")) {
			dCn.commitTrans();
			this.close();
		} else {
			dCn.rollbackTrans();
			this.close();
		}
	}

	private void setValue(MyCDataImpl dImpl) {
		if (!_uid.equals("")) {
			dImpl.setValue("US_UID", _uid, MyCDataImpl.STRING);
		}
		if (!_pwd.equals("")) {
			dImpl.setValue("US_PWD", getMD5(_pwd), MyCDataImpl.STRING);
		}
		if (!_sex.equals("")) {
			dImpl.setValue("us_sex", _sex, MyCDataImpl.STRING);
		}
		if (!_userName.equals("")) {
			dImpl.setValue("US_NAME", _userName, MyCDataImpl.STRING);
		}
		if (!_email.equals("")) {
			dImpl.setValue("US_EMAIL", _email, MyCDataImpl.STRING);
		}
		if (!_tel.equals("")) {
			dImpl.setValue("US_TEL", _tel, MyCDataImpl.STRING);
		}
		if (!_address.equals("")) {
			dImpl.setValue("US_ADDRESS", _address, MyCDataImpl.STRING);
		}
		if (!_zip.equals("")) {
			dImpl.setValue("US_ZIP", _zip, MyCDataImpl.STRING);
		}
		if (!_cellphonenumber.equals("")) {
			dImpl.setValue("US_CELLPHONENUMBER", _cellphonenumber, MyCDataImpl.STRING);
		}
		if (!_idCardNumber.equals("")) {
			dImpl.setValue("US_IDCARDNUMBER", _idCardNumber, MyCDataImpl.STRING);
		}
		/*if (!_ukid.equals("")) {
			dImpl.setValue("UK_ID", _ukid, CDataImpl.STRING);
		}*/
		if (!_status.equals("")) {
			dImpl.setValue("US_STATUS", _status, MyCDataImpl.STRING);
		}
		if (!_regdate.equals("")) {
			dImpl.setValue("US_REGDATE", _regdate, MyCDataImpl.STRING);
		}
		if (!_isok.equals("")) {
			dImpl.setValue("US_ISOK", _isok, MyCDataImpl.STRING);
		}
	}

	private boolean isDup(MyCDataImpl dImpl) {
		String sql = "select * from tb_user where us_uid='" + _uid + "'";
		Vector vectorPage = dImpl.splitPage(sql, 100, 1);
		if (vectorPage != null) {
			return true;
		}
		return false;
	}

	public static void main(String[] args) {
		try {
			CassoUser u = new CassoUser();
			u.setAddress("上海市浦东新区居家桥路");
			u.setEmail("yojiwei@beyondbit.com");
			u.setLogin(false);
			u.setPwd("123456");
			u.setTel("13545303229");
			u.setUid("user520");
			u.setSex("1");
			u.setStatus("0");
			u.setUserName("wode");
			u.setUkid("1");
			u.setZip("441000");
			u.setIdCardNumber("");
			u.setCellphonenumber("");
			System.out.println(u.newUser());
		} catch (Exception ex) {
			System.out.println(ex);
			ex.printStackTrace();
		}
	}

	public void setUserName(String userName) {
		this._userName = userName;
	}

	public void setUid(String uid) {
		this._uid = uid;
	}

	public void setTel(String tel) {
		this._tel = tel;
	}

	public void setSex(String sex) {
		this._sex = sex;
	}

	public void setPwd(String pwd) {
		this._pwd = pwd;
	}

	public void setLogin(boolean login) {
		this._login = login;
	}

	public void setId(String id) {
		this._id = id;
	}

	public void setEmail(String email) {
		this._email = email;
	}

	public void setAddress(String address) {
		this._address = address;
	}

	public void setZip(String zip) {
		this._zip = zip;
	}

	public String getZip() {
		return _zip;
	}

	private String getMD5(String pwd) {
		MD5 md = new MD5();
		return md.getMD5ofStr(pwd);
	}

	public String getIdCardNumber() {
		return _idCardNumber;
	}

	public void setIdCardNumber(String idCardNumber) {
		this._idCardNumber = idCardNumber;
	}

	public String getRegdate() {
		return _regdate;
	}

	public void setRegdate(String regdate) {
		this._regdate = regdate;
	}

	public String getUkid() {
		return _ukid;
	}

	public void setUkid(String ukid) {
		this._ukid = ukid;
	}
	
	public void close(){
		if(dImpl!=null){
			dImpl.closeStmt();
		}
		if(dCn!=null){
			dCn.closeCn();
		}
	}
	
}