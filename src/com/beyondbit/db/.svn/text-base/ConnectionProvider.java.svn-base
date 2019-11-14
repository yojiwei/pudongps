package com.beyondbit.db;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp.BasicDataSource;
import com.beyondbit.config.DaoConfig;

public class ConnectionProvider {
    private static BasicDataSource ds = null;
    static {
        DaoConfig config = DaoConfig.getInstance();

        ds = new BasicDataSource();
        ds.setDriverClassName(config.getDriver());
//        ds.setDriverClassName ("oracle.jdbc.driver.OracleDriver");
        ds.setUrl(config.getConnectionURL());
//        ds.setUrl ("jdbc:oracle:thin:@192.10.5.171:1521:product");
        ds.setMaxActive(config.getMaxActive());
//        ds.setMaxActive (5);
        ds.setMaxWait(config.getMaxWait());
//        ds.setMaxWait (2);
        ds.setDefaultAutoCommit(config.getDefaultAutoCommit());
//        ds.setDefaultAutoCommit (true);
//        ds.setDefaultReadOnly(config.getDefaultAutoCommit());
//        ds.setDefaultReadOnly (false);
        ds.setDefaultTransactionIsolation(Connection.
                                          TRANSACTION_READ_COMMITTED);
//        ds.setDefaultCatalog ("test catalog");
        
        ds.setUsername(config.getUsername());
//        ds.setUsername ("sst");
        ds.setPassword(config.getPassword());
        ds.setMaxIdle(20);
        ds.setInitialSize(20);
//        ds.setPassword ("shishitong");
//        ds.setValidationQuery ("SELECT DUMMY FROM DUAL");


    }

    public static Connection getConnection() throws SQLException {

        return ds.getConnection();

    }
    
    public static BasicDataSource getDataSource(){
    	return ds;
    }
    public static void main(String args[]) throws Exception{
    	Connection[] c = new Connection[50]; 
    	for(int i=0;i<10;i++){
    		try {
    			System.out.println(i+"开始获取连接！"+System.currentTimeMillis());
				c[i] = getConnection();
				System.out.println("空闲数字："+ds.getNumIdle());
				System.out.println(i+"获取到连接！"+System.currentTimeMillis());
				Thread.sleep(2000);
				c[i].createStatement();
			} catch (SQLException e) {
				System.out.println(i+"没有取到连接！");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	
    	for(int i=0;i<10;i++){
    		if(c[i]!=null)
    		c[i].close();
    	}
    	System.out.println("空闲数字："+ds.getNumIdle());
    	
    }


}
