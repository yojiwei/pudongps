/**
 * 2006-08-09
 */
package com.website;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class ListKFZH {

	public ListKFZH() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 上一刊开发纵横日期
	 * @param toMon
	 * @return
	 */
	public String upMon(String toId) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String reId = "";
		//String sql = "select * from (select distinct c.ct_id,c.ct_title,ct_inserttime from tb_content c," +
		//			 "tb_subject s,tb_contentpublish p where p.ct_id = c.ct_id and p.sj_id = s.sj_id and " +
		//			 "c.ct_id < " + toId + " and s.sj_dir = 'pudongNews_KFZH' order by c.ct_id desc) where rownum = 1";
		
		String sql = "select * from (select distinct c.ct_id,c.ct_title,c.ct_inserttime from tb_content c," +
					 "tb_contentpublish p,tb_subject s where p.ct_id=c.ct_id and p.sj_id=s.sj_id and " +
					 "s.sj_dir='pudongNews_KFZH' and ct_delflag='0' and ct_img_path is not null and " +
					 "p.cp_ispublish='1' and c.ct_id < " + toId + " order by c.ct_id desc) where rownum = 1";  
		
		ResultSet rs = dImpl.executeQuery(sql);
		try {
			if (rs.next()) 
				reId = rs.getString("ct_id");
			else 
				reId = "#";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("ListKFZH_upMon() ERROR!" + e);
		}
		
		dImpl.closeStmt();
		dCn.closeCn();
		return reId;
	}
	
	/**
	 * 下一刊开发纵横
	 * @param downMon
	 * @return
	 */
	public String downMon(String toId) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String reId = "";
		//String sql = "select * from (select distinct c.ct_id,c.ct_title,ct_inserttime from tb_content c," +
		//			 "tb_subject s,tb_contentpublish p where p.ct_id = c.ct_id and p.sj_id = s.sj_id and " +
		//			 "c.ct_id > " + toId + " and s.sj_dir = 'pudongNews_KFZH') where rownum = 1";

		String sql = "select * from (select distinct c.ct_id,c.ct_title,c.ct_inserttime from tb_content c," +
					 "tb_contentpublish p,tb_subject s where p.ct_id=c.ct_id and p.sj_id=s.sj_id and " +
					 "s.sj_dir='pudongNews_KFZH' and ct_delflag='0' and ct_img_path is not null and " +
					 "p.cp_ispublish='1' and c.ct_id > " + toId + " order by c.ct_id) where rownum = 1";  

		ResultSet rs = dImpl.executeQuery(sql);
		try {
			if (rs.next()) 
				reId = rs.getString("ct_id");
			else 
				reId = "#";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("ListKFZH_upMon() ERROR!" + e);
		}
		dImpl.closeStmt();
		dCn.closeCn();
		return reId;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/*
		ListKFZH lkf = new ListKFZH();
		System.out.println(lkf.upMon("100000"));
		*/
	}
}
