/**
 * 如果在后台发布的是文件
 */
package com.website;

import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * @author hh
 * 2006-08-30
 */
public class CcheckFile {
	
	/**
	 * 根据参数ct_id,得到tb_image表中的内容
	 * @param ct_id
	 * @return
	 */
	public String[] jumpNet(String ct_id) {
		String reHtm[] = null;
		String ia_id = "";
		Hashtable ht = null;
		if ("".equals(ct_id)) return null;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		
		String sql = "select im_id from tb_image where ct_id = " + ct_id;
		
		Vector vPage = dImpl.splitPageOpt(sql,100,1);
		if (vPage != null) {
			reHtm = new String[vPage.size()];
			for (int i = 0;i < vPage.size();i++) {
				ht = (Hashtable)vPage.get(i);
				ia_id = ht.get("im_id").toString();
				reHtm[i] = ia_id;
			}			
		}
		
		dImpl.closeStmt();
		dCn.closeCn();
		return reHtm;
	}
	
	public String getCtid() {
		String reCtid = "";
		Hashtable ht = null;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String strSql = "select ct_id from tb_contentpublish where sj_id in (select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_id=89) order by ct_id desc";

		Vector vPage = dImpl.splitPageOpt(strSql,100,1);
		if (vPage != null) {
			for (int i = 0;i < vPage.size();i++) {
				ht = (Hashtable)vPage.get(i);
				reCtid += ht.get("ct_id").toString() + ","; 
			}
		}
		
		dImpl.closeStmt();
		dCn.closeCn();
		return reCtid;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		CcheckFile cf = new CcheckFile();
		System.out.println("getCtid = " + cf.getCtid());		
	}

}
