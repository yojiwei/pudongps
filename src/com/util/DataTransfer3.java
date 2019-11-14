package com.util;

import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东信息统一报送</p>
 * <p>Module Name:工具类</p>
 * <p>Function:将原来"浦东诚信"的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-6 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer3 {

	
	
	public void doInsertContent(){
		CDataCn cCn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cCn);
		Vector vector = null;
		Hashtable table = null;
		int totalCnt = -1;
		int ctId = -1;
		String ctContent = ""; 
		String selectSql = "select ct_id,ct_content from tb_content_new";
		try{
			totalCnt = getTotalCnt();
			totalCnt = totalCnt/20 + 1;
			for(int count = 1; count <= totalCnt; count++){
				vector = getVector(selectSql,count);
				if(vector != null){
					for(int cnt = 0; cnt < vector.size(); cnt++){
						table = (Hashtable)vector.get(cnt);
						ctId = Integer.parseInt(table.get("ct_id").toString());
						if(table.get("ct_content") != null)
							ctContent = table.get("ct_content").toString();
						doUpdateContent(ctId,ctContent);
					}
				}
			}
			
		}catch(Exception ex){
			System.out.println("SALException:: doInsertContent " + ex.getMessage());
		}finally{
			cCn.closeCn();
			cImpl.closeStmt();
		}
	}
	
	private int getTotalCnt(){
		int maxId = 1;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		Vector vector = null;
		try{
			vector = dImpl.splitPage("select count(ct_id) as maxId from tb_content",5,1);
			if(vector != null){
				maxId = Integer.parseInt(((Hashtable)vector.get(0)).get("maxid").toString());
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getTotalCnt " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return maxId;
	}
	
	private Vector getVector(String sql,int cnt){
		CDataCn cCn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cCn);
		Vector vector = null;
		try{
			vector = cImpl.splitPage(sql,20,cnt);
		}catch(Exception ex){
			System.out.println("SALException:: getVector " + ex.getMessage());
		}finally{
			cCn.closeCn();
			cImpl.closeStmt();
		}
		return vector;
	}
	
	private boolean doUpdateContent(int ctId,String ctContent){
		CDataCn cCn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cCn);
		boolean flag = false;
		try{
			cImpl.edit("tb_content","ct_id",ctId);
			cImpl.setValue("ct_content",ctContent,CDataImpl.SLONG);
			flag = cImpl.update();
			if(flag){
				cImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_content','ct_id'," + ctId + ",'Yes','22')");
			}else{
				cImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','ct_id'," + ctId + ",'No','22')");
			}
		}catch(Exception ex){
			System.out.println("SALException:: doInsert " + ex.getMessage());
		}finally{
			cCn.closeCn();
			cImpl.closeStmt();
		}
		return flag;
	}
	
	public static void main(String [] args){
		DataTransfer3 transfer = new DataTransfer3();
		transfer.doInsertContent();
	}
}
