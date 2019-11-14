package com.app.event;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class TSEvent implements AppEvent {
	

	
	public int getCount() {
		// TODO Auto-generated method stub
		
		return 0;
	}

	public String createInformation(String dtId,Connection con) throws Exception{
		// TODO Auto-generated method stub		
		int count = 0;
		String returnValue = "";
		String sql = "select count(c.cw_id) as id from tb_connwork c,tb_deptinfo d,tb_connproc p " +
				"where c.cp_id=p.cp_id and (p.cp_id='o4'or p.cp_upid='o4') and " +
				"c.cw_status=1 and p.dt_id=" + dtId + " and p.dt_id=d.dt_id ";
		
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();
			 rs = stmt.executeQuery(sql);
			if(rs.next()) {count = rs.getInt("id");returnValue = "有" + String.valueOf(count) + "条待处理事务";}
			else returnValue = "-1";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new Exception("TSEvent.class is worong!");			
		}
		finally{
			stmt.close();
			rs.close();
		}
		return returnValue;
	}

}
