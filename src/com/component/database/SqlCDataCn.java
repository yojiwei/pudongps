package com.component.database;

import java.sql.Connection;
import java.sql.DriverManager;

public class SqlCDataCn {
	
	public void getSqlConnect(){
		try{
			
			String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=wtgy";
			String userName = "sa";
			String userPwd = "123456";
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection conn = DriverManager.getConnection(URL, userName, userPwd);//userName是你数据库的用户名如sa,
			if(conn!=null){
				System.out.println("conn="+conn);
			}
			
			conn.close();
		}catch (Exception e){
			System.out.println("数据库连接失败");
			e.printStackTrace();
		}
	}
	
	public static void main(String args[]){
		SqlCDataCn scc = new SqlCDataCn();
		scc.getSqlConnect();
	}

}
