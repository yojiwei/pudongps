/**
 * 2006-08-21
 * 将一个栏目下的数据导入到另一个栏目下
 */

package com.website;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Vector;
import com.util.CTools;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class ImpData {
	
	/**
	 * 将一个栏目下的数据导入到另一个栏目下
	 * @param id
	 * @return
	 */
	private int countNoData = 0;		//已经在数据库存在的数据数目
	
	private void transfer_1(String getId,String goId,String str) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		int k = 0;
		Vector vPage = null;
		Hashtable content = null;
		String ctCon = null;
		String ctId = null;
		
		String sql = "select c.ct_id,c.ct_content from (select c.ct_id,c.ct_content from tb_content c," + 
					 "tb_subject s,tb_contentpublish p where c.ct_id = p.ct_id and s.sj_id = p.sj_id and" +
					 "s.sj_id = " + getId + ") c";

		vPage = getAllData(sql);
		
		dImpl.closeStmt();
		dCn.closeCn();
		
		if (vPage != null) {
			for (int i = 0;i < vPage.size();i++) {
				content = (Hashtable)vPage.get(i);
				ctId = content.get("ct_id").toString();
				ctCon = content.get("ct_content").toString();
				String[] tmp = ctCon.split(str);
				if (tmp.length > 1) {
					
					System.out.println("========== " + ctId);
				}				
			}
		}
		
	}
	
	public boolean putData(Hashtable content,String sjid) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String sql = null;
		try {
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			dImpl.closeStmt();
			dCn.closeCn();
			return true;
		}
	}
	
	public boolean transfer(String id) {
		
		boolean reBool = false;
		String sjid = "";
		int k = 0;
		Vector vPage = null;
		Hashtable content = null;
		String sql = "select ct_id,sj_id,cp_ispublish,cp_filename,cp_commend from tb_contentpublish where " +
		 			 "sj_id in (select sj_id from (select sj_id,sj_acdid from tb_subject connect by prior " +
		 			 "sj_id = sj_parentid start with sj_id = " + id + ") where sj_acdid is not null) order by cp_id";
		
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		dCn.beginTrans();
		
		vPage = getAllData(sql);
		
		dImpl.closeStmt();
        dCn.closeCn();
		
		if (vPage != null) {
			for (int i = 0;i < vPage.size();i++) {
				content = (Hashtable)vPage.get(i);
				sjid = insertData(content,sjid);
				if (!"".equals(sjid)) k++;
				if ("WRONG".equals(sjid)) break;
			}
		}
		
		if ("WRONG".equals(sjid)) {
			dCn.rollbackTrans();
			System.out.println("==================ImpData_transfer THERE ARE SOMETHING WRONG! ");
			System.out.println("==================ImpData_TOTALIMORT: " + k);
			System.out.println("==================NO_ImpData_TOTALIMORT: " + countNoData);
		}
		else {
			dCn.commitTrans();
			dCn.rollbackTrans();
			System.out.println("==================ImpData_transfer INSERT TB_CONTENTPUBLISH " + 
								k + " TIMES IS SUCCESSFULLY! ");
			System.out.println("==================NO_ImpData_TOTALIMORT: " + countNoData);
		}
		
		return reBool;
	}
	
	/**
	 * 	如果tb_subject表中sj_acdid有记录，
	 * 判定contentpublish表中是否已经存在此条记录如果有返回sjid,没有插入
	 * @param content	Hashtable 某栏目下数据
	 * @param sjid	sj_id
	 * @return
	 */
	public String insertData(Hashtable content,String sjid) {
		
		String id = "";
		String acdid = "";
		String ct_id = "";
		String sj_id = "";
		String cp_ispublish = "";
		String cp_filename = "";
		String cp_commend = "";
		String sql = "";
		
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		
		dCn.beginTrans();
		
		ct_id = content.get("ct_id").toString();
		sj_id = content.get("sj_id").toString();
		cp_ispublish = content.get("cp_ispublish").toString();
		cp_filename = content.get("cp_filename").toString();
		cp_commend = content.get("cp_commend").toString();
		//
		if ("".equals(sjid) || (!"".equals(sjid) && !ct_id.equals(sjid))) {
			sql = "select sj_id,sj_acdid from tb_subject where sj_id = " + sj_id;
			ResultSet rs = dImpl.executeQuery(sql);
			
			try {
				if (rs.next()) {
					acdid = rs.getString("sj_acdid");
					if ("".equals(acdid) || acdid.equals("null")) {
						return "";
					}
					sjid = acdid;
				}
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("==================GET SJ_ACDID WRONG BECAUESE: " + e);
			}
		}
		//判定contentpublish表中是否已经存在此条记录如果有返回sjid,没有插入
		try {
			sql = "select cp_id from tb_contentpublish where sj_id = " + sjid + " and ct_id = " + ct_id;
			ResultSet rs1 = dImpl.executeQuery(sql);
			if (rs1.next()) {
				countNoData++;
				return sjid;
			}
			rs1.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("==================SELECT rs1 WRONG: " + e);
		}
		//判定结束

		//插入tb_contentpublish
		dImpl.setTableName("tb_contentpublish");
		dImpl.setPrimaryFieldName("cp_id");		
		id = "" + dImpl.addNew();
		dImpl.setValue("ct_id",ct_id,CDataImpl.INT);
		dImpl.setValue("sj_id",sjid,CDataImpl.INT);
		dImpl.setValue("cp_ispublish",cp_ispublish,CDataImpl.INT);
		dImpl.setValue("cp_filename",cp_filename,CDataImpl.STRING);
		dImpl.setValue("cp_commend",cp_commend,CDataImpl.INT);
		dImpl.update();

		if (!"".equals(dCn.getLastErrString())) {
			dCn.rollbackTrans();
			sjid = "WRONG";
			System.out.println("==================ImpData_insertData IS WRONG: sjid = " + sjid);
		}
		else {
			dCn.commitTrans();
			System.out.println("==================ImpData_insertData INSERT TB_CONTENTPUBLISH CP_ID = " + 
					id + " IS SUCCESSFULLY! ");
		}

		dImpl.closeStmt();
        dCn.closeCn();
        return sjid;
	}
	
	/**
     * 取得生成表中所有的记录
     * @param vt_id
     * @return
     */
    public Vector getAllData(String sql) {
    	
    	Vector reVt = new Vector();
    	String str = "";
    	String strVal = "";
    	int colNum = 0; 
        ResultSetMetaData  rsmd = null; //记录集行标题
        ResultSet rs = null;
		
    	CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        rs = dImpl.executeQuery(sql);
        try {
            rsmd = rs.getMetaData(); //获得ResultSetMetaData，用于列标题
            colNum = rsmd.getColumnCount();
			while (rs.next()) {
				Hashtable hVal = new Hashtable();
				for (int j = 1;j <= colNum;j++) {
					if (rs.getObject(j) != null && !"".equals(rs.getObject(j).toString())) {
						hVal.put(rsmd.getColumnName(j).toLowerCase(),rs.getObject(j));
					}
					else {
						hVal.put(rsmd.getColumnName(j).toLowerCase(),"");
					}
				}
				reVt.add(hVal);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("================== ImpData_getAllData Wrong: " + e);
		}
        dImpl.closeStmt();
        dCn.closeCn();
        
    	return reVt;
    }
    
    /**
     * 给sj_dir栏目下没有日期的信息插入一个统一的日期
     * @param sj_dir	栏目
     * @param sj_date	插入的预期日期
     */
    public void insertDate(String sj_dir,String date) {
    	String ctIds = "";
    	int i = 0;
    	String sql = "select distinct c.ct_id from tb_content c,tb_contentpublish p,tb_subject s " +
    				 "where p.ct_id = c.ct_id and p.sj_id = s.sj_id and s.sj_id in (select sj_id from " +
    				 "tb_subject connect by prior sj_id = sj_parentid start with sj_dir = '" + sj_dir + "') and " +
    				 "ct_create_time is null";
    	    	
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		ResultSet rs = dImpl.executeQuery(sql);
		try {
			while (rs.next()) {
				ctIds += rs.getString("ct_id") + ",";
				i++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("==================  ImpData_insertDate Wrong: " + e);
		}
		System.out.println("TOTAL IS " + i);
		if (!"".equals(ctIds)) {
			ctIds = ctIds.substring(0,ctIds.length()-1);
			sql = "update tb_content set ct_create_time = '" + date + 
				  "' where ct_id in (" + ctIds + ")";
		}
		System.out.println(sql);
		dImpl.closeStmt();
		dCn.closeCn();
    }
    
    /**
     * 修改某个栏目下所有数据的显示问题 
     * @param sj_dir	栏目代码 
     */
    public void updateDisplay(String sj_dir) {
    	String sj_ids = "";
    	int i = 0;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String sql = "select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_dir = '" + sj_dir + "'";
		ResultSet rs = dImpl.executeQuery(sql);
		try {
			while (rs.next()) {
				sj_ids += rs.getString("sj_id") + ",";
				i++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("==================  ImpData_insertDate Wrong: " + e);
		}
		System.out.println("------------------- " + i + ":" + sj_ids);
		dImpl.closeStmt();
		dCn.closeCn();
    }
	
	public static void main(String args[]) {
		/*ImpData ida = new ImpData();
		ida.updateDisplay("pudongNews_xqecddh");*/
		/*String sj_dir = "pudongNews_xqecddh";
		String date = "2003-12-31";
		ImpData ida = new ImpData();
		ida.insertDate(sj_dir,date);*/
		
		ImpData ida = new ImpData();
		ida.transfer_1("328","25691","常务会议");
		//ida.updateDisplay("weeklycommented");
	}
	
}
