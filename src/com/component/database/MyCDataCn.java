
package com.component.database;

import java.sql.*;

import com.util.ReadProperty;
/**
 * 浦东信息后台数据库连接。
 * @author yaojiwei
 * date 20081118
 */

public class MyCDataCn extends CError
{
   private Connection cn = null;
   private ReadProperty pro = null;
   //硬编码连接
	 public MyCDataCn() { 
		 try{
				
				String URL = "jdbc:sqlserver://192.168.152.213:1433;DatabaseName=pudong0113";
				String userName = "pudongdbuser2019";
				String userPwd = "pudong12354pduser";
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				cn = DriverManager.getConnection(URL, userName, userPwd);//userName是你数据库的用户名如sa,
				if(cn!=null){
					System.out.println("conn="+cn); 
				}
				//cn.close();
			}catch (Exception e){
				System.out.println("数据库连接失败");
				e.printStackTrace();
			}
	}
   
   /**
   * Method: getConnection()
   * Description: 返回数据库连接对象
   * @return Connection
   @roseuid 3BF39CE90064
   */
   public Connection getConnection()
   {
     return cn;
   }

   /**
   * Method:beginTrans()
   * Description: 设置事务开始
   * @return void
   @roseuid 3BFB4F8C00CF
   */
   public void beginTrans()
   {
     try
     {
       cn.setAutoCommit(false);

     }
     catch(Exception ex)
     {
       System.out.println(ex.getMessage());
     }
   }

   /**
   * Method:commitTrans()
   * Description: 提交事务
   * @return boolean
   @roseuid 3BFB4FC40184
   */
   public boolean commitTrans()
   {
     try
     {
       cn.commit();
       return true;
     }
     catch(Exception ex)
     {
       System.out.println(ex.getMessage());
       return false;
     }
   }

   /**
   * Method:rollbackTrans()
   * Description: 回滚事务
   * @return void
   @roseuid 3BFB4FE90296
   */
   public void rollbackTrans()
   {
     try
     {
       cn.rollback();
     }
     catch(Exception ex)
     {
       System.out.println(ex.getMessage());
     }
   }

   /**
    * Method: closeCn()
    * Description:关闭数据库连接
   */
   public void closeCn()
   {
     try
     {
       if(!cn.isClosed())
         cn.close();
     }
     catch(Exception ex)
     {
       System.out.println(ex.getMessage());
     }
   }

   
   /**
    * main方法
    * @param args
    */
   public static void main(String[] args)
   {
	   MyCDataCn cDn = new MyCDataCn();
	   
       System.out.println("Hello World!" + cDn);
   }
}
