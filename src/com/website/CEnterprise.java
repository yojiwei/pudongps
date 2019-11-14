package com.website;

import com.component.database.*;
import java.sql.*;
import com.util.*;

public class CEnterprise extends CDataControl
{
   private long _id;
   private String _uid = "";
   private String _pwd = "";
   private String _userName = "";
   private String _email = "";
   private String _dept = "";
   private String _sex = "";
   private String _tel = "";
   private String _serialNum = "";
   private int _activeFlag;
   private String _address = "";
   private String _trade = "";
   private String _idCard = "";
   private String _userKind = "";
   private long _enterpriseId;
   private String _publishFlag = "";
   private boolean _login = false; //登录标签
   private CLog log = null;

   /**
    * @deprecated
    */
   public CEnterprise()
   {
     log = new CLog();
   }

   public CEnterprise(CDataCn dCn)
   {
     super(dCn);
     log = new CLog(dCn);
   }

   /**
    * Method:login(String uid,String pwd)
    * Description: 用户登录
    * @param uid 企业用户ＵＩＤ
　  * @param pwd 企业用户ＰＷＤ
    * return boolean
   @roseuid 3E12A6C6026C
   */
   public boolean login(String uid, String pwd)
   {
     ResultSet rs = null;
     StringBuffer sql = new StringBuffer("");
    // uid=CTools.replacequote(uid);
    // pwd=CTools.replacequote(pwd);
     try {
       sql.append("select * from tb_enterprise where ep_userid = '" + CTools.replacequote(uid) + "' and ep_password = '" + CTools.replacequote(pwd) + "' and ep_activeflag = 1");
       //System.out.println(sql.toString());
       rs = executeQuery(sql.toString()); //执行sql

       if(rs.next())
       {
         _id = rs.getLong("ep_id");
         _uid = rs.getString("ep_userid");
         _pwd = rs.getString("ep_password");
         _userName = rs.getString("ep_username");
         _email = rs.getString("ep_email");
         _dept = rs.getString("ep_dept");
         _sex = rs.getString("ep_sex");
         _tel = rs.getString("ep_tel");
         _serialNum = rs.getString("ep_serialNum");
         _activeFlag = rs.getInt("ep_activeFlag");
         _address = rs.getString("ep_address");
         _trade = rs.getString("ep_trade");
         _idCard = rs.getString("ep_idcard");
         _userKind = rs.getString("ep_userkind");
         _enterpriseId = rs.getLong("ep_enterpriseid");
         _publishFlag = rs.getString("ep_publish_flag");
         _login = true;
         log.setLog(CLog.LOGIN,"用户登录","登录成功",_userName);
         log.closeStmt();
         rs.close();
         return true; //成功登录
       }
       else
       {
         log.setLog(CLog.LOGIN,"用户登录","登录失败",uid);
         log.closeStmt();
         rs.close();
         return false;
       }
     }
     catch(Exception ex) {
       raise(ex,"登录的时候出现异常错误","login(String uid,String pwd)");
       return false;
     }
   }

   /**
   @roseuid 3E12A9A3037F
   */
   public void logout()
   {
     CDataCn cdCn = new CDataCn();
     log = new CLog(cdCn);
     log.setLog(CLog.LOGIN,"用户登录","退出成功",_userName);
     log.closeStmt();
     cdCn.closeCn();
     _id = 0;
     _uid = "";
     _pwd = "";
     _userName = "";
     _email = "";
     _dept = "";
     _sex = "";
     _tel = "";
     _serialNum = "";
     _activeFlag = 0;
     _address = "";
     _trade = "";
     _idCard = "";
     _login = false;
   }

   /**
   @roseuid 3E14F65C0240
   */
   public boolean isLogin()
   {
     return _login;
   }

   public long getId()
   {
     return _id;
   }

   public String getUid()
   {
     return _uid;
   }

   public String getPwd()
   {
     return _pwd;
   }

   public String getUserName()
   {
     return _userName;
   }

   public String getEmail()
   {
     return _email;
   }

   public String getDept()
   {
     return _dept;
   }

   public String getSex()
   {
     return _sex;
   }

   public String getTel()
   {
     return _tel;
   }

   public String getSerialNum()
   {
     return _serialNum;
   }

   public int getActiveFlag()
   {
     return _activeFlag;
   }

   public String getAddress()
   {
     return _address;
   }

   public String getTrade()
   {
     return _trade;
   }

   public String getIdCard()
   {
     return _idCard;
   }

   public String getUserKind()
   {
     return _userKind;
   }

   public long getEnterpriseId()
   {
     return _enterpriseId;
   }

   public long getEiId()
   {
     return _enterpriseId;
   }

   public String getPublishFlag()
   {
     return _publishFlag;
   }

   /**
   @roseuid 3E12AAB200C1
   */
   private void setLog()
   {
   }

   public static void main(String[] args) {
      try{
        CEnterprise x = new CEnterprise();
        System.out.println(x.login("dd","1"));
      }
      catch(Exception ex)
      {
        System.out.println(ex);
      }
    }
}
