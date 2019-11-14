
package com.component.database;

import java.sql.*;

import com.util.ReadProperty;
/**
 * 浦东信息后台数据库连接。
 * @author yaojiwei
 *
 */

public class CDataCn extends CError
{
   private Connection cn = null;
   private ReadProperty pro = null;
   
   public CDataCn() { 
	   try {
//		   @pudong--localhost
		   String strUrl = "dbc:oracle:thin:@localhost:1521:orcl"; 
		   String strDBDriver = "oracle.jdbc.driver.OracleDriver"; 
		   String strWebname = "gwba";
		   String strWebpass = "123456"; 
		   //@pudong--
//		   pro = new ReadProperty();
//		   String strUrl = "jdbc:oracle:thin:@" + pro.getPropertyValue("dbip") + ":" 
//		   		+ pro.getPropertyValue("dbport") + ":" + pro.getPropertyValue("dbsid"); 
//		   

		    //载入 JDBC 驱动 
           Class.forName(strDBDriver).getInterfaces();
           // 得到数据库连接
           cn = DriverManager.getConnection(strUrl, strWebname, strWebpass);
           System.out.println("cn="+cn);
       }catch (Exception ex){
            System.out.println(ex); 
       }
   }
   
   /**
    * mySql 连接数据库
    */
//   public CDataCn(){
//       //驱动程序名
//       String driver = "com.mysql.jdbc.Driver";
//       //URL指向要访问的数据库名mydata
//       String url = "jdbc:mysql://localhost:3306/test?useSSL=true";
//       //MySQL配置时的用户名
//       String user = "root";
//       //MySQL配置时的密码
//       String password = "";
//       try {
//           Class.forName(driver);
//           cn = DriverManager.getConnection(url,user,password);
//		    
//	   }catch(Exception ex){
//		   System.out.println(ex.toString());
//	   }
//   }
   
   
   /**
    * 用于oracle集群访问
    */
//   public CDataCn() { 
//	   try {    
//			   Driver driver = (Driver) Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();     
//			   DriverManager.registerDriver(driver);    
//		   } 
//		   catch (Exception e) { 
//			   System.out.println(e);
//		   } 
//	   
//	   try {
//           cn = DriverManager.getConnection("jdbc:oracle:thin:@(description=(address_list=(address=(host=10.220.250.70)(protocol=tcp)(port=1521))(address=(host=10.220.250.71)(protocol=tcp)(port=1521))(load_balance=yes)(failover=yes))(connect_data=(service_name=pudong)))","gwbanew", "gwba+2009");
//           
//       }catch (Exception ex){
//            System.out.println(ex);
//       }
//   }
//   
   /**
    * 用于sqlserver访问
    */
//   public CDataCn() { 
//	   try {
//		    //载入 JDBC 驱动 
//           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").getInterfaces();
//           // 得到数据库连接
//           cn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=wtgy", "sa", "123456");
//           //System.out.println("cn="+cn);
//       }catch (Exception ex){
//            System.out.println(ex); 
//       }
//   }

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
