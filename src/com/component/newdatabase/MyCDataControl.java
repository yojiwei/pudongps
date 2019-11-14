
package com.component.newdatabase;

import java.io.*;
import java.sql.*;
import java.util.*;

public class MyCDataControl extends CError
{
   public MyCDataCn dataCn;
   protected Connection cn;
   protected Statement stmt;
   private long updateCount;


   /**
    * Method:CDataControl()
    * Description: 构造函数
    * @deprecated
    * 如果没有传入CDataBase对象，自动创建对象，不推荐使用，
   @roseuid 3BFB51C800DC
   */
   public MyCDataControl()
   {
     try
     {
       MyCDataCn dCn = new MyCDataCn();
       dataCn = dCn;
       cn = dataCn.getConnection();
       stmt = cn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_UPDATABLE);
       //stmt = cn.createStatement();
     }
     catch(Exception ex)
     {
       //System.out.println(ex.getMessage());
       dataCn.raise(ex,"数据库连接错误","CDataControl:CDataControl()");
     }
   }

   /**
    * Method:CDataControl(CDataCn dCn)
    * Description: 构造函数,初始化数据连接对象
    * @param dCn
   @roseuid 3BFB51E5016A
   */
   public MyCDataControl(MyCDataCn dCn)
   {
     try
     {
       if(dCn==null){
           dataCn = new MyCDataCn();
       }
       else {
           dataCn = dCn;
       }

       cn = dataCn.getConnection();

       stmt = cn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_UPDATABLE);
     }
     catch(Exception ex)
     {
       ex.printStackTrace();
     }
   }


   /**
   * Method:executeUpdate(String sql)
   * Description: 执行insert,update,delete等动作sql语句，返回执行所影响的记录数
   * @param sql
   * @return long
   @roseuid 3BFB52B4009F
   */
   public long executeUpdate(String sql) //throws Exception
   {
     try
     {
       updateCount = stmt.executeUpdate(sql);
       return updateCount;
     }
     catch(Exception ex)
     {
       dataCn.raise(ex,"更新数据的时候出错","executeUpdate(String sql)");
       return -1;
     }
   }

   /**
   * Method:executeQuery(String sql)
   * Description: 执行selete sql语句，返回记录集，若
   * @param sql
   * @return ResultSet
   @roseuid 3BFB5A8D01C0
   */
   public ResultSet executeQuery(String sql) //throws Exception
   {
     try
     {
       return stmt.executeQuery(sql);
     }
     catch(Exception ex)
     {
       System.out.println(ex.toString());
         dataCn.raise(ex,"执行SQL语句的时候出错",sql); //"executeQuery(String sql)");
       return null;
     }
   }



   /**
   * Method:getMaxId(String tableName)
   * Description: 返回记录数
   * @param tableName 表名称
   * @return long
   @roseuid 3BFB6A06037F
   */
   public long getMaxId(String tableName)
   {
     try
     {
       String strSql;
       int MaxId=1;
       ResultSet rs = null;
       PreparedStatement pStmt = null; //预处理

       tableName = tableName.toLowerCase();
       strSql = "select RC_maxid from tb_rowcount where RC_tablename = '"+ tableName +"'";
       rs = stmt.executeQuery(strSql);
       boolean isok = rs.next();
       if(isok){
    	   //update by yao
    	   //先修改
    	   strSql = "update tb_rowcount set RC_maxid = RC_maxid + 1 where RC_tablename = ?";
           pStmt = cn.prepareStatement(strSql);
           pStmt.setString(1,tableName);
           pStmt.execute();
           //再查看
           strSql = "select RC_maxid from tb_rowcount where RC_tablename = '"+ tableName +"'";
           ResultSet rs2 = stmt.executeQuery(strSql);
           if(rs2.next())
           {
        	   MaxId = rs2.getInt("RC_maxid"); 
           }
           rs2.close();
           pStmt.close();
//       if (rs.next())
//       {
//         MaxId = rs.getInt("RC_maxid") + 1;
//         strSql = "update tb_rowcount set RC_maxid = ? where RC_tablename = ?";
//         pStmt = cn.prepareStatement(strSql);
//         pStmt.setInt(1,MaxId);
//         pStmt.setString(2,tableName);
//         pStmt.execute();
//         pStmt.close();
//         rs.close();
       }
       else
       {
         strSql = "insert into tb_rowcount values ( ? ,1)";
         pStmt = cn.prepareStatement(strSql);
         pStmt.setString(1,tableName);
         pStmt.execute();

         MaxId = 1;
         pStmt.close();
       }
       return MaxId;
     }
     catch(Exception ex)
     {
       //System.out.println(ex);
       dataCn.raise(ex,"获取最大ID的时候出错","getMaxId(String tableName)");
       return -1;
     }
   }

   /**
    * 返回更新记录影响的数量
    * @return long 返回影响的数量
    */
   public long getUpdateCount()
   {
     return updateCount;
   }

   /**
    * Method: closeStmt()
    * Description: 关闭Stmt
    */

   public void closeStmt()
   {
     try
     {
       if (stmt != null)
       {
         stmt.close();
       }
     }
     catch(Exception ex)
     {
       dataCn.raise(ex,"关闭stmt出错","CDataControl:closeStmt()");
     }
   }

   public static void main(String[] args) {
      try{
        MyCDataControl x = new MyCDataControl();
        System.out.println(x.getMaxId("test"));
      }
      catch(Exception ex)
      {
        System.out.println(ex);
      }
    }
}
