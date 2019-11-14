/**
 * 2006-08-03
 */
package com.website;

import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class UpdateImp {

	public UpdateImp() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * ´ý¶¨
	 * @param sWhere
	 * @return
	 */
	public String doImp(String sWhere) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String sql = "select sj_id,sj_name,sj_acdid from tb_subject connect by prior " +
					 "sj_id = sj_parentid start with sj_id = " + sWhere;
		Hashtable hash = null;
		String reStr = "";
		String sj_id = "";
		String sj_acdid = "";
		String upSql = "";
        dCn.beginTrans();
		Vector vtAll = dImpl.splitPageOpt(sql,1000,1);
		if (vtAll != null) {
			for (int i = 0;i < vtAll.size();i++) {
				hash = (Hashtable)vtAll.get(i);
				sj_id = hash.get("sj_id").toString();
				sj_acdid = hash.get("sj_acdid").toString();
				upSql = "update tb_subject set sj_acdid = " + sj_id + " where sj_id = " + sj_acdid;
				dImpl.executeUpdate(upSql);
			}
		}
        if (dCn.getLastErrString().equals("")) {
            dCn.commitTrans();
            reStr = "ok";
        }
        else {
            dCn.rollbackTrans();
            System.out.println(dCn.getLastErrString());
        }
		dImpl.closeStmt();
		dCn.closeCn();
		return reStr;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UpdateImp test = new UpdateImp();
		System.out.println(test.doImp("467"));
	}

}
