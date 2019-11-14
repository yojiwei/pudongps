
package com.component.newdatabase ;

import com.component.database.*;
import com.util.*;
import java.sql.*;


public class CLog extends CDataControl implements ILog
{
  PreparedStatement _stmt = null; //预处理

   public CLog()
   {
   }

   public CLog(CDataCn dCn)
   {
     super(dCn);
   }

   /**
   @roseuid 3BFB4DD603E7
   */
   public boolean setLog(int type, String action, String content, String user)
   {
     if (type < 0) return false;
     if (action == null || content == null) return false;
     if (action.equals("") || content.equals("")) return false;

     long id = getMaxId("tb_log");
     String sql ;
     String _user ;
     sql  = "insert into tb_log(lg_id ,lg_type,lg_rgtime,lg_action,lg_content,lg_user) values (?,?,?,?,?,?)";
     if (user == null) _user = "";
     else _user = user;
     try
     {
       CDate date = new CDate();
       _stmt = cn.prepareStatement(sql);
       _stmt.setLong(1,id);
       _stmt.setInt(2,type);
       _stmt.setString(3,date.getNowTime());
       _stmt.setString(4,action);
       _stmt.setString(5,content);
       _stmt.setString(6,_user);
       _stmt.execute();
       return true;
     }catch(Exception ex){
       raise(ex,"在写入日志时出错！","CLog.setLog()");
       return false;
     }
   }

   public boolean setLog(int type, String action, String content)
   {
     return setLog(type,action, content,null) ;
   }

   public static void main(String [] args)
   {
     CDataCn dCn = new CDataCn();
     CLog l = new CLog(dCn);
     l.setLog(LOGIN,"登录","登录失败！");
     dCn.closeCn();
   }

}
