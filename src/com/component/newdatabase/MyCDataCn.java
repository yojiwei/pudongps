
package com.component.newdatabase;

import java.sql.*;

import com.util.ReadProperty;
/**
 * 链接浦东数据库
 */

public class MyCDataCn extends CError
{
   private Connection cn = null;
   private ReadProperty pro = null;
   //硬编码连接
   public MyCDataCn() { 
	   try {
		   String strUrl = "dbc:oracle:thin:@192.168.152.240:1521:beyond"; 
		   String strDBDriver = "oracle.jdbc.driver.OracleDriver"; 
		   String strWebname = "pudongweb0113";
		   String strWebpass = "aimer19810216";
           // 载入 JDBC 驱动
           Class.forName(strDBDriver).getInterfaces();
           // 得到数据库连接
           cn = DriverManager.getConnection(strUrl, strWebname, strWebpass);
       }catch (Exception ex){
            System.out.println(ex);
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
