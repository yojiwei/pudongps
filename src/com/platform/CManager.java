package com.platform;

import com.component.database.*;
import com.util.CLoginInfo;
import java.io.*;
import java.sql.*;
import java.util.*;

public class CManager extends CDataControl {

  private String _uid = "";
  private String _pwd = "";
  private int _purvoewlevel = 0;
  private int _atIsactive = 0;
  private String _atOrgname = ""; //用户
  private String _atModule = ""; //模块
  private String _atSubject = ""; //栏目
  private boolean _login = false; //登录标签
  private String _managelvl = ""; //后台权限
  private CLog log = null;

  /**
   * @deprecated
   */
  public CManager() {
    log = new CLog();
  }

  public CManager(CDataCn dCn)
  {
    super(dCn);
    log = new CLog(dCn);
  }

  /**
   * Method:login(String uid,String pwd)
   * Description: 登录系统
   * @param uid 用户登录名
   * @param pwd 用户登录密码
   * return boolean
   @roseuid 3E06F50E022D
   */
  public int login(String uid, String pwd)
  {
    ResultSet rs = null;
    String sql = "";
    int dateDf = 0;
    
    try{
	  dateDf = getDateDiff(uid);
	  if(dateDf >= CLoginInfo.passwordAvailDate){
		  log.setLog(CLog.LOGIN,"平台登录","密码已过期",uid);
	      log.closeStmt(); //关闭日志
		  return -1;
	  }else{
		  sql = "select * from tb_administrator where AT_LOGINNAME = '" + uid + "' and AT_PASSWORD = '" + pwd + "'";
	      rs = executeQuery(sql);
	      if(rs.next()){
	    	  if("0".equals(rs.getString("AT_ISACTIVE"))){
	    		  log.setLog(CLog.LOGIN,"平台登录","帐号已被管理员停用",uid);
	    	      log.closeStmt(); //关闭日志
	    	      rs.close();
	    		  return -3;
	    	  }else{
	    		  _uid = rs.getString("AT_LOGINNAME");
	 		     _pwd = rs.getString("AT_PASSWORD");
	 			 _purvoewlevel = rs.getInt("PURVIEWLEVEL");
	 			 _atOrgname = rs.getString("AT_ORGNAME");
	 			 _atModule = rs.getString("AT_MODULE");
	 			 _atSubject = rs.getString("AT_SUBJECT");
				 _managelvl = rs.getString("AT_MANAGELVL");
	 			 _login = true; //把当前登录标示执为成功
	 			 log.setLog(CLog.LOGIN,"平台登录","登录成功",_uid);
	 			 log.closeStmt(); //关闭日志
	 			 rs.close(); //关闭rs对象
	 			 updateLogindate(uid);
	 			 return 1;
	    	  }
	      }else {
	          log.setLog(CLog.LOGIN,"平台登录","登录失败",uid);
	          log.closeStmt(); //关闭日志
	          rs.close();
	          return 0;
	      }
      } 
    } catch(Exception ex){
      raise(ex,"平台登录时出错","CManager::login()");
      return -2;
    }
  }

  private long updateLogindate(String uid){
	  long l = 0;
	  try{
		  String sql = "UPDATE TB_ADMINISTRATOR SET AT_LOGINDATE = SYSDATE WHERE AT_LOGINNAME = '"+ uid +"' ";
		  l = executeUpdate(sql);
	  }catch(Exception ex){
		  raise(ex,"修改登录时间时出错","CManager::updateLogindate()");
	      l = -1;
	  }
	  return l;
  }
  
  private int getDateDiff(String uid){
	  int dateDiff = 0;
	  String sql ="";
	  ResultSet result = null;
	  try{
		  sql = " SELECT to_number(trim(to_char((sysdate-AT_LOGINDATE),'0000'))) AS DD FROM "
			         + " TB_ADMINISTRATOR WHERE AT_LOGINNAME = '"+ uid +"' ";
		  result = executeQuery(sql);
		  while(result.next()){
			  dateDiff = result.getInt("DD");
		  }
		  //result.close();
	  }catch(Exception ex){
		  raise(ex,"计算未登录时间时出错","CManager::getDateDiff()");
		  dateDiff = -1;
	  }
	  return dateDiff;
  }
  
  /**
   * Method:logout()
   * Description: 退出系统
   * return void
   @roseuid 3E06F57C00EA
   */
  public void logout()
  {
    CDataCn cdCn = new CDataCn();
    log = new CLog(cdCn);
    log.setLog(CLog.LOGIN,"平台登录","退出成功",_uid);
    _uid = ""; //用户名称
    _pwd = ""; //用户密码
    _purvoewlevel = 0;
	_managelvl = "";
    _login = false;
    log.closeStmt();
    cdCn.closeCn();
  }

  /**
   * Method:isLogin()
   * Description: 是否已登录系统　<br> 若是，返true；若假，返false
   * return boolean
   @roseuid 3E06F5DD031B
   */
  public boolean isLogin()
  {
    return _login;
  }
  
  /**
   * 返回登录者的密码
   * @return
   */
  public String getPassword(){
	  return _pwd;
  }
  
  /**
   * 返回登录者的名字
   * @return
   */
  public String getLoginName(){
	  return _uid;
  }

   /**
   * 返回登录者的后台权限
   * @return
   */
  public String getManageLvl(){   
	  return _managelvl;
  }    
  
       
  /**
   * 得到等录者的权限级别，1为超级管理员，2为用户管理员，3为角色管理员，4为模块管理员
   * @return int
   */
  public int getPurviewLevel(){
	  return _purvoewlevel;
  }
   
  /**
   * 得到用户的字符串
   * @return String 
   */
  public String getAtOrgname(){
	  String rtnOrgname = "";
	  StringTokenizer st = new StringTokenizer(_atOrgname,"");
	  while(st.hasMoreTokens()){
		  rtnOrgname += "'" + st.nextToken() + "',";
	  }
	  rtnOrgname = rtnOrgname.substring(0,rtnOrgname.length()-1);
	  return rtnOrgname;
  }
  
  /**
   * 得到模块的字符串
   * @return String 
   */
  public String getAtModule(){
	  String rtnModule = "";
	  StringTokenizer st = new StringTokenizer(_atModule,"");
	  while(st.hasMoreTokens()){
		  rtnModule += "'" + st.nextToken() + "',";
	  }
	  rtnModule = rtnModule.substring(0,rtnModule.length()-1);
	  return rtnModule;
  }
  
  /**
   * 得到栏目的字符串
   * @return String 
   */
  public String getAtSubject(){
	  String rtnSubject = "";
	  StringTokenizer st = new StringTokenizer(_atSubject,"");
	  while(st.hasMoreTokens()){
		  rtnSubject += "'" + st.nextToken() + "',";
	  }
	  rtnSubject = rtnSubject.substring(0,rtnSubject.length()-1);
	  return rtnSubject;
  }

  
}