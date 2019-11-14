package com.app;

import com.component.database.*;
import java.sql.*;

import com.util.*;

public class CMySelf
    extends CDataControl {

    private String _uid = ""; //用户名称
    private String _pwd = ""; //用户密码
    private String _name = "";
    private long _dtId = 0; //部门ID
    private long _id; //用户ID
    private boolean _login = false; //登录标签
    private String sjIds = "";
    private String sjNames = "";
    private CLog log = null;


    /**
     * @deprecated
     */
    public CMySelf() {
        log = new CLog();
    }

    public CMySelf(CDataCn dCn) {
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
    public boolean login(String uid, String pwd) {
        ResultSet rs = null;
        String sql = "";
        boolean islogin = false;
        try {
            sql = "select * from tb_userinfo where ui_uid = '" + uid +
                "' and ui_active_flag = 0";
            rs = executeQuery(sql);

            if (rs.next()) {            	
            	_uid = rs.getString("ui_uid");            	
                _pwd = rs.getString("ui_password");
                //================解密开始
                _pwd=SecurityTest.decode(_pwd);
                byte[] bt = new sun.misc.BASE64Decoder().decodeBuffer(_pwd);
        		_pwd = new String(bt);
        		//================解密结束
        		if(_pwd.equals(pwd))
                {
                	_login = true; //把当前登录标示执为成功
                	islogin = true;
                }
                _id = rs.getLong("ui_id");                
                _name = rs.getString("ui_name");
                _dtId = rs.getLong("dt_id");
               // _login = true; //把当前登录标示执为成功
                setSJRole();
                log.setLog(CLog.LOGIN, "后台登录", "登录成功", _name);
                log.closeStmt(); //关闭日志
                
                rs.close(); //关闭rs对象
                return islogin;
            }
            else {
                log.setLog(CLog.LOGIN, "后台登录", "登录失败", uid);
                log.closeStmt(); //关闭日志
                rs.close();
                return islogin;
            }
        }
        catch (Exception ex) {
            raise(ex, "后台登录时出错", "CMySelf::login()");
            return islogin;
        }
    }
    
    /**
     * 用于单点登录
     * @author yaojiwei
     */
    public boolean login(String uid, String pwd,boolean status) {
        ResultSet rs = null;
        String sql = "";
        boolean islogin = false;
        try {
            sql = "select * from tb_userinfo where ui_uid = '" + uid +
                "' and ui_active_flag = 0";
            //System.out.print(sql);
            rs = executeQuery(sql);
            //================解密传递的参数
            pwd=SecurityTest.decode(pwd);
            byte[] _bt = new sun.misc.BASE64Decoder().decodeBuffer(pwd);
            pwd = new String(_bt);
            //================解密结束
            if (rs.next()) {            	
            	_uid = rs.getString("ui_uid");            	
                _pwd = rs.getString("ui_password");
                //================解密数据库用户密码开始
                _pwd=SecurityTest.decode(_pwd);
                byte[] bt = new sun.misc.BASE64Decoder().decodeBuffer(_pwd);
        		_pwd = new String(bt);
        		//================解密结束
                if(_pwd.equals(pwd))
                {
                	_login = true; //把当前登录标示执为成功
                	islogin = true;
                }
                _id = rs.getLong("ui_id");                
                _name = rs.getString("ui_name");
                _dtId = rs.getLong("dt_id");
               // _login = true; //把当前登录标示执为成功
                setSJRole();
                log.setLog(CLog.LOGIN, "后台登录", "登录成功", _name);
                log.closeStmt(); //关闭日志
                
                rs.close(); //关闭rs对象
                
                return islogin;
            }
            else {
                log.setLog(CLog.LOGIN, "后台登录", "登录失败", uid);
                log.closeStmt(); //关闭日志
                rs.close();
                return islogin;
            }
        }
        catch (Exception ex) {
            raise(ex, "后台登录时出错", "CMySelf::login()");
            return islogin;
        }
    }

    /**
     * Method:logout()
     * Description: 退出系统
     * return void
        @roseuid 3E06F57C00EA
     */
    public void logout() {
        CDataCn cdCn = new CDataCn();
        log = new CLog(cdCn);
        log.setLog(CLog.LOGIN, "后台登录", "退出成功", _name);
        _uid = ""; //用户名称
        _pwd = ""; //用户密码
        _name = "";
        _id = 0; //用户ID
        _login = false;
        _dtId = 0;
        log.closeStmt();
        cdCn.closeCn();
    }

    /**
     * Method:isLogin()
     * Description: 是否已登录系统　<br> 若是，返true；若假，返false
     * return boolean
        @roseuid 3E06F5DD031B
     */
    public boolean isLogin() {
        return _login;
    }

    public String getMyUid() {
        return _uid;
    }

    /**
     * Method:getMyID()
     * Description: 取得自已的ID
     * return long
        @roseuid 3E06F4920351
     */
    public long getMyID() {
        return _id;
    }

    /**
        @roseuid 3E06F63B01D5
     */
    public String getMyName() {
        return _name;
    }

    
    public long getDtId() {
        return _dtId;
    }
    
    public String getSjNames()
    {
    	return this.sjNames;
    }
    
    public String getSjIds()
    {
    	return this.sjIds;
    }
    
    public void setSJRole()
    {
    	CDataCn dCn = new CDataCn();
    	CDataImpl dImpl = new CDataImpl(dCn);
    	
    	String sjSql="select distinct s.sj_name f_name,s.sj_id f_id from tb_subject s " +
    			"where s.sj_id in(select sj_id from tb_subjectrole " +
    			"where  tr_id in (select tr_id from tb_roleinfo where tr_userids like '%,"+_id+",%'))";
    	//System.out.println(sjSql);
    	ResultSet rs1 = null;
    	
    	 try {
           
             rs1 = dImpl.executeQuery(sjSql);
             while (rs1.next()) {
                // System.out.println("right");
            	 this.sjNames +=rs1.getString("f_name") + ",";
            	 //System.out.println("right1");
                 this.sjIds +=String.valueOf(rs1.getInt("f_id")) + ",";               
             }  
             //System.out.println(sjNames);
             //System.out.println(sjIds);
            
         }
         catch (Exception ex) {
             raise(ex, "取栏目出错", "CMySelf::setSJRole()");
         }
         finally
         {
        	 try {
				rs1.close();
				dImpl.closeStmt();
				dCn.closeCn();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
         }
    	
    }
    
    
    public static void main(String [] args)
    {
    	CMySelf myself = new CMySelf();
    	myself.login("admin","......");
    }
    
}
