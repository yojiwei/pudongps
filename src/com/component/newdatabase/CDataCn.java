
package com.component.newdatabase;

import java.sql.*;

import com.util.ReadProperty;
/**
 *
 */

public class CDataCn extends CError
{
   private Connection cn = null;
   private ReadProperty pro = null;
   
   public CDataCn() { 
	   try {
//		   @pudong--localhost
		   String strUrl = "dbc:oracle:thin:@192.68.76.153:1521:ORCL"; 
		   String strDBDriver = "oracle.jdbc.driver.OracleDriver"; 
		   String strWebname = "pdccdb_viewer";
		   String strWebpass = "pdccdb@012";

		    //载入 JDBC 驱动 
           Class.forName(strDBDriver).getInterfaces();
           // 得到数据库连接
           cn = DriverManager.getConnection(strUrl, strWebname, strWebpass);
       }catch (Exception ex){
            System.out.println(ex);
       }
   }


   /**
    * 通过传值获得数据库链接
    */
   public CDataCn(String linkStr)
   {
       cn = null;
       try
       {
           pro = new ReadProperty();
           if(!"".equals(linkStr))
           {
        	   String strUrl = "jdbc:oracle:thin:@" + pro.getPropertyValue(linkStr + "dbip") + ":" + pro.getPropertyValue(linkStr + "dbport") + ":" + pro.getPropertyValue(linkStr + "dbsid");
               String strDBDriver = pro.getPropertyValue(linkStr + "dbdriver");
               String strWebname = pro.getPropertyValue(linkStr + "dbusername");
               String strWebpass = pro.getPropertyValue(linkStr + "dbpassword");
               Class.forName(strDBDriver).getInterfaces();
               cn = DriverManager.getConnection(strUrl, strWebname, strWebpass);
           }
       }
       catch(Exception ex)
       {
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

   public static void main(String[] args)
   {
	   CDataCn cDn = new CDataCn();
     System.out.println("Hello World!" + cDn);
     
   }
}
