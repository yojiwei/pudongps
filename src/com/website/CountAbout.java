/**
 * 2006-07-25
 */
package com.website;

import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class CountAbout {
	
	/**
	 * ?????????????
	 * @param cam ?????id
	 * @param ct_id	?????id
	 */
	public void addAt(CountAboutModel[] cam,String ct_id) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		dCn.beginTrans();
		for (int i = 0;i < cam.length;i++) {
			dImpl.setTableName("tb_countnewsabout");
			dImpl.setPrimaryFieldName("cna_id");		
			dImpl.addNew();
			dImpl.setValue("ct_id",ct_id,CDataImpl.INT); 
			dImpl.setValue("ct_id_at",cam[i].getCt_id_at(),CDataImpl.INT);
			dImpl.update();
		}
		if ("".equals(dCn.getLastErrString())) {
			dCn.commitTrans();
			System.out.println("=========INSERT SUCCESS!=========");
		}
		else {
			dCn.rollbackTrans();
			System.out.println("==========CountAbout_addAt FUNCTION WRONG!=========");
		}
		dImpl.closeStmt();
		dCn.closeCn();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		
		String sql = "select tb_count from tb_countnews where tb_type = 'count'";
		Vector vt = dImpl.splitPage(sql,1000,1);
		int tb_count = 0;
		String countStr = "";
		if (vt != null) {
			for(int i = 0;i < vt.size();i++) {
				Hashtable hash = (Hashtable)vt.get(i);
				countStr = hash.get("tb_count").toString();
				tb_count += Integer.parseInt(countStr);
				System.out.println("-------------- " + countStr + "  -----tb_count:" + tb_count);
			}
		}
		System.out.println(">>>>>>>>>>>>> " + tb_count);
		dImpl.closeStmt();
		dCn.closeCn();
		// TODO Auto-generated method stub
		/*
		CountAbout ca = new CountAbout();
		CountAboutModel[] cam = new CountAboutModel[3];
		
		for (int i = 0;i < cam.length;i++) {
			cam[i] = new CountAboutModel();
			cam[i].setCt_id_at(String.valueOf(i));			
		}
		ca.addAt(cam,"1111");
		*/
	}

}
