package com.website;

import com.component.database.CDataCn;
import com.component.database.CDataControl;
import com.component.database.CDataImpl;
import com.component.database.CLog;
import com.util.CTools;
import com.util.MD5;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.Hashtable;
import java.util.Vector;

public class User extends CDataControl
{
  private String _id;
  private String _uid;
  private String _pwd;
  private String _userName;
  private String _email;
  private String _tel;
  private String _sex;
  private int _activeFlag;
  private String _address;
  private String _userKind;
  private String _websiteKind;
  private boolean _login;
  private CLog log;
  private String _zip;
  private String _istemp;
  private String _idCardNumber;
  private String _cellPhoneNumber;
  private String _nameEn;
  private String _homeaddress;
  private String _identify;

  public User()
  {
    this._uid = "";
    this._pwd = "";
    this._userName = "";
    this._email = "";
    this._tel = "";
    this._sex = "";
    this._activeFlag = 1;
    this._address = "";
    this._userKind = "";
    this._websiteKind = "";
    this._login = false;
    this.log = null;
    this._zip = "";
    this._istemp = "0";
    this._idCardNumber = "";
    this._cellPhoneNumber = "";
    this._nameEn = "";
    this._homeaddress = "";
    this._identify = "";
    this.log = new CLog();
  }

  public User(CDataCn dCn)
  {
    super(dCn);
    this._uid = "";
    this._pwd = "";
    this._userName = "";
    this._email = "";
    this._tel = "";
    this._sex = "";
    this._activeFlag = 1;
    this._address = "";
    this._userKind = "";
    this._websiteKind = "";
    this._login = false;
    this.log = null;
    this._zip = "";
    this._istemp = "0";
    this._idCardNumber = "";
    this._cellPhoneNumber = "";
    this._nameEn = "";
    this._homeaddress = "";
    this._identify = "";
    this.log = new CLog(dCn);
  }
  /**
   * login wsb
   * @param uid
   * @param pwd
   * @param wid
   * @return
   */
  public boolean loginWSB(String uid, String pwd, String wid) {
      uid = uid.toLowerCase();
      //pwd = getMD5(pwd);
      ResultSet rs = null;
      StringBuffer sql = new StringBuffer("");
      try {
          sql.append("select * from tb_user where us_uid = '" +
                     CTools.replacequote(uid) + "'and us_isok=1 and ws_id ='" +
                     CTools.replacequote(wid) + "'");
          //System.out.println(sql.toString());
          rs = executeQuery(sql.toString()); //执行sql
          if (rs.next()) {
          	_pwd = rs.getString("us_pwd");
          	if(_pwd.equals(pwd)){
          		_id = rs.getString("us_id");
          		this._id = rs.getString("us_id");
                this._uid = rs.getString("us_uid");
                this._pwd = rs.getString("us_pwd");
                this._userName = rs.getString("us_name");
                this._sex = rs.getString("us_sex");
                this._nameEn = rs.getString("us_nameen");
                this._email = rs.getString("us_email");
                this._tel = rs.getString("us_tel");
                this._activeFlag = rs.getInt("us_isok");
                this._address = rs.getString("us_address");
                this._zip = rs.getString("us_zip");
                this._userKind = rs.getString("uk_id");
                this._websiteKind = rs.getString("ws_id");
                this._istemp = rs.getString("us_istemp");
                this._login = true;
                this._idCardNumber = rs.getString("us_idcardnumber");
                this._cellPhoneNumber = rs.getString("us_cellphonenumber");
                this._homeaddress = rs.getString("us_homeaddress");
                this._identify = rs.getString("us_identify");
                this.log.setLog(1, "用户登录", "登录成功", this._userName);
                this.log.closeStmt();
	                rs.close();
	                return true; //成功登录
          	}else{
          		log.setLog(CLog.LOGIN, "用户登录", "登录失败", uid);
                  log.closeStmt();
                  rs.close();
                  return false;
          	}
          }
          else {
              log.setLog(CLog.LOGIN, "用户登录", "登录失败", uid);
              log.closeStmt();
              rs.close();
              return false;
          }
      }
      catch (Exception ex) {
          raise(ex, "登录的时候出现异常错误", "login(String uid,String pwd,String wid)");
          return false;
      }
  }
  
  /**
   * login 
   * @param uid
   * @param pwd
   * @param wid
   * @return
   */
  public boolean login(String uid, String pwd, String wid)
  {
    uid = uid.toLowerCase();
    pwd = getMD5(pwd);
    ResultSet rs = null;
    StringBuffer sql = new StringBuffer("");
    try
    {
      //sql.append("select * from tb_user where us_uid = '" + CTools.replacequote(uid) + "' and us_pwd = '" + CTools.replacequote(pwd) + "'and us_isok=1 and ws_id ='" + CTools.replacequote(wid) + "'");
      //使用单点登录后修改的登录方法
      sql.append("select * from tb_user where us_uid = '" +
              CTools.replacequote(uid) + "' and us_isok=1 and ws_id ='" +
              CTools.replacequote(wid) + "'");
      rs = executeQuery(sql.toString());
      if (rs.next())
      {
        this._id = rs.getString("us_id");
        this._uid = rs.getString("us_uid");
        this._pwd = rs.getString("us_pwd");
        this._userName = rs.getString("us_name");
        this._sex = rs.getString("us_sex");
        this._nameEn = rs.getString("us_nameen");
        this._email = rs.getString("us_email");
        this._tel = rs.getString("us_tel");
        this._activeFlag = rs.getInt("us_isok");
        this._address = rs.getString("us_address");
        this._zip = rs.getString("us_zip");
        this._userKind = rs.getString("uk_id");
        this._websiteKind = rs.getString("ws_id");
        this._istemp = rs.getString("us_istemp");
        this._login = true;
        this._idCardNumber = rs.getString("us_idcardnumber");
        this._cellPhoneNumber = rs.getString("us_cellphonenumber");
        this._homeaddress = rs.getString("us_homeaddress");
        this._identify = rs.getString("us_identify");
        this.log.setLog(1, "用户登录", "登录成功", this._userName);
        this.log.closeStmt();
        rs.close();
        return true;
      }

      this.log.setLog(1, "用户登录", "登录失败", uid);
      this.log.closeStmt();
      rs.close();
      return false;
    }
    catch (Exception ex)
    {
      raise(ex, "登录的时候出现异常错误", "login(String uid,String pwd,String wid)");

      return false;
    }
  }

  public void logout() {
    CDataCn cdCn = new CDataCn();
    this.log = new CLog(cdCn);
    this.log.setLog(1, "用户登录", "退出成功", this._userName);
    this.log.closeStmt();
    cdCn.closeCn();
    this._id = "";
    this._uid = "";
    this._pwd = "";
    this._userName = "";
    this._email = "";
    this._sex = "";
    this._tel = "";
    this._activeFlag = 0;
    this._address = "";
    this._userKind = "";
    this._websiteKind = "";
    this._login = false;
    this._istemp = "";
    this._idCardNumber = "";
    this._cellPhoneNumber = "";
    this._homeaddress = "";
    this._identify = "";
    this._nameEn = "";
  }

  public String getNameEn()
  {
    return this._nameEn;
  }

  public boolean isLogin()
  {
    return this._login;
  }

  public String getId()
  {
    return this._id;
  }

  public String getUid()
  {
    return this._uid;
  }

  public String getPwd()
  {
    return this._pwd;
  }

  public String getUserName()
  {
    return this._userName;
  }

  public String getEmail()
  {
    return this._email;
  }

  public String getTel()
  {
    return this._tel;
  }

  public int getActiveFlag()
  {
    return this._activeFlag;
  }

  public String getAddress()
  {
    return this._address;
  }

  public String getUserKind()
  {
    return this._userKind;
  }

  public String getSex() {
    return this._sex;
  }

  public String getHomeAddress() {
    return this._homeaddress;
  }

  public String getIdentify() {
    return this._identify;
  }

  private void setLog()
  {
  }

  public int newUser()
  {
    CDataCn dCn = new CDataCn();
    CDataImpl dImpl = new CDataImpl(dCn);
    dCn.beginTrans();
    this._id = dImpl.addNew("tb_user", "us_id", 2);
    setValue(dImpl);
    if (isDup(dImpl))
      return 1;
    dImpl.update();
    if (dCn.getLastErrString().equals(""))
    {
      dCn.commitTrans();
      return 0;
    }

    dCn.rollbackTrans();
    System.out.println(dCn.getLastErrString());
    return 2;
  }

  public void updateUser()
  {
    CDataCn dCn = new CDataCn();
    CDataImpl dImpl = new CDataImpl(dCn);
    dCn.beginTrans();
    dImpl.edit("tb_user", "us_id", this._id);
    setValue(dImpl);
    dImpl.update();
    addRecord(this._id, dImpl, "update");
    if (dCn.getLastErrString().equals(""))
      dCn.commitTrans();
    else
      dCn.rollbackTrans();
  }

  public void deleteUser()
  {
    CDataCn dCn = new CDataCn();
    CDataImpl dImpl = new CDataImpl(dCn);
    dCn.beginTrans();
    dImpl.delete("tb_user", "us_id", this._id);
    addRecord(this._id, dImpl, "delete");
    if (dCn.getLastErrString().equals(""))
      dCn.commitTrans();
    else
      dCn.rollbackTrans();
  }

  private void setValue(CDataImpl dImpl)
  {
    if (!(this._uid.equals("")))
      dImpl.setValue("US_UID", this._uid, 3);
    if (!(this._pwd.equals("")))
      dImpl.setValue("US_PWD", getMD5(this._pwd), 3);
    if (!(this._userKind.equals("")))
      dImpl.setValue("UK_ID", this._userKind, 3);
    if (!(this._sex.equals("")))
      dImpl.setValue("us_sex", this._sex, 3);
    if (!(this._userName.equals("")))
      dImpl.setValue("US_NAME", this._userName, 3);
    if (!(this._email.equals("")))
      dImpl.setValue("US_EMAIL", this._email, 3);
    if (!(this._tel.equals("")))
      dImpl.setValue("US_TEL", this._tel, 3);
    if (!(this._tel.equals("")))
      dImpl.setValue("US_ADDRESS", this._address, 3);
    if (!(this._zip.equals("")))
      dImpl.setValue("US_ZIP", this._zip, 3);
    dImpl.setValue("US_ISOK", Integer.toString(this._activeFlag), 0);
    if (!(this._websiteKind.equals("")))
      dImpl.setValue("WS_ID", this._websiteKind, 3);
    dImpl.setValue("US_ISTEMP", this._istemp, 3);
    if (!(this._idCardNumber.equals("")))
      dImpl.setValue("US_IDCARDNUMBER", this._idCardNumber, 3);
    if (!(this._cellPhoneNumber.equals("")))
      dImpl.setValue("US_CELLPHONENUMBER", this._cellPhoneNumber, 3);
    if (!(this._homeaddress.equals("")))
      dImpl.setValue("US_HOMEADDRESS", this._homeaddress, 3);

    if (!(this._identify.equals("")))
      dImpl.setValue("US_IDENTIFY", this._identify, 3);
  }

  private void addRecord(String us_id, CDataImpl dImpl, String type)
  {
    String cu_id = dImpl.addNew("tb_commuser", "CU_ID", 2);
    dImpl.setValue("US_ID", us_id, 3);
    dImpl.setValue("CU_TYPE", type, 3);
    dImpl.update();
    String sql = "select * from tb_website order by ws_sequence";
    Vector vectorPage = dImpl.splitPage(sql, 100, 1);
    for (int i = 0; i < vectorPage.size(); ++i)
    {
      Hashtable content = (Hashtable)vectorPage.get(i);
      String ws_id = content.get("ws_id").toString();
      dImpl.addNew("tb_extrec", "er_id", 2);
      dImpl.setValue("CU_ID", cu_id, 3);
      dImpl.setValue("WS_ID", ws_id, 3);
      dImpl.setValue("ER_ISEXTR", "0", 0);
      dImpl.update();
    }
  }

  private boolean isDup(CDataImpl dImpl)
  {
    String sql = "select * from tb_user where us_uid='" + this._uid + "'";
    Vector vectorPage = dImpl.splitPage(sql, 100, 1);
    return (vectorPage != null);
  }

  public static void main(String[] args)
  {
    User u;
    try {
      u = new User();
      u.setActiveFlag(1);
      u.setAddress("aaa");
      u.setEmail("eee@ee.com");
      u.setLogin(false);
      u.setPwd("123456");
      u.setTel("1111111111111");
      u.setUid("user003");
      u.setSex("1");
      u.setUserKind("o1");
      u.setUserName("hhhhhhhhhhh");
      u.setWsid("o27");
      u.setZip("qqqqqqqqqqqqqqqq");
      System.out.println(u.newUser());
    }
    catch (Exception ex)
    {
      System.out.println(ex);
      ex.printStackTrace();
    }
  }

  public String getWsid()
  {
    return this._websiteKind;
  }

  public void setWsid(String wsid)
  {
    this._websiteKind = wsid;
  }

  public void setUserName(String userName)
  {
    this._userName = userName;
  }

  public void setUserKind(String userKind)
  {
    this._userKind = userKind;
  }

  public void setUid(String uid)
  {
    this._uid = uid;
  }

  public void setTel(String tel)
  {
    this._tel = tel;
  }

  public void setSex(String sex)
  {
    this._sex = sex; }

  public void setHomeAddress(String homeaddress) {
    this._homeaddress = homeaddress; }

  public void setIdentify(String identify) {
    this._identify = identify;
  }

  public void setPwd(String pwd)
  {
    this._pwd = pwd;
  }

  public void setLogin(boolean login)
  {
    this._login = login;
  }

  public void setId(String id)
  {
    this._id = id;
  }

  public void setEmail(String email)
  {
    this._email = email;
  }

  public void setAddress(String address)
  {
    this._address = address;
  }

  public void setActiveFlag(int activeFlag)
  {
    this._activeFlag = activeFlag;
  }

  public void setZip(String zip)
  {
    this._zip = zip;
  }

  public String getZip()
  {
    return this._zip;
  }

  public String getIstemp()
  {
    return this._istemp;
  }

  public void setIstemp(String istemp)
  {
    this._istemp = istemp;
  }

  private String getMD5(String pwd)
  {
    MD5 md = new MD5();
    return md.getMD5ofStr(pwd);
  }

  public String getIdCardNumber()
  {
    return this._idCardNumber;
  }

  public void setIdCardNumber(String idCardNumber)
  {
    this._idCardNumber = idCardNumber;
  }

  public String getCellPhoneNumber()
  {
    return this._cellPhoneNumber;
  }

  public void setCellPhoneNumber(String cellPhoneNumber)
  {
    this._cellPhoneNumber = cellPhoneNumber;
  }
}