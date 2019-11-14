package com.website;

import java.sql.*;
import com.component.database.*;
import java.util.Hashtable;
import java.util.Enumeration;


public class DataOper {
	private Connection conn = null;
	private String sql = "";
    public   DataOper() {
    	  try{
			  if(conn == null)
			   conn =  (new CDataCn().getConnection());
			  }catch(Exception e )
			  {
				e.printStackTrace();
			  }
	
  }
    
   /**
	 * @return Returns the sql.
	 */
	public  String getSql() {
		return sql;
	}

	/**
	 * @param sql The sql to set.
	 */
	public void setSql(String sql) {
		this.sql = sql;
		
		//АэИз sql =update tb_suggest 
	}
	public  void  doUpdate(Hashtable ht,String update_Column,String condition_Column) throws Exception 
	{
		try{
		 Statement statement = conn.createStatement();
		 
		 Enumeration  enu = null; 
		 enu = ht.keys();
		 while(enu.hasMoreElements())
		 {
			 String key = (String)enu.nextElement();
			 String value = (String)ht.get(key);
			 StringBuffer  sqlBuf= new StringBuffer();
			 sqlBuf.append(sql).append(" set ")
			 .append(update_Column).append(" = ")
			 .append(Integer.parseInt(value))
			 .append(" where ").append(condition_Column)
			 .append(" = '").append(key).append("' ");
			 statement.addBatch(sqlBuf.toString());
		 }
		// statement.addBatch(sql);
		 statement.executeBatch();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			this.resolve();
		}
	}

	public  void  doUpdateExt(Hashtable ht) throws Exception 
	{
		try{
		 Statement statement = conn.createStatement();
		 
		 Enumeration  enu = null; 
		 enu = ht.keys();
		 while(enu.hasMoreElements())
		 {
			 String key = (String)enu.nextElement();
			 String value = (String)ht.get(key);
			 if(value.equals("")||value ==null)
				 value = "0";
			 String update_Column= "";
			 String condition_Column = "" ;
			 String tableName = key.substring(0,key.indexOf("-"));
			 if(tableName.equalsIgnoreCase("tb_datatdictionary"))
			 {
				 update_Column ="dd_sequence";
				 condition_Column="DD_ID";
			 }
			 if(tableName.equalsIgnoreCase("tb_datavalue"))
			 {
				 update_Column ="DV_SEQUENCE";
				 condition_Column="DV_ID";
			 }
			 this.sql="update "+tableName + " ";
			 String key_Value = key.substring(key.indexOf("-")+1,key.length());
			 StringBuffer  sqlBuf= new StringBuffer();
			 sqlBuf.append(sql).append(" set ")
			 .append(update_Column).append(" = ")
			 .append(Integer.parseInt(value))
			 .append(" where ").append(condition_Column)
			 .append(" = ").append(Integer.parseInt(key_Value)).append(" ");
			 statement.addBatch(sqlBuf.toString());
		 }
		// statement.addBatch(sql);
		 statement.executeBatch();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			this.resolve();
		}
	}
	
	public static void main(String[] args){
		String demo = "tb_result-1234";
		System.out.println(demo.substring(0,demo.indexOf("-"))+"***"+demo.substring(demo.indexOf("-")+1,demo.length()));
	}
private void resolve() throws Exception {
	     if(conn != null )
	    	 conn.close();
   }
}
